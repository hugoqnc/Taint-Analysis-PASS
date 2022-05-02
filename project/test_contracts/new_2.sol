pragma solidity ^0.5.0;

contract Contract {
  address owner;
  address oldMsgSender;

  function storeOld() public {
    oldMsgSender = msg.sender;
  }

  function kill() public {
    require(oldMsgSender == owner);
    selfdestruct(msg.sender);
  }


}
