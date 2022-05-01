pragma solidity ^0.5.0;

contract Contract {
  address payable user;
  address payable owner;

  function registerUser() public {
    user = msg.sender;
  }

  function changeOwner(address payable newOwner) public {
    address x;
    x = address(0xDEADBEEF);
    if (msg.sender == user){
      owner = newOwner;
      x = address(0x01010101);
    } else {
      require(msg.sender == x);
      owner = newOwner;
    }
  }

  function kill() public {
    selfdestruct(owner);
  }
}
