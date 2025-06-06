// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

    interface IFoo{
        function foo() external;
    }


contract LowLevel {
    function main(address a) public returns (bool) {
        // call function "foo()" on address a
        // do not use an interface, use a low level call
        // return true if the call succeeded
        // return false if the call failed

        // bonus challenge: use an interface and a high level call to accomplish the same task
        (bool success1, ) = a.call(hex"c2985578");
        (bool success2, ) = a.call(abi.encodeWithSignature("foo()"));
        IFoo f = IFoo(a);
        bool success3 = false;
        try f.foo() { success3 = true; } catch {}
        assert(success1 == success2 && success2 == success3);
        return success2;
    }
}
