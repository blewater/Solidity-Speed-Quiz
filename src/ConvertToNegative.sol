// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract ConvertToNegative {
    error TooBig();

    function convertToNegative(uint256 x) external pure returns (int256) {
        // return -x
        // if -x cannot be computed, revert with "TooBig()"
        // do not hardcode any constants

        // abs(minimum negative) is +1 than abs(int256.max)
        require(x <= uint(type(int256).max)+1, TooBig());

        // special case: abs(type(int256).min)
        if (x == uint(type(int).max)+1) {
            return type(int256).min;
        }

        return -int256(x);
    }
}