pragma solidity ^0.5.0;

contract Contract {
  address a;
  address b;
  address c;
  address d;


  function branch(address addr) public {
    if(addr == a) {
      require(msg.sender == b); // guard
      selfdestruct(msg.sender); // safe
    } else {
      c = addr;
    }
  }

  function branch2(address addr) public {
    if(addr == c) {
      require(msg.sender == d); // not a guard (d not safe)
      selfdestruct(msg.sender); // vulnerable
    } else {
      d = addr;
    }
  }
}
