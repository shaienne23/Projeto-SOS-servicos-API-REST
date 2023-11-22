const { config } = require("dotenv");
config();

const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const knex = require("../conexao");

const testeServidor= async(req, res) => {
  
    try {
      console.log("Tudo certo na porta 3000");

      res.status(200).json({ message: "Tudo certo na porta 3000" });

    } catch (error) {
      return res.status(500).json({ message: error.message });
    }
}



module.exports = testeServidor;
