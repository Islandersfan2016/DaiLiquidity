require("@nomiclabs/hardhat-ethers");

module.exports = {
  defaultNetwork: "kovan",
  networks: {
    hardhat: {
    },
    kovan: {
      url: "https://kovan.infura.io",
      accounts: [privateKey1, privateKey2, ...]
    }
  },
  solidity: {
    version: "0.5.15",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000
  }
}