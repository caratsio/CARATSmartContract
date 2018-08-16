pragma solidity ^0.4.24;

import "./StandardToken.sol";
import "../ownership/Ownable.sol";


contract MintableToken is StandardToken {
  event Mint(address indexed to, uint256 amount);
  event MintFinished();


  modifier canMint() {
    _;
  }

  modifier canReceive(address addr) {
    _;
  }

  /**
   * @dev Function to mint tokens
   * @param _to The address that will receive the minted tokens.
   * @param _amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address _to, uint256 _amount) canMint canReceive(_to) public returns (bool) {
    totalSupply_ = totalSupply_.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    emit Mint(_to, _amount);
    emit Transfer(address(0), _to, _amount);
    return true;
  }


}
