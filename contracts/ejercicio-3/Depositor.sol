// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IVaultV2 {
    function deposit() external payable;
    function withdraw() external;
}

contract Depositor is Ownable {

    IVaultV2 public immutable vault;

    constructor(address vaultContractAddress) {
        vault = IVaultV2(vaultContractAddress);
    }

    function depositToVault() external payable onlyOwner {
        vault.deposit{value: msg.value}();
        // La sintaxis para enviar ETH de un contrato a otro podés verla acá https://docs.soliditylang.org/en/v0.8.7/control-structures.html#external-function-calls
    }

    function withdrawFromVault() external onlyOwner {
        vault.withdraw();
    }

    function withdrawAllEther() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // 1. ¿Por qué es necesaria esta función?
    // sirve para que un contrato pueda recibir ether de otro contrato
    // 2. ¿Qué pasa si la borramos?
    //  el contrato no va a poder recibir ether a traves de .transfer
    // 3. Aún así, ¿es suficiente? ¿No necesitamos lógica adicional? no, si
    // 4. De ser necesaria, ¿podemos incluir esa lógica acá?
    //  no, en otra funcion, como withdrawAllEther
    //  reverts on failure, forwards 2300 gas stipend, not adjustable
    receive() external payable {}
}
