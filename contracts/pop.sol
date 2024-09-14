// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

// contract Music is ERC721 {
//     using Counters for Counters.Counter;
//     Counters.Counter private _tokenIds; // Token ID counter

//     uint256 public ticketPrice = 0.00000005 ether; // Price of one ticket
//     uint256 public venueLatitude;
//     uint256 public venueLongitude;
//     uint256 public tolerance = 100; // Example: tolerance of 100 meters

//     event Used(bool);

//     // Function to use a ticket and validate user ID
//     function useTicketWithLocation(uint256 userLatitude, uint256 userLongitude) public returns (bool) {
//         // Validate user location with the venue location
//         if (isLocationValid(userLatitude, userLongitude)) {
//             emit Used(true);
//             return true; // Ticket used successfully
//         } else {
//             emit Used(false);
//             revert("You are not at the event venue.");
//         }
//     }

//     // Internal function to compare user and venue location using absolute difference
//     function isLocationValid(uint256 userLatitude, uint256 userLongitude) internal view returns (bool) {
//         // Compare the absolute difference between user and venue latitudes/longitudes
//         if (
//             absDifference(userLatitude, venueLatitude) <= tolerance &&
//             absDifference(userLongitude, venueLongitude) <= tolerance
//         ) {
//             return true;
//         }
//         return false;
//     }

//     // Helper function to calculate the absolute difference between two uint256 values
//     function absDifference(uint256 a, uint256 b) internal pure returns (uint256) {
//         if (a >= b) {
//             return a - b;
//         } else {
//             return b - a;
//         }
//     }

//     // Mapping to track if a ticket has been used
//     mapping(address => string) public ipfsHash;
//     event TicketPurchased(bool, uint256);


//     constructor() ERC721("EventTicket", "TICKET") {}


//     // Function to buy a ticket and mint NFT
//     function buyTicket() public payable returns (uint256, bool) {
//         require(msg.value == ticketPrice, "Incorrect ticket price");

//         // Increment tokenId for each new ticket
//         _tokenIds.increment();
//         uint256 newItemId = _tokenIds.current();

//         // Mint the ticket NFT and assign ownership to the buyer
//         _safeMint(msg.sender, newItemId);

//         // Emit event
//         emit TicketPurchased(false, newItemId);

//         return (newItemId, false);
//     }

//     function updateTokenState(string memory newHash) public {
//         // Update the IPFS hash for the sender's address
//         ipfsHash[msg.sender] = newHash;
//     }

//     // Set ticket price (only callable by contract owner in this version)
//     function setTicketPrice(uint256 _price) public {
//         require(msg.sender == address(this), "Not authorized");
//         ticketPrice = _price;
//     }
// }

// contract Food is ERC721 {
//     using Counters for Counters.Counter;
//     Counters.Counter private _tokenIds; // Token ID counter

//     uint256 public ticketPrice = 0.00000006 ether; // Price of one ticket
//     uint256 public venueLatitude;
//     uint256 public venueLongitude;
//     uint256 public tolerance = 100; // Example: tolerance of 100 meters

//     event Used(bool);

//     // Function to use a ticket and validate user ID
//     function useTicketWithLocation(uint256 userLatitude, uint256 userLongitude) public returns (bool) {
//         // Validate user location with the venue location
//         if (isLocationValid(userLatitude, userLongitude)) {
//             emit Used(true);
//             return true; // Ticket used successfully
//         } else {
//             emit Used(false);
//             revert("You are not at the event venue.");
//         }
//     }

//     // Internal function to compare user and venue location using absolute difference
//     function isLocationValid(uint256 userLatitude, uint256 userLongitude) internal view returns (bool) {
//         // Compare the absolute difference between user and venue latitudes/longitudes
//         if (
//             absDifference(userLatitude, venueLatitude) <= tolerance &&
//             absDifference(userLongitude, venueLongitude) <= tolerance
//         ) {
//             return true;
//         }
//         return false;
//     }

//     // Helper function to calculate the absolute difference between two uint256 values
//     function absDifference(uint256 a, uint256 b) internal pure returns (uint256) {
//         if (a >= b) {
//             return a - b;
//         } else {
//             return b - a;
//         }
//     }

//     // Mapping to track if a ticket has been used
//     mapping(address => string) public ipfsHash;
//     event TicketPurchased(bool, uint256);


//     constructor() ERC721("EventTicket", "TICKET") {}


//     // Function to buy a ticket and mint NFT
//     function buyTicket() public payable returns (uint256, bool) {
//         require(msg.value == ticketPrice, "Incorrect ticket price");

//         // Increment tokenId for each new ticket
//         _tokenIds.increment();
//         uint256 newItemId = _tokenIds.current();

//         // Mint the ticket NFT and assign ownership to the buyer
//         _safeMint(msg.sender, newItemId);

//         // Emit event
//         emit TicketPurchased(false, newItemId);

//         return (newItemId, false);
//     }

//     function updateTokenState(string memory newHash) public {
//         // Update the IPFS hash for the sender's address
//         ipfsHash[msg.sender] = newHash;
//     }

//     // Set ticket price (only callable by contract owner in this version)
//     function setTicketPrice(uint256 _price) public {
//         require(msg.sender == address(this), "Not authorized");
//         ticketPrice = _price;
//     }
// }


