// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "../TwoStageOwnable.sol";

contract TwoStageOwnableMock is TwoStageOwnable {
    constructor(address owner_) public TwoStageOwnable(owner_) {}
}
