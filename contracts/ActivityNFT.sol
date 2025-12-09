// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ActivityNFT is ERC721URIStorage {
    mapping(address => uint256) public connectionCount;
    uint256 private _nextTokenId;
    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public constant MINT_PRICE = 0.005 ether;
    address public owner;

    constructor() ERC721("Web3 Ink", "W3INK") {
        owner = msg.sender;
    }

    function withdraw() external {
        require(msg.sender == owner, "Only owner");
        payable(owner).transfer(address(this).balance);
    }

    function checkIn() external {
        require(balanceOf(msg.sender) > 0, "Must own an NFT");
        connectionCount[msg.sender]++;
    }

    function mint() external payable {
        require(msg.value >= MINT_PRICE, "Insufficient mint fee");
        require(_nextTokenId < MAX_SUPPLY, "Max supply reached");
        uint256 tokenId = _nextTokenId++;
        _mint(msg.sender, tokenId);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        address ownerAddr = ownerOf(tokenId);
        uint256 count = connectionCount[ownerAddr];
        string memory svg = '<svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">';
        svg = string(abi.encodePacked(svg, '<rect width="500" height="500" fill="#ffffff"/>')); // Background
        if (count >= 1) {
            svg = string(abi.encodePacked(svg, '<circle cx="250" cy="250" r="5" fill="#000000"/>'));
        }
        if (count >= 5) {
            svg = string(
                abi.encodePacked(svg, '<line x1="100" y1="100" x2="400" y2="400" stroke="#000000" stroke-width="2"/>')
            );
        }
        if (count >= 10) {
            svg = string(
                abi.encodePacked(
                    svg,
                    '<path d="M250 50 Q350 150 250 250 Q150 150 250 50" stroke="#000000" fill="none" stroke-width="2"/>'
                )
            );
        }
        // Add more reveals as count increases
        if (count >= 50) {
            // Faint Colosseum outline
            svg = string(
                abi.encodePacked(
                    svg,
                    '<path d="M150 200 L350 200 L350 300 L150 300 Z M160 210 L160 290 M170 210 L170 290 M180 210 L180 290 M190 210 L190 290 M200 210 L200 290 M210 210 L210 290 M220 210 L220 290 M230 210 L230 290 M240 210 L240 290 M250 210 L250 290 M260 210 L260 290 M270 210 L270 290 M280 210 L280 290 M290 210 L290 290 M300 210 L300 290 M310 210 L310 290 M320 210 L320 290 M330 210 L330 290 M340 210 L340 290" stroke="#cccccc" stroke-width="1" fill="none"/>'
                )
            );
            svg = string(
                abi.encodePacked(
                    svg,
                    '<text x="250" y="350" text-anchor="middle" font-size="16" fill="#000000">VaultWars Awaits...</text>'
                )
            );
        }
        svg = string(abi.encodePacked(svg, "</svg>"));

        string memory json = string(
            abi.encodePacked(
                '{"name":"Web3 Ink #',
                toString(tokenId),
                '","description":"A dynamic NFT that evolves with your Web3 activity. Connect more to reveal cosmic secrets. Inspired by VaultWars.","image":"data:image/svg+xml;base64,',
                Base64.encode(bytes(svg)),
                '"}'
            )
        );
        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(bytes(json))));
    }

    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
