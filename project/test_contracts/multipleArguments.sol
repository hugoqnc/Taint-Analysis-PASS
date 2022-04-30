pragma solidity ^0.5.0;

contract Contract {
  address owner;
  function check(address x, address y) public returns(bool) {
    address a = y;
    return (msg.sender == x);
  }
  function foo(address z) public {
    require(check(owner,z));         // guard
    selfdestruct(msg.sender);      // safe
  }
  function bar(address z) public {
    require(check(z,z));             // not a guard
    selfdestruct(msg.sender);      // vulnerable
  }
}
