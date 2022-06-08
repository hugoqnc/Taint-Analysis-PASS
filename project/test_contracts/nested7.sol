pragma solidity ^0.5.0;

// Safe
contract Contract {
  address payable owner;
  address payable something;

  function bar(address payable a, address payable b) public returns (bool){
      if (a == b) {
          return (something == msg.sender);
      }
      return (owner == msg.sender);
  }

  function foo(address payable x, address payable y) public {
      require(bar(x, y));
      owner = x;
  }

  function kill() public payable {
    selfdestruct(owner);
  }
}
