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
        uint amount;
        uint interestRate;
        uint period;
        bool active;
    }
    
    struct pending {
        address from;
        address to;
        uint amount;
        uint interestRate;
        uint period;
        bool active;
    }
    
    // mapping address to a person info
    mapping (address => user) private _userList;
    
    request[] public _borrowRequestList;
    request[] public _lendRequestList;
    
    pending[] private _pendingList;
    
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
    
    // create and adding a request to the list
    function createRequest(uint amount, uint rate, uint period, string reqType) public returns (string) {
        
        request storage temp;
        temp.reqAddress = msg.sender;
        temp.amount = amount;
        temp.interestRate = rate;
        temp.period = period;
        temp.active = true;
        
        if(keccak256(bytes(reqType)) == keccak256("borrow")) {
            _borrowRequestList.push(temp);    
        }
        else {
            _lendRequestList.push(temp);    
        }
        
        return "request was registered successfully";
    }
    
    // function to lend moeny to a person
    function lend(uint index) public payable returns (string) {
        if(_borrowRequestList[index].active) {
            _borrowRequestList[index].active = false;
        
            pending storage temp;
            temp.from = msg.sender;
            temp.to = _borrowRequestList[index].reqAddress;
            temp.amount = _borrowRequestList[index].amount;
            temp.interestRate = _borrowRequestList[index].interestRate;
            temp.period = _borrowRequestList[index].period;
            temp.active = true; 
            
            _pendingList.push(temp);
        }
        
        return "requests not active";
    }
    
    // function to lend moeny to a person
    function payBack(uint index) public payable returns (string) {
        if(_borrowRequestList[index].active) {
            _borrowRequestList[index].active = false;
        
            pending storage temp;
            temp.from = msg.sender;
            temp.to = _borrowRequestList[index].reqAddress;
            temp.amount = _borrowRequestList[index].amount;
            temp.interestRate = _borrowRequestList[index].interestRate;
            temp.period = _borrowRequestList[index].period;
            temp.active = true; 
            
            _pendingList.push(temp);
        }
        
        return "requests not active";
    }
    
    /*
    function getBorrowList() public constant returns (request[]) {
        // send this or send multiple arguments back
        return _borrowRequestList;
    }
    
    function getLendList() public constant returns (request[]) {
        // send this or send multiple arguments back
        return _lendRequestList;
    }
    */
}

