// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "https://github.com/APexBlockchainDevelopments/ERC4626FeesUpdate/blob/main/ERC4626Fees.sol";


contract DemoVault is ERC4626Fees {

    address payable public owner;
    uint256 public entryFeeBasisPoints;
    uint256 public exitFeeBasisPoints;

    constructor(IERC20 _asset, uint256 _startingEntryFeeBasisPoints, uint256 _startingExitFeeBasisPoints) ERC4626(_asset) ERC20("Vault Demo Token", "vDTK"){
        owner = payable(msg.sender);
        entryFeeBasisPoints = _startingEntryFeeBasisPoints;
        exitFeeBasisPoints = _startingExitFeeBasisPoints;
    }

    // === Fee configuration ===

    function _entryFeeBasisPoints() internal view override returns (uint256) {
        return entryFeeBasisPoints; // replace with e.g. 100 for 1%
    }

    function _exitFeeBasisPoints() internal view override returns (uint256) {
        return exitFeeBasisPoints; // replace with e.g. 100 for 1%
    }

    function _entryFeeRecipient() internal view override returns (address) {
        return owner; // replace with e.g. a treasury address
    }

    function _exitFeeRecipient() internal view override returns (address) {
        return owner; // replace with e.g. a treasury address
    }

    function newEntryFee(uint256 _newEntryFee) external {
        require(msg.sender == owner, "You are not permited to change the fees");
        entryFeeBasisPoints = _newEntryFee;
    }

    function newExitFee(uint256 _newExitFee) external {
        require(msg.sender == owner, "You are not permited to change the fees");
        exitFeeBasisPoints = _newExitFee;
    }

}
