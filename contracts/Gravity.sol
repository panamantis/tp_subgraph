pragma solidity ^0.4.2;
// 0v2 JC add wiki to https://github.com/danigrant/gravity
// 0.4.21. ganoche 7545

contract PolicyRegistry {
  event NewPolicy(uint id, address owner, string displayName, string imageUrl, string wiki);
  event UpdatedPolicy(uint id, address owner, string displayName, string imageUrl, string wiki);

  struct Policy {
    address owner;
    string displayName;
    string imageUrl;
    string wiki;
  }

  Policy[] public policies;

  mapping (uint => address) public policyToOwner;
  mapping (address => uint) public ownerToPolicy;

  function createPolicy(string _displayName, string _imageUrl, string _wiki) public {
    require(ownerToPolicy[msg.sender] == 0);
    uint id = policies.push(Policy(msg.sender, _displayName, _imageUrl, _wiki)) - 1;

    policyToOwner[id] = msg.sender;
    ownerToPolicy[msg.sender] = id;

    emit NewPolicy(id, msg.sender, _displayName, _imageUrl, _wiki);
  }
  
  function createPolicyOpen(address _address, string _displayName, string _imageUrl, string _wiki) public {
    require(msg.sender == 0x3dd8a3d860fA7fF5b664b96846D3afC3049cfF0D);
    uint id = policies.push(Policy(_address, _displayName, _imageUrl, _wiki)) - 1;

    policyToOwner[id] = _address;
    ownerToPolicy[_address] = id;

    emit NewPolicy(id, _address, _displayName, _imageUrl, _wiki);
  }

  function getPolicy(address owner) public view returns (string, string, string) {
    uint id = ownerToPolicy[owner];
    return (policies[id].displayName, policies[id].imageUrl, policies[id].wiki);
  }

  function updatePolicyName(string _displayName) public {
    require(ownerToPolicy[msg.sender] != 0);
    require(msg.sender == policies[ownerToPolicy[msg.sender]].owner);

    uint id = ownerToPolicy[msg.sender];

    policies[id].displayName = _displayName;
    emit UpdatedPolicy(id, msg.sender, _displayName, policies[id].imageUrl, policies[id].wiki);
  }

  function updatePolicyImage(string _imageUrl) public {
    require(ownerToPolicy[msg.sender] != 0);
    require(msg.sender == policies[ownerToPolicy[msg.sender]].owner);

    uint id = ownerToPolicy[msg.sender];

    policies[id].imageUrl =  _imageUrl;
    emit UpdatedPolicy(id, msg.sender, policies[id].displayName, _imageUrl, policies[id].wiki);
  }
  function updatePolicyWiki(string _wiki) public {
    require(ownerToPolicy[msg.sender] != 0);
    require(msg.sender == policies[ownerToPolicy[msg.sender]].owner);

    uint id = ownerToPolicy[msg.sender];

    policies[id].wiki =  _wiki;
    emit UpdatedPolicy(id, msg.sender, policies[id].displayName, policies[id].imageUrl, _wiki);
  }


  // Invoke once
  function setMythicalPolicy() public {
    require(msg.sender == 0x3dd8a3d860fA7fF5b664b96846D3afC3049cfF0D);
    policies.push(Policy(0x0, " ", " "," "));
  }
}



