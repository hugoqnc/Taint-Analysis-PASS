pragma solidity ^0.5.0;

// Safe
contract Contract {
  address payable owner;
  address payable something;

  function kill(address payable x) public payable {
    if (owner == something) {
        something = owner;
        if (true) {
            selfdestruct(something);
        } else {
            selfdestruct(owner);
        }
    } else {
        owner = something;
    }
    require(msg.sender == owner); // Guard
    selfdestruct(owner);
  }
}
