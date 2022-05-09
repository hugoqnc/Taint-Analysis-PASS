pragma solidity ^0.5.0;

contract Contract {
  address c;

  function order2(address addr) public {
    address payable b1 = msg.sender;
    address dependOnSender = addr;
    if(b1==addr) {
      dependOnSender = addr; // depends on msg.sender
      require(dependOnSender==c); // guard
      selfdestruct(b1); // safe
    }
    require(dependOnSender==c); // not a guard
    selfdestruct(b1); // vulnerable
  }
}
