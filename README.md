# Parking API

Parking API is a Ruby on Rails backend application designed to manage parking reservations, vehicle stays and payments.

The project was initially created as a backend study/challenge and later maintained as a portfolio project focused on RESTful API design, relational modeling and business rule organization.

## Features

* Parking reservation management
* Vehicle entry and exit control
* Reservation status tracking
* Payment management
* RESTful API structure
* PostgreSQL database
* Automated tests with RSpec

## Domain

### Reservation

Represents a vehicle reservation or stay in the parking lot.

Main fields:

* `plate`: vehicle license plate
* `entry`: vehicle entry date/time
* `exit`: vehicle exit date/time
* `status`: reservation status

Available statuses:

* `active`: reservation in progress
* `finished`: reservation completed
* `cancelled`: reservation cancelled

### Payment

Represents a payment associated with a reservation.

Main fields:

* `value`: paid amount
* `reservation_id`: related reservation

## Endpoints

### Reservations

```http
GET    /reservations
GET    /reservations/:id
POST   /reservations
PATCH  /reservations/:id
DELETE /reservations/:id
```

Example request:

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

Example request:

```json
{
  "payment": {
    "value": 10.25,
    "reservation_id": 1
  }
}
```

## Tech Stack

* Ruby 2.7.1
* Ruby on Rails 6.1
* PostgreSQL
* RSpec

## Setup

Clone the repository:

```bash
git clone https://github.com/ArcelinoNeto/parking-api.git
cd parking-api
```

Install dependencies:

```bash
bundle install
```

Create and migrate the database:

```bash
bin/rails db:create
bin/rails db:migrate
```

Start the application:

```bash
bin/rails server
```

By default, the API will be available at:

```text
http://localhost:3000
```

## Running Tests

```bash
bundle exec rspec
```

## Project Goals

This project demonstrates:

* RESTful API development with Ruby on Rails
* Relational modeling between reservations and payments
* Basic parking business rules
* JSON API structure
* Automated test execution with RSpec
* Backend organization using Rails conventions

## Future Improvements

Some planned improvements for the project include:

* Automatic parking fee calculation
* License plate format validation
* Specific endpoints for vehicle entry and exit
* JSON serializers for response standardization
* Authentication and authorization
* Docker support
* CI/CD pipeline
* Upgrade to a newer Ruby and Rails version

## Portfolio Notes

Although this project started as a simple backend challenge, it was kept as a portfolio case because it represents common API scenarios involving reservations, statuses, payments and relational data management.
