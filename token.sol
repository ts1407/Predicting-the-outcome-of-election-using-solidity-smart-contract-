pragma solidity 0.8.0;

contract Token {
    string public name;
    string public symbol;
    uint public totalSupply;
    uint public payout;

    mapping(address => uint) public balances;

    constructor(string memory _name, string memory _symbol, uint _totalSupply, uint _payout) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        payout = _payout;
        balances[msg.sender] = _totalSupply;
    }

    function transfer(address _to, uint _amount) public returns (bool) {
        require(_to != address(0));
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        return true;
    }

    function transferFrom(address _from, address _to, uint _amount) public returns (bool) {
        require(_to != address(0));
        require(balances[_from] >= _amount);
        require(allowances[_from][msg.sender] >= _amount);
        balances[_from] -= _amount;
        balances[_to] += _amount;
        allowances[_from][msg.sender] -= _amount;
        return true;
    }

    function approve(address _spender, uint _amount) public returns (bool) {
        allowances[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint) {
        return allowances[_owner][_spender];
    }
}
