// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.6;

/**
* 
*/

contract TaxPrep {

	address private owner;

	uint256 totalReceived;
	uint256 taxRate;

	struct Payment {
		address sender;
		uint256 amount;
		uint256 taxes;
		uint256 netAmount;
	}

	Payment[] public payments;

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

	function changeTaxRate(uint256 newRate) external isOwner {
		taxRate = newRate;
	}

	function changeOwner(address newOwner) external isOwner {
		owner = newOwner;
	}

	function receivePayment() external payable {
		uint256 taxed = msg.value * taxRate;
		uint256 net = msg.value - taxed;
		Payment[] storage savedPayments = payments;
		Payment memory incoming = Payment(msg.sender,msg.value,taxed,net);
		savedPayments.push(incoming);
	}

}