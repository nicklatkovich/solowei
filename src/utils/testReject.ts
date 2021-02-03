import { REVERT_WITHOUT_AN_ERROR, REVERT_PREFIX } from "./constants";

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
