pragma solidity ^0.5.0;

// Tainted
contract Contract {
  address a;
  address b;
  address c;

  function taintC() public {
    c = msg.sender;
  }

  function bar(address x) public {
    require(msg.sender == a || msg.sender == b && msg.sender == c && msg.sender == msg.sender);
    selfdestruct(msg.sender);
  }
}
