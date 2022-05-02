pragma solidity ^0.5.0;

contract Contract {
  address owner;
  int i;

  function store(int x) public {
    int y = x+1;
    i = y;
    int z = i;
    require(msg.sender == owner || z == 0);
    kill();
  }

  function kill() public {
    selfdestruct(msg.sender);
  }
}
