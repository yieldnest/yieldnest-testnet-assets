// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC4626Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./YnAsset.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract YnVault is Initializable, ERC4626Upgradeable, OwnableUpgradeable {
    function initialize(IERC20 asset, string memory name, string memory symbol, address owner) public initializer {
        __ERC4626_init(asset);
        __ERC20_init(name, symbol);
        __Ownable_init(owner);
    }
}
