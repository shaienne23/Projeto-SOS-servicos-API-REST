CREATE DATABASE Sos_Servicos

CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  email VARCHAR(50) UNIQUE NOT NULL,
  senha VARCHAR(50) NOT NULL,
  cpf VARCHAR(11) UNIQUE NOT NULL
);

CREATE TABLE tokens (
  id SERIAL PRIMARY KEY,
  token VARCHAR(255) NOT NULL,
  usuario_id INTEGER REFERENCES usuarios(id)
);

CREATE TABLE carrinhos (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id)
);

CREATE TABLE servicos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  descricao TEXT,
  categoria VARCHAR(255),
  preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE itens_carrinho (
  id SERIAL PRIMARY KEY,
  carrinho_id INTEGER REFERENCES carrinhos(id),
  servico_id INTEGER REFERENCES servicos(id),
  quantidade INTEGER NOT NULL
);


CREATE TABLE pagamentos (
  id SERIAL PRIMARY KEY,
  servico_id INTEGER REFERENCES servicos(id),
  valor DECIMAL(10, 2) NOT NULL,
  status VARCHAR(255) DEFAULT 'pendente'
);

CREATE TABLE solicitacoes_orcamento (
   id SERIAL PRIMARY KEY,
   usuario_id INTEGER REFERENCES usuarios(id),
   descricao_servico TEXT,
   rg_documento_url VARCHAR(255), 
   cpf_documento_url VARCHAR(255), 
   status VARCHAR(50) DEFAULT 'PENDENTE',
   data_solicitacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE historico_emails (
    id SERIAL PRIMARY KEY,
    solicitacao_orcamento_id INTEGER REFERENCES solicitacoes_orcamento(id),
    destinatario_email VARCHAR(255) NOT NULL,
    assunto VARCHAR(255),
    corpo TEXT,
    tipo VARCHAR(20) CHECK (tipo IN ('ENVIADO', 'RECEBIDO')),
    data_envio_recebimento TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


