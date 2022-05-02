// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract HotelRoom {
    address payable public owner;


    enum Status { Vacant, Occupied }

    event Occupy(address _occupant, uint _value);

    Status currentStatus;

    constructor(){
        owner = payable(msg.sender);
        currentStatus = Status.Vacant;
    }

    modifier onlyWhileVacant {
        require(currentStatus == Status.Vacant, "Currently Occupied");
        _;
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not Enough Ether Provided.");
        _;
    }

    receive() payable external onlyWhileVacant costs(2 ether) {
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}