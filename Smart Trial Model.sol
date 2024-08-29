// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract SmartTrialModel {

    struct Org {
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
        string[] healthStat;
        uint[] healthStatTime;
        string[] prescription;
        uint[] prescriptionTime;
        uint[] dosage;
        uint[] nextAP;
        string[] labResult;
        uint[] labResultTime;
        uint balance;
        uint userAppointmentCount;
    }

    uint appointmentCount;
    uint interval;

    string patient = "patient";
    string clinicalTeam = "clinicalTeam";
    address payable patients;
    address owner;

    mapping(string => Org) orgs;
    mapping(address => healthData) healthDatas;
    // uint public timer1;

    function timers() private view returns(uint) {
        uint timer = block.timestamp;
        return timer;
    }

     /** - healthDatas[_userAdd].dosage includes _dosage*/
    function withdraw(address _patient) external {
        uint256 amount = healthDatas[_patient].balance;
        require(amount > 0, "No balance to withdraw");
        healthDatas[_patient].balance = 0;
        payable(_patient).transfer(amount);
    }

    /** - healthDatas[_userAdd].dosage includes _dosage*/
    function deposit() external payable {}

    /** - healthDatas[_userAdd].dosage includes _dosage*/
    function registerMember(address _memberAddress, string memory _name, string memory _org, string memory _role, string memory _profile) external {
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

    /** - healthDatas[_userAdd].dosage includes _dosage*/
    function updateHealthStat(address _userAdd, string memory _healthStat) external {
        if (appointmentCount >= timers() - interval) {
            appointmentCount = appointmentCount + interval;
        }
        
        require(orgs[patient].members[_userAdd].isRegistered == true);
        require(orgs[clinicalTeam].members[msg.sender].isRegistered == true);
        require(healthDatas[_userAdd].userAppointmentCount >= appointmentCount - 2 * interval);
        healthDatas[_userAdd].healthStat.push(_healthStat);
        healthDatas[_userAdd].healthStatTime.push(timers());
        healthDatas[_userAdd].balance = healthDatas[_userAdd].balance + 250000000000000000;
    }

    /** - healthDatas[_userAdd].dosage includes _dosage*/
    function updatelabResult(address _userAdd, string memory _labResult) external {
        require(orgs[patient].members[_userAdd].isRegistered == true);
        require(orgs[clinicalTeam].members[msg.sender].isRegistered == true);
        healthDatas[_userAdd].labResult.push(_labResult);
        healthDatas[_userAdd].labResultTime.push(timers());
        healthDatas[_userAdd].balance = healthDatas[_userAdd].balance + 250000000000000000;
    }

    /** - healthDatas[_userAdd].dosage includes _dosage*/
    function updateprescriptiont(address _userAdd, string memory _prescription, uint _dosage) external {
        require(orgs[patient].members[_userAdd].isRegistered == true);
        require(orgs[clinicalTeam].members[msg.sender].isRegistered == true);
        healthDatas[_userAdd].prescription.push(_prescription);
        healthDatas[_userAdd].dosage.push(_dosage);
        healthDatas[_userAdd].prescriptionTime.push(timers());
        healthDatas[_userAdd].balance = healthDatas[_userAdd].balance + 250000000000000000;
    }

    /** - healthDatas[_userAdd].dosage includes _dosage*/
    function updatenextAP(address _userAdd, uint _nextAP) external {
        require(orgs[patient].members[_userAdd].isRegistered == true);
        require(orgs[clinicalTeam].members[msg.sender].isRegistered == true);
        healthDatas[_userAdd].nextAP.push(_nextAP);
        // healthDatas[_userAdd].labResultTime.push(block.timestamp);
    }

    /** - healthDatas[_userAdd].dosage includes _dosage*/
  function viewMember(string memory _org, address _user) external view returns(Member memory) {
        return orgs[_org].members[_user];
    }

    /** - healthDatas[_userAdd].dosage includes _dosage*/
    function viewUpdate(address _user) external view returns(healthData memory) {
        return healthDatas[_user];
    }
}
