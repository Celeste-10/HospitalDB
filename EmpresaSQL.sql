
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

-- ================================================
--   Parte 2: Modificacion de estructuras (ALTER)
-- ================================================

--Agregar columna cEmail a TEmpleado
alter table TEmpleado add cEmail varchar(100)

--Agregar columna cTelefono
alter table TEmpleado add cTelefono varchar(15)

--Modificar longitud de cNombre a 100 caracteres
alter table TEmpleado alter column cNombre varchar(100) not null

--Modificar longitud de cApellido a 100 caracteres
alter table TEmpleado alter column cApellido varchar (100) not null

--Agregar columna cDireccion
alter table TEmpleado add cDireccion varchar(250)

--Agregar columna nEdad
alter table TEmpleado add nEdad int

--Crear restricción CHECK para edades entre 18 y 65 años
alter table TEmpleado
add constraint CHK_Empleado_Edad check (nEdad between 18 and 65)

--Agregar restricción UNIQUE al correo electrónico
alter table TEmpleado
add constraint UQ_Empleado_Email unique (cEmail)

--Agregar columna bActivo tipo BIT con valor por defecto 1
alter table TEmpleado add bActivo bit constraint DF_Empleado_Activo default 1

--Eliminar la columna cDireccion
alter table TEmpleado drop column cDireccion

--Cambiar el tipo de dato de teléfono a VARCHAR(20)
alter table TEmpleado alter column cTelefono varchar(20)

--Agregar columna cGenero
alter table TEmpleado add cGenero char(1)

--Agregar restricción CHECK para que el género solo permita M o F
alter table TEmpleado
add constraint CHK_Empleado_Genero check (cGenero in('M', 'F'))

--Agregar columna dFechaNacimiento
alter table TEmpleado add dFechaNacimiento date

--Crear una nueva tabla llamada TSucursal
create table TSucursal(
	nSucursalID int identity (1,1) primary key,
	cNombreSucursal varchar(100) not null,
	cUbicacion varchar(150) 
)

