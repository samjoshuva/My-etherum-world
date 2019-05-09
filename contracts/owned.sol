pragma solidity ^ 0.5.0;


contract owned {
    
    address public owner; 
    
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier isowned {
        require (msg.sender == owner,"This function can only be called by owner ");
        _;
    }
    
    function transferOwnership(address _newOwner) public isowned returns(bool){
        owner = _newOwner;
    }
    
}
