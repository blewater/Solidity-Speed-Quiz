// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

interface IBar {
    function bar() external returns (uint256);
}

contract LowLevelReturnUint {
    function main(address a) public returns (uint256) {
        // call function "bar()" on address a
        // do not use an interface
        // return the return value of the call

        // bonus challenge: use an interface and a high level call to accomplish the same task
        (bool ok, bytes memory ret) = a.call(abi.encodeWithSignature("bar()"));
        require(ok);
        uint ret1 = abi.decode(ret, (uint256));

        uint256 ret2 = IBar(a).bar();

        assert(ret1 == ret2);

        return ret1;
    }
}