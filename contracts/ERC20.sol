pragma solidity ^0.5.0;

contract ERCToken {
    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply;
    
    address public owner;

    mapping(address => uint) balances;

    constructor() public payable {
        symbol = "SJ";
        name = "DUMMY Token";
        decimals = 10;
        _totalSupply = 100000000000000000000000000;
        owner = msg.sender;
        balances[owner] = _totalSupply;
    }

    function balanceOf(address tokenOwner) public view  returns (uint balance) {
        return balances[tokenOwner];
    }


    function transfer(address to, uint tokens) public payable  returns (bool success) {
        balances[msg.sender] = balances[msg.sender] - tokens;
        balances[to] = balances[to] + tokens;
        // emit Transfer(msg.sender, to, tokens);
        return true;
    }
    
    function transferFrom(address from, address to, uint tokens ) public payable returns(bool success){
        balances[from] = balances[from] - tokens;
        balances[to] = balances[to] + tokens;
        return true;
    }
    
}













