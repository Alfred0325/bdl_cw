// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract DiceGame {
    mapping(address => uint256) balance;
    mapping(address => bool) lock;
    address[] public players;
    string[] private seeds;
    address[] public customers;

    event Deposit(address customer, string message);
    event Withdrawal(address customer);
    event Message(string messgae);
    event Num(uint256 num);

    function deposit(string memory message) public payable {
        balance[msg.sender] += msg.value;

        emit Deposit(msg.sender, message);
    }

    function getBalance() public view returns (uint256) {
        return balance[msg.sender];
    }

    function getLock() public view returns (bool) {
        return lock[msg.sender];
    }

    function add() public {
        customers.push(msg.sender);
        players.push(msg.sender);
    }


    function play(string memory seed) public {
        require(bytes(seed).length != 0, "No empty seed here");
        // require(lock[msg.sender] == false, "You are in the game right now!");
        require(balance[msg.sender] >= 3, "Not enough deposit");
        require(players.length <= 1, "Already have two players, Please try later!");

        lock[msg.sender] = true;
        players.push(msg.sender);
        seeds.push(seed);

        if (players.length == 2){
            address playerA = players[0];
            address playerB = players[1];
            stratGame(playerA, playerB);
        }
        else if (players.length > 2){
            for (uint i = 0; i < players.length-2; i++){
                players.pop(); 
            }
        } 
        else{
            emit Message("Wait for the other player...");
        }
    }

    function stratGame(address playerA, address playerB) private{
        uint256 n = rollRandomNum();

        if (n <= 3){
            balance[playerA] += n * 1000000000000000000;
            balance[playerB] -= n * 1000000000000000000;
        } else{
            // balance[playerB] += (n-3) * 1000000000000000000;
            balance[playerA] -= (n-3) * 1000000000000000000;
        }
        emit Num(n);     
        players.pop();
        players.pop();
        seeds.pop();
        seeds.pop();

        lock[playerA] = false;
        lock[playerB] = false;
    }

    function rollRandomNum() private returns (uint256){
        return 5;
    }

    function withdraw() public {
        uint256 b = balance[msg.sender];
        balance[msg.sender] = 0;
        payable(msg.sender).transfer(b);

        emit Withdrawal(msg.sender);
    }

    function stopGame() public {
        require(players.length == 1, "No players so far");
        require(seeds.length == 1, "No seeds so far");
        require(players[0] == msg.sender, "You are not the player!!");
        
        lock[msg.sender] = false;
        players.pop();
        seeds.pop();
        
    }


}
