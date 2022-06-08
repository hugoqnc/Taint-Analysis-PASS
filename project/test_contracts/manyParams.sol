pragma solidity ^0.5.0;

// Safe
contract Contract {
  address payable owner;
  address something;

  function foo(address x, address y, address z, address payable a, address payable b) public {
      if (x == y) {
        something = y;
        something = z;
      }
      require(msg.sender == owner); // Guard, which should sanitize all the parameters
      owner = a;
      owner = b;
  }

  function kill() public payable {
    selfdestruct(owner);
  }
}
