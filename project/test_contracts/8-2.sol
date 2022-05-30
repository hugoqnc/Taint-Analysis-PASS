pragma solidity ^0.5.0;

contract Contract {
  address owner;
  function check() public returns(bool) {
    return (msg.sender == msg.sender);
  }
  function foo() public {
    require(check());         // guard
    selfdestruct(msg.sender);      // safe
  }
  function bar(address z) public {
    require(check());             // guard
    selfdestruct(msg.sender);      // safe
  }
}
