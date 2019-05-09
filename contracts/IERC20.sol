pragma solidity ^0.5.0;


interface IERC20 {
    
    
    function balanceOf(address tokenOwner) external view returns(uint);
    function totalSupply() external view returns(uint);
    function transfer(address to, uint tokens) external returns(bool);
    function transferFrom(address from, address to, uint tokens) external returns(bool);
    function approve(address spender, uint tokens) external  returns(bool);
    function allowance(address owner, address spender) external view returns(uint);
    
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
    
}


