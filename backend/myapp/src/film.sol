// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";



contract Film is ERC721 {
    uint256 private _tokenIdCounter; // Token ID counter

    uint256 public ticketPrice = 0.00000007 ether; // Price of one ticket
    uint256 public venueLatitude;
    uint256 public venueLongitude;
    uint256 public tolerance = 100; // Example: tolerance of 100 meters

    event Used(bool);

    function useTicketWithLocation(uint256 userLatitude, uint256 userLongitude) public returns (bool) {
        if (isLocationValid(userLatitude, userLongitude)) {
            emit Used(true);
            return true; // Ticket used successfully
        } else {
            emit Used(false);
            revert("You are not at the event venue.");
        }
    }

    function isLocationValid(uint256 userLatitude, uint256 userLongitude) internal view returns (bool) {
        if (
            absDifference(userLatitude, venueLatitude) <= tolerance &&
            absDifference(userLongitude, venueLongitude) <= tolerance
        ) {
            return true;
        }
        return false;
    }

    function absDifference(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a >= b) {
            return a - b;
        } else {
            return b - a;
        }
    }

    mapping(address => string) public ipfsHash;
    event TicketPurchased(bool, uint256);

    constructor() ERC721("EventTicket", "TICKET") {}

    function buyTicket() public payable returns (uint256, bool) {
        require(msg.value == ticketPrice, "Incorrect ticket price");

        _tokenIdCounter++;
        uint256 newItemId = _tokenIdCounter;

        _safeMint(msg.sender, newItemId);

        emit TicketPurchased(false, newItemId);

        return (newItemId, false);
    }

    function updateTokenState(string memory newHash) public {
        ipfsHash[msg.sender] = newHash;
    }

    function setTicketPrice(uint256 _price) public {
        require(msg.sender == address(this), "Not authorized");
        ticketPrice = _price;
    }
}