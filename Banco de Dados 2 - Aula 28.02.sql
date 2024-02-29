create schema FINTECH;
use FINTECH;

create table Cliente(
	ClienteID int, 
    Nome varchar(255) not null, 
    CPF varchar (11) check (CPF like '___________') unique, 
    Email varchar (20) unique not null, 
    Telefone varchar(20), 
    Salario decimal(6, 2), 
    primary key(ClienteID)
);

insert into Cliente (ClienteID, Nome, CPF, Email)
values ('1', 'Cliente 1', '00100200399', ''); 

insert into Cliente (ClienteID, Nome, CPF, Email)
values ('1', 'Cliente 1', '00100200399', null); 

insert into Cliente (ClienteID, Nome, CPF)
values ('1', 'Cliente 1', '00100200399'); 

insert into Cliente (ClienteID, Nome, CPF, Email)
values ('1', 'Cliente 1', '00100200299', ''); 

create table ContaBancaria(
	ContaID int, 
    ClienteID int, 
    TipoConta varchar(10) check (TipoConta in('Corrente', 'Poupança')), 
    Saldo decimal(10, 2) not null default 0.00, 
    primary key(ContaID), 
    foreign key(ClienteID) references Cliente(ClienteID)
);

create table Transacao(
	TransacaoID int, 
	ContaOrigemID int not null, 
    ContaDestinoID int not null, 
    Valor decimal(10, 2) not null, 
    DataHora datetime not null default now(), 
    primary key(TransacaoID), 
    foreign key(ContaOrigemID) references ContaBancaria(ContaID), 
    foreign key(ContaDestinoID) references ContaBancaria(ContaID)
);

create table CartaoCredito(
	CartaoID int, 
    ClienteID int not null, 
    NumeroCartao varchar(19) unique not null check (NumeroCartao like ('____ ____ ____ ____')),
    LimiteCredito decimal(10, 2) not null check (LimiteCredito >= 500.00) default 500.00, 
    primary key (CartaoID), 
    foreign key (ClienteID) references Cliente(ClienteID)
);

alter table Cliente modify column Email varchar(255) not null;

### Clientes
INSERT INTO Cliente (ClienteID, Nome, CPF, Email, Telefone, Salario)
VALUES
    (1, 'Maria Silva', '12345678901', 'maria.silva@gmail.com', '(11) 98765-4321', NULL),
    (2, 'João Santos', '98765432109', 'santos.joao@gmail.com', '(11) 99999-8888', NULL),
	(3, 'Eduardo Tavares', '11122233344', 'edu2009@gmail.com', '(11) 98744-4113', 8000.00),
	(4, 'Marcos Menezes', '55566677788', 'marmen@gmail.com', '(11) 94321-8765', 5000.00);

## Contas Bancárias
INSERT INTO ContaBancaria (ContaID, ClienteID, TipoConta, Saldo)
VALUES
    (101, 1, 'Corrente', 5000.00),
    (102, 2, 'Poupança', 10000.00),
	(103, 3, 'Corrente', 9999.99),
    (104, 4, 'Corrente', 1000.00);

## Transações
INSERT INTO Transacao (TransacaoID, ContaOrigemID, ContaDestinoID, Valor, DataHora)
VALUES
    (1001, 101, 102, 1000.00, '2024-01-10 10:30:00'),
    (1002, 102, 101, 250.00, '2024-02-25 11:15:00'),
    (1003, 103, 104, 100.00, '2024-02-10 13:15:00'),
	(1004, 101, 102, 80.00, '2024-02-12 20:05:00'),
	(1005, 103, 101, 700.00, '2024-02-24 09:50:00'),
	(1006, 102, 103, 200.00, '2024-02-24 10:15:00');

## Cartões de Crédito
# Insert deve falhar pois o número do cartão não está no formato especificado
INSERT INTO CartaoCredito(CartaoID, ClienteID, NumeroCartao, LimiteCredito)
VALUES
	(201, 1, '1234567890123456', 5000.00);

# Insert deve falhar pois o limite está abaixo de 500
INSERT INTO CartaoCredito(CartaoID, ClienteID, NumeroCartao, LimiteCredito)
VALUES 
	(202, 2, '9876 5432 1098 7654', 400.00);

# Inserts Corrigidos
INSERT INTO CartaoCredito(CartaoID, ClienteID, NumeroCartao, LimiteCredito)
VALUES
    (201, 1, '1234 5678 9012 3456', 5000.00),
    (202, 2, '9876 5432 1098 7654', 500.00);