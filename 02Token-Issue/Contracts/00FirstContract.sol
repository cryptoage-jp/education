pragma solidity 0.4.23;

contract Lottery{
    address public manager;
    address[] public plyaers;

    constructor() public {
        manager = msg.sender;
    } 

    function enter() public{
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
    }

    function getPlayers() public view returns (address[]){
        return players;
    } 
}