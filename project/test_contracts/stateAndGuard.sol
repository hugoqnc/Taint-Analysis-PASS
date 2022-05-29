pragma solidity ^0.5.0;

contract Contract {
  address owner;
  int y;

  function func1(int x) public {
    y = y + x;  // y is trusted because of the following guard
    require(msg.sender == owner); // guard
    selfdestruct(msg.sender);     // safe
  }

  function func2() public {
    require(msg.sender == owner || y > 1); // guard
    selfdestruct(msg.sender);              // safe
  }
  
}
