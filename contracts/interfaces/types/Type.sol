// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import {CircularDoublyLinkedList} from "../../libraries/CircularDoublyLinkedList.sol";

interface Type {

    /// @TODO add others attribute.
    struct Transaction {
        bytes16 id;
        // ...
        bool status;
    }
    
    struct CDR {
        mapping(bytes16 UUIDv4 => Transaction) transactions;
        CircularDoublyLinkedList.List collection;
    }
}