// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "../TwoStageOwnable.sol";

contract TwoStageOwnableMock is TwoStageOwnable {
    constructor(address owner_) TwoStageOwnable(owner_) {}
}
