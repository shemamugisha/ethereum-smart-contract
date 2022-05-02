// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.4.24;



contract Lottery {

    address[] public players;
    address public manager;

    constructor() public {
        manager = msg.sender;
    }

    
    function paying() payable public {
        require(msg.value >= 0.01 ether);
        players.push(msg.sender);
    }



    function getBalance() view public returns(uint) {
        require(msg.sender == manager);
        return address(this).balance;
    }

    function random() view public returns(uint256) {
        return uint256(keccak256(block.difficulty, block.timestamp, players.length));
    }


    function selectWinner() public {
        require(msg.sender == manager);

        uint r = random();

        address winner;

        uint index = r % players.length;
        winner = players[index];

        winner.transfer(address(this).balance);

        players = new address[](0);
    }

}