let _accounts: readonly string[];

export const setAccounts = (accounts: readonly string[]) => {
  _accounts = accounts;
};

export const getAccounts: () => readonly string[] = () => _accounts;
