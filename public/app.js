// Get the event parameter from the URL
const evet = getQueryParam("event");
const key = {
  "music-festival": 2,
  "film-festival": 0,
  "food-festival": 1,
  "tech-festival": 3,
};

console.log(evet);

ABIpool = [
[],
[],
[],
[]
];
const INFURA_PROJECT_ID = "";
const INFURA_URL = `https://sepolia.infura.io/v3/${INFURA_PROJECT_ID}`;
contractAddresspool = [
  "",
  "",
  "",
  "",
];
pricepool = ["", "", "", ""];

const ABI = ABIpool[key[evet]];
const contractAddress = contractAddresspool[key[evet]];

// Initialize MetaMask provider and contract
async function init() {
  if (window.ethereum) {
    try {
      // Initialize MetaMask provider
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      const infuraProvider = new ethers.providers.JsonRpcProvider(INFURA_URL);
      const contract = new ethers.Contract(
        contractAddress,
        ABI,
        infuraProvider
      );

      // Connect contract with signer
      contractWithSigner = contract.connect(signer);

      // Request account access if needed
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const account = await signer.getAddress();
      console.log(`Connected account: ${account}`);
      // window.history.pushState({}, '', '/getTicket');
      // Change page content dynamically
      document.getElementById("app").innerHTML = `
            <h1>Get Your NFT Ticket</h1>
            <div>Connected account: ${account}</div>
        <button id="buyTicketBtn" class="btn">
            <i class="fas fa-wallet"></i>Buy Ticket
        </button>
        <button id="showTicket" class="btn">
            <i class="fas fa-wallet"></i> Show Ticket
        </button>
            <a class="btn" href='/home'><i class="fas fa-wallet"></i> Go to DashBoard</a>
        <div>
            <ul id="ticketBoard"></ul>
        </div>
        
          `;
      document
        .getElementById("buyTicketBtn")
        .addEventListener("click", buyTicket);
      document
        .getElementById("showTicket")
        .addEventListener("click", showTicket);
    } catch (error) {
      console.error("Error initializing MetaMask or Infura:", error);
    }
  } else {
    console.error("MetaMask is not installed");
  }
}

async function showTicket() {
  if (!contractWithSigner) {
    console.error("Contract is not connected");
    return;
  }

  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const account = await signer.getAddress();

  const ipfs = await contractWithSigner.ipfsHash(account);
  console.log(`IPFS Hash: ${ipfs}`);

  if(ipfs=="") return;
  const url = `https://gateway.pinata.cloud/ipfs/${ipfs}`;
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error("Failed to fetch the message");
    }
    const data = await response.json();
    console.log(data);
    const ele = document.getElementById("ticketBoard");
    const listItem = document.createElement("li");
    listItem.innerHTML = `
      <img src="${data.Image}" alt="Ticket Image" class="ticket-image">
      <div class="ticket-details">
          <div class="ticket-id">Ticket #${data.Id}</div>
            <div class="ticket-status ${data.Status? 'used' : 'not-used'}">
                ${data.Status? 'Used' : 'Not Used'}
            </div>
      <button id="useNowBtn" class="btn" ${data.Status? "disabled" : ""}>
          <i class="fas fa-wallet"></i> Use Now! 
      </button>
      </div>

  `;
    ticketBoard.appendChild(listItem);
    document.getElementById("useNowBtn").addEventListener("click",UseNow);
  } catch (error) {
    console.error("Error fetching the ticket from IPFS:", error);
  }
}

