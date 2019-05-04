pragma solidity >=0.5.0 <0.7.0;

contract Project {
    
    string public title;
    uint public min_bid;
    address public employer;
    
    address public bestBidder = address(0);
    uint public bestBid = 0;
    
    mapping(address => uint) public bidders;
    address selectedBidder= address(0);

    bool ended;
    
    constructor(string memory _title, uint  _min_bid) public payable {
        employer = msg.sender;
        title = _title;
        min_bid = _min_bid;
    }
    
    function bid(uint amount) public {
        require (amount > min_bid);
        require(!ended);
        require(bidders[msg.sender] == 0);
        require(bestBid < amount);
        
        bestBid = amount;
        bestBidder = msg.sender;
                
        bidders[msg.sender] += amount;
    }
    
    function selectBidder(address bidder) public{
        require(!ended);
        require(bidders[bidder] != 0);
        require(msg.sender == employer);
        
        selectedBidder = bidder;
        endBid();
    }
    
    
    function withDraw() public{
        require(ended);
        require(msg.sender == employer);
        msg.sender.transfer(20 ether);
       
    }
    
    function endBid() public {
        require(!ended);
        require(msg.sender == employer);
        ended = true;
    }
    
    
    
    
}

