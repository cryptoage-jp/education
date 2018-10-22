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