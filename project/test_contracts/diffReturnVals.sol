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
    return owner;
  }

  function kill() public {
    address y = foo(msg.sender);
    require(y == msg.sender); // guard, b.c. either a trusted variable (owner) is returned or msg.sender itself
    selfdestruct(owner);
  }
}
