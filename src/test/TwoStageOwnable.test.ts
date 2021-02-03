import { setAccounts, getAccounts } from "@test-utils";
import { testTwoStageOwnable } from "@utils";

const TwoStageOwnableMock = artifacts.require("TwoStageOwnableMock");

contract("TwoStageOwnable", (accounts) => {
  setAccounts(accounts);
  testTwoStageOwnable((owner) => TwoStageOwnableMock.new(owner), getAccounts);
});
