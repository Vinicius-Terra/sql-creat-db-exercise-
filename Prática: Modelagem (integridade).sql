
CREATE DATABASE "Customers_DB";

CREATE TABLE "customers" (
	"id" SERIAL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	"cpf" varchar(11) UNIQUE,
    "email" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL
);

CREATE TABLE "customerPhones" (
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	"number" varchar(12) NOT NULL UNIQUE,
    "type" TEXT NOT NULL CHECK (type='landline' OR type='mobile')
);

CREATE TABLE "states" (
	"id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL
);

CREATE TABLE "cities" (
	"id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
	"stateId" INTEGER REFERENCES states(id)
);

CREATE TABLE "customerAddresses" (
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	"street" TEXT NOT NULL,
    "number" INTEGER NOT NULL,
    "complement" TEXT NOT NULL,
    "postalCode" TEXT NOT NULL,
    "cityId" INTEGER REFERENCES cities(id)
);

CREATE TABLE "bankAccount" (
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	"accountNumber" INTEGER NOT NULL,
    "agency" TEXT NOT NULL,
    "openDate" DATE NOT NULL,
    "closeDate" DATE
);

CREATE TABLE "transactions" (
	"id" SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER REFERENCES "bankAccount"(id),
	"amount" DOUBLE PRECISION NOT NULL,
    "type" TEXT NOT NULL CHECK (type='deposit' OR type='withdraw'),
    "time" TIME NOT NULL,
    "descriptions" TEXT NOT NULL,
    "cancelled" BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE "creditCards" (
	"id" SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER REFERENCES "bankAccount"(id),
	"name" TEXT NOT NULL,
    "number" INTEGER NOT NULL,
    "securityCode" INTEGER NOT NULL UNIQUE,
    "expirationMonth" INTEGER NOT NULL,
    "expirationYear" INTEGER NOT NULL,
    "password" TEXT NOT NULL,
    "limit" INTEGER NOT NULL
);


