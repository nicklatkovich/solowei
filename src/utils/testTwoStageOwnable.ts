import assert from "assert";

import { TwoStageOwnableInstance } from "@contracts";
import { OwnerChanged, OwnerNominated } from "@contracts/TwoStageOwnable";
import { ZERO_ADDRESS } from "./constants";
import { testReject } from "./testReject";

export type Promisable<T> = T | Promise<T>;

export function testTwoStageOwnable(
  createInstance: (owner: string) => Promisable<TwoStageOwnableInstance>,
  getAccounts: () => Promisable<readonly string[]>,
): Mocha.Suite {
  return describe("Abstract: TwoStageOwnable", () => {
    let owner: string;
    let nominatedOwner: string;
    let additionalAccount: string;
    let instance: TwoStageOwnableInstance;
    before(async () => {
      const accounts = await getAccounts();
      assert(accounts.length >= 3, "At least 3 accounts required to test TwoStageOwnable contract");
      [owner, nominatedOwner, additionalAccount] = accounts;
      instance = await createInstance(owner);
    });
    describe("When owner in contructor params is zero address", () => {
      testReject(async () => await createInstance(ZERO_ADDRESS), "Owner is zero");
    });
    describe("Ownership nominating", () => {
      describe("When called not by owner", () => {
        testReject(() => instance.nominateNewOwner(nominatedOwner, { from: additionalAccount }), "Not owner");
      });
      describe("When nominating owner to ownership", () => {
        testReject(() => instance.nominateNewOwner(owner, { from: owner }), "Already owner");
      });
      describe("When should succeed", () => {
        let receipt: Truffle.TransactionResponse<OwnerNominated> | null = null;
        it("not rejects", async () => {
          receipt = await instance.nominateNewOwner(nominatedOwner, {
            from: owner,
          }) as Truffle.TransactionResponse<OwnerNominated>;
        });
        it("provided account should be nominated to ownership", async () => {
          const actual = await instance.nominatedOwner();
          assert.strictEqual(actual.toLowerCase(), nominatedOwner.toLowerCase());
        });
        it("tx emits single event", function () {
          if (receipt === null) throw this.skip();
          assert.strictEqual(receipt.logs.length, 1);
        });
        it("with name \"OwnerNominated\"", function () {
          if (receipt === null || receipt.logs.length < 1) throw this.skip();
          assert(receipt.logs.some((e) => e.event === "OwnerNominated"));
        });
        it("with valid nominated account address", function () {
          if (receipt === null) throw this.skip();
          const ownerNominatingLogs = receipt.logs.filter((e) => e.event === "OwnerNominated");
          if (ownerNominatingLogs.length < 1) throw this.skip();
          assert(ownerNominatingLogs.every((e) => (
            e.args.nominatedOwner.toLowerCase() === nominatedOwner.toLowerCase()
          )));
        });
      });
      describe("When account to nominate is already nominated", () => {
        before(async () => {
          const currentNominatedOwner = await instance.nominatedOwner();
          if (currentNominatedOwner.toLowerCase() !== nominatedOwner.toLowerCase()) {
            await instance.nominateNewOwner(nominatedOwner, { from: owner });
          }
        });
        let receipt: Truffle.TransactionResponse<OwnerNominated> | null = null;
        it("not rejects", async () => {
          receipt = await instance.nominateNewOwner(nominatedOwner, {
            from: owner,
          }) as Truffle.TransactionResponse<OwnerNominated>;
        });
        it("nominated owner not changed", async () => {
          const actual = await instance.nominatedOwner();
          assert.strictEqual(actual.toLowerCase(), nominatedOwner.toLowerCase());
        });
        it("tx not emits events", function () {
          if (receipt === null) throw this.skip();
          assert.strictEqual(receipt.logs.length, 0);
        });
      });
    });
    describe("Ownership accepting", () => {
      describe("When not nominated", () => {
        testReject(() => instance.acceptOwnership({ from: additionalAccount }), "Not nominated to ownership");
      });
      describe("When nominated", () => {
        before(async () => {
          const currentNominatedOwner = await instance.nominatedOwner();
          if (currentNominatedOwner.toLowerCase() !== nominatedOwner.toLowerCase()) {
            await instance.nominateNewOwner(nominatedOwner, { from: owner });
          }
        });
        let receipt: Truffle.TransactionResponse<OwnerChanged> | null = null;
        it("not rejects", async () => {
          receipt = await instance.acceptOwnership({
            from: nominatedOwner,
          }) as Truffle.TransactionResponse<OwnerChanged>;
        });
        it("contract owner changed", async () => {
          const actual = await instance.owner();
          assert.strictEqual(actual.toLowerCase(), nominatedOwner.toLowerCase());
        });
        it("nominated owner reseted", async () => {
          const actual = await instance.nominatedOwner();
          assert.strictEqual(actual, ZERO_ADDRESS);
        });
        it("tx emits single event", function () {
          if (receipt === null) throw this.skip();
          assert.strictEqual(receipt.logs.length, 1);
        });
        it("with name \"OwnerChanged\"", function () {
          if (receipt === null || receipt.logs.length < 1) throw this.skip();
          assert(receipt.logs.some((e) => e.event === "OwnerChanged"));
        });
        it("with new owner in argument", function () {
          if (receipt === null) throw this.skip();
          const ownerNominatingLogs = receipt.logs.filter((e) => e.event === "OwnerChanged");
          if (ownerNominatingLogs.length < 1) throw this.skip();
          assert(ownerNominatingLogs.every((e) => (
            e.args.newOwner.toLowerCase() === nominatedOwner.toLowerCase()
          )));
        });
      });
      after(async () => {
        const currentOwner = await instance.owner();
        if (currentOwner.toLowerCase() !== owner.toLowerCase()) {
          const currentNominatedOwner = await instance.nominatedOwner();
          if (currentNominatedOwner.toLowerCase() !== owner.toLowerCase()) {
            await instance.nominateNewOwner(owner, { from: currentOwner });
          }
          await instance.acceptOwnership({ from: owner });
        }
      });
    });
  });
}
