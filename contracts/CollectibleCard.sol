// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract CollectibleCard is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    struct Card {
        uint256 id;
        string title;
        string description;
        string category;
        string subCategory;
        string identifierType;
        string identifierNumber;
        string gradingCompany;
        string grade;
    }

        Card[] public cards;


    constructor() ERC721("collectibleCard", "COC") {}

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        require(
            // Returns whether spender is allowed to manage tokenId.
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _setTokenURI(tokenId, _tokenURI);
    }

    function createCollectible(
        address to, 
        string memory myTokenURI,
        string memory title,
        string memory description,
        string memory category,
        string memory subCategory,
        string memory identifierType,
        string memory identifierNumber,
        string memory gradingCompany,
        string memory grade
        )
        public onlyOwner  
        returns (uint256
        )
    {

        _tokenIdCounter.increment();
        uint256 newItemId = _tokenIdCounter.current();

        cards.push(
            Card(
                newItemId,
                title,
                description,
                category,
                subCategory,
                identifierType,
                identifierNumber,
                gradingCompany,
                grade
            )
        );
            

            _safeMint(to,newItemId);
            setTokenURI(newItemId, myTokenURI);

        return newItemId;
    }

    function _baseURI() internal pure override returns (string memory)
    {
        return "https://example.com";
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

     function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
    

}