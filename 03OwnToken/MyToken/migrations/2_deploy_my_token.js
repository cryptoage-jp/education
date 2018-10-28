const MyToken = artifacts.require('./MyToken.sol')

module.exports = (deployer) => {
  const initialSupply = 50000e18
  deployer.deploy(MyToken, initialSupply)
}