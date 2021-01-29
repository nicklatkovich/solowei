import { WebsocketProvider } from "web3-core";

export const ZERO_ADDRESS = "0x".padEnd(42, "0");
export const ONE_ATTO_MANTISSA = "1".padEnd(19, "0");
export const MAX_UINT256 = "115792089237316195423570985008687907853269984665640564039457584007913129639935";

export const REVERT_WITHOUT_AN_ERROR: string = "Returned error: VM Exception while processing transaction: revert";
export const REVERT_PREFIX = `${REVERT_WITHOUT_AN_ERROR} `;

export function testReject(func: () => Promise<unknown>, revertMessage?: string) {
  let error: Error | null = null;
  it('should rejects', async () => {
    try {
      await func();
    } catch (err) {
      error = err;
      return;
    }
    throw new Error('not rejects');
  });
  let isRevert = false;
  it('revert instructions', function () {
    if (!error) this.skip();
    assert(
      error.message.startsWith(REVERT_WITHOUT_AN_ERROR),
      `error "${error.message}" is not revert instruction error`,
    );
    isRevert = true;
  });
  if (revertMessage === undefined) {
    it('without any message', function () {
      if (!isRevert || !error) this.skip();
      else assert(error.message === REVERT_WITHOUT_AN_ERROR);
    });
  } else {
    it(`with message "${revertMessage}"`, function () {
      if (!isRevert || !error) this.skip();
      else assert(error.message.startsWith(REVERT_PREFIX + revertMessage), `found: ${error.message}`);
    });
  }
}

export async function mine(count: number) {
  const provider = web3.currentProvider;
  if (!provider || typeof provider === "string") throw new Error("provider not found");
  for (let i = 0; i < (count || 1); i++) {
    await new Promise<void>((resolve) => (provider as WebsocketProvider).send({
      jsonrpc: '2.0',
      method: 'evm_mine',
      params: [],
      id: 0,
    }, () => resolve()));
  }
}

export type UnPromisify<T> = T extends Promise<infer U> ? U : T;
