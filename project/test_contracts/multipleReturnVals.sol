pragma solidity ^0.5.0;

contract Contract {
  address payable user;
  address payable owner;

  function registerUser(address payable x) public returns (address payable, address) {
    require(msg.sender == user); // guard
    return (x, owner);
  }

  function changeOwner(address payable newOwner) public {
    require(msg.sender == user);
    owner = newOwner;
  }

  function kill(address payable x) public {
    (address payable a, address b) = registerUser(x);
    selfdestruct(a); // safe, b.c. a is trusted
  }
}
