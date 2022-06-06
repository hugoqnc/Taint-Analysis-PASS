pragma solidity ^0.5.0;

contract Contract {
  address payable user;
  address payable owner;

  function registerUser() public {
    user = msg.sender;
  }

  function foo(address x) public returns (address){
    if (x == msg.sender){
        return x;
    }
    return user;
  }

  function kill(address payable a) public {
    address y = foo(msg.sender);
    require(y == msg.sender); // not a guard, b.c. foo() could return an untrusted value (user)
    selfdestruct(a);
  }
}
