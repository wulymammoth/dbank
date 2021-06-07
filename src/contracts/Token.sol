// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  //add minter variable
  address public minter;

  //add minter changed event
  event MinterChanged(address indexed from, address to);

  constructor() public payable ERC20("Decentralized Bank Currency", "DBC") {
    minter = msg.sender; // caller of this contract
  }

  // Add pass minter role function
  function passMinterRole(address dBank) public returns (bool) {
    require(msg.sender == minter, 'Error, ohnly owner can change pass minter role');
    minter = dBank;

    emit MinterChanged(msg.sender, dBank);
    return true;
  }

  // creates new tokens
  function mint(address account, uint256 amount) public {
    // check if msg.sender have minter role
    // - halts execution if this returns false
    require(msg.sender == minter, 'Error, `msg.sender` does not have a minter role');
		_mint(account, amount);
	}
}
