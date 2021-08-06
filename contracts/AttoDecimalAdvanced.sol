// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./AttoDecimal.sol";

library AttoDecimalAdvanced {
    using AttoDecimal for AttoDecimal.Instance;

    enum RoundingMode {ROUND_UP, ROUND_DOWN, ROUND_HALF_UP, ROUND_HALF_DOWN}

    function round(AttoDecimal.Instance memory a, RoundingMode roundingMode) internal pure returns (uint256) {
        return toPrecision(a, 0, roundingMode).floor();
    }

    function round(AttoDecimal.Instance memory a) internal pure returns (uint256) {
        return toPrecision(a, 0, RoundingMode.ROUND_HALF_UP).floor();
    }

    function mul(
        AttoDecimal.Instance memory a,
        AttoDecimal.Instance memory b,
        RoundingMode roundingMode
    ) internal pure returns (AttoDecimal.Instance memory) {
        return _fromAttoMantissa(a.mantissa * b.mantissa, roundingMode);
    }

    function div(
        AttoDecimal.Instance memory a,
        AttoDecimal.Instance memory b,
        RoundingMode roundingMode
    ) internal pure returns (AttoDecimal.Instance memory) {
        uint256 aAttoMantissa = a.mantissa * AttoDecimal.ONE_MANTISSA;
        if (roundingMode == RoundingMode.ROUND_DOWN) {
            return AttoDecimal.Instance({mantissa: aAttoMantissa / b.mantissa});
        }
        bool addition = false;
        uint256 modulo = aAttoMantissa % b.mantissa;
        if (roundingMode == RoundingMode.ROUND_UP) addition = modulo > 0;
        else {
            uint256 half = b.mantissa / 2;
            if (roundingMode == RoundingMode.ROUND_HALF_UP) addition = modulo >= half;
            else if (roundingMode == RoundingMode.ROUND_HALF_DOWN) {
                bool halfIsSignificant = b.mantissa % 2 == 0;
                addition = modulo > half || (!halfIsSignificant && modulo == half);
            } else revert("Unknown rounding mode");
        }
        return AttoDecimal.Instance({mantissa: aAttoMantissa / b.mantissa + (addition ? 1 : 0)});
    }

    function div(
        AttoDecimal.Instance memory a,
        uint256 b,
        RoundingMode roundingMode
    ) internal pure returns (AttoDecimal.Instance memory) {
        return div(a, AttoDecimal.convert(b), roundingMode);
    }

    function div(
        uint256 a,
        AttoDecimal.Instance memory b,
        RoundingMode roundingMode
    ) internal pure returns (AttoDecimal.Instance memory) {
        return div(AttoDecimal.convert(a), b, roundingMode);
    }

    function div(
        uint256 a,
        uint256 b,
        RoundingMode roundingMode
    ) internal pure returns (AttoDecimal.Instance memory) {
        return div(AttoDecimal.convert(a), AttoDecimal.convert(b), roundingMode);
    }

    function toPrecision(
        AttoDecimal.Instance memory a,
        uint8 decimals,
        RoundingMode roundingMode
    ) internal pure returns (AttoDecimal.Instance memory) {
        require(decimals < AttoDecimal.EXPONENTIATION, "Exponentiation overflow");
        uint256 minSignificantMantissa = 10**(AttoDecimal.EXPONENTIATION - decimals);
        uint256 halfOfMinSignificantMantissa = minSignificantMantissa / 2;
        uint256 fractional = a.mantissa % minSignificantMantissa;
        bool addition = _calculateAddition(fractional, roundingMode, halfOfMinSignificantMantissa);
        uint256 mantissa = (a.mantissa / minSignificantMantissa + (addition ? 1 : 0)) * minSignificantMantissa;
        return AttoDecimal.Instance(mantissa);
    }

    function toPrecision(AttoDecimal.Instance memory a, uint8 decimals)
        internal
        pure
        returns (AttoDecimal.Instance memory)
    {
        return toPrecision(a, decimals, RoundingMode.ROUND_HALF_UP);
    }

    function toFraction(AttoDecimal.Instance memory a) internal pure returns (uint256 mantissa, uint8 exponentiation) {
        if (a.mantissa == 0) return (mantissa, exponentiation);
        mantissa = a.mantissa;
        while (true) {
            if (mantissa % 10 > 0) break;
            mantissa /= 10;
            exponentiation += 1;
        }
    }

    function _fromAttoMantissa(uint256 attoMantissa, RoundingMode roundingMode)
        internal
        pure
        returns (AttoDecimal.Instance memory)
    {
        uint256 fractional = attoMantissa % AttoDecimal.ONE_MANTISSA;
        bool addition = _calculateAddition(fractional, roundingMode, AttoDecimal.HALF_MANTISSA);
        return AttoDecimal.Instance({mantissa: attoMantissa / AttoDecimal.ONE_MANTISSA + (addition ? 1 : 0)});
    }

    function _calculateAddition(
        uint256 fractional,
        RoundingMode roundingMode,
        uint256 halfMantissa
    ) private pure returns (bool) {
        if (roundingMode == RoundingMode.ROUND_DOWN) return false;
        if (roundingMode == RoundingMode.ROUND_UP) return fractional > 0;
        if (roundingMode == RoundingMode.ROUND_HALF_UP) return fractional >= halfMantissa;
        if (roundingMode == RoundingMode.ROUND_HALF_DOWN) return fractional > halfMantissa;
        revert("Unknown rounding mode");
    }
}
