# Projeto-SOS-servicos-API-REST

## API Criada para back de projeto front posterior

## Banco de dados

Você precisa criar um Banco de Dados PostgreSQL chamado Sos_Servicos contendo as seguintes tabelas e colunas:

Usuários:
id (chave primária)
nome (string, obrigatório)
email (string, único, obrigatório)
senha (string, obrigatório - deve ser armazenado o hash da senha)
cpf (string, único, obrigatório)

Tokens:
id (chave primária)
token (string, obrigatório)
usuario_id (chave estrangeira referenciando a tabela usuarios)

Carrinhos:
id (chave primária)
usuario_id (chave estrangeira referenciando a tabela usuarios)

ItensCarrinho:
id (chave primária)
carrinho_id (chave estrangeira referenciando a tabela carrinhos)
servico_id (chave estrangeira referenciando a tabela servicos)
quantidade (inteiro, obrigatório)

Serviços:
id (chave primária)
nome (string, obrigatório)
descricao (string)
categoria (string)
preco (decimal, obrigatório)

Pagamentos:
id (chave primária)
servico_id (chave estrangeira referenciando a tabela servicos)
valor (decimal, obrigatório)
status (string - por exemplo, "pendente", "concluído")

Tabela orcamentos:
Armazenará informações sobre os orçamentos solicitados.

Tabela orcamento_itens:
Se um orçamento puder incluir vários itens, você pode criar uma tabela separada para armazenar esses itens.

Tabela emails_enviados:
Armazenará registros de emails enviados para que você possa rastrear quais emails foram enviados para quais clientes.

# Rotas Usuarios

## POST - Cadastro

**POST /usuario/cadastrar**
Essa é a rota que será utilizada para cadastrar um novo usuario no sistema.

Requisição
Sem parâmetros de rota ou de query.
O corpo (body) deverá possuir um objeto com as seguintes propriedades (respeitando estes nomes):

nome: Necessario validaçao string e obrigatorio
emailNecessario validaçao email e obrigatorio
senha:Limitar senha a 8 digitos e obrigatorio
cpf: limitar 11 digitos e obrigatorio

Resposta
Em caso de sucesso, deveremos enviar no corpo (body) da resposta o conteúdo do usuário cadastrado, incluindo seu respectivo id e excluindo a senha criptografada. Em caso de falha na validação, a resposta deverá possuir status code apropriado, e em seu corpo (body) deverá possuir um objeto com uma propriedade mensagem que deverá possuir como valor um texto explicando o motivo da falha.

REQUISITOS OBRIGATÓRIOS

Validar os campos obrigatórios:
nome
email
senha
cpf
Validar se o e-mail informado já existe
Criptografar a senha antes de persistir no banco de dados
Cadastrar o usuário no banco de dados

Exemplo de requisição
// POST /usuario
{
"nome": "José",
"email": "jose@email.com",
"senha": "123456"
"cpf": "101.877.296-03"
}
Exemplos de resposta
// HTTP Status 200 / 201 / 204
{
"id": 1,
"nome": "José",
"email": "jose@email.com"
}
// HTTP Status 400 / 401 / 403 / 404
{
"mensagem": "Já existe usuário cadastrado com o e-mail informado."
}

## POST - Login

**POST /login**
Essa é a rota que permite o usuario cadastrado realizar o login no sistema.

Requisição
Sem parâmetros de rota ou de query.
O corpo (body) deverá possuir um objeto com as seguintes propriedades (respeitando estes nomes):

email
senha

Resposta
Em caso de sucesso, o corpo (body) da resposta deverá possuir um objeto com a propriedade token que deverá possuir como valor o token de autenticação gerado e uma propriedade usuario que deverá possuir as informações do usuário autenticado, exceto a senha do usuário.
Em caso de falha na validação, a resposta deverá possuir status code apropriado, e em seu corpo (body) deverá possuir um objeto com uma propriedade mensagem que deverá possuir como valor um texto explicando o motivo da falha.

REQUISITOS OBRIGATÓRIOS

Validar os campos obrigatórios:
email: Verificar se o e-mail existe no BD
senha: Validar senha e tamanho da senha

Criar token de autenticação com id do usuário
Exemplo de requisição
// POST /login
{
"email": "jose@email.com",
"senha": "123456"
}
Exemplos de resposta
// HTTP Status 200 / 201 / 204
{
"usuario": {
"id": 1,
"nome": "José",
"email": "jose@email.com"
},
"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjIzMjQ5NjIxLCJleHAiOjE2MjMyNzg0MjF9.KLR9t7m_JQJfpuRv9_8H2-XJ92TSjKhGPxJXVfX6wBI"
}
// HTTP Status 400 / 401 / 403 / 404
{
"mensagem": "Usuário e/ou senha inválido(s)."
}

