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
    require(msg.sender == msg.sender); // guard
    if (y > 0) {
        if (x > 0) {
            addr = admin;
        }
    }
    require(msg.sender == addr);  // guard
    selfdestruct(msg.sender);
  }
}
