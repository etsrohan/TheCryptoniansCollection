// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

abstract contract AccessProtected is
    Context,
    Ownable
{
    // -----------------------------------VARIABLES-----------------------------------
    mapping(address => bool) internal _admins;

    // ------------------------------------EVENTS-------------------------------------
    event NewAdminSet(address _admin, bool _enabled);

    // -----------------------------------MODIFIERS-----------------------------------
    modifier onlyAdmin() {
        require(
            _admins[_msgSender()] || _msgSender() == owner(),
            "Caller does not have Admin Access"
        );
        _;
    }

    // -----------------------------------FUNCTIONS-----------------------------------
    function setAdmin(
        address admin,
        bool enabled
    )
        external
        onlyOwner
    {
        _admins[admin] = enabled;
        emit NewAdminSet(admin, enabled);
    }

    function isAdmin(
        address admin
    )
        public
        view
        returns (bool)
    {
        return _admins[admin];
    }
}