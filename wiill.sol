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

    address payable[] familyWallets; // store all family addresses

    mapping(address => uint) inheritance;  //mappping through addresses which has its own integer

    // set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public onlyOwner {  //only owner can set ingeritance
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    // Pay each family member based on their wallet address

    function payout() private mustBeDeceased {
        for(uint i=0;i<familyWallets.length;i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    // oracle switch simulation
    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}