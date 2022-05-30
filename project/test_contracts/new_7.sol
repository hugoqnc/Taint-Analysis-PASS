pragma solidity ^0.5.0;

contract Contract {
  address owner;

  function func(address payable addr) public {
    address dependOnSender = addr;
    if(msg.sender==addr) {            // not a guard
      dependOnSender = addr;          // depends on msg.sender
      require(dependOnSender==owner); // guard?
      selfdestruct(addr);             // safe?
    }
  }
}
