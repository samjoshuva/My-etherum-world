pragma solidity ^0.5.0;

import "browser/ERC20.sol";


contract TokenVesting is ERC20 {
    
     uint duration;
    uint percent;
    
    mapping(address => uint) public released;

    uint  currentTime;
    uint public  startTime; 
    uint  cliff;
    constructor() public payable {
        
        startTime = block.timestamp;
        currentTime = now;
        duration = 575;
        cliff = 30; 
        percent = (5*_totalSupply)/100;
    }
    
    function balanceOf(address tokenOwner) public view  returns (uint balance) {
        if(tokenOwner == _owner){
            uint currentBalance = _balances[tokenOwner];
            uint totalBalance = currentBalance + calculateRelease();
            // uint totalBalance = currentBalance + calculateRelease();

            return totalBalance;
        }
        return super.balanceOf(tokenOwner);
    }
    
    
     function calculateRelease() public view returns(uint value){
        
        if(now < startTime+duration){
            uint diff = (now - startTime)/30;
            return (diff+1) * percent;
        }
    }
    
}
