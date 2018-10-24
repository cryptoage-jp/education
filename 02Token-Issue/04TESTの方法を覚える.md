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


## コードの追記
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

        //lottery.enter()が正しく動作するかをチェックする
        //async/awaitはこの値が返ってくれるまで待ってくれるようになる
        //ここではenter()とplayerの挙動の確認をしている
        it('allows one account to enter', async () => {
            await this.lottery.enter({
                from: accounts[0],
                value: web3.toWei(0.02, 'ether')
            });

            const players = await this.lottery.getPlayers()

            players[0].should.be.equal(accounts[0]);
            players.length.should.be.equal(1);
        });

        it('allows multiple accounts to enter', async () => {
            await this.lottery.enter({
                from: accounts[0],
                value: web3.toWei('0.02','ether')
            })
            await this.lottery.enter({
                from: accounts[1],
                value: web3.toWei('0.02', 'ether')
            })
            await this.lottery.enter({
                from: account[2],
                value: web3.toWei('0.02', 'ether')
            })

            const players = await this.lottery.getPlayers()

            accounts[0].should.be.equal(players[0]);
            accounts[1].should.be.equal(players[1]);
            accounts[2].should.be.equal(players[2]);
            assert.equal(3, players.length);
        });

        it('requires a minimum amount of ether to enter', async () =>{
            await assertRevert(
                this.lottery.enter({
                    from: accounts[0],
                    value: 0
                })
            );
        });

        it('only manager can call pickWinner', async () => {
            await assertRevert(
                this.lottery.pickWinner({
                    from: accounts[1]
                })
            );
        });

        //勝者に報酬が支払われ参加者のプレーヤーの配列が空になることを確認する
        //最初に2eth払って参加し選出後と選出前の値をとっておきその差額をチェックする。2ではなく、1.8よりも多ければ良いというのはコントラクト実行時にガスを払っているので差分を見積もっている。
        it('sends money to the winner and reset the players array', async () => {
            await this.lottery.enter({
                from: accounts[0],
                value: web3.toWei('2','ether')
            });

            const initialBalance = await web3.eth.getBalance(accounts[0]);
            await this.lottery.pickWinner({ from: accounts[0] });
            const finalBalance = await web3.eth.getBalance(accounts[0]);
            const difference = finalBalance - initialBalance;

            assert(difference > web3.toWei('1.8','ether'));
        });
    });
});
```