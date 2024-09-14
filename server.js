const express = require('express');
const path = require('path');
require('dotenv').config();
const app = express();
const port = 3000;

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));
app.use('/images', express.static(path.join(__dirname, 'images')));
// Route for the home page
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Route for the ticket page
app.get("/home", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'ticket.html'));
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
