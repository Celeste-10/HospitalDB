
-- =============================================
--  Parte 1: Creacion de base de datos y tablas
-- =============================================
create database EmpresaSQL
go

use EmpresaSQL
go

create table TDepartamento(
	nDepartamentoID int identity (1,1) primary key,
	cNombreDepartamento varchar(100) unique not null
)

create table TCargo(
	nCargoID int identity (1,1) primary key,
	cNombreCargo varchar(100) unique not null
)

create table TEmpleado(
	nEmpleadoID int identity (1,1) primary key,
	cNIF varchar(20) unique not null,
	cNombre varchar(50) not null,
	cApellido varchar(50) not null,
	nDepartamentoID int,
	nCargoID int,
	dFechaContratacion date,
	nSalario decimal (10,2)
)

--Agregar restricción CHECK para que el salario sea mayor que 300
alter table TEmpleado
add constraint CHK_Empleado_Salario check (nSalario > 300)

--Agregar restricción DEFAULT para la fecha de contratación
alter table TEmpleado
add constraint DF_Empleado_FechaContratacion default getdate() for dFechaContratacion

--Establecer llave foránea entre TEmpleado y TDepartamento
alter table TEmpleado
add constraint FK_Empleado_Departamento foreign key (nDepartamentoID) references TDepartamento (nDepartmentoID)

--Establecer llave foránea entre TEmpleado y TCargo
alter table TEmpleado
add constraint FK_Empleado_Cargo foreign key (nCargoID) references TCargo(nCargoID)

--Crear una tabla llamada TProyecto con sus restricciones
create table TProyecto(
	nProyectoID int identity (1,1) primary key,
	cNombreProyecto varchar(150) not null,
	dFechaInicio date not null,
	dFechaFinalizacion date
)

--Crear tabla intermedia TEmpleadoProyecto para relación muchos a muchos
create table TEmpleadoProyecto(
	nEmpleadoID int,
	nProyectoID int,
	constraint PK_EmpleadoProyecto primary key (nEmpleadoID, nProyectoID),
	constraint FK_EmpProj_Empleado foreign key (nEmpleadoID) references TEmpleado(nEmpleadoID),
	constraint FK_Emproj_Proyecto foreign key (nProyectoID) references TProyecto(nProyectoID)
)