# 🗳️ Ethereum Voting Smart Contract

A secure and transparent voting smart contract built with Solidity for use in decentralized voting systems. This contract allows the owner to register candidates and voters, toggle the voting session, and enable registered users to cast votes securely.

## 🔧 Features

- ✅ Owner-controlled candidate and voter registration
- ✅ Secure voting mechanism for registered users only
- ✅ Vote tracking and prevention of double-voting
- ✅ Real-time vote count for each candidate
- ✅ Function to determine the winner
- ✅ Event emission for transparency and auditability

## 📄 Smart Contract Details

### 🏗️ Contract: `Project`

### Key Variables

| Variable           | Type     | Description                                 |
|--------------------|----------|---------------------------------------------|
| `owner`            | `address`| The contract deployer and administrator     |
| `votingActive`     | `bool`   | Status of voting session                    |
| `totalCandidates`  | `uint256`| Total number of candidates registered       |
| `totalVoters`      | `uint256`| Total number of voters registered           |

### Structs

- **Candidate**: `id`, `name`, `voteCount`, `exists`
- **Voter**: `isRegistered`, `hasVoted`, `votedCandidateId`

### Events

- `CandidateAdded`
- `VoterRegistered`
- `VoteCast`
- `VotingStatusChanged`

## ⚙️ Functions

### Admin Functions (Only Owner)
- `addCandidate(string memory _name)`
- `registerVoter(address _voterAddress)`
- `toggleVotingStatus()`

### Voter Functions
- `castVote(uint256 _candidateId)` – Only for registered voters when voting is active.

### View Functions
- `getCandidate(uint256 _candidateId)`
- `getVoterInfo(address _voterAddress)`
- `getWinner()` – Returns the candidate with the highest votes.

## 🚨 Requirements & Rules

- Voters must be registered **before** voting starts.
- Candidates can only be added **before** voting starts.
- Each registered voter can **vote only once**.
- The owner toggles voting status manually using `toggleVotingStatus()`.

## 🧪 Testing

You can test this contract using:

- **Remix IDE**: https://remix.ethereum.org/
- **Hardhat** or **Foundry** for local testing and scripting

### Suggested Tests

- Register voters and candidates before voting starts
- Attempt voting when voting is inactive (should fail)
- Test double-voting prevention
- Validate winner determination logic
- Test tie situations manually

## 🛡️ Security Notes

- Only the contract owner can manage critical settings.
- Double voting is strictly prevented.
- No third-party access to voter identity or preferences.

## 💡 Possible Enhancements

- Handle ties in `getWinner()` with a `getWinners()` function
- Add time-based voting duration
- Export results in batches for frontend integration
- Add role-based access using OpenZeppelin’s `Ownable` or `AccessControl`
- Make the system DAO-based and remove central authority

## 📜 License

This project is licensed under the MIT License.  
See the [LICENSE](./LICENSE) file for more details.

---

> Made with ❤️ in Solidity
> Contract Address: 0x38C43e549F53b25B6253ae7DddCeEF5B0b84e95e
> 
> <img width="1286" height="329" alt="image" src="https://github.com/user-attachments/assets/c7d5c6ed-d142-4283-9984-82d532a721df" />