### Todas as funcionalidades (endpoints) a seguir, a partir desse ponto, deverão exigir o token de autenticação do usuário logado, recebendo no header com o formato Bearer Token. Portanto, em cada funcionalidade será necessário validar o token informado.

Validações do token
REQUISITOS OBRIGATÓRIOS
Validar se o token foi enviado no header da requisição (Bearer Token)
Verificar se o token é válido
Consultar usuário no banco de dados pelo id contido no token informado.

## Detalhar usuário

**GET /usuario/detalhar**
Essa é a rota que será chamada quando o usuario quiser obter os dados do seu próprio perfil.
Atenção!: O usuário deverá ser identificado através do ID presente no token de autenticação.

Requisição
Sem parâmetros de rota ou de query.
Não deverá possuir conteúdo no corpo da requisição.

Resposta
Em caso de sucesso, o corpo (body) da resposta deverá possuir um objeto que representa o usuário encontrado, com todas as suas propriedades (exceto a senha), conforme exemplo abaixo, acompanhado de status code apropriado.
Em caso de falha na validação, a resposta deverá possuir status code apropriado, e em seu corpo (body) deverá possuir um objeto com uma propriedade mensagem que deverá possuir como valor um texto explicando o motivo da falha.
Dica: neste endpoint podemos fazer uso do status code 401 (Unauthorized).

Exemplo de requisição
// GET /usuario
// Sem conteúdo no corpo (body) da requisição
Exemplos de resposta
// HTTP Status 200 / 201 / 204
{
"id": 1,
"nome": "José",
"email": "jose@email.com"
}
// HTTP Status 400 / 401 / 403 / 404
{
"mensagem": "Para acessar este recurso um token de autenticação válido deve ser enviado."
}

## Atualizar usuário

**PUT /usuario/atualizar**
Essa é a rota que será chamada quando o usuário quiser realizar alterações no seu próprio usuário.
Atenção!: O usuário deverá ser identificado através do ID presente no token de autenticação.

Requisição
Sem parâmetros de rota ou de query.
O corpo (body) deverá possuir um objeto com as seguintes propriedades (respeitando estes nomes):

**nome
email
senha**

Resposta
Em caso de sucesso, não deveremos enviar conteúdo no corpo (body) da resposta.
Em caso de falha na validação, a resposta deverá possuir status code apropriado, e em seu corpo (body) deverá possuir um objeto com uma propriedade mensagem que deverá possuir como valor um texto explicando o motivo da falha.

REQUISITOS OBRIGATÓRIOS

**Validar os campos obrigatórios:
nome
email
senha**
Validar se o novo e-mail já existe no banco de dados para outro usuário; Caso já exista o novo e-mail fornecido para outro usuário no banco de dados, a alteração não deve ser permitida (o campo de email deve ser sempre único no banco de dados)
Criptografar a senha antes de salvar no banco de dados Atualizar as informações do usuário no banco de dados
Exemplo de requisição

// PUT /usuario
{
"nome": "José de Abreu",
"email": "jose_abreu@email.com",
"senha": "j4321"
}
Exemplos de resposta
// HTTP Status 200 / 201 / 204
// Sem conteúdo no corpo (body) da resposta
// HTTP Status 400 / 401 / 403 / 404
{
"mensagem": "O e-mail informado já está sendo utilizado por outro usuário."
}

## DELETE - Deletar

**DELETE /usuario/deletar**

Essa é a rota que será chamada quando o usuario logado quiser excluir o seu cadastro de usuario.
Lembre-se: Deverá ser possível excluir apenas o usuário logado, que deverá ser identificado através do ID presente no token de validação.

Requisição
Deverá ser enviado o ID do usuario no parâmetro de rota do endpoint.
O corpo (body) da requisição não deverá possuir nenhum conteúdo.

Resposta
Em caso de sucesso, não deveremos enviar conteúdo no corpo (body) da resposta.
Em caso de falha na validação, a resposta deverá possuir status code apropriado, e em seu corpo (body) deverá possuir um objeto com uma propriedade mensagem que deverá possuir como valor um texto explicando o motivo da falha.

REQUISITOS OBRIGATÓRIOS:

Validar se existe transação para o id enviado como parâmetro na rota e se esta transação pertence ao usuário logado.
Excluir a transação no banco de dados.
Exemplo de requisição
// DELETE /transacao/2
// Sem conteúdo no corpo (body) da requisição

# Rotas Serviços

## Listar Serviços

Rota: Listar Serviços
Método HTTP: GET
Endpoint: /servicos
Descrição: Retorna uma lista de serviços disponíveis.
Parâmetros da Query String:
Opcional: categoria para filtrar por categoria de serviço.
Resposta:
Retorna uma lista de serviços com detalhes.

