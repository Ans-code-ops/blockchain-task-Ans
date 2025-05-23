const fs = require("fs");
const path = require("path");

// Replace this with your real IPFS image CID
const imageBaseURI = "https://ipfs.io/ipfs/bafybeicc54v7v4bdeqowghoi5eqoep2crx4xdzrr5dyfif7zslqhfl5rbm";

const totalNFTs = 4; // number of images
const metadataDir = path.join(__dirname, "metadata");

// Create metadata folder if it doesn't exist
if (!fs.existsSync(metadataDir)) {
    fs.mkdirSync(metadataDir);
}

for (let i = 0; i < totalNFTs; i++) {
    const metadata = {
        name:`My NFT #${i}`,
        description: `This is NFT #${i}`,
        image: `${imageBaseURI}/${i}.jpg`
    };

    fs.writeFileSync(
        path.join(metadataDir, `${i}.json`),
        JSON.stringify(metadata, null, 2)
    );

    console.log(`Created metadata for NFT #${i}`);
}
