import assert from "assert";
import BN from "bn.js";

import { AttoDecimalComparatorsMockInstance } from "@contracts";

const AttoDecimalComparatorsMock = artifacts.require("AttoDecimalComparatorsMock");

describe("comparators", () => {
  let contract: AttoDecimalComparatorsMockInstance;
  before(async function () {
    this.timeout(7e3);
    contract = await AttoDecimalComparatorsMock.new();
  });

  describe("compare(a: decimal, b: decimal)", () => {
    describe('When "a" less than "b"', () => {
      let result: BN | null = null;
      it("should success", async () => {
        // https://github.com/ethereum-ts/TypeChain/pull/320
        // @ts-ignore
        result = await contract.methods["compare((uint256),(uint256))"]({ mantissa: 123 }, { mantissa: 234 });
      });
      it("should return -1", function () {
        if (result === null) return this.skip();
        return assert(result.eq(new BN(-1)));
      });
    });
  });
});
