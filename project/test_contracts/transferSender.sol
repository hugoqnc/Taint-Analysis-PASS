pragma solidity ^0.5.0;

contract Contract {
  address owner;

  function identity(address x) public returns(address) {
    address y = x;
    require(msg.sender==msg.sender);
    return y;
  }

  function check(address x, address x2) public returns(bool,bool) {
    address x = x;
    address x2 = x2;
    address y = identity(x);
    address y2 = identity(x2);
    if (true) {}
    address m = msg.sender;
    return ((y2 == y2), (y == y));
  }
  function foo() public {
    (bool b, bool b2) = check(owner, owner);        
    selfdestruct(msg.sender);      
  }
  function bar() public {
    address a = address(0xDEADBEEF);
    //if (msg.sender == msg.sender) {
      a = msg.sender;
    //}
    (bool b, bool b2) = check(owner, a);
    //require(b);
    //require(b2);       
    selfdestruct(msg.sender);     
  }
}
