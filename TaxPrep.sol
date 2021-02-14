// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

/**
* 
*/

contract TaxPrep {

	address private owner;

	uint256 totalReceived;
	uint256 taxRate;

    mapping (uint => Payment) payments;

    struct Payment {
        address sender;
        uint256 amount;
    }

	// event for EVM logging
	event OwnerSet(address indexed oldOwner, address indexed newOwner);
	event TaxRateSet(uint256 indexed oldRate, uint256 indexed newRate);
	event ReceivedPayment(address indexed sender, uint256 indexed amount);

	constructor() {
		owner = msg.sender; 
		emit OwnerSet(address(0), owner);
	}

	modifier isOwner() {
		require(msg.sender == owner, "Contract Owner Required");
		_;
	}

	function changeTaxRate(uint256 newRate) external isOwner {
	    emit TaxRateSet(taxRate,newRate);
        taxRate = newRate;
	}

	function changeOwner(address newOwner) external isOwner {
		emit OwnerSet(owner, newOwner);
		owner = newOwner;
	}

	function receivePayment() external payable {
	    // update totalReceived
		totalReceived += msg.value;
		uint256 taxAmount = msg.value * taxRate;
		uint256 clearAmount = msg.value - taxAmount;
		Payment incoming = Payment(msg.sender,msg.value,clearAmount,taxAmount);
		this.payments.push(incoming);
		emit ReceivedPayment(msg.sender,msg.value);
	}

}