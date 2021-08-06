// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "../AttoDecimal.sol";

contract AttoDecimalUtilsMock {
    using AttoDecimal for AttoDecimal.Instance;

    function convert(uint256 integer) external pure returns (AttoDecimal.Instance memory) {
        return AttoDecimal.convert(integer);
    }

    function isInteger(AttoDecimal.Instance memory a) external pure returns (bool) {
        return a.isInteger();
    }

    function isPositive(AttoDecimal.Instance memory a) external pure returns (bool) {
        return a.isPositive();
    }

    function isZero(AttoDecimal.Instance memory a) external pure returns (bool) {
        return a.isZero();
    }

    function sum(AttoDecimal.Instance[] memory array) internal pure returns (AttoDecimal.Instance memory result) {
        return AttoDecimal.sum(array);
    }

    function toTuple(AttoDecimal.Instance memory a)
        internal
        pure
        returns (
            uint256 mantissa,
            uint256 base,
            uint256 exponentiation
        )
    {
        return a.toTuple();
    }
}
