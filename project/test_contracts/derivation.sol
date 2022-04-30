pragma solidity ^0.5.0;

contract Contract {
  int x;
  int y;

//  function bar(int x) public {
//    int a = 0;
//    a = x;
//    int b = x + 8;
//    int c = 2;
//    c = a + 1;
//    int d = 0;
//    d = b;
//    d = 3;
//  }
  function foo(int a) public {
    x = a;
    int b = x;
    int c = b;
    y = c;
    x = 0;
    int d = x;
  }
}
