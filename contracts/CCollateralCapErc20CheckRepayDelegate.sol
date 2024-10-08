pragma solidity ^0.5.16;

import "./CCollateralCapErc20CheckRepay.sol";

/**
 * @title Zeno's CCollateralCapErc20CheckRepayDelegate Contract
 * @notice CTokens which wrap an EIP-20 underlying and are delegated to
 * @author Zeno
 */
contract CCollateralCapErc20CheckRepayDelegate is CCollateralCapErc20CheckRepay {
    /**
     * @notice Construct an empty delegate
     */
    constructor() public {}

    /**
     * @notice Called by the delegator on a delegate to initialize it for duty
     * @param data The encoded bytes data for any initialization
     */
    function _becomeImplementation(bytes memory data) public {
        // Shh -- currently unused
        data;

        // Shh -- we don't ever want this hook to be marked pure
        if (false) {
            implementation = address(0);
        }

        require(msg.sender == admin, "admin only");

        // Set internal cash when becoming implementation
        internalCash = getCashOnChain();

        // Set CToken version in comptroller
        ComptrollerInterfaceExtension(address(comptroller)).updateCTokenVersion(
            address(this),
            ComptrollerV1Storage.Version.COLLATERALCAP
        );
    }

    /**
     * @notice Called by the delegator on a delegate to forfeit its responsibility
     */
    function _resignImplementation() public {
        // Shh -- we don't ever want this hook to be marked pure
        if (false) {
            implementation = address(0);
        }

        require(msg.sender == admin, "admin only");
    }
}
