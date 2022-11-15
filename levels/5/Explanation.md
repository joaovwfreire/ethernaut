Instance address: 0x3dea6e9a46031D76e9D83bCc119785a604098Ef0

Level address: 0xDc0c34CFE029b190Fc4A6eD5219BF809F04E57A3

Level instance creation transaction: https://goerli.etherscan.io/tx/0xe6ce3cd7a96b77f268c10138934ffcba6709f9bad9542cac639a6a05961ea706
Level instance submission transaction: https://goerli.etherscan.io/tx/0x83588a9985bcf9d87180285c126e27e6313cc54349b84e1d5f89a910c715f587

Ethernaut asks us to withdraw as many tokens as possible.
For this exploitation, the only method that accepts user-input directly or indirectly is transfer().

The intention is to withdraw a value bigger than one's original balance. Since the balances mapping maps addresses to uints and _value is an uint as well, we can conclude that
any negative value placed will actually represent an overflown positive integer. If balances[addressX] becomes - 3; the contract will actually display the value 2^256 -3.

For that reason, the _value passed at the transfer function should be equal to a user's balance minus one. 

