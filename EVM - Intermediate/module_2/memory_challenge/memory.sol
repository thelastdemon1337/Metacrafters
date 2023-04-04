// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Memory {
    // This state variable is stored in storage
  struct LotteryNumber{
    uint256 Lnumber;
    string selection;
  }  


    // The variable num which is an argument is stored in memory and gets cleared after function execution
    function multiply(uint256 num) external pure returns(uint256) {
    uint256 result = num * num;  return result;
}

}