async function UseNow(){
    console.log("cclicked")
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(async function(position) {
          const userLat = position.coords.latitude;
          const userLon = position.coords.longitude;
      
          console.log(`User Location: Latitude - ${userLat}, Longitude - ${userLon}`);
          if (!contractWithSigner) {
            console.error("Contract is not connected");
            return;
          }

          const tx = await contractWithSigner.useTicketWithLocation(0,0)
      
          const receipt = await tx.wait();
          console.log("here")
        

          const ticketPurchasedEvent = receipt.events.find(
            (event) => event.event === "Used"
          );

          if (ticketPurchasedEvent) {
            res = ticketPurchasedEvent.args[0].toString();
            if(!res) return;
          } else {
            console.error("TicketPurchased event not found");
            return;
          }


          const provider = new ethers.providers.Web3Provider(window.ethereum);
          const signer = provider.getSigner();
          const account = await signer.getAddress();


        
          const ipfs = await contractWithSigner.ipfsHash(account);
          console.log(`IPFS Hash: ${ipfs}`);
        
          if(ipfs=="") return;
          const url = `https://gateway.pinata.cloud/ipfs/${ipfs}`;
          try {
            const responsed = await fetch(url);
            if (!responsed.ok) {
              throw new Error("Failed to fetch the message");
            }
            let data = await responsed.json();
            data.Status = true;


            const response = await axios.post(
                "https://api.pinata.cloud/pinning/pinJSONToIPFS",
                data,
                {
                  headers: {
                    "Content-Type": "application/json",
                    pinata_api_key: "",
                    pinata_secret_api_key:
                      "",
                  },
                }
              );
              console.log("Tokens data uploaded to IPFS:", response.data);
          
              const tx = await contractWithSigner.updateTokenState(
                response.data.IpfsHash
              );
              await tx.wait();
              console.log(
                `Ticket updated successfully! and the id of token is ${tx.data}`
              );
        }catch(error){
            console.error("Error fetching the ticket from IPFS:", error);
        }
        });
      } else {
        console.log("Geolocation is not supported by this browser.");
      }
}

async function saveToIpfs(tokenId, tokenStatus) {
  const tokenImage = [
    "/images/film.jpg",
    "/images/food.jpg",
    "/images/music.jpg",
    "/images/tech.jpg",
  ];

  const data = {
    Id: tokenId,
    Status: tokenStatus,
    Image: tokenImage[key[evet]],
  };

  try {
    const response = await axios.post(
      "https://api.pinata.cloud/pinning/pinJSONToIPFS",
      data,
      {
        headers: {
          "Content-Type": "application/json",
          pinata_api_key: "",
          pinata_secret_api_key:
            "",
        },
      }
    );
    console.log("Tokens data uploaded to IPFS:", response.data);

    const tx = await contractWithSigner.updateTokenState(
      response.data.IpfsHash
    );
    await tx.wait();
    console.log(
      `Ticket updated successfully! and the id of token is ${tx.data}`
    );
  } catch (error) {
    console.error("Error uploading message to Pinata:", error);
  }
}

async function buyTicket() {
  // console.log("clicked")
  if (!contractWithSigner) {
    console.error("Contract is not connected");
    return;
  }
  const ticketPrice = ethers.utils.parseEther(pricepool[key[evet]]); // Convert 0.01 Ether to Wei

  try {
    const tx = await contractWithSigner.buyTicket({
      value: ticketPrice,
    });

    const receipt = await tx.wait();
    // Find the TicketPurchased event
    const ticketPurchasedEvent = receipt.events.find(
      (event) => event.event === "TicketPurchased"
    );
    let tokenId;
    let status;
    if (ticketPurchasedEvent) {
      tokenId = ticketPurchasedEvent.args[1].toString(); // Extract the tokenId from the event args
      status=true;
      if(ticketPurchasedEvent.args[0].toString()=='false') status = false;
      console.log(
        `Ticket purchased successfully! The ID of the token is ${tokenId}`
      );
    } else {
      console.error("TicketPurchased event not found");
    }
    saveToIpfs(tokenId, status);
  } catch (error) {
    console.error("Error Buying Ticket:", error);
  }
}

async function getTicket() {
  const tx = await contractWithSigner.getIpfsHash();
  await tx.wait();
  console.log(tx.data);
}

document.getElementById("loginButton").addEventListener("click", init);

function getQueryParam(param) {
  const urlParams = new URLSearchParams(window.location.search);
  return urlParams.get(param);
}
