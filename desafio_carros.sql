create database loja_carros;
use loja_carros;

create table carros (
	id integer primary key auto_increment,
    nome varchar(50),
    descricao text,
    categoria varchar(200),
    quantidade_em_estoque integer
);

alter table compras rename column client_id to cliente_id;

create table clientes(
	id integer primary key auto_increment,
    nome varchar(60),
    cpf varchar(20),
    endereco text,
    telefone varchar(25),
    email varchar(256)
);

create table compras (
	id integer primary key auto_increment,
    client_id integer,
    data_compra date,
    total_compra double,
    foreign key (client_id) references clientes(id)
);

create table carros_compra (
	id integer primary key auto_increment,
    compra_id integer,
    carro_id integer,
    quantidade integer,
    subtotal double,
    
    foreign key(compra_id) references compras(id),
    foreign key(carro_id) references carros(id)
);

/*CONSULTA USANDO INNER JOIN*/
select carros_compra.id as carros_compra_id, compras.id as compras_id, carros_compra.carro_id, quantidade, subtotal, data_compra, clientes.nome from carros_compra 
INNER JOIN compras 	
ON carros_compra.compra_id = compras.id
INNER JOIN clientes
ON compras.cliente_id = clientes.id
where cliente_id in(1,2);

select * from clientes join compras on clientes.id = compras.cliente_id where cliente_id = 2; 

create table estoque (
	id integer primary key auto_increment,
    carro_id integer,
    quantidade_em_estoque integer,
    
    foreign key (carro_id) references carros(id)
);


/*inserindo registros nas tabelas*/
insert into carros (nome, descricao, preco, categoria, quantidade_em_estoque) values
("Volkswagen", "V6 1.6", 115000, "Crossover", 3),
("Hyundai", "V6 1.8", 36000, "SUV", 5),
("Chevrolet", "V6 2.0", 120990, "Tracker", 4);

insert into clientes (nome, cpf, telefone, endereco, email) values
("Maria Luiza", 12345678911, 12345678901, "Rua Itambé", "marialuizagomes1305@gmail.com"),
("Lidia", 12345678912, 12345678902, "Rua Itajaí", "lidia123@gmail.com"),
("Mylena", 12345678913, 12345678903, "Rua Nascimento", "mylena321@gmail.com");

insert into compras (cliente_id, data_compra, total_compra) values
(1, "2023-08-23", 115000),
(2, "2021-01-24", 36000),
(3, "2018-05-13", 120900);

insert into carros_compra (compra_id, carro_id, quantidade, subtotal) values
(1, 2, 1, 36000),
(2, 1, 1, 115000),
(3, 3, 1, 120900);

insert into estoque (carro_id, quantidade_em_estoque) values
(1, 3),
(2, 5),
(3, 4);


