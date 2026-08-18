# cdr-transaction-management-contracts

This repository provides Call Detail Records (CDRs) Transaction Management using smart contracts written in `solidity`. It enables telecom operators and service providers to manage billing processes transparently and efficiently on a blockchain network, ensuring accurate, immutable, and automated.

## Prerequisite

- node [Download](https://nodejs.org/en/)
- nvm [Download](https://github.com/nvm-sh/nvm#installing-and-updating)
- git [Download](https://git-scm.com/)

```shell
git clone https://github.com/MASDXI/cdr-transaction-management-contracts.git
cd cdr-transaction-management-contracts
```

## Installing

To install all necessary packages and dependencies in the project, run command.

```
yarn install
```

## Compile the code

To compile the smart contracts, run command.

```
yarn compile
```

## Testing

To run the tests and ensure that the contracts behave as expected, run command.

```
yarn test
```

## Rationale

- The design approach not tied exclusively to `solidity` or `evm-based` but can be applied across various Distributed Ledger Technologies (DLTs) or blockchain frameworks that support turing-complete smart contracts.

## License

Copyright (C) Sirawit Techavanitch. You are free to use, modify, and distribute the code under the terms of the [GPL v3.0](LICENSE).
