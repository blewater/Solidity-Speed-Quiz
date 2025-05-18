// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

interface IBar {
    function baz() external returns (string memory);
}

contract LowLevelReturnString {
    function main(address a) public returns (string memory) {
        // call function "baz()" on address a
        // do not use an interface
        // baz() returns a string. Return the string.
        // However, if baz reverts, return an empty string

        // bonus challenge: use an interface and a high level call to accomplish the same task
        (bool ok, bytes memory ret) = a.call(abi.encodeWithSignature("baz()"));
        if (!ok) {
            return "";
        }
        string memory ret1 = abi.decode(ret, (string));

        string memory ret2 = IBar(a).baz();

        assert(keccak256(bytes(ret1)) == keccak256(bytes(ret2)));

        return ret1;
    }
}
