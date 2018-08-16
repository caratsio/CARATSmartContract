pragma solidity ^0.4.21;


import "./AccessControl.sol";


contract AccessControlManager is AccessControl {

    string public constant SUPER_ADMIN = "superAdmin";
    string public constant LIMITED_ADMIN = "limitedAdmin";

    /**
     * @dev modifier to scope access to admins
     * // reverts
     */
    modifier onlyAdmin()
    {
        checkRole(msg.sender, SUPER_ADMIN);
        _;
    }

    /**
     * @dev modifier to check adding/removing roles
     *
     */
    modifier canUpdateRole(string role){
        if ((keccak256(abi.encodePacked(role)) != keccak256(abi.encodePacked(SUPER_ADMIN)) && (hasRole(msg.sender, SUPER_ADMIN) || hasRole(msg.sender, LIMITED_ADMIN))))
        _;
    }

    /**
     * @dev constructor. Sets msg.sender as admin by default
     */
    constructor()
    public
    {
        addRole(msg.sender, SUPER_ADMIN);
    }

    /**
     * @dev add admin role to an address
     * @param addr address
     */
    function addAdmin(address addr)
    onlyAdmin
    public
    {
        addRole(addr, SUPER_ADMIN);
    }

    /**
     * @dev remove a role from an address
     * @param addr address
     */
    function removeAdmin(address addr)
    onlyAdmin
    public
    {
        require(msg.sender != addr);
        removeRole(addr, SUPER_ADMIN);
    }

    /**
     * @dev add a role to an address
     * @param addr address
     * @param roleName the name of the role
     */
    function adminAddRole(address addr, string roleName)
    canUpdateRole(roleName)
    public
    {
        addRole(addr, roleName);
    }


    /**
     * @dev remove a role from an address
     * @param addr address
     * @param roleName the name of the role
     */
    function adminRemoveRole(address addr, string roleName)
    canUpdateRole(roleName)
    public
    {
        removeRole(addr, roleName);
    }


    /**
     * @dev add a role to an addresses array
     * solidity dosen't supports dynamic arrays as arguments so only one role at time.
     * @param addrs addresses
     * @param roleName the name of the role
     */
    function adminAddRoles(address[] addrs, string roleName)
    public
    {
        for (uint256 i = 0; i < addrs.length; i++) {
            adminAddRole(addrs[i],roleName);
        }
    }


    /**
     * @dev remove a specific role from an addresses array
     * solidity dosen't supports dynamic arrays as arguments so only one role at time.
     * @param addrs addresses
     * @param roleName the name of the role
     */
    function adminRemoveRoles(address[] addrs, string roleName)
    public
    {
        for (uint256 i = 0; i < addrs.length; i++) {
            adminRemoveRole(addrs[i],roleName);
        }
    }


}
