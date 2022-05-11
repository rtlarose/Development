pragma solidity ^0.5.7;

contract Will {
    address owner;  // address of grandfathers wallet
    uint fortune;   // amount in owner's wallet
    bool deceased;  // validate owner is deceased to pay out fortune 

    constructor() payable public { // special function that is deployed when contract is called (payable allows send and receive ether)
        owner = msg.sender;  // msg sender represents address being called
        fortune = msg.value;  //msg value tells us how much ether is being sent
        deceased = false;
    } 

    // create modifier so the only person that can call contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;  // tell function to continue the function after modifier is complete
    }

    // create modifier so that we can only allocate funds if owner is deceased
    modifier mustBeDeceased {
        require(deceased == true);
        _;  // tell function to continue the function after modifier is complete
    }
}