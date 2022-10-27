// SPDX-License-Identifier: GPL-3.0 

pragma solidity >=0.7.0 <0.9.0;


contract DiceGame {
    mapping(address => uint256) balance; 
    address[] public players; 
    address[] public customers;

    
    event Deposit(address customer, string message, address[] customers); 
    event Withdrawal(address customer);
    event RandomNum(uint256 randomNum);
    event Twoplayers(address playerA, address playerB);
    event Message(string message);
    event moneyTransfer(uint256 amountWinner, uint256 amountLoser);

    
    function deposit(string memory message) public payable { 
        require(msg.value > 10);
        balance[msg.sender] += msg.value; 

        customers.push(msg.sender);

        emit Deposit(msg.sender, message, customers); 
    }


    function play() public {
        players.push(msg.sender);
        if (players.length >= 2){
            address playerA = players[0];
            address playerB = players[1];

            emit Message("Already have two players");

            startGame(playerA, playerB);
            
        } 
        else {
            emit Message("Not enough players");
        }
        
    }

    function startGame(address playerA, address playerB) private {
        emit Twoplayers(playerA, playerB);

        uint256 n = requestRandomNum();
        emit RandomNum(n);

        address winner; address loser;
        uint256 amountWinner; uint256 amountLoser;
        
        if (n <= 3){
            winner = playerA;
            loser = playerB;
            amountWinner = (3 + n) * 1000000000000000000;
            amountLoser = (3 - n) * 1000000000000000000;

            emit Message("Hey!!!!!!!! n < 3");
        } 
        else{
            winner = playerB;
            loser = playerA;
            amountWinner = (3 - 3 + n) * 1000000000000000000;
            amountLoser = (3 + 3 - n) * 1000000000000000000;
        }

        emit moneyTransfer(amountWinner, amountLoser);

        balance[winner] -= 3 * 1000000000000000000;
        balance[loser] -= 3 * 1000000000000000000;
        payable(winner).transfer(amountWinner);
        payable(loser).transfer(amountLoser);


    }

    function requestRandomNum() private returns (uint256) {
        return 6;
    }

    function PlayersLength() public view returns (uint256) {
        return players.length;
    }

    function withdraw() public { 
        uint256 b = balance[msg.sender]; 
        balance[msg.sender] = 0; 
        payable(msg.sender).transfer(b); 

        emit Withdrawal(msg.sender);
    }

    function getBalance() public view returns (uint256) {
        return balance[msg.sender];
    }

}
