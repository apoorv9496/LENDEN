pragma solidity ^0.4.0;

import "browser/ERC20.sol";

contract lenDen is ERC20 {
    string public constant symbol = "LDT";
    string public constant name = "LenDen Token";
    uint8 public constant decimals = 18;
    
    struct borrower{
        string name;
        uint256 balance;
        uint amount;
        uint NoOfDays;
        uint interestRate;
    }
    
    struct lender{
        string name;
        uint256 balance;
        uint[] transactionId;
    }
    
    uint private constant __totalSupply = 10000;
    mapping (address => uint) private owner;
    
    mapping (address => borrower) public _borrower;
    mapping (address => lender) public _lender;
    
    
    function lenDen() {
        owner[msg.sender] = __totalSupply;
        
    }
    
    function totalSupply() constant returns (uint _totalSupply) {
        _totalSupply = __totalSupply;
    }
    
    function balanceOf(address _addr, string category) constant returns (uint balance) {
        if(keccak256(category) == "lender"){
            balance = _lender[_addr].balance;
        }
        else{
            balance = _borrower[_addr].balance;
        }
    }
    
    function transfer(address _to, uint _value, string category) constant returns (bool success) {
        if (_value > 0 && _value <= balanceOf(msg.sender, category)) {
            if(keccak256(category) == "lender"){
                _lender[msg.sender].balance -= _value;
                _borrower[_to].balance += _value;
            }
            else{
                _borrower[msg.sender].balance -= _value;
                _lender[_to].balance += _value;
            }
            
            success = true;
        }
        success = false;
    }
    
    /* this will be used by lender to lend money to the borrower also saving the transactionId
    *  transactionId will be later used to identify any defaulters swiftly
    */
    function lend(){
        
    }
    
    // when borrower's request gets accepted, it's added to the structure - borrower
    function borrowRequest(){
        
    }
}

