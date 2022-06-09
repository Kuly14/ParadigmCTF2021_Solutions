pragma solidity 0.8.7;

import "./Hello.sol";

contract Attack {

    Hello hello;

    constructor(Hello _hello) {
        hello = _hello;
        hello.solve()
    }
}
