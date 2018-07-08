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
    
    struct pending {
        address reqAddress;
        uint amount;
        uint interestRate;
        uint period;
        bool active;
    }
    
    struct accept {
        address from;
        address to;
        uint amount;
        uint interestRate;
        uint period;
        bool active;
        string reqType;
    }
    
    struct user{
        uint id;
        string name;
        bool active;
        uint rating;
        uint lends;
        pending[] pendingList;
        accept[] acceptList;
        uint borrows;
    }
    
    struct request {
        address reqAddress;
        uint amount;
        uint interestRate;
        uint period;
        bool active;
    }
    
    // mapping address to a person info
    mapping (address => user) private _userList;
    
    request[] public _borrowRequestList;
    request[] public _lendRequestList;
    
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
        
        request memory temp = request(0, 0, 0, 0, false);
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
        
            // creating an acceptList
            accept memory temp = accept(0, 0, 0, 0, 0, true, "lend");
            temp.from = msg.sender;
            temp.to = _borrowRequestList[index].reqAddress;
            temp.amount = _borrowRequestList[index].amount;
            temp.interestRate = _borrowRequestList[index].interestRate;
            temp.period = _borrowRequestList[index].period;
            temp.active = true; 
            
            temp.reqType = "lend";
            
            // adding to lender's acceptList
            _userList[msg.sender].acceptList.push(temp);
            
            temp.reqType = "borrow";
            
            // adding to borrower's acceptList
            _userList[_borrowRequestList[index].reqAddress].acceptList.push(temp);
            
        }
        
        return "requests not active";
    }
    
    // accepting a lending request from the list
    function borrow(uint index) public returns (string) {
        if(_lendRequestList[index].active) {
            
            pending memory temp = pending(0, 0, 0, 0, false);
            
            temp.reqAddress = msg.sender;
            temp.amount = _lendRequestList[index].amount;
            temp.interestRate = _lendRequestList[index].interestRate;
            temp.period = _lendRequestList[index].period;
            temp.active = true;
            
            // adding to the lender's pendingList
            _userList[_lendRequestList[index].reqAddress].pendingList.push(temp);
            
            // setting this request as inactive since it has been satisfied
            _lendRequestList[index].active = false;
        }       
            
        return "request not active";
    }
    
    // when lender makes payment to the borrower after they accepted former's lend request
    /*function acceptToLend(uint index) public {
        
        // creating an acceptList
        accept memory temp = accept(0, 0, 0, 0, 0, true, "lend");
        temp.from = msg.sender;
        temp.to = _userList[msg.sender].pendingList[index].reqAddress;
        temp.amount = _userList[msg.sender].pendingList[index].amount;
        temp.interestRate = _userList[msg.sender].pendingList[index].interestRate;
        temp.period = _userList[msg.sender].pendingList[index].period;
        temp.active = true; 
            
        temp.reqType = "lend";
            
        // adding to lender's acceptList
        _userList[msg.sender].acceptList.push(temp);
            
        temp.reqType = "borrow";
            
        // adding to borrower's acceptList
        _userList[temp.to].acceptList.push(temp);
            
        _userList[msg.sender].pendingList[index].active = false;
    }*/
    
    function acceptToLend(uint index, address addr, uint amount, uint interestRate, uint period) public {
        
        // creating an acceptList
        accept memory temp = accept(0, 0, 0, 0, 0, true, "lend");
        temp.from = msg.sender;
        temp.to = addr;
        temp.amount = amount;
        temp.interestRate = interestRate;
        temp.period = period;
        temp.active = true; 
            
        temp.reqType = "lend";
            
        // adding to lender's acceptList
        _userList[msg.sender].acceptList.push(temp);
            
        temp.reqType = "borrow";
            
        // adding to borrower's acceptList
        _userList[temp.to].acceptList.push(temp);
            
        _userList[msg.sender].pendingList[index].active = false;
    }
    
    // paying money back to the lender 
    function payBack() public payable returns (string) {
        // ToDo    
        return "";
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

