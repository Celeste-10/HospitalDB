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

--Tabla Medicos
create table Personal.Medicos(
	Id_Medico int identity (1,1),
	Nombre_Medico varchar(50) not null,
	Correo_Medico varchar(100) not null,
	Salario decimal(10,2) not null,
	Id_Especialidad int null,

	Created_at datetime not null default getdate(),
	Updated_at datetime null,
	Deleted_at datetime null,

	constraint PK_Medicos primary key (Id_Medico),
	constraint UQ_CorreoMedico unique (Correo_Medico),
	constraint CK_SalarioMedico check (Salario > 0),
	constraint FK_Medicos_Especialidades foreign key (Id_Especialidad) 
		references Personal.Especialidades(Id_Especialidad)
)
go