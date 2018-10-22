# truffleでコントラクトの実行を確かめる

lotteryフォルダを作る

`$ mkdir lottery && cd lottery`

truffleプロジェクトを作成する

`$ mkdir lottery-contract && cd lottery-contract && truffle init`

truffleの設計ファイルtruffle.jsと.envファイルを作成する

`$ touch .env //.envファイルの作成`

.envファイルの中にメタマスクのニーモニックコードを入れる

`$ echo MNEMONIC=hoge hoge hoge hoge hoge hoge hoge >> .env`
`$ echo INFURA_ACCESS_TOKEN >> .env`

![metamaskでニーモニックを見る方法](https://github.com/cryptoage-jp/education/blob/master/images/metamask.png)

## デプロイ準備
`$ npm init`

`$ npm install`

`$ npm i -g genache-cli@6.1.8 truffle@4.1.14`

## truffleでのデプロイ
1. remixで書いたコードをtruffleプロジェクトのcontractsにいれる。contracts/Lottery.solを作ってfirstContractをコピー
1. deploy scriptを準備する。migrations/2_deploy_contracts.jsのファイルを作る

![truffle](https://github.com/cryptoage-jp/education/blob/master/images/truffle.png)

## ganache-cliに向けてデプロイ
別のターミナルでganache-cliを立ち上げる
`$ ganache-cli`

lottery-contract直下で
`lottery-contract$ truffle compile`
`lottery-contract$ truffle migrate`