// contract Film is ERC721 {
//     using Counters for Counters.Counter;
//     Counters.Counter private _tokenIds; // Token ID counter

//     uint256 public ticketPrice = 0.00000007 ether; // Price of one ticket
//     uint256 public venueLatitude;
//     uint256 public venueLongitude;
//     uint256 public tolerance = 100; // Example: tolerance of 100 meters

//     event Used(bool);

//     // Function to use a ticket and validate user ID
//     function useTicketWithLocation(uint256 userLatitude, uint256 userLongitude) public returns (bool) {
//         // Validate user location with the venue location
//         if (isLocationValid(userLatitude, userLongitude)) {
//             emit Used(true);
//             return true; // Ticket used successfully
//         } else {
//             emit Used(false);
//             revert("You are not at the event venue.");
//         }
//     }

//     // Internal function to compare user and venue location using absolute difference
//     function isLocationValid(uint256 userLatitude, uint256 userLongitude) internal view returns (bool) {
//         // Compare the absolute difference between user and venue latitudes/longitudes
//         if (
//             absDifference(userLatitude, venueLatitude) <= tolerance &&
//             absDifference(userLongitude, venueLongitude) <= tolerance
//         ) {
//             return true;
//         }
//         return false;
//     }

//     // Helper function to calculate the absolute difference between two uint256 values
//     function absDifference(uint256 a, uint256 b) internal pure returns (uint256) {
//         if (a >= b) {
//             return a - b;
//         } else {
//             return b - a;
//         }
//     }

//     // Mapping to track if a ticket has been used
//     mapping(address => string) public ipfsHash;
//     event TicketPurchased(bool, uint256);


//     constructor() ERC721("EventTicket", "TICKET") {}


//     // Function to buy a ticket and mint NFT
//     function buyTicket() public payable returns (uint256, bool) {
//         require(msg.value == ticketPrice, "Incorrect ticket price");

//         // Increment tokenId for each new ticket
//         _tokenIds.increment();
//         uint256 newItemId = _tokenIds.current();

//         // Mint the ticket NFT and assign ownership to the buyer
//         _safeMint(msg.sender, newItemId);

//         // Emit event
//         emit TicketPurchased(false, newItemId);

//         return (newItemId, false);
//     }

//     function updateTokenState(string memory newHash) public {
//         // Update the IPFS hash for the sender's address
//         ipfsHash[msg.sender] = newHash;
//     }

//     // Set ticket price (only callable by contract owner in this version)
//     function setTicketPrice(uint256 _price) public {
//         require(msg.sender == address(this), "Not authorized");
//         ticketPrice = _price;
//     }
// }


// contract Tech is ERC721 {
//     using Counters for Counters.Counter;
//     Counters.Counter private _tokenIds; // Token ID counter

//     uint256 public ticketPrice = 0.00000008 ether; // Price of one ticket
//     uint256 public venueLatitude;
//     uint256 public venueLongitude;
//     uint256 public tolerance = 100; // Example: tolerance of 100 meters

//     event Used(bool);

//     // Function to use a ticket and validate user ID
//     function useTicketWithLocation(uint256 userLatitude, uint256 userLongitude) public returns (bool) {
//         // Validate user location with the venue location
//         if (isLocationValid(userLatitude, userLongitude)) {
//             emit Used(true);
//             return true; // Ticket used successfully
//         } else {
//             emit Used(false);
//             revert("You are not at the event venue.");
//         }
//     }

//     // Internal function to compare user and venue location using absolute difference
//     function isLocationValid(uint256 userLatitude, uint256 userLongitude) internal view returns (bool) {
//         // Compare the absolute difference between user and venue latitudes/longitudes
//         if (
//             absDifference(userLatitude, venueLatitude) <= tolerance &&
//             absDifference(userLongitude, venueLongitude) <= tolerance
//         ) {
//             return true;
//         }
//         return false;
//     }

//     // Helper function to calculate the absolute difference between two uint256 values
//     function absDifference(uint256 a, uint256 b) internal pure returns (uint256) {
//         if (a >= b) {
//             return a - b;
//         } else {
//             return b - a;
//         }
//     }

//     // Mapping to track if a ticket has been used
//     mapping(address => string) public ipfsHash;
//     event TicketPurchased(bool, uint256);


//     constructor() ERC721("EventTicket", "TICKET") {}


//     // Function to buy a ticket and mint NFT
//     function buyTicket() public payable returns (uint256, bool) {
//         require(msg.value == ticketPrice, "Incorrect ticket price");

//         // Increment tokenId for each new ticket
//         _tokenIds.increment();
//         uint256 newItemId = _tokenIds.current();

//         // Mint the ticket NFT and assign ownership to the buyer
//         _safeMint(msg.sender, newItemId);

//         // Emit event
//         emit TicketPurchased(false, newItemId);
//         return (newItemId, false);
//     }

//     function updateTokenState(string memory newHash) public {
//         // Update the IPFS hash for the sender's address
//         ipfsHash[msg.sender] = newHash;
//     }

//     // Set ticket price (only callable by contract owner in this version)
//     function setTicketPrice(uint256 _price) public {
//         require(msg.sender == address(this), "Not authorized");
//         ticketPrice = _price;
//     }



// }

