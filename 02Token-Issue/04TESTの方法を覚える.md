# Testを書く
コントラクトをデプロイ前にコントラクトのメソッドがうまく動くかどうかをチェックする。予期せぬコントラクトの仕様を防ぐことができるようになる。

## Testの書き方
1. Testというフォルダに{コントラクト名}.test.jsというファイルを作成する。今回はlottery.test.js。

## コード
```javascript
const {assertRevert} = require('./helpers/assertRevert');
const BigNumber = web3.BigNumber;

const Lottery = artifacts.require('Lottery.sol');

require('chai')
    .use(require('chai-bignumber')(BigNumber))
    .should();
    // http://takezoe.hatenablog.com/entry/20140129/p1

contract(`Lottery`, function (accounts){
    const creater = accounts[0]
    //contractというコントラクト専用のテストメソッドを使用する
    //その中に関数を定義しaccountsを渡す
    //truffleのtestではaccounts[]が0〜9まで何も定義せずに利用可能

    //コントラクトを呼ぶためのAPIをインスタンス化
    beforeEach(async() => {
        this.lottery = await Lottery.new({ from: creater });
    });

    describe('Lottery Contract', () => {
        //it('テスト説明',関数)という形で書く
        //ここではlottery.addressと書いてlotteryのコントラクトアドレスが帰ってくればtestをokにするとなっている。
        it('deploys a contract', () => {
            assert.ok(lottery.address);
        });
    });
});
```
テストをかけたら
`$ truffle test`

ここで使われている関数
![Mocha関数](https://github.com/cryptoage-jp/education/blob/master/images/mocha.png)
![Mocha関数Process](https://github.com/cryptoage-jp/education/blob/master/images/process.png)