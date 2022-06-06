pragma solidity ^0.5.0;

// Tainted
contract Contract {
  address payable owner;

  function foo(uint256 x, uint256 y) public returns(uint256) {
    uint256 z = y;
    if(z == 1) {
      z = 1;
    } else {
      z = 1;
    }
    return 2 * x * z;
  }

  function kill(uint256 x) public payable {
    uint256 a = x;
    uint256 b = 15;

    b = foo(a, b);
    a = foo(b, a);

    require(msg.sender == address(a)); // not a guard b.c. a is not trusted
    selfdestruct(owner);
  }
}
