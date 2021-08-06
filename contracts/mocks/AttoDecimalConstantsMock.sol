// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
pragma experimental ABIEncoderV2;

import "../AttoDecimal.sol";

contract AttoDecimalConstantsMock {
    using AttoDecimal for AttoDecimal.Instance;

    function base() external pure returns (uint256) {
        return AttoDecimal.BASE;
    }

    function exponentiation() external pure returns (uint256) {
        return AttoDecimal.EXPONENTIATION;
    }

    function oneMantissa() external pure returns (uint256) {
        return AttoDecimal.ONE_MANTISSA;
    }

    function oneTenthMantissa() external pure returns (uint256) {
        return AttoDecimal.ONE_TENTH_MANTISSA;
    }

    function halfMantissa() external pure returns (uint256) {
        return AttoDecimal.HALF_MANTISSA;
    }

    function squaredOneMantissa() external pure returns (uint256) {
        return AttoDecimal.SQUARED_ONE_MANTISSA;
    }

    function maxInteger() external pure returns (uint256) {
        return AttoDecimal.MAX_INTEGER;
    }

    function maximum() external pure returns (AttoDecimal.Instance memory) {
        return AttoDecimal.maximum();
    }

    function zero() external pure returns (AttoDecimal.Instance memory) {
        return AttoDecimal.zero();
    }

    function one() external pure returns (AttoDecimal.Instance memory) {
        return AttoDecimal.one();
    }
}
