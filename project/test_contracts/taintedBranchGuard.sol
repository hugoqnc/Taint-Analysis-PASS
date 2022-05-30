pragma solidity ^0.5.0;

contract Contract {
  address payable owner;

  function func4(uint x) public {
    address a = address(0x00000000);
    if(x < 5) {                  // not a guard
      uint y = x;
    } else {
      a = address(0xDEADBEEF);
      require(msg.sender == a); // guard
      selfdestruct(msg.sender);                   // safe
    }
    require(msg.sender == a); //not a guard
    selfdestruct(msg.sender); //tainted
  }
}
