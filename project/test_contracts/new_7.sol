pragma solidity ^0.5.0;

contract Contract {
  address a;
  address c;
  address d;

  function order(address payable addr) public {
    require(msg.sender==c); // guard
    selfdestruct(addr); // safe
  }

  function order2(address addr) public {
    a = addr;
    address payable b1 = msg.sender;
    address dependOnSender;
    if(b1==a) {
      dependOnSender = addr; // depends on msg.sender
      require(dependOnSender==c); // guard
      selfdestruct(b1); // safe
    }
    require(d==c); // not a guard
    selfdestruct(b1); // vulnerable
  }
}
