// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "../AttoDecimal.sol";

contract AttoDecimalComparatorsMock {
    using AttoDecimal for AttoDecimal.Instance;

    function compare(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b) external pure returns (int8) {
        return a.compare(b);
    }

    function compare(AttoDecimal.Instance memory a, uint256 b) external pure returns (int8) {
        return a.compare(b);
    }

    function eq(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b) external pure returns (bool) {
        return a.eq(b);
    }

    function eq(AttoDecimal.Instance memory a, uint256 b) external pure returns (bool) {
        return a.eq(b);
    }

    function gt(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b) external pure returns (bool) {
        return a.gt(b);
    }

    function gt(AttoDecimal.Instance memory a, uint256 b) external pure returns (bool) {
        return a.gt(b);
    }

    function gte(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b) external pure returns (bool) {
        return a.gte(b);
    }

    function gte(AttoDecimal.Instance memory a, uint256 b) external pure returns (bool) {
        return a.gte(b);
    }

    function lt(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b) external pure returns (bool) {
        return a.lt(b);
    }

    function lt(AttoDecimal.Instance memory a, uint256 b) external pure returns (bool) {
        return a.lt(b);
    }

    function lte(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b) external pure returns (bool) {
        return a.lte(b);
    }

    function lte(AttoDecimal.Instance memory a, uint256 b) external pure returns (bool) {
        return a.lte(b);
    }
}
