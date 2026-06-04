--Creacion de la base de datos
create database HospitalDB
use HospitalDB

--Mostrar todas las bases de datos existentes
select name from sys.databases
go

--Creacion de esquemas
create schema Personal
create schema Pacientes
create schema Atencion
create schema Farmacia

--Creacion de las tablas con sus restricciones

--Tabla Especialidades
create table Personal.Especialidades(
	Id_Especialidad int identity(1,1),
	Nombre_Especialidad varchar(50) not null,

	Created_at datetime not null default getdate(),
	Updated_at datetime null,
	Deleted_at datetime null,

	constraint PK_Especialidades primary key (Id_Especialidad)
)
go