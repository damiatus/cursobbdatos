# Entidades:
# Persona
# Local
# Producto

#Todas las relaciones son N-M
# EN vez de tener todos los consumos juntos, vamos a separar los pedidos en sus subproductos

create database fondas;
use fondas;

CREATE TABLE persona (
    `idPersona` BIGINT(20) not null primary key ,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE local (
    `idLocal` BIGINT(20) not null primary key ,
    `name` VARCHAR(50) NOT NULL
   # idproducto VARCHAR(50) NOT NULL
);

CREATE TABLE producto (
    `idProducto` BIGINT(20) not null primary key ,
    `name` VARCHAR(50) NOT NULL
);

#Se crea tabla para pedidos que une personas con locales
create table pedido(
    idPedido BIGINT(20) not null primary key auto_increment,
    idLocal BIGINT(20),
    idPersona BIGINT(20),
    fecha date,
    foreign key (idLocal) references local (idLocal),
    foreign key (idPersona) references persona (idPersona)
);

create table detallePedido(
    idDetallePedido BIGINT(20) not null primary key auto_increment,
    idPedido BIGINT(20),
    idProducto BIGINT(20),
    cantidad int,

    foreign key (idPedido) references pedido (idPedido),
    foreign key (idProducto) references producto (idProducto)
);



#otra tabla que una persona con consumo y tenga fecha
drop TABLE personaProducto;

#Así para poder analizar cuanto compro un cliente en un local basta hacer la query con dichas restricciones
