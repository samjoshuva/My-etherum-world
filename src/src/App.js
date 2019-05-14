import React,{Component} from 'react';
import contract from './contract'
import crowedSale from './crowedSale'
import Web3 from 'web3';
import { async } from 'q';


const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
const token = web3.eth.Contract(contract.abi,contract.address)
const sale = web3.eth.Contract(crowedSale.abi,crowedSale.address)


class App extends Component{
  state={
    toAddress:'',
    balanceOf:'',
    wei:'',
    message:'',
    benifiary:''
  }

  async componentDidMount(){
    

    // const balance = await token.methods.balanceOf('0xbc0f6469b4b3d27b14bf883438b4ed296b0cc884').call()
    // console.log(balance.toString())
    // console.log(address[4])
    // console.log(address[0])

    // await token.methods.transfer(address[4],1).send({from:address[0]})

    // const balanceTo = await token.methods.balanceOf(address[0]).call()
    // console.log("from ",balanceTo.toString())

    // const balanceFrom = await token.methods.balanceOf(address[4]).call()
    // console.log("to ",balanceFrom.toString())

  
    
  }

  checkBalance = async () =>{
  
    web3.eth.getAccounts(async (error, result) => {
    
      console.log(result[0])
      const balance = await token.methods.balanceOf(this.state.balanceOf).call()
      console.log("from ",balance.toString())
      this.setState({message:` ${balance.toString()} SJ tokens`})

    });
    
  }
  transfer= async ()=>{
    console.log(this.state.toAddress)
    // this.setState({message:"Please wait while your transaction is performed"})
    web3.eth.getAccounts(async (error, result) => {
      if(error){
        return this.setState({message:`ERROR :Transaction succesfull ${error} `})
      }
    
      await token.methods.transfer(this.state.toAddress,this.state.wei).send({from:result[0]})
      

    });
    this.state.toAddress = ''
      this.state.wei = ''
      this.setState({message:"Transaction succesfull"})

  }
   buyToken=async()=>{

    web3.eth.getAccounts(async (error, result) => {
      if(error){
        return this.setState({message:`ERROR :Transaction succesfull ${error} `})
      }
    
      await sale.methods.buyTokens(this.state.benifiary).send({from:result[0],gas: 3000000, value: this.state.wei})

    });
    // this.state.benifiary =''
    this.setState({message:"Transaction succesfull"})

     

  }



  render(){
    // console.log(web3.version)
    // web3.eth.getAccounts().then(console.log)

    
    return (
      <div>
        <div className="alert alert-secondary" role="alert">
            <strong> {this.state.message}</strong>
        </div> 
         <input className="form-control" value={this.state.balanceOf} onChange={e=>this.setState({balanceOf:e.target.value})}></input>

        <button className="btn btn-primary"  onClick={this.checkBalance} >Check balance</button>
        <hr/>

        {/* <input className="form-control" value={this.state.toAddress} placeholder="to address" onChange={e=>this.setState({toAddress:e.target.value})}></input>
        <input className="form-control" value={this.state.wei} placeholder="number of tokens needed to be send" onChange={e=>this.setState({wei:e.target.value})}></input>
        
        <button className="btn btn-primary" onClick={this.transfer}>transfer</button> */}

        <input className="form-control" placeholder="wei to transfer" value={this.state.wei} onChange={e=>this.setState({wei:e.target.value})}></input>
        
        <input className="form-control" placeholder="Address of benifiary" value={this.state.benifiary} onChange={e=>this.setState({benifiary:e.target.value})}></input>

        <button className="btn btn-primary"  onClick={this.buyToken} >Buy Token</button>
        <hr/>

      </div>
    )
  }
}

export default App;
