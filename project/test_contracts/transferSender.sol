pragma solidity ^0.5.0;

contract Contract {
  address owner;
  function check(address x, address x2) public returns(bool,bool) {
    address y = x;
    address y2 = x2;
    return ((y2 == y2), (y == y));
  }
  function foo() public {
    (bool b, bool b2) = check(owner, owner);        
    selfdestruct(msg.sender);      
  }
  function bar() public {
    address a = address(0xDEADBEEF);
    if (msg.sender == msg.sender) {
      a = address(0xDEADB00F);
    }
    (bool b, bool b2) = check(owner, a);           
    selfdestruct(msg.sender);     
  }
}
