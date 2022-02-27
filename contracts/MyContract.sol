pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    address private minter;
    mapping(address => uint) public balances;
    modifier checkMinter {
        require(minter == msg.sender, 'You have permission setup balace');
        _;
    }
    modifier checkBalance(uint amount) {
        require(balances[msg.sender] >= amount, "You don't have enough balance");
        _;
    }
    event Transfer(address indexed from, address indexed to, uint value);
    constructor() {
        minter = msg.sender;
    }

    function set(uint amount) public checkMinter{
        balances[msg.sender] += amount;
    }

    function get(address add) public view returns (uint) {
        return balances[add];
    }

    function send(address receiver, uint amount) public checkBalance(amount){
        balances[msg.sender]-= amount;
        balances[receiver]+= amount;
        emit Transfer(msg.sender, receiver, amount);
    }
}