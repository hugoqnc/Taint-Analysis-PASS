pragma solidity ^0.5.0;

contract Contract {
  address owner;
  address admin;
  function changeOnwer1() public {
    owner = admin;
  }
  function changeOnwer2() public {
    owner = address(0xDEADBEEF);
  }

  function foo() public returns (address) {
      return owner;
  }

  function kill() public {
    require(msg.sender == foo()); // guard
    selfdestruct(msg.sender);     // safe
  }
}
