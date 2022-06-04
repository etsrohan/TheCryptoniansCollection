// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "../utils/AccessProtected.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract TheCryptoniansCollection is 
    ERC721("The Cryptonians Collection", "TCC"),
    AccessProtected
{
    using Counters for Counters.Counter;
    using Strings for uint256;

    event TokenMinted(uint256 tokenId, address recepient, string uri);
    event ChangedURI(uint256 tokenId, string uri);

    mapping(uint256 => string) private _tokenURIs;
    string private _baseURIExtended;

    Counters.Counter internal numTokens;

    function setBaseURI(string memory baseURI_) external onlyOwner() {
        _baseURIExtended = baseURI_;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIExtended;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();
        
        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }
        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(base, tokenId.toString()));
    }

    function mint(
        address recepient,
        string memory uri
    )
        onlyAdmin
        external
    {
        numTokens.increment();
        uint256 tokenId = numTokens.current();
        _mint(recepient, tokenId);
        _setTokenURI(tokenId, uri);
        emit TokenMinted(tokenId, recepient, uri);
    }

    function setTokenURI(
        uint256 tokenId,
        string memory uri
    )
        external
        onlyAdmin
    {
        _setTokenURI(tokenId, uri);
        emit ChangedURI(tokenId, uri);
    }

}