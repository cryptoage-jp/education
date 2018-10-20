pragma solidity 0.4.23;

contract Lottery {
    address public manager;
    address[] public plyaers;

    constructor() public {
        manager = msg.sender;
    } 

    //payableを追加
    function enter() public payable{
        //0.1 etherより多い参加費を指定
        require(msg.value > 0.1 ether)
        players.push(msg.sender);
    }

    function random() private view return (uint){
        //なぜprivate修飾子がついているのか？publicではいけない理由はなにか？を考える。
        return uint(keccak256(block.difficulty, now, players));
    }

    function pickWinner() public {
        uint index = random() % players.length;
        //thisの果たす役割は？
        players[index].transfer(address(this).balance);

        //抽選の後に再抽選ができるようにメンバーを削除
        players = new address[](0);
    }

    function getPlayers() public view returns (address[]){
        return players;
    } 

    //抽選で溜まっている金額を返す関数を書く
    function getLotteryBalance() public view returns (uint) {
        return address(this).balance;
    }
}