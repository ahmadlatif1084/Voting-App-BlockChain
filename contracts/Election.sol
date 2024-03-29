pragma solidity ^0.5.0;

contract Election {
//Model Candidate
    struct Candidate {
    uint id;
    string name;
    uint voteCount;
    }

    event votedEvent(
        uint indexed _candidateId
    );
    //Store accounts that have voted
    mapping (address => bool) public voters;
    //Read write candidates
    mapping(uint => Candidate) public candidates;
    //store candidates count
    uint public candidatesCount;
    constructor() public{
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name,0);
    }
    function vote(uint _candidateId) public{
        // require that they haven't voted before
        require(!voters[msg.sender],'require that they donot voted before');
             //require a valid candidate
             require(_candidateId > 0 && _candidateId <= candidatesCount,'candidate valid');
            //record voter has voted
            voters[msg.sender] = true;
            //update candidate vote count
            candidates[_candidateId].voteCount++;

            emit votedEvent(_candidateId);

    }
}