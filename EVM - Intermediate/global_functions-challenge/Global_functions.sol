// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error fund__NotFunderEnough();
error withdraw__NotOwner();

contract Globals {

    //Natspec Documentation standard
    /** @author Tarun Kotagiri
     *  @notice A simple contract using globals in msg context
     *  @dev Allows users to fund this contract more than a certain eth
     *  @dev allows only owner to withdraw funds
     */ 


    uint256 public constant MIN_AMOUNT = 100000000;

    address private immutable i_owner;
    constructor() {
        i_owner = msg.sender;
    }

    modifier onlyOwner {
        if(msg.sender != i_owner) revert withdraw__NotOwner(); 
        _;       
    }

    receive() external payable{
        // allows users to fund from wallets
    }
    function fund() public payable {
        if(msg.value < MIN_AMOUNT) revert fund__NotFunderEnough();
    }

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

}