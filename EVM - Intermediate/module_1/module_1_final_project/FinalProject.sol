// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

error FundMe__NotOwner();

// Natspec
/** @title A contract for crowd funding
 *   @author Tarun Kotagiri
 *   @notice This contract is final project assignment of Metacrafters Eth Intermediate
 *   @dev This projects implements require, revert and assert
 */

contract FundMe {

    // State variables
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    address public immutable i_owner;
    uint256 public constant MINIMUM_ETH = 2;


    modifier onlyOwner() {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

    constructor() {
        i_owner = msg.sender;
    }

//  The below two functions allow external users to fund this contract using their wallets
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    function fund() public payable {
        assert(MINIMUM_ETH == 2);
        require(
            msg.value >= MINIMUM_ETH, "You need to spend more ETH!"
        );
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
}

