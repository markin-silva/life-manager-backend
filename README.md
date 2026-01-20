# Life Manager API

Uma API REST desenvolvida em Ruby on Rails como projeto de portfólio, demonstrando arquitetura desacoplada, autenticação segura e boas práticas de desenvolvimento backend.

## 📋 Visão Geral

Backend RESTful completamente independente do frontend, estruturado seguindo padrões de produção com foco em escalabilidade, segurança e manutenibilidade.

**Características principais:**
- API RESTful com versionamento (`/api/v1`)
- Autenticação baseada em token (JWT)
- Banco de dados PostgreSQL
- Ambiente containerizado com Docker
- Código organizado com padrões de boas práticas

## 🛠 Tecnologias

| Categoria | Tecnologia | Versão |
|-----------|-----------|--------|
| **Runtime** | Ruby | 3.3.0 |
| **Framework** | Rails | 7.2.3+ |
| **Banco de Dados** | PostgreSQL | 16 |
| **Autenticação** | Devise Token Auth | Latest |
| **Containerização** | Docker | Latest |
| **Orquestração** | Docker Compose | Latest |
| **Web Server** | Puma | 5.0+ |
| **Segurança** | Brakeman | Latest |
| **Linting** | Rubocop Rails | Latest |
| **Paginação** | Kaminari | 1.2+ |
| **Serialização** | Blueprinter | 1.2+ |

---

## 🔐 Autenticação

### Estratégia de Autenticação

O projeto utiliza **Devise Token Auth** com autenticação baseada em tokens JWT. Cada usuário recebe um token após login que deve ser incluído em requisições autenticadas.

### Headers de Autenticação

```
Authorization: Bearer <token>
access-token: <token>
client: <client_id>
expiry: <timestamp>
uid: <user_email>
```

### Fluxo de Autenticação

1. **Signup**: `POST /api/v1/auth` com email e senha
2. **Login**: `POST /api/v1/auth/sign_in` com credenciais
3. **Refresh**: Tokens renovados automaticamente em cada requisição
4. **Logout**: `DELETE /api/v1/auth/sign_out`

### Detalhes de Tokens

- **Expiração**: 2 semanas (configurável)
- **Token cost**: 4 (teste) / 10 (produção)
- **Max dispositivos**: 10 simultâneos por usuário

---

## 📡 Versionamento da API

### Estratégia de Versionamento

O projeto adota versionamento **URI-based**, colocando a versão no caminho:

```
/api/v1/health
/api/v2/health  # Futuras versões coexistem
```

---

## 📄 Paginação

Endpoints de listagem aceitam:

- `page` (padrão: 1)
- `per_page` (padrão: 30, máximo: 30)

Exemplo de resposta:

```json
{
  "status": "success",
  "data": ["..."],
  "meta": {
    "current_page": 1,
    "total_count": 120,
    "per_page": 30
  }
}
```

## 🐳 Docker

### Serviços

- **API**: Rails em container (porta 3000)
- **Database**: PostgreSQL 16 (porta 5432)

### Entrypoint

Em produção, o container executa migrações automaticamente via `entrypoint.sh`.
Em outros ambientes, as migrações são ignoradas.

---

## ⚡ Gup (CLI de produtividade)

O projeto inclui um script bash chamado **gup** para facilitar comandos do dia a dia via terminal.

### Instalação

Na raiz do projeto:

```bash
chmod +x gup
```

Opcional: tornar disponível globalmente no terminal:

```bash
sudo ./gup setup
```

### Uso

```bash
./gup help
```

### Comandos disponíveis

```bash
gup build          # docker compose build
gup up             # docker compose up
gup down           # docker compose down
gup restart        # down + up
gup rails c        # docker compose run --rm api rails console
gup rails s        # docker compose exec api rails server -b 0.0.0.0
gup db migrate     # docker compose run --rm api rails db:migrate
gup db rollback    # docker compose run --rm api rails db:rollback
gup test           # bundle exec rspec
gup cop            # bundle exec rubocop
```

### Variáveis

- `SERVICE_NAME`: nome do serviço no Docker Compose (padrão: `api`)

---

## 🚀 Como Rodar

### Pré-requisitos

- Docker e Docker Compose instalados
- Git
- Porta 3000 e 5432 disponíveis

### Instalação e Execução

#### 1. Clonar o repositório

```bash
git clone <repository-url>
cd life_manager_backend
```

#### 2. Iniciar com Docker Compose

```bash
docker-compose up -d
```

Isso irá:
- Construir a imagem Docker
- Iniciar a API na porta 3000
- Iniciar o PostgreSQL na porta 5432

#### 3. Preparar o banco de dados

```bash
docker-compose exec api rails db:create
docker-compose exec api rails db:migrate
docker-compose exec api rails db:seed  # Opcional
```

#### 4. Verificar o status da API

```bash
curl http://localhost:3000/api/v1/health
```

Resposta esperada:
```json
{
  "status": "success",
  "data": {
    "status": "ok"
  }
}
```


## 🔧 Variáveis de Ambiente

### Variáveis Obrigatórias

```env
DATABASE_URL=postgres://user:password@host:port/database_name
DATABASE_URL_TEST=postgres://user:password@host:port/database_name_test
RAILS_ENV=development
RAILS_MASTER_KEY=<chave-mestre>
```

### Variáveis Opcionais

```env
DEVISE_TOKEN_AUTH_TOKEN_LIFESPAN=1209600
DEVISE_TOKEN_AUTH_TOKEN_COST=10
CORS_ORIGINS=http://localhost:3000
LOG_LEVEL=info
```

### Observações

- Recuperação de senha via Devise está desabilitada no backend.

## ✅ Boas Práticas

### JSON API Standard

```json
Respostas padronizadas:

{
  "status": "success",
  "data": {},
  "meta": {}
}

Erros padronizados:

{
  "status": "error",
  "error": {
    "code": "string_identifier",
    "message": "human readable message",
    "details": {}
  }
}
```

### Code Quality

```bash
bundle exec rubocop      # Linting
bundle exec rubocop -A   # Auto-correct
bundle exec brakeman     # Segurança
bundle exec rspec        # Testes
```

**RuboCop**: configuração pragmática, focada em legibilidade e consistência, com regras adaptadas para Rails API e RSpec.

### Logging

```ruby
Rails.logger.info("User logged in", user_id: user.id)
Rails.logger.warn("Suspicious activity")
Rails.logger.error("Database error")
```

---

## 📝 Licença

Este projeto é fornecido como-é para fins de portfólio e aprendizado.

Você é livre para:
- Estudar e entender o código
- Usar como referência para seus próprios projetos
- Contribuir com melhorias

Quando usar este código como base:
- Cite a fonte original
- Adapte para suas necessidades
- Não revenda como seu próprio trabalho

---

## 📞 Suporte e Contato

Para dúvidas, sugestões ou reportar bugs, abra uma **issue** no repositório.
