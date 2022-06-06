pragma solidity ^0.5.0;

contract Contract {
  address payable owner;
  address payable admin;
  int c;
  function setc(int newc) public {
    c = newc;
  }
  function foo(int x, int y) public {
    address addr = owner;
    if (y > 0) {
        require(msg.sender == msg.sender); // guard
        if (x > 0) {
            addr = admin;
        }
    }
    require(msg.sender == addr);  // not a guard
    selfdestruct(msg.sender);     // vulnerable
  }
}
