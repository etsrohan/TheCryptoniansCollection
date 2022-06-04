import {HardhatUserConfig} from 'hardhat/types';
import 'hardhat-deploy';
import 'hardhat-deploy-ethers';
import * as dotenv from "dotenv";
import "@typechain/hardhat";
dotenv.config();
import "@nomiclabs/hardhat-etherscan";
import "solidity-coverage";

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
        {
            version: "0.7.6",
        },
        {
            version: "0.8.7",
        },
        {
            version: "0.6.12",
        },
    ],
  },
  networks: {
    bsc_testnet: {
      url:"https://speedy-nodes-nyc.moralis.io/90a1fc90eb42ab6305b6e9ba/bsc/testnet",
      chainId: 97,
      accounts: [process.env.DEPLOYER_PRIVATE_KEY as string],
    },
    rinkeby: {
      url:"https://speedy-nodes-nyc.moralis.io/90a1fc90eb42ab6305b6e9ba/eth/rinkeby",
      chainId: 4,
      accounts: [process.env.DEPLOYER_PRIVATE_KEY as string],
    },
  },
  namedAccounts: {
    deployer: 0,
  },
  paths: {
      sources: 'src',
  },
  typechain: {
    outDir: "src/types",
    target: "ethers-v5",
  }
};
export default config;