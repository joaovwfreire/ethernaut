// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;


contract Attack {
    uint unusedUint0;
    uint unusedUint1;
    uint owner;

    function setTime(uint _time) public {
    owner = _time;
  }
}