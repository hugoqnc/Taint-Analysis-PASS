pragma solidity ^0.5.0;

contract Contract {
  address a;
  address payable b;
  address c;
  address d;


  function order(address payable addr) public {
    require(msg.sender==c); // guard
    selfdestruct(addr); // safe
  }

  function order2(address addr) public {
    a = addr;
    b = msg.sender;
    address dependOnSender;
    if(b==a) {
      dependOnSender = addr; // depends not necessarily on msg.sender, as b is shared memory and could be modified by another simultaneous call of this function
      require(dependOnSender==c); // not a guard
      selfdestruct(b); // vulnerable
    }
    require(d==c); // not a guard
    selfdestruct(b); // vulnerable
  }
}
