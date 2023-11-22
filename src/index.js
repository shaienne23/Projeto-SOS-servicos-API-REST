const { config } = require("dotenv");
config();

const express = require("express");
const rotas = require("./rotas");

const app = express();

app.use(express.json());

app.use(rotas);

const port = process.env.PORT || 3000;

app.listen(port, () => {
  console.log(`Ouvindo na porta " ${port}`);
});

