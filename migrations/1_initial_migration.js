const Bid = artifacts.require("Bid");

module.exports = function (deployer) {
  deployer.deploy(Bid);
};