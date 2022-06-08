pragma solidity ^0.5.0;

// Tainted
contract Contract {
  address payable owner;
  address payable something;

  function bar(address payable a, address payable b) public returns (bool){
      if (a == b) { // not a guard
          return (something == owner); // not a guard
      }
      return (owner == msg.sender); // guard
  }

  function foo(address payable x, address payable y) public {
      require(bar(x, y));
      owner = x;
  }

  function kill() public payable {
    selfdestruct(owner);
  }
}
