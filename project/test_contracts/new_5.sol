pragma solidity ^0.5.0;

contract Contract {
  address a;
  address b;
  address c;
  address d;


  function branch(address addr) public {
    if(msg.sender == a) { // guard, so we trust msg.sender and addr
      selfdestruct(msg.sender); // safe
    } else {
      require(msg.sender == addr || b == addr); // not a guard
      selfdestruct(msg.sender); // safe because we trust msg.sender
    }
  }

  function branch2(address addr) public {
    if(addr == c) {
      b == addr;
    } else {
      require(msg.sender == a); // guard
      c = addr;
    }
  }
}
