// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VolcanoCoin {
//non erc20 compliant contract 🌋
    uint public totalSupply;
    address owner;
    mapping(address => uint) public balance;
    mapping(address => Payment[] ) payments;

    struct Payment {
        address recipients;
        uint amount;
    }

    modifier onlyOwner {
        require( msg.sender == owner, "Access Control error, not alowed");
        _;
    }

    event supplyChanged(uint indexed supply);
    event transferFrom(address indexed from, uint value);

    constructor() {
        totalSupply = 100000;
        owner = msg.sender;
        setBalance(owner, totalSupply);
    }

    function getBalance(address user) public view returns (uint) {
        return balance[user];
    }

    function setBalance(address user, uint _balance) public returns (uint) {
        return balance[user] = _balance;
    }

    // extra function, a public variable is also a getter
    function getTotalSupply() public view returns (uint) {
        return totalSupply;
    }

    //insecure function, for pedagogical reasons
    function transfer(address from, uint amount) public payable {
        require(balance[owner] >= 0);
        require(amount <= balance[owner], "Insuficient funds" );
        setBalance(owner, getBalance(owner)-amount); //balance[owner] -= amount;
        setBalance(from, getBalance(from)+amount);   //balance[from] += amount;

        emit transferFrom(from , amount);
    }

    function getPayments(address user) public view returns (Payment[] memory){
        return payments[user];
    }

    function mint(uint amount) public onlyOwner{
        totalSupply += amount;
        emit supplyChanged(totalSupply);
    }

}

