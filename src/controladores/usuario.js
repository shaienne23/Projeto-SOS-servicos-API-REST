const { config } = require("dotenv");
config();

const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const knex = require("../conexao");

async function testeServidor(req, res) {
    try {
      console.log("Tudo certo na porta 3000");
      res.status(200).json({ message: "Tudo certo na porta 3000" });
    } catch (err) {
      return res.status(500).json({ message: err.message });
    }
}

module.exports = testeServidor;
