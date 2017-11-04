pragma solidity ^0.4.2;

contract OpenElection {

    address public owner;

    uint public votingDeadline;
    string public proposalDescription;

    event Voted(uint proposalID, bool position, address voter);


    uint public numProposals;

    //Voter[] public voters;
    mapping(address => Voter) public voters;

    struct Voter {
        uint weight;
        bool voted;
        uint8 votes;
        address delegate;
    }

    Proposal[] public proposals;

    struct Proposal {
        bytes32 proposition;
        uint voteCount;
    }





    // @notice creating the Ballot based on votes
    // @param list of proposals that voters can choose between
    // @param the deadline when the vote ends
    function OpenElection(string _proposalDescription, bytes32[] _proposalDescriptions) {

        proposalDescription = _proposalDescription;

        //votingDeadline = now + _votingDeadlineInMinutes * 1 minutes;


        voters[msg.sender].weight = 1;

        for (uint i=0; i < _proposalDescriptions.length; i++) {
            proposals.push(Proposal({
                proposition: _proposalDescriptions[i],
                voteCount: 0
            }));
        }

    }

    function getProposalDescription() constant returns(bytes32 _proposalDescription) {
        return stringToBytes32(proposalDescription);
    }


    function stringToBytes32(string memory source) constant returns (bytes32 result) {
        assembly {
        result := mload(add(source, 32))
        }
    }


    function vote(uint8 proposal) {
        Voter storage sender = voters[msg.sender];
        //require(!sender.voted);

        sender.voted = true;
        proposals[proposal].voteCount += 1;
    }

    function getResults() constant returns (bytes32[], uint[]) {

        bytes32[] memory proposalNames = new bytes32[](proposals.length);
        uint[] memory counts = new uint[](proposals.length);

        for (uint p = 0; p < proposals.length; p++) {
            proposalNames[p] = proposals[p].proposition;
            counts[p] = proposals[p].voteCount;
        }
        return (proposalNames, counts);
    }

}
