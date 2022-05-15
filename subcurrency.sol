pragma solidity >=0.7.0 <0.9.0


//The contract allows only the creator to creat new coins (different issuance schemes are possible)
//Any one can send coins to eact other without  a need for registering with user name and password.  All that is needed is etehreum key pair.

contract Coin {
    address public minter;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    //only runs when we deploy contract
    constructor() {
        minter = msg.sender;
    }

    //make new coins and send thenm to address
    //make sure only owner can send coins
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver]  += amount;
    }


    //send any amount of coins to and existing address

    error insufficientBalance(uint requested, uint availables);

    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])
        revert insufficentBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }

}