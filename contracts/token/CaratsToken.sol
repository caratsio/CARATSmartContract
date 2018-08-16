pragma solidity 0.4.24;


import "./DetailedERC20.sol";
import "./BurnableToken.sol";
import "./MintableToken.sol";
import "../ownership/AccessControlClient.sol";


contract CaratToken is MintableToken, BurnableToken, DetailedERC20, AccessControlClient {


    string public constant SUPER_ADMIN = "superAdmin";

    string public constant LIMITED_ADMIN = "limitedAdmin";

    string public constant KYC_ROLE = "KycEnabled";


    //Token Spec
    string public constant NAME = "Carats Token";

    string public constant SYMBOL = "CARAT";

    uint8 public constant DECIMALS = 18;



    /**
      * @dev Throws if called by any account other than the minters(ACM) or if the minting period finished.
      */
    modifier canMint() {
        require(_isMinter(msg.sender));
        _;
    }


    /**
      * @dev Throws if minted to any account other than the KYC
      */
    modifier canReceive(address addr) {
        if(hasRole(addr, KYC_ROLE) || hasRole(addr, LIMITED_ADMIN) || hasRole(addr, SUPER_ADMIN)){
            _;
        }
    }


    constructor (AccessControlManager acm)
                 AccessControlClient(acm)
                 DetailedERC20(NAME, SYMBOL,DECIMALS) public
                 {}



    function _isMinter(address addr) internal view returns (bool) {
    return hasRole(addr, SUPER_ADMIN) || hasRole(addr, LIMITED_ADMIN);
    }
}