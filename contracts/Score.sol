//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// just a toy contract , to reinforce syntax
// because i can
contract Score {
    address owner;
    mapping( address => uint ) score_list;
    uint my_score = score_list[owner]; 

    event score_set(uint indexed);

    constructor(){
        owner = msg.sender;
    }

    //onlyOwner
    modifier onlyMeTheOwnerWhoAlsoIsMyBestFanSoOnlyFans {
        require( msg.sender == owner, "Not allowed");
        _;
    }

    modifier safeScore {
        require(score <= type(uint256).max && score >= type(uint256).min ,"don't over/underflow me");
        _;
    }

    //get score is implicit in the public declaration
    function getScore(address user) public view returns (uint){
        return score_list[user];
    }

    //set score, a defensive approach
    function setScore(uint _score, address user) public onlyMeTheOwnerWhoAlsoIsMyBestFanSoOnlyFans safeScore {
        score_list[user] = _score;
        emit score_set(_score);
    }
}
