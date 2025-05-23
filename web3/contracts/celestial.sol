// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

/**
 * @title Celestial
 * @author RuinsOfRome devs
 * @dev Celestial is a contract to mint the celestial nfts
 */

contract Celestial is ERC721URIStorage {
    /* Custom Errors */
    error Celestial__OnlyOwner();

    uint256 private _nextTokenId;
    address public owner;

    constructor() ERC721("Celestial", "GOD") {
        _nextTokenId = 0;
        owner = msg.sender;
    }

    function mintNFT(address to, string memory tokenURI) public {
        uint256 tokenId = _nextTokenId;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _nextTokenId++;
    }

    function getNFTs(address addy) public view returns (string[] memory) {
        if (addy == address(0)) revert("Invalid address");

        string[] memory uris = new string[](_nextTokenId);
        uint256 tokenCount = 0;

        for (uint256 i = 0; i < _nextTokenId; i++) {
            if (ownerOf(i) == addy) {
                uris[tokenCount] = tokenURI(i);
                tokenCount++;
            }
        }

        // Create correctly sized array
        string[] memory result = new string[](tokenCount);
        for (uint256 i = 0; i < tokenCount; i++) {
            result[i] = uris[i];
        }

        return result;
    }
}
