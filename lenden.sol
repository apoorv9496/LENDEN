pragma solidity ^0.4.0;

contract lenden {
    
    // owner address
    address _owner;
    
    // accounting total users + acting as unique ID
    uint _userCounter = 0;
    
    // verify owner
    modifier owner {
        require(msg.sender == _owner);
        _;
    }
    
    struct user{
        uint id;
        string name;
        bool active;
        uint rating;
        uint lends;
        uint borrows;
    }
    
    struct request {
        address reqAddress;
        uint interestRate;
        uint period;
        bool active;
    }
    
    // mapping address to a person info
    mapping (address => user) public _userList;
    
    request[] _borrowRequestList;
    request[] _lendRequestList;
    
    constructor() public {
        _owner = msg.sender;
    }
    
    // owner calls to create an account only after KYC success of a to be user
    function createAccount(string name, address userAddress) public owner {
        _userCounter++;
        
        _userList[userAddress].name = name;
        _userList[userAddress].active = true;
        _userList[userAddress].rating = 0;
        _userList[userAddress].lends = 0;
        _userList[userAddress].borrows = 0;
    }
    
    function createBorrowRequest() public {
        
    }
}
