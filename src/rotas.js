const express = require("express");
const testeServidor = require("./controladores/usuario");
// implementar controladores
// implementar controladores intermediadores

const rotas = express();

rotas.get("/teste", testeServidor);

module.exports = rotas
