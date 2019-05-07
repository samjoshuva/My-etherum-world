const ERC20 = artifacts.require("./ERCToken");

module.exports = function (deployer) {
    deployer.deploy(ERC20);
};