## Cadastrar Serviços

Rota: Cadastrar Serviços
Método HTTP: POST
Endpoint: /servicos
Descrição: Cadastra um novo serviço.
Parâmetros do Corpo:
nome: Nome do serviço.
descricao: Descrição do serviço.
categoria: Categoria do serviço.
preco: Preço do serviço.
Resposta:
Retorna os detalhes do serviço cadastrado.

## Editar Serviços

Rota: Editar Serviços
Método HTTP: PUT
Endpoint: /servicos/:id
Descrição: Atualiza informações de um serviço existente.
Parâmetros da URL:
id: ID do serviço.
Parâmetros do Corpo:
Opcionais: nome, descricao, categoria, preco para atualizar as informações.
Resposta:
Retorna os detalhes atualizados do serviço.

## Remover Serviços

Rota: Remover Serviços
Método HTTP: DELETE
Endpoint: /servicos/:id
Descrição: Remove um serviço existente.
Parâmetros da URL:
id: ID do serviço.
Resposta:
Retorna uma mensagem indicando o sucesso da remoção.

## Fazer Orçamentos de serviços com retorno por email

# Rotas Carrinho de compras

**POST /carrinho**
Requisição:
• Sem parâmetros de rota ou de query.
• O corpo (body) da requisição pode ser vazio, dependendo dos requisitos específicos do seu projeto.

Resposta em Caso de Sucesso:
• Status code 200 / 201 / 204.
• O corpo da resposta deve conter um identificador único para o carrinho que será usado em operações subsequentes.

**POST /carrinho/:carrinhoId/item**

Requisição:
• Parâmetros de rota: carrinhoId - Identificador único do carrinho.
• O corpo (body) da requisição deve conter informações sobre o item a ser adicionado, como servicoId, quantidade, e outros detalhes específicos.

Validações:
• Validar se o carrinho com o ID fornecido existe.
• Validar os dados do item a ser adicionado.

Resposta em Caso de Sucesso:
• Status code 200 / 201 / 204.
• O corpo da resposta pode conter informações relevantes sobre o item adicionado ao carrinho.

**GET /carrinho/:carrinhoId**
Requisição:

Parâmetros de rota: carrinhoId - Identificador único do carrinho.
Validações:

Validar se o carrinho com o ID fornecido existe.
Resposta em Caso de Sucesso:

Status code 200.
O corpo da resposta deve conter uma lista de itens no carrinho, incluindo detalhes como servicoId, quantidade, preço, etc.

# Rotas Transações

## Fazer pagamentos

Rota: Fazer Pagamentos
Método HTTP: POST
Endpoint: /pagamentos/iniciar
Descrição: Inicia um novo processo de pagamento para um serviço.
Parâmetros do Corpo:
servicoId: ID do serviço para o qual o pagamento está sendo iniciado.
valor: O valor do pagamento.
Resposta:
Retorna informações necessárias para o cliente continuar o processo de pagamento, como uma URL de redirecionamento para a página de pagamento do provedor (por exemplo, Stripe).

## Listar transações

Rota: Listar Transações
Método HTTP: GET
Endpoint: /pagamentos/transacoes
Descrição: Retorna uma lista de transações de pagamento.
Parâmetros da Query String:
Opcional: filtro para filtrar transações com base em determinados critérios (por exemplo, status, data, etc.).
Resposta:
Retorna uma lista de transações de pagamento.

## Detalhar transação

Rota: Detalhar Transação
Método HTTP: GET
Endpoint: /pagamentos/transacoes/:id
Descrição: Obtém detalhes de uma transação específica.
Parâmetros da URL:
id: ID da transação.
Resposta:
Retorna detalhes específicos da transação.

## Obter extrato de transações\*\*

Rota: Obter Extrato de Transações
Método HTTP: GET
Endpoint: /pagamentos/extrato
Descrição: Retorna o extrato de transações, fornecendo um resumo das atividades financeiras.
Parâmetros da Query String:
Opcional: periodo para especificar o período do extrato (por exemplo, mês atual, últimos 3 meses, etc.).
Resposta:
Retorna um extrato de transações com informações resumidas.

## Status Codes

Abaixo, listamos os possíveis status codes esperados como resposta da API.

// 200 (OK) = requisição bem sucedida
// 201 (Created) = requisição bem sucedida e algo foi criado
// 204 (No Content) = requisição bem sucedida, sem conteúdo no corpo da resposta
// 400 (Bad Request) = o servidor não entendeu a requisição pois está com uma sintaxe/formato inválido
// 401 (Unauthorized) = o usuário não está autenticado (logado)
// 403 (Forbidden) = o usuário não tem permissão de acessar o recurso solicitado
// 404 (Not Found) = o servidor não pode encontrar o recurso solicitado
