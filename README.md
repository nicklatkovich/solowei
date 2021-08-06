# SOLOWEI

A library for solidity smart contract development. It contrains helpers that are not added to openzeppelin, but can also be very useful.

# Usage

Package contains abstract contracts and libraries. They may be imported using
```ts
import "solowei/contracts/{NAME_OF_CONTRACT_OR_LIBRARY}";
```

Example of usage:
```ts
pragma solidity ^0.8.6;

import "solowei/contracts/AttoDecimal.sol";
import "solowei/contracts/TwoStageOwnable.sol";

contract Example is TwoStageOwnable {
    using AttoDecimal for AttoDecimal.Instance;

    AttoDecimal.Instance private _decimal;

    function decimal()
        public
        view
        returns (
            uint256 mantissa,
            uint256 base,
            uint256 exponentiation
        )
    {
        return _decimal.toTuple();
    }

    constructor() TwoStageOwnable(msg.sender) {
        _decimal = AttoDecimal.convert(123).div(234);
    }

    function double() external onlyOwner returns (bool success) {
        _decimal = _decimal.mul(2);
        return true;
    }

    function set(uint256 mantissa) external onlyOwner returns (bool success) {
        _decimal = AttoDecimal.Instance(mantissa);
        return true;
    }
}
```

# Entities
* [TrySafeMath](#trysafemath)
* [TwoStageOwnable](#twostageownable)
* [AttoDecimal](#attodecimal)
* [AttoDecimalAdvanced](#attodecimaladvanced)

## TrySafeMath
Library to working with safe math. But instead of revert transaction it returns result as tuple of operation status (succeed or not) and answer. Most likely this will be implemented in openzepplin, but for now you may use this implementation.

## TwoStageOwnable
Abstract contract similar to openzepplin's `Ownable` but with two step ownership transfering.
```ts
view nominatedOwner(): address
view owner(): address
acceptOwnership()
nominateNewOwner(address)
modifier onlyOwner()
event OwnerChanged(address indexed)
event OwnerNominated(address indexed)
internal _nominateNewOwner(address)
internal _setOwner(address)
```
Note that when owner is changed (also using internal `_setOwner` method) nominated owner is cleared.

## AttoDecimal
Library for working with float numbers with 18 decimal places.
```ts
BASE: 10
EXPONENTIATION: 18
ONE_MANTISSA: 1e18
ONE_TENTH_MANTISSA: 1e17
HALF_MANTISSA: 5e17
SQUARED_ONE_MANTISSA: 1e36
MAX_INTEGER: 115792089237316195423570985008687907853269984665640564039457
static maximum(): MAX_INTEGER + 0.584007913129639935
static zero(): 0.0
static one(): 1.0
static convert(uint): decimal
static sub(uint, decimal): decimal
static div(uint, decimal): decimal
static div(uint, uint): decimal
static idiv(uint, decimal): decimal
static mod(uint, decimal): decimal
static sum(decimal[]): decimal
compare(decimal): -1| 0 | 1
compare(uint): -1 | 0 | 1
add(uint|decimal): decimal
sub(uint|decimal): decimal
mul(uint|decimal): decimal
div(uint|decimal): decimal
idiv(uint|decimal): decimal
mod(uint|decimal): decimal
floor(): uint
ceil(): uint
round(): uint
eq(decimal|uint): bool
gt(decimal|uint): bool
gte(decimal|uint): bool
lt(decimal|uint): bool
lte(decimal|uint): bool
isInteger(): bool
isPositive(): bool
isZero(): bool
toTuple(): [mantissa:uint, base:10, exponentiation:18]
```

## AttoDecimalAdvanced
Library that provides rounding operations for [atto-decimals](#attodecimal). For methods `mul` and `div` rounding mode affects 18th digit.
```ts
enum RoundingMode { ROUND_UP, ROUND_DOWN, ROUND_HALF_UP, ROUND_HALF_DOWN }
static div(uint, decimal, RoundingMode)
round(?RoundingMode): uint
mul(decimal, RoundingMode): decimal
div(decimal|uint, RoundingMode): decimal
toPrecision(uint): decimal
toPrecision(uint, RoundingMode): decimal
toFraction() // note: not constant gas cost
```
