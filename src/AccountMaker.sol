// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import "@openzeppelin/contracts/utils/Create2.sol";

contract Account2 {
    address immutable owner;

    constructor(address _owner) payable {
        owner = _owner;
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        (bool ok, ) = owner.call{value: address(this).balance}("");
        require(ok);
    }
}

contract AccountMaker {
    function makeAccount(address owner) external payable returns (address) {
        // derive salt and init code
        bytes32 salt = bytes32(bytes20(owner));
        bytes memory bytecode = abi.encodePacked(type(Account2).creationCode, abi.encode(owner));

        // compute the account address
        // address acct = Create2.computeAddress(salt, keccak256(bytecode), address(this));

        return Create2.deploy(msg.value, salt, bytecode);
    }
}
