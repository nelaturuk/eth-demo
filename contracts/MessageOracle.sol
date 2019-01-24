pragma solidity >=0.4.0 <0.6.0;

contract MessageOracle {

    /* Events - START */
    event MainDevChanged(address indexed oldMainDev, address indexed newMainDev);
    event MessageAdded(bytes32 message);
    /* Events - END */

    /* Modifiers - START */
    modifier onlyMainDev {
        require(msg.sender == mainDev, "Only owner can proceed further.");
        _;
    }
    /* Modifiers - END */

    address public mainDev;
    bytes32[] public messages;

    /* Constructor - START */
    constructor() public {
        mainDev = msg.sender;

        messages.push("I'd rather be a bird than a fish");
        messages.push("The lake is a long way from here");
        messages.push("Christmas is coming");
        messages.push("Don't step on the broken glass");
        messages.push("I hear that Nancy is very pretty");
        messages.push("We have a lot of rain in June");
        messages.push("Two seats were vacant");
        messages.push("Please wait outside of the house");
        messages.push("She did her best to help him");
        messages.push("The stranger officiates the meal");
    }
    /* Constructor - END */

    function changeMainDev(address _newMainDev) public onlyMainDev returns(bool) {
        address _oldMainDev = mainDev;
        mainDev = _newMainDev;

        emit MainDevChanged(_oldMainDev, _newMainDev);

        return true;
    }

    function addMessage(bytes32 _message) public onlyMainDev returns(bool) {
        messages.push(_message);

        emit MessageAdded(_message);

        return true;
    }

    function getMessage() public view returns(bytes32) {
        return messages[uint(keccak256(abi.encode(msg.sender, block.number))) % messages.length];
    }
}