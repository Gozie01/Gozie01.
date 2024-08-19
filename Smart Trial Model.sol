// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract colabresearch{

    struct Org{
        mapping(address => Member) members;
        string orgName;

    }

    struct Member {
        string name;
        string role;
        string profile;
        bool isRegistered;
        string orgName;
    }

    struct healthData {
        string [] healthStat;
        uint [] healthStatTime;
        string [] prescription;
        uint [] prescriptionTime;
        uint [] dosage;
        uint [] nextAP;
        string [] labResult;
        uint [] labResultTime;
    }

    string patient = "patient";
    string clinicalTeam = "clinicalTeam";

    // address public admin;
    mapping(string => Org) orgs;
    mapping (address => healthData) healthDatas;


    function registerMember(address _memberAddress, string memory _name, string memory _org, string memory _role, string memory _profile) public {
        require(!orgs[_org].members[_memberAddress].isRegistered, "Member is already registered");

        orgs[_org].orgName = _org;
        orgs[_org].members[_memberAddress] = Member({
            name: _name,
            orgName: _org,
            role: _role,
            profile: _profile,
            isRegistered: true
        });
    }


    function updateHealthStat(address _userAdd, string memory _healthStat)external{
        require(orgs[patient].members[_userAdd].isRegistered == true);
        require(orgs[clinicalTeam].members[msg.sender].isRegistered == true);
        healthDatas[_userAdd].healthStat.push(_healthStat);
        healthDatas[_userAdd].healthStatTime.push(block.timestamp);
        
        
    }

    function updatelabResult(address _userAdd, string memory _labResult)external{
        require(orgs[patient].members[_userAdd].isRegistered == true);
        require(orgs[clinicalTeam].members[msg.sender].isRegistered == true);
        healthDatas[_userAdd].labResult.push(_labResult);
        healthDatas[_userAdd].labResultTime.push(block.timestamp);
        
        
    }

    function updateprescriptiont(address _userAdd, string memory _prescription, uint _dosage)external{
        require(orgs[patient].members[_userAdd].isRegistered == true);
        require(orgs[clinicalTeam].members[msg.sender].isRegistered == true);
        healthDatas[_userAdd].prescription.push(_prescription);
        healthDatas[_userAdd].dosage.push(_dosage);
        healthDatas[_userAdd].prescriptionTime.push(block.timestamp);
               
    }
        function updatenextAP(address _userAdd, uint _nextAP)public {
        require(orgs[patient].members[_userAdd].isRegistered == true);
        require(orgs[clinicalTeam].members[msg.sender].isRegistered == true);
        healthDatas[_userAdd].nextAP.push(_nextAP);
        // healthDatas[_userAdd].labResultTime.push(block.timestamp);
        
    }function viewMember(string memory _org, address _user)external view returns(Member memory){
        return orgs[_org].members[_user];
    }
    function viewUpdate(address _user)external view returns(healthData memory){
        return healthDatas[_user];


}
}
