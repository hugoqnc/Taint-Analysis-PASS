pragma solidity ^0.5.0;

contract Contract {
  address payable user;
  address payable owner;

  function save(address payable x) public {
    user = x;
  }

  function registerUser() public {
    user = msg.sender;
  }

  function changeOwner(address payable newOwner) public {
    address payable a = address(0xDEADBEEF);
    save(a);
    address payable b = address(0xDEADBEEF);
    save(b);
    require(msg.sender == user);
    registerUser();
    owner = newOwner;
  }

  function kill() public {
    selfdestruct(owner);
  }
}
