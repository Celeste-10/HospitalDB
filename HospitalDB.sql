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

--Tabla Pacientes
create table Pacientes.Pacientes(
	Id_Paciente int identity(1,1),
	Nombre_Paciente varchar(50) not null,
	Correo_Paciente varchar(100) not null,
	Edad int not null,
	Fecha_Registro datetime not null default getdate(),

	Created_at datetime not null default getdate(),
	Updated_at datetime null,
	Deleted_at datetime null,

	constraint PK_Paciente primary key (Id_Paciente),
	constraint UQ_CorreoPaciente unique (Correo_Paciente),
	constraint CK_EdadPaciente check (Edad >= 0)
)
go

--Tabla Habitaciones
create table Pacientes.Habitaciones(
	Id_Habitacion int identity(1,1),
	Numero_Habitacion varchar(10) not null,
	Id_Paciente int null,

	Created_at datetime not null default getdate(),
	Updated_at datetime null,
	Deleted_at datetime null,

	constraint PK_Habitaciones primary key (Id_Habitacion),
	constraint FK_Habitaciones_Pacientes foreign key (Id_Paciente)
		references Pacientes.Pacientes(Id_Paciente)
)
go

--Tabla Citas
create table Atencion.Citas(
	Id_Cita int identity(1,1),
	Id_Paciente int null,
	Id_Medico int null,
	Fecha_Cita datetime not null,

	Created_at datetime not null default getdate(),
	Updated_at datetime null,
	Deleted_at datetime null,

	constraint PK_Citas primary key (Id_Cita),
	constraint FK_Citas_Pacientes foreign key (Id_Paciente)
		references Pacientes.Pacientes (Id_Paciente),
	constraint FK_Citas_Medicas foreign key (Id_Medico)
		references Personal.Medicos(Id_Medico)
)
go

--Tabla Tratamientos
create table Atencion.Tratamientos(
	Id_Tratamiento int identity(1,1),
	Descripcion varchar(max) not null,
	Id_Paciente int null,

	Created_at datetime not null default getdate(),
	Updated_at datetime null,
	Deleted_at datetime null,

	constraint PK_Tratamientos primary key (Id_Tratamiento),
	constraint FK_Tratamientos_Pacientes foreign key (Id_Paciente)
		references Pacientes.Pacientes (Id_Paciente)
)
go

--Tabla Medicamentos
create table Farmacia.Medicamentos(
	Id_Medicamento int identity (1,1),
	Nombre_Medicamento varchar(50) not null,
	Id_Tratamiento int null,

	Created_at datetime not null default getdate(),
	Updated_at datetime null,
	Deleted_at datetime null,

	constraint PK_Medicamentos primary key (Id_Medicamento),
	constraint FK_Medicamentos_Tratamientos foreign key (Id_Tratamiento)
		references Farmacia.Tratamientos(Id_Tratamiento)
)
go

--Transfiere la tabla del esquema Atencion al esquema Farmacia
alter schema Farmacia transfer Atencion.Tratamientos
go

--Modificaciones de la tabla Pacientes
alter table Pacientes.Pacientes add Telefono varchar(20) null
alter table Pacientes.Pacientes add Direccion varchar(100) null
alter table Pacientes.Pacientes add Genero char(1) null
alter table Pacientes.Pacientes add Tipo_Sangre varchar(5) null
alter table Pacientes.Pacientes add Fecha_Nacimiento date null
alter table Pacientes.Pacientes alter column Nombre_Paciente varchar(100) not null
alter table Pacientes.Pacientes alter column Direccion varchar(200) null
go
--Modificaciones de la tabla Medicos
alter table Personal.Medicos add Experiencia int null
alter table Personal.Medicos add Turno varchar(20) null
alter table Personal.Medicos add Observaciones varchar(250) null
alter table Personal.Medicos drop column Observaciones
go
--Modificaciones de la tabla Citas
alter table Atencion.Citas add Estado varchar(20) null
alter table Atencion.Citas add Costo_Consulta int null
alter table Atencion.Citas alter column Costo_Consulta decimal(10,2) null
go
--Modificaciones de la tabla Habitaciones
alter table Pacientes.Habitaciones add Disponibilidad varchar(20) not null default 'Disponible'
go