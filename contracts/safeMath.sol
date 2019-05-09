pragma solidity ^0.5.0;


library safeMath {
    
    
    function mul(uint a, uint b) internal pure returns(uint){
        if(a == 0){
            return 0;
        }
        
        uint c = a*b;
        require(c/a == b, "Multiplication overflow");
        return c;
    }
    
    function add(uint a, uint b) internal pure returns(uint){
        uint c = a + b;
        require( c >= a, "Addition overflow");
        return c;
    }
    
    function div(uint a, uint b) internal pure returns(uint){
        require(b > 0, "Division by zero");
        uint c = a/b;
        return c;
        
    }
    
    function sub(uint a, uint b) internal pure returns(uint){
        require(b <= a, "Subration overflow");
        uint c = a - b;
        return c;
    }
    
    function mod(uint a, uint b) internal pure returns(uint) {
        require(b > 0, "Division by zero");
        uint c = a%b;
        return c;
    }
}
