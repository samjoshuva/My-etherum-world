pragma solidity ^0.5.0;

import "browser/IERC20.sol";
import "browser/safeMath.sol";
import "browser/owned.sol";
import 'browser/approveandCallFallback.sol';


contract ERC20 is IERC20, owned {
    
    using safeMath for uint;    
    
    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply;
    

    mapping(address => uint) public _balances;
    mapping(address => mapping(address => uint)) public  _allowed;
    
    constructor( ) public payable {
        symbol = "SJ";
        name = "SJ Token";
        decimals = 10;
        _totalSupply = 100;
        _balances[owner] = _totalSupply;
        emit Transfer(address(0), owner, _totalSupply);
    }
    
    function balanceOf(address tokenOwner) public view returns(uint){
        return _balances[tokenOwner];
    }
    
    function totalSupply() public view isowned returns(uint){
        return _totalSupply;
    }
    
    function transfer(address to, uint tokens) public returns(bool){
        _balances[msg.sender] = _balances[msg.sender].sub(tokens);
        _balances[to] = _balances[to].add(tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;

    }
    function transferFrom(address from, address to, uint tokens) public returns(bool){
        _balances[from] = _balances[from].sub(tokens);
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(tokens);
        _balances[to] = _balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }
    
    function approve(address spender, uint tokens) public returns(bool){
        _allowed[msg.sender][spender] = tokens;
        return true;
    }
    
    function allowance(address owner, address spender) public view returns(uint){
        return _allowed[owner][spender];
    }
    
    function approveAndCall(address spender, uint tokens, bytes memory data) public returns (bool success) {
        _allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        approveAndCallFallback(spender).receiveApproval(msg.sender, tokens, address(this), data);
        return true;
    }

    function () external payable{
        revert();
    }
    
}
