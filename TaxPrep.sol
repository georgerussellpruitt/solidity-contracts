// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

/**
* 
*/

contract TaxPrep {

	address private owner;
	address private paymentAddress;
	address private taxAddress;
	uint256 totalReceived;
	uint256 withdrawAmount;
	uint256 storedTax;


	// event for EVM logging
	event OwnerSet(address indexed oldOwner, address indexed newOwner);

	constructor() {
		owner = msg.sender; 
		emit OwnerSet(address(0), owner);
	}

	modifier isOwner() {
		require(msg.sender == owner, "Contract Owner Required");
		_;
	}
	
	function changeOwner(address newOwner) public isOwner {
		emit OwnerSet(owner, newOwner);
		owner = newOwner;
	}

	function acceptTaxablePayment(uint256 num) public payable {
		uint256 newTotal = totalReceived + num;
		totalReceived = newTotal;
		
	}

	
}