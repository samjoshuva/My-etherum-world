pragma solidity ^0.5.0;

import "browser/ERC20.sol";
import "browser/safeMath.sol";


contract CrowedSale {
    using safeMath for uint; 
    
    ERC20 private _token;
    
    address payable private _wallet;
    
    uint private _rate;
    
    
    
    constructor(uint rate, address payable wallet, ERC20 token) public payable {
        
        require(rate > 0, "Crowdsale: rate is 0");
        require(wallet != address(0), "Crowdsale: wallet is the zero address");
        require(address(token) != address(0), "Crowdsale: token is the zero address");

        _rate = rate;
        _wallet = wallet;
        _token = token;
        
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
        uint256 weiAmount = msg.value;
        uint256 tokens = _getTokenAmount(weiAmount);
        _token.transferFrom(msg.sender, benifiary, tokens);
        _forwardFunds();
        
    }
    
    modifier preValidate() {
        require(msg.sender != address(0), "benifiary is address zero");
        require(msg.value != 0, " zero wei send");
        _;
    }
    
    function _getTokenAmount(uint256 weiAmount) internal view returns (uint256) {
        return weiAmount.mul(_rate);
    }
    
    
    function _forwardFunds() internal {
        _wallet.transfer(msg.value);
    }
    
}
