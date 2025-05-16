// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract IsFirstBitSet {
    function main(bytes32 x) pure public returns (bool) {
        // return true if the first bit is set
        // for example 0x000....0001 returns true
        // for example 0x000....0010 returns false
        return uint8(x[31]) & 0x01 == 0x01;
    }
}
