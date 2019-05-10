const ERC20 = artifacts.require("./ERC20");
const CrowedSale = artifacts.require("./CrowedSale");

module.exports = function (deployer) {

    deployer.deploy(ERC20).then(()=>{
        // console.log(ERC20.address())
        return deployer.deploy(CrowedSale,1,"0x67d3624c632736ef7d3796d39cc7c96c7a8c68e1",ERC20.address).then(()=>{
            console.log(CrowedSale.address)
        })

    });
    // deployer.deploy(CrowedSale,);
    
};