// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenContract {
    struct Token {
        string name;
        string symbol;
        uint256 totalSupply;
    }
    
    Token[] public tokens;
    mapping(string => mapping(address => uint256)) balances;
    
    function createToken(string memory _name, string memory _symbol, uint256 _totalSupply) public {
        Token memory newToken = Token(_name, _symbol, _totalSupply);
        tokens.push(newToken);
        balances[_symbol][msg.sender] = _totalSupply;
    }
    
    function transferToken(string memory _symbol, address _recipient, uint256 _amount) public {
        require(balances[_symbol][msg.sender] >= _amount, "Insufficient balance");
        balances[_symbol][msg.sender] -= _amount;
        balances[_symbol][_recipient] += _amount;
    }
    
    function getBalanceByToken(string memory _symbol, address _address) public view returns (uint256) {
        return balances[_symbol][_address];
    }
    
    function getTotalTokenCount() public view returns (uint256) {
        return tokens.length;
    }
}
