pragma solidity ^0.5.0;

contract Contract {
  address owner;

  function check_proxy2(address x) public returns(bool) {
    return (msg.sender == x);
  }
  function check_proxy(address x) public returns(bool) {
    return check_proxy2(x);
  }
  function check(address x) public returns(bool) {
    return check_proxy(x);
  }
  function foo() public {
    require(check(owner));         // guard
    selfdestruct(msg.sender);      // safe
  }
  function bar(address z) public {
    require(check(z));             // not a guard
    selfdestruct(msg.sender);      // vulnerable
  }
}
