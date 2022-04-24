// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC20VolcanoCoin is ERC20, Ownable {
    uint256 private constant INITIAL_SUPPLY = 100000;
    struct Payment {
        address recipients;
        uint256 amount;
    }

    mapping(address => Payment[]) public payments;
    event SupplyChanged(uint indexed newSupply);

    // 0x12..34 => { {0x12, 1900}, {0x34, 4000},.. }

    constructor() ERC20("VolcanoCoin", "VLC") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function getPayments(address _user) public view returns (Payment[] memory) {
        return payments[_user];
    }

    function recordPayment(
        address _sender,
        address _receiver,
        uint256 _amount
    ) internal {
        payments[_sender].push(Payment(_receiver, _amount));
    }

    function transfer(address _receiver, uint256 _amount)
        public
        override
        onlyOwner
        returns (bool)
    {
        _transfer(msg.sender,_receiver, _amount);
        recordPayment(msg.sender, _receiver, _amount);
        return true;
    }

    function addTotalSupply(uint256 _amount) public onlyOwner {
        _mint(msg.sender, _amount);
        emit SupplyChanged(_amount);
    }
}
