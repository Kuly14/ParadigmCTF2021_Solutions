pragma solidity 0.5.12;

contract b {
    function show() public view returns (address) {
        return address(this);
    }
}

contract T {
    b bcont;
    event addr(address indexed addres);

    constructor() public {
        bcont = new b();
    }

    function get() public {
        (bool ok, bytes memory data) = address(bcont).delegatecall(
            abi.encodeWithSignature("show()")
        );
        require(ok);
        address decodedAddress = abi.decode(data, (address));
        emit addr(decodedAddress);
    }
}
