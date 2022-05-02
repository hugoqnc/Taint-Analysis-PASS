pragma solidity ^0.5.0;

contract Contract {
  address payable user;
  address payable owner;
    address payable owner2;

  function registerUser() public {
    user = msg.sender;
  }

  function changeOwner(address payable newOwner) public {
    require(msg.sender == user);
    owner = newOwner;
  }

  function changeOwner2(address payable newOwner) public {
  require(msg.sender == owner);
  owner2 = newOwner;
  }

  function kill() public {
    selfdestruct(owner2);
  }
}
