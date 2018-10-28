# 03Solidityコードの作成
cd desktop/MyToken/Contractsに移動してMyToken.solを用意する


```solidity
pragma solidity ^0.4.18;
//OpenZeppelinからStandardToken.solをインポート
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

//standardTokenを継承
contract MyToken is StandardToken {
  string public name = "SotaToken";
  string public symbol = "SOT";
  //小数点の桁数
  uint public decimals = 18;

  function MyToken(uint initialSupply) public {
    totalSupply_ = initialSupply;
    balances[msg.sender] = initialSupply;
  }
}
```

## solidityコンパイル
`$ truffle compile`

build/contractsにjsonファイルが作成される

## マイグレーションファイルの作成
名前：2_deploy_my_token.js
```javascript
const MyToken = artifacts.require('./MyToken.sol')

module.exports = (deployer) => {
  //xxxのとことで総量を決める
  const initialSupply = xxxe18
  deployer.deploy(MyToken, initialSupply)
}
```
