// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/YnAsset.sol";

interface IStrategy {
    /// @notice The underlying token for shares in this Strategy
    function underlyingToken() external view returns (address);
}

contract VerifyStrategies is Script {
    function run() external {
        verifyStrategy(0x6C50dfEdD1AFfEB9610b91e4A73a4424D6CB3494, 0x810615698eeAEE37efA98F821411aACe4e0d14e5, "ynBTC");
        verifyStrategy(0x1b4F6959f073F5eD89b1169cC365A2279B3e45DE, 0xf1BD6f0da70926d0d4c9Ed76ef4DBF6963972a13, "ynSBTC");
    }

    function verifyStrategy(address strategyAddress, address tokenAddress, string memory tokenName) internal {
        IStrategy strategy = IStrategy(strategyAddress);
        YnAsset token = YnAsset(tokenAddress);

        address underlyingToken = strategy.underlyingToken();

        if (underlyingToken == address(token)) {
            console.log("Verification successful: Strategy is for ", tokenName);
        } else {
            console.log("Verification failed: Strategy is not for ", tokenName);
            console.log("Expected: ", address(token));
            console.log("Actual: ", underlyingToken);
        }
    }
}
