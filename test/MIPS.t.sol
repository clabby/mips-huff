// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";

/// @dev TODO
interface IMIPS { }

contract MIPS_Test is Test {
    IMIPS mips;

    function setUp() public {
        string[] memory commands = new string[](3);
        commands[0] = "huffc";
        commands[1] = "-b";
        commands[2] = "src/MIPS.huff";
        bytes memory initCode = vm.ffi(commands);

        assembly {
            let mipsAddr := create(0, add(initCode, 0x20), mload(initCode))
            // Revert if the contract creation failed.
            if iszero(extcodesize(mipsAddr)) {
                revert(0, 0)
            }
            sstore(mips.slot, mipsAddr)
        }
    }
}
