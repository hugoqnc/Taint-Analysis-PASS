pragma solidity ^0.5.0;

// Tainted
contract Contract {
  address payable owner;
  address payable something;

  function kill(address payable x) public payable {
    if (owner == something) {
        something = owner;
        if (true) {
            owner = x;
        } else {
            selfdestruct(owner);
        }
    } else {
        owner = something;
    }
    require(owner == owner); // Not a guard
    selfdestruct(owner);
  }
}
