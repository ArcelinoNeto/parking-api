# Parking API

API em Rails para controle simples de estacionamento. O projeto gerencia reservas de veiculos e pagamentos associados a essas reservas.

## Dominio

### Reservation

Representa a reserva ou permanencia de um veiculo no estacionamento.

Campos principais:

- `plate`: placa do veiculo.
- `entry`: data/hora de entrada.
- `exit`: data/hora de saida.
- `status`: estado da reserva.

Status disponiveis:

- `active`: reserva em andamento.
- `finished`: reserva finalizada.
- `cancelled`: reserva cancelada.

### Payment

Representa um pagamento feito para uma reserva.

Campos principais:

- `value`: valor pago.
- `reservation_id`: reserva vinculada ao pagamento.

## Endpoints

### Reservations

```http
GET    /reservations
GET    /reservations/:id
POST   /reservations
PATCH  /reservations/:id
DELETE /reservations/:id
```

Exemplo de criacao:

```json
{
  "reservation": {
    "plate": "ABC-1234",
    "entry": "2026-05-28T08:00:00Z",
    "exit": "2026-05-28T10:00:00Z",
    "status": "active"
  }
}
```

### Payments

```http
GET    /payments
GET    /payments/:id
POST   /payments
PATCH  /payments/:id
DELETE /payments/:id
```

Exemplo de criacao:

```json
{
  "payment": {
    "value": 10.25,
    "reservation_id": 1
  }
}
```

## Requisitos

- Ruby 2.7.1
- Rails 6.1
- PostgreSQL

O projeto possui `.ruby-version` e `Gemfile` apontando para Ruby 2.7.1.

## Setup

Instale as dependencias:

```bash
bundle install
```

Prepare o banco:

```bash
bin/rails db:create
bin/rails db:migrate
```

Rode a API:

```bash
bin/rails server
```

Por padrao, a aplicacao sobe em:

```text
http://localhost:3000
```

## Testes

```bash
bundle exec rspec
```

## Proximos passos sugeridos

- Adicionar calculo automatico do valor da estadia.
- Validar formato da placa.
- Criar endpoints especificos para entrada e saida de veiculos.
- Adicionar serializers para padronizar as respostas JSON.
- Atualizar a stack para uma versao mais recente de Ruby/Rails.
