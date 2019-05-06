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
        require (amount > min_bid, " amount must be greater than minimum bid value ");
        require(!ended," Sorry bid has been closed ");
        require(bidders[msg.sender] == 0, " you have already bidded some amount in project  ");
 
        if(bestBid < amount){
            bestBid = amount;
        }

        bestBidder = msg.sender;
        bidders[msg.sender] += amount;
    }
    
    function selectBidder(address bidder) public{
        require(!ended," Sorry bid has been closed ");
        require(bidders[bidder] != 0, "no address found");
        require(msg.sender == employer," only employer can execute this function ");
        
        selectedBidder = bidder;
        endBid();
    }
    
    
    function withDraw() public{
        require(ended," Sorry bid has been closed ");
        require(msg.sender == employer," only employer can execute this function ");
        msg.sender.transfer(20 ether);
       
    }
    
    function endBid() public {
        require(!ended," Sorry bid has been closed ");
        require(msg.sender == employer," only employer can execute this function ");
        ended = true;
    }
 
}

