pragma solidity ^0.5.0;

import "browser/ERC20.sol";
import "browser/safeMath.sol";


contract CrowedSale {
    using safeMath for uint; 
    
    ERC20 private _token;
    
    address payable private _wallet;
    
    uint private _rate;
    
    uint public _minCap;
    
    uint public _hardCap;
    uint startTime;
    
    uint public _goal;
    
    bool public ended;
    
    mapping(address => uint)  accounts;
    mapping (uint => address  payable)  accountIndex;
    uint accountCount = 0;
    
    uint public _tokenSaled;
    
    event CrowedsaleEnded(bool ended);
    
    
    
    constructor(uint rate, address payable wallet, ERC20 token, uint minCap, uint hardCap, uint goal) public payable {
        
        require(rate > 0, "Crowdsale: rate is 0");
        require(wallet != address(0), "Crowdsale: wallet is the zero address");
        require(address(token) != address(0), "Crowdsale: token is the zero address");
        require(minCap < hardCap,"Minimum cap must be smaller than hard cap");

        _rate = rate;
        _wallet = wallet;
        _token = token;
        _minCap = minCap;
        _hardCap = hardCap;
        _goal = goal;
        ended = false;
        _tokenSaled = 0;
        startTime = block.timestamp;
    }
    
    function () external payable {
        buyTokens(msg.sender);
    }

    
    function token() public view returns (ERC20) {
        return _token;
    }

   
    function wallet() public view returns (address payable) {
        return _wallet;
    }

    
    function rate() public view returns (uint256) {
        return _rate;
    }
    
    
    function buyTokens(address benifiary) public payable preValidate {
        require(!ended,"CrowedSale has been over");
        uint256 weiAmount = msg.value;
        uint256 tokens = _getTokenAmount(weiAmount);
        _token.transferFrom(_wallet, benifiary, tokens);
        _forwardFunds();
        _tokenSaled = _tokenSaled + tokens;
        accounts[msg.sender] = msg.value;
        accountIndex[accountCount] = msg.sender;
        accountCount ++;
    }
    
    modifier preValidate() {
        require(msg.sender != address(0), "benifiary is address zero");
        require(msg.value != 0, " zero wei send");
        require(!ended,"CrowedSale has been over");
        
       
        // if(now >= startTime){
           
        //     ended = true ;
        //     emit CrowedsaleEnded(ended);
            

        // }
        // else{
            _;
        // }
    }
    
    function _getTokenAmount(uint256 weiAmount) internal view returns (uint256) {
        return weiAmount.mul(_rate);
    }
    
    
    function _forwardFunds() internal {
        // address(this).transfer(msg.value);
    }
    
    
    function withDraw() public payable {
        for(uint i = 0; i<= accountCount; i++){
            address payable accountAddr = accountIndex[i];
            // address payable
            // address(this).transfer(account);
            // account.transfer(_wallet.)
            // address(this).transfer(_wallet.balance);
            uint weiToTransfer = accounts[accountAddr];
            accountAddr.transfer(weiToTransfer);

    
        }
        
    }

}