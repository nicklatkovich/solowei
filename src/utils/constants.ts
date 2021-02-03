export const ZERO_ADDRESS = "0x".padEnd(42, "0");
export const ONE_ATTO_MANTISSA = "1".padEnd(19, "0");
export const MAX_UINT256 = "115792089237316195423570985008687907853269984665640564039457584007913129639935";

export const REVERT_WITHOUT_AN_ERROR: string = "Returned error: VM Exception while processing transaction: revert";
export const REVERT_PREFIX = `${REVERT_WITHOUT_AN_ERROR} `;
