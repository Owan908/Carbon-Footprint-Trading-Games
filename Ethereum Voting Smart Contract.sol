// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Project {
    // State variables
    address public owner;
    uint256 public totalCandidates;
    uint256 public totalVoters;
    bool public votingActive;
    
    // Structs
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
        bool exists;
    }
    
    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint256 votedCandidateId;
    }
    
    // Mappings
    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voter) public voters;
    
    // Events
    event CandidateAdded(uint256 indexed candidateId, string name);
    event VoterRegistered(address indexed voterAddress);
    event VoteCast(address indexed voter, uint256 indexed candidateId);
    event VotingStatusChanged(bool status);
    
    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    modifier onlyRegisteredVoter() {
        require(voters[msg.sender].isRegistered, "You must be registered to vote");
        _;
    }
    
    modifier votingIsActive() {
        require(votingActive, "Voting is not currently active");
        _;
    }
    
    // Constructor
    constructor() {
        owner = msg.sender;
        votingActive = false;
        totalCandidates = 0;
        totalVoters = 0;
    }
    
    // Core Function 1: Add Candidate
    function addCandidate(string memory _name) public onlyOwner {
        require(bytes(_name).length > 0, "Candidate name cannot be empty");
        require(!votingActive, "Cannot add candidates while voting is active");
        
        totalCandidates++;
        candidates[totalCandidates] = Candidate({
            id: totalCandidates,
            name: _name,
            voteCount: 0,
            exists: true
        });
        
        emit CandidateAdded(totalCandidates, _name);
    }
    
    // Core Function 2: Register Voter
    function registerVoter(address _voterAddress) public onlyOwner {
        require(_voterAddress != address(0), "Invalid voter address");
        require(!voters[_voterAddress].isRegistered, "Voter already registered");
        require(!votingActive, "Cannot register voters while voting is active");
        
        voters[_voterAddress] = Voter({
            isRegistered: true,
            hasVoted: false,
            votedCandidateId: 0
        });
        
        totalVoters++;
        emit VoterRegistered(_voterAddress);
    }
    
    // Core Function 3: Cast Vote
    function castVote(uint256 _candidateId) public onlyRegisteredVoter votingIsActive {
        require(!voters[msg.sender].hasVoted, "You have already voted");
        require(candidates[_candidateId].exists, "Candidate does not exist");
        require(_candidateId > 0 && _candidateId <= totalCandidates, "Invalid candidate ID");
        
        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedCandidateId = _candidateId;
        candidates[_candidateId].voteCount++;
        
        emit VoteCast(msg.sender, _candidateId);
    }
    
    // Additional utility functions
    function toggleVotingStatus() public onlyOwner {
        require(totalCandidates > 0, "Must have at least one candidate before starting voting");
        votingActive = !votingActive;
        emit VotingStatusChanged(votingActive);
    }
    
    function getCandidate(uint256 _candidateId) public view returns (uint256, string memory, uint256) {
        require(candidates[_candidateId].exists, "Candidate does not exist");
        Candidate memory candidate = candidates[_candidateId];
        return (candidate.id, candidate.name, candidate.voteCount);
    }
    
    function getVoterInfo(address _voterAddress) public view returns (bool, bool, uint256) {
        Voter memory voter = voters[_voterAddress];
        return (voter.isRegistered, voter.hasVoted, voter.votedCandidateId);
    }
    
    function getWinner() public view returns (uint256, string memory, uint256) {
        require(totalCandidates > 0, "No candidates available");
        
        uint256 winningVoteCount = 0;
        uint256 winningCandidateId = 0;
        
        for (uint256 i = 1; i <= totalCandidates; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningCandidateId = i;
            }
        }
        
        require(winningCandidateId > 0, "No winner found");
        return (winningCandidateId, candidates[winningCandidateId].name, winningVoteCount);
    }
}
