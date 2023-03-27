pragma solidity ^0.4.20;

contract ECR20Interface{
    string public name;
    string public symbol;
    uint8 public decimals;
    uint public totalSupply;

    function balanceOf(address _owner) public view returns (uint256 balance);

    function transfer(address _to, uint256 _value) public returns (bool success);

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);

    function approve(address _spender, uint256 _value) public returns (bool success);

    function allowance(address _owner, address _spender) public view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract ERC20  is ECR20Interface{

    mapping(address => uint) balanceOfMap;
    mapping(address => mapping(address =>uint)) internal allowed;

    constructor() public{
        name = "bing token";
        symbol = "Silence";
        decimals = 0;
        totalSupply = 100000000;
        balanceOfMap[msg.sender] = totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance){
        return balanceOfMap[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        require(_to!=address(0));
        require(balanceOfMap[msg.sender]>=_value);
        require(balanceOfMap[_to]+_value>=balanceOfMap[_to]);

        balanceOfMap[msg.sender] -=_value;
        balanceOfMap[_to]+=_value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(_to!=address(0));
        require(balanceOfMap[_from] >= _value);
        /// 重要，不要弄混了
        require(allowed[_from][msg.sender]>=_value);
        require(balanceOfMap[_to] + _value >= balanceOfMap[_to]);

        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
        /// 重要，不要弄混了
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender,_spender,_value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }

}