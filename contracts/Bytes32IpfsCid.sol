// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Base58.sol";

/**
 * @title bytes32IpfsCid
 * @author @philogicae
 * @notice Convenient minimal library to convert IPFS CIDs from/to bytes32 using pure Solidity.
 * Storing IPFS CIDs/hashs/URIs can be gas expensive https://ethereum.stackexchange.com/a/61104
 * The idea here is to precompute offchain the bytes32 version of our IPFS CID, by calling a view function, before to store it.
 * We can then recover the CID in the same manner later https://ethereum.stackexchange.com/a/17112
 * Meant to be used ONLY in view/pure functions.
 */
library Bytes32IpfsCid {
    function encode(string memory cid) internal pure returns (bytes32 shorten) {
        bytes memory result = Base58.decode(bytes(cid));
        assembly {
            shorten := mload(add(result, 34))
        }
    }

    function decode(bytes32 data) internal pure returns (string memory) {
        return string(Base58.encode(abi.encodePacked(bytes2(0x1220), data)));
    }
}
