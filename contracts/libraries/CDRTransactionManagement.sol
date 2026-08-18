// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import {Type} from "../interfaces/types/Type.sol";
import {UUIDv4} from "./UUIDv4.sol";
import {CircularDoublyLinkedList} from "./CircularDoublyLinkedList.sol";

/**
 * @title CDR Transaction Management Library
 * @notice Inspired from TMF735_CDRTransactionManagement_V5.0.0.
 */

library CDRTransactionManagement {
    using CircularDoublyLinkedList for CircularDoublyLinkedList.List;

    event TransactionAttributeValueChanged();
    event TransactionCreated();
    event TransactionDeleted();
    event TransactionStateChanged();

    function transactions(
        Type.CDR storage self,
        uint256 _start,
        uint256 _limit
    ) internal view returns (Type.Transaction[] memory result) {
        uint256 length = self.collection.size();
        if (_limit > length) {
            _limit = length;
        }
        uint256 id = self.collection.next(uint256(_start));
        result = new Type.Transaction[](_limit);
        for (uint i = 0; i < _limit; i++) {
            result[i] = self.transactions[bytes16(uint128(id))];
            id = self.collection.next(id);
        }
    }

    function transaction(
        Type.CDR storage self,
        bytes16 _id
    ) internal view returns (Type.Transaction memory) {
        return self.transactions[_id];
    }

    function create(
        Type.CDR storage self,
        Type.Transaction memory _transaction
    ) internal returns (bool) {
        bytes16 id = UUIDv4.uuid(
            "CDRTransactionManagement",
            self.collection.size()
        );
        self.transactions[id] = _transaction;
        self.collection.add(uint256(bytes32(id)));

        emit TransactionCreated();

        return true;
    }

    function update(
        Type.CDR storage self,
        bytes16 _id,
        Type.Transaction memory _transaction
    ) internal returns (bool) {
        if (!self.collection.contains(uint256(bytes32(_id)))) {
            revert();
        }
        Type.Transaction storage $transaction = self.transactions[_id];
        bytes32 hash = keccak256(abi.encode($transaction));
        bytes32 hashed = keccak256(abi.encode(_transaction));
        if (hash != hashed) {
            if ($transaction.status != _transaction.status) {
                emit TransactionAttributeValueChanged();
            }
            self.transactions[_id] = _transaction;

            emit TransactionAttributeValueChanged();

            return true;
        }
    }

    /// @dev `delete` is reserve word use remove instead.
    function remove(
        Type.CDR storage self,
        bytes16 _id
    ) internal returns (bool) {
        self.collection.remove(uint256(bytes32(_id)));

        emit TransactionDeleted();

        return true;
    }
}
