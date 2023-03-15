const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors({
    origin: 'http://127.0.0.1:5500' // Remplacez cette URL par l'origine autorisée
  }));
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.post('/data', (req, res) => {
  console.log(req.body);
  res.send('Data received');
});

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});
