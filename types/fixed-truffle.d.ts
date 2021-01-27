interface Deployer {
  deploy<T extends Truffle.ContractInstance, C extends Truffle.Contract<T> = Truffle.Contract<T>>(
    contract: C,
    ...args: Parameters<C["new"]>,
  ): Promise<T> & Deployer;
  then(cb: () => unknown): Promise<unknown>;
}

type Migration = (deploy: Deployer, network: string, accounts: Truffle.Accounts) => void;

type MutationMethod<
  A extends any[],
  E extends Truffle.AnyEvent,
  M extends (...args: A) => Promise<Truffle.TransactionResponse<E>>,
  C
> = M & {
  call(...args: A): Promise<C>;
  sendTransaction(...args: A): Promise<string>;
  estimateGas(...args: A): Promise<number>;
}
