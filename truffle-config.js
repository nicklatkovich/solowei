module.exports = {
  networks: {
    development: { host: "127.0.0.1", network_id: "*", port: 8545, confirmations: 0, skipDryRun: true },
  },
  compilers: {
    solc: {
      version: "0.6.12",
      docker: false,
      settings: { optimizer: { enabled: false, runs: 200 }, evmVersion: "constantinople" },
    },
  },
  plugins: ["solidity-coverage"],
};
