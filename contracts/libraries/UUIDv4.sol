// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

library UUIDv4 {
    function uuid(bytes32 seed) internal pure returns (bytes16) {
        return _format(bytes16(keccak256(abi.encodePacked(seed))));
    }

    /**
     * @notice Generate a UUID v4 using current block entropy, given domain and sequence.
     *
     * WARNING:
     * block.prevrandao is not cryptographically secure randomness.
     * Do not use this function where unpredictable randomness has
     * financial/security consequences.
     */
    function uuid(
        string memory domain,
        uint256 sequence
    ) internal view returns (bytes16) {
        bytes32 entropy = keccak256(
            abi.encodePacked(
                block.prevrandao,
                block.number,
                domain,
                sequence,
                msg.sender
            )
        );

        return _format(bytes16(entropy));
    }

    function isUUIDv4(bytes16 value) internal pure returns (bool) {
        uint128 word = uint128(value);

        // version:
        // byte 6 high nibble must be 0100.
        // 0x4 << 76
        bool version = ((word >> 76) & 0xF) == 0x4;

        // variant:
        // byte 8 high two bits must be 10.
        // 0x2 << 62
        bool variant = ((word >> 62) & 0x3) == 0x2;

        return version && variant;
    }

    function _format(bytes16 value) private pure returns (bytes16) {
        uint128 word = uint128(value);

        // set version 4.
        word = (word & ~(uint128(0xF) << 76)) | (uint128(0x4) << 76);

        // set RFC 4122 variant 1.
        word = (word & ~(uint128(0x3) << 62)) | (uint128(0x2) << 62);

        return bytes16(word);
    }
}
