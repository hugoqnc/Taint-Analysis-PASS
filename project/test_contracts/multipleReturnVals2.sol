pragma solidity ^0.5.0;

contract Contract {
  address payable user;
  address payable owner;

  function registerUser(address payable x) public returns (address payable, address) {
    require(msg.sender == owner); // not a guard, b.c. owner is not trusted
    return (x, owner);
  }

  function changeOwner(address payable newOwner) public {
    owner = newOwner;
  }

  function kill(address payable x) public {
    (address payable a, address b) = registerUser(x);
    selfdestruct(a); // tainted, b.c. a is not trusted
  }
}
