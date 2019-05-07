pragma solidity ^0.5.0;

contract ERCToken {
    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply;
    
    address public owner;

    mapping(address => uint) balances;
    
    mapping(address => uint) allowed;

    uint  currentTime;
    uint  startTime; 
    uint cliff;
  
    constructor() public payable {
        symbol = "SJ";
        name = "DUMMY Token";
        decimals = 10;
        _totalSupply = 30;
        owner = msg.sender;
        
        startTime = block.timestamp;
        currentTime = now;
        cliff = 10; 
    }

    function balanceOf(address tokenOwner) public view  returns (uint balance) {
        return balances[tokenOwner];
    }
    
    function allowance(address tokenOwner) public returns (uint allow){
        return allowed[tokenOwner] = calculateAllowance();
    }
    
    function calculateAllowance() public view returns(uint balance){
        uint inc = 0;
        uint percent = (5*_totalSupply)/100;
        uint rem;
        uint diff = (now - startTime); // difference of present time and time last function called
        if(diff > cliff){ // if the difference is greater than cliff value
            rem = (diff / cliff);
            inc =  rem * percent;
            if(inc == 0){
                return percent;
            }
            else if(inc == 1){
                return percent * 2;
            }
            else if(inc >= _totalSupply){
                return  _totalSupply;
            }
            else {
                return inc;
            }
            
            
            
        }
        
        
        
    }
    
    // function allowance( address spender) public view returns (uint remaining) {
    //     return allowed[spender];
    // }

    function transfer(address to, uint tokens) public payable vesting(tokens)   returns (bool success) {
        
        balances[msg.sender] = balances[msg.sender] - tokens;
        balances[to] = balances[to] + tokens;
        // allowed[msg.sender] = allowed[msg.sender] - tokens;
        // currentTime = now;

        return true;
    }
    
    function transferFrom(address from, address to, uint tokens ) public payable vesting(tokens)  returns(bool success){
      
        balances[from] = balances[from] - tokens;
        balances[to] = balances[to] + tokens;
        // allowed[msg.sender] = allowed[msg.sender] - tokens;
        // currentTime = now;

        return true;
    }
    
    // function approve(address spender, uint percent) public  {
       
    // }
     
    modifier vesting(uint tokens){
        require(tokens <= balances[msg.sender],"You don't have enough token");  // check if o. of token to to send is avaliable in balance
        
        
       
        _;
    }
   
   
   function timeTest() public view returns(uint) {
       uint inc =0;
       uint percent = (5*_totalSupply)/100;
       uint rem;
        uint diff = (now - startTime); // difference of present time and time last function called
        if(diff > cliff){ // if the difference is greater than cliff value
            rem = (diff / cliff);
            inc =  rem * percent;
            return percent;
            // balances[msg.sender] += inc;
        }
        

   }
    
}
