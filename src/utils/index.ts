import { WebsocketProvider } from "web3-core";

export * from "./constants";
export * from "./testReject";
export * from "./testTwoStageOwnable";

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
