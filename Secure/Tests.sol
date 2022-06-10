pragma solidity 0.5.12;

contract T {
    function show() public pure returns (uint) {
        return 22;
    }
}

contract B {
    event showUint(uint indexed num);
    T t;

    constructor() public {
        t = new T();
    }

    function call() public returns (bytes memory) {
        bytes memory data = abi.encodeWithSelector(T(0x00).show.selector);

        (bool success, bytes memory dat) = address(t).call(data);
        require(success);
        uint decodedOutput = abi.decode(dat, (uint));
        emit showUint(decodedOutput);
        return dat;
    }
}
