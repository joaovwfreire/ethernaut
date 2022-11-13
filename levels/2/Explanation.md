Level 2
==========================================================================================================================================

Deployment transaction: https://goerli.etherscan.io/tx/0xa30e49b186a8c50491c4d97359f649cdcc2fe497e5e9aef5b174af6ffbc56548
Submission transaction: https://goerli.etherscan.io/tx/0xb6fa16fe47d688c80802cfca647a7be5a22641a4a1f62d1453d1707e507b633b

-------
This challenge's task is to aquire contract ownership. 
To get started, I simply ran a ctrl-F to figure out whenever the owner variable was being used.
What got me thinking was the Fal1out() function, as it was commented as a constructor, but since it wasn't typed as one, there's not really a way the EVM interpret that as so.
When one considers that the function was also public, this meant vulnerability.
The solution doesn't require a smart contract. All needed is to get an ABI of that contract then call Fal1out() through a script. 


[Claim ownership tx with wrong account]('https://goerli.etherscan.io/tx/0x6bb75e3130fa0c7dfc3aea3a432b9410fd57c001a6e13387d8cbf61d705cb4f5')
[Claim ownership tx with correct account]('https://goerli.etherscan.io/tx/0x1e1b0994834f97777bcda78f496bee49e5ff0ff2cf5bbfffef13bb6a45b8caa4')

