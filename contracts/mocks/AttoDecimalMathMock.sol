// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "../AttoDecimal.sol";

contract AttoDecimalMathMock {
    using AttoDecimal for AttoDecimal.Instance;

    function add(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b)
        external
        pure
        returns (AttoDecimal.Instance memory)
    {
        return a.add(b);
    }

    function add(AttoDecimal.Instance memory a, uint256 b) external pure returns (AttoDecimal.Instance memory) {
        return a.add(b);
    }

    function sub(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b)
        external
        pure
        returns (AttoDecimal.Instance memory)
    {
        return a.sub(b);
    }

    function sub(AttoDecimal.Instance memory a, uint256 b) external pure returns (AttoDecimal.Instance memory) {
        return a.sub(b);
    }

    function sub(uint256 a, AttoDecimal.Instance memory b) external pure returns (AttoDecimal.Instance memory) {
        return AttoDecimal.sub(a, b);
    }

    function mul(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b)
        external
        pure
        returns (AttoDecimal.Instance memory)
    {
        return a.mul(b);
    }

    function mul(AttoDecimal.Instance memory a, uint256 b) external pure returns (AttoDecimal.Instance memory) {
        return a.mul(b);
    }

    function div(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b)
        external
        pure
        returns (AttoDecimal.Instance memory)
    {
        return a.div(b);
    }

    function div(AttoDecimal.Instance memory a, uint256 b) external pure returns (AttoDecimal.Instance memory) {
        return a.div(b);
    }

    function div(uint256 a, AttoDecimal.Instance memory b) external pure returns (AttoDecimal.Instance memory) {
        return AttoDecimal.div(a, b);
    }

    function div(uint256 a, uint256 b) external pure returns (AttoDecimal.Instance memory) {
        return AttoDecimal.div(a, b);
    }

    function idiv(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b) external pure returns (uint256) {
        return a.idiv(b);
    }

    function idiv(AttoDecimal.Instance memory a, uint256 b) external pure returns (uint256) {
        return a.idiv(b);
    }

    function idiv(uint256 a, AttoDecimal.Instance memory b) external pure returns (uint256) {
        return AttoDecimal.idiv(a, b);
    }

    function mod(AttoDecimal.Instance memory a, AttoDecimal.Instance memory b)
        external
        pure
        returns (AttoDecimal.Instance memory)
    {
        return a.mod(b);
    }

    function mod(AttoDecimal.Instance memory a, uint256 b) external pure returns (AttoDecimal.Instance memory) {
        return a.mod(b);
    }

    function mod(uint256 a, AttoDecimal.Instance memory b) external pure returns (AttoDecimal.Instance memory) {
        return AttoDecimal.mod(a, b);
    }

    function floor(AttoDecimal.Instance memory a) external pure returns (uint256) {
        return a.floor();
    }

    function ceil(AttoDecimal.Instance memory a) external pure returns (uint256) {
        return a.ceil();
    }

    function round(AttoDecimal.Instance memory a) external pure returns (uint256) {
        return a.round();
    }
}
