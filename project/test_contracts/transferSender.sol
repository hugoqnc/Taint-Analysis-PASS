pragma solidity ^0.5.0;

contract Contract {
  address owner;
  function check(address x) public returns(bool) {
    address y = x;
    return (y == y);
  }
  function foo() public {
    bool b = check(owner);        
    selfdestruct(msg.sender);      
  }
  function bar() public {
    address a = msg.sender;
    bool b = check(a);           
    selfdestruct(msg.sender);     
  }
}
