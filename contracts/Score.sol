//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// just a toy contract , to reinforce syntax
// because i can
contract Score {
    address owner;
    mapping(address => uint256) score_list;
    uint256 my_score = score_list[owner];

    event score_set(uint256 indexed);

    constructor() {
        owner = msg.sender;
    }

    //onlyOwner
    modifier onlyMeTheOwnerWhoAlsoIsMyBestFanSoOnlyFans() {
        require(msg.sender == owner, "Not allowed");
        _;
    }

    //get score is implicit in the public declaration
    function getScore(address user) public view returns (uint256) {
        return score_list[user];
    }

    //set score, a defensive approach
    function setScore(uint256 _score, address user)
        public
        onlyMeTheOwnerWhoAlsoIsMyBestFanSoOnlyFans
    {
        require(
            _score <= type(uint256).max && _score >= type(uint256).min,
            "don't over/underflow me"
        );

        score_list[user] = _score;
        emit score_set(_score);
    }
}
