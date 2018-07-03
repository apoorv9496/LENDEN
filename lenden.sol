pragma solidity ^0.4.0;

contract lenden {
    
    // owner address
    address _owner;
    
    // verify owner
    modifier owner {
        require(msg.sender == _owner);
        _;
    }
    
    struct user{
        string name;
        bool active;
        uint rating;
        uint lends;
        uint borrows;
    }
    
    // mapping address to a person info
    mapping (address => user) public _userList;
    
    constructor() public {
        _owner = msg.sender;
    }
    
    function createAccount() public owner{
        
    }
}
