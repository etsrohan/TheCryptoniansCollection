// Import statements
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/dist/types";
import { BigNumberish, ethers } from "ethers";

// Deploy Function
const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
    const { deployments, getNamedAccounts } = hre;
    const { deploy } = deployments;
    const { deployer } = await getNamedAccounts();

    // Change these when deploying new currency
    // =======================================================================
    await deploy("TheCryptoniansCollection", {
        contract: "TheCryptoniansCollection",
        from: deployer,
        args: [],
        log: true,
        skipIfAlreadyDeployed: true
    });
}

export default func;
func.tags = ["TheCryptoniansCollection"]