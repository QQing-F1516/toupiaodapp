// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting {
    // 候选人结构体
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // 合约管理员
    address public admin;
    // 候选人列表
    Candidate[] public candidates;
    // 记录已投票的地址
    mapping(address => bool) public hasVoted;

    // 事件（候选人添加事件）
    event CandidateAdded(uint256 id, string name);
    event Voted(address indexed voter, uint256 candidateId);

    // 修饰符：仅管理员
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    // 构造函数：设置合约管理员
    constructor() {
        admin = msg.sender;
    }

    // 功能：添加候选人（管理员） - 主要函数（代码注释）- 关键
    function addCandidate(string memory _name) public onlyAdmin {
        uint256 candidateId = candidates.length;
        candidates.push(Candidate({
            id: candidateId,
            name: _name,
            voteCount: 0
        }));
        emit CandidateAdded(candidateId, _name);
    }

    // 功能：投票（选民） - 投票函数
    function vote(uint256 _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId < candidates.length, "Invalid candidate ID");
        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        emit Voted(msg.sender, _candidateId);
    }

    // 功能：获取所有候选人 
    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    // 功能：获取候选人数量 - 主要函数（代码注释）- 关键
    function getCandidateCount() public view returns (uint256) {
        return candidates.length;
    }

    // 功能：获取单个候选人信息 - 主要函数（代码注释）- 关键
    function getCandidate(uint256 _candidateId) public view returns (Candidate memory) {
        require(_candidateId < candidates.length, "Invalid candidate ID");
        return candidates[_candidateId];
    }

    // 功能：检查地址是否已投票 - 主要函数（代码注释）- 关键
    function checkVote(address _voter) public view returns (bool) {
        return hasVoted[_voter];
    }
}