// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/YnAsset.sol";
import "../src/YnVault.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "forge-std/console.sol";


contract DeployYnSUSD is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        console.log("Deployer address:", deployerAddress);

        vm.startBroadcast(deployerPrivateKey);

        // Deploy ynUSD implementation
        YnAsset ynUSDImpl = new YnAsset();
        console.log("ynUSD implementation deployed at:", address(ynUSDImpl));

        // Deploy ynUSD proxy
        TransparentUpgradeableProxy ynUSDProxy = new TransparentUpgradeableProxy(
            address(ynUSDImpl),
            deployerAddress,
            abi.encodeWithSelector(YnAsset(address(0)).initialize.selector, "YieldNest USD", "ynUSD", deployerAddress)
        );
        console.log("ynUSD proxy deployed at:", address(ynUSDProxy));

        // Deploy YnSUSD implementation
        YnVault ynSUSDImpl = new YnVault();
        console.log("YnSUSD implementation deployed at:", address(ynSUSDImpl));

        // Deploy YnSUSD proxy
        TransparentUpgradeableProxy ynSUSDProxy = new TransparentUpgradeableProxy(
            address(ynSUSDImpl),
            deployerAddress,
            abi.encodeWithSelector(YnVault(address(0)).initialize.selector, 
                IERC20(address(ynUSDProxy)), 
                "YieldNest Savings USD Vault",
                "YnSUSD",
                deployerAddress
            )
        );
        console.log("YnSUSD proxy deployed at:", address(ynSUSDProxy));

        

        vm.stopBroadcast();
    }
}

