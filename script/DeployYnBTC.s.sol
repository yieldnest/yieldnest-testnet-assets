// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/YnAsset.sol";
import "../src/YnVault.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "forge-std/console.sol";

contract DeployYnBTC is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        console.log("Deployer address:", deployerAddress);

        vm.startBroadcast(deployerPrivateKey);

        // Deploy ynBTC implementation
        YnAsset ynBTCImpl = new YnAsset();
        console.log("ynBTC implementation deployed at:", address(ynBTCImpl));

        // Deploy ynBTC proxy
        TransparentUpgradeableProxy ynBTCProxy = new TransparentUpgradeableProxy(
            address(ynBTCImpl),
            deployerAddress,
            abi.encodeWithSelector(
                YnAsset(address(0)).initialize.selector, "YieldNest Bitcoin", "ynBTC", deployerAddress
            )
        );
        console.log("ynBTC proxy deployed at:", address(ynBTCProxy));

        // Deploy YnSBTC implementation
        YnVault ynSBTCImpl = new YnVault();
        console.log("YnSBTC implementation deployed at:", address(ynSBTCImpl));

        // Deploy YnSBTC proxy
        TransparentUpgradeableProxy ynSBTCProxy = new TransparentUpgradeableProxy(
            address(ynSBTCImpl),
            deployerAddress,
            abi.encodeWithSelector(
                YnVault(address(0)).initialize.selector,
                IERC20(address(ynBTCProxy)),
                "YieldNest Savings Bitcoin Vault",
                "YnSBTC",
                deployerAddress
            )
        );
        console.log("YnSBTC proxy deployed at:", address(ynSBTCProxy));

        vm.stopBroadcast();
    }
}
