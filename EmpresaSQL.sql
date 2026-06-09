
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

-- ========================================
--   Parte 3: Insercion de datos (INSERT) 
-- ========================================

insert into TDepartamento (cNombreDepartamento) values
('Tecnología'), 
('Recursos Humanos'), 
('Finanzas'), 
('Ventas'), 
('Marketing')

insert into TCargo (cNombreCargo) values
('Desarrollador'), 
('Analista de RRHH'), 
('Contador'), 
('Asesor Comercial'), 
('Gerente')

insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, cTelefono, nEdad, cGenero, dFechaNacimiento) values
('11111111A', 'Carlos', 'Gomez', 1, 1, '2025-01-15', 1500.00, 'carlos@empresa.com', '8888-1111', 28, 'M', '1997-05-10'),
('22222222B', 'Ana', 'Martinez', 2, 2, '2024-03-22', 1200.00, 'ana@empresa.com', '8888-2222', 34, 'F', '1991-08-20'),
('33333333C', 'Luis', 'Rodriguez', 3, 3, '2023-06-10', 1400.00, 'luis@empresa.com', '8888-3333', 41, 'M', '1984-11-03'),
('44444444D', 'Maria', 'Garcia', 4, 4, '2026-02-01', 950.00, 'maria@empresa.com', '8888-4444', 25, 'F', '2001-02-14'),
('55555555E', 'Jorge', 'Lopez', 1, 1, '2026-01-10', 1600.00, 'jorge@empresa.com', '8888-5555', 30, 'M', '1996-03-25'),
('66666666F', 'Elena', 'Perez', 5, 5, '2022-09-05', 2500.00, 'elena@empresa.com', '8888-6666', 45, 'F', '1980-07-19'),
('77777777G', 'Pedro', 'Guti', 1, 1, '2025-11-20', 1550.00, 'pedro@empresa.com', '8888-7777', 29, 'M', '1996-12-05'),
('88888888H', 'Sofia', 'Castro', 4, 4, '2024-05-18', 450.00, 'sofia@empresa.com', '8888-8888', 22, 'F', '2003-09-30'),
('99999999I', 'Miguel', 'Sanchez', 3, 3, '2026-04-12', 400.00, 'miguel@empresa.com', '8888-9999', 35, 'M', '1991-01-12'),
('00000000J', 'Lucia', 'Fernandez', 2, 2, '2023-11-11', 1100.00, 'lucia@empresa.com', '8888-0000', 31, 'F', '1994-04-02')

insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, cTelefono, nEdad, cGenero, dFechaNacimiento) values
('11111111A', 'Carlos', 'Gomez', 1, 1, '2025-01-15', 1500.00, 'carlos@empresa.com', '8888-1111', 28, 'M', '1997-05-10'),
('22222222B', 'Ana', 'Martinez', 2, 2, '2024-03-22', 1200.00, 'ana@empresa.com', '8888-2222', 34, 'F', '1991-08-20'),
('33333333C', 'Luis', 'Rodriguez', 3, 3, '2023-06-10', 1400.00, 'luis@empresa.com', '8888-3333', 41, 'M', '1984-11-03'),
('44444444D', 'Maria', 'Garcia', 4, 4, '2026-02-01', 950.00, 'maria@empresa.com', '8888-4444', 25, 'F', '2001-02-14'),
('55555555E', 'Jorge', 'Lopez', 1, 1, '2026-01-10', 1600.00, 'jorge@empresa.com', '8888-5555', 30, 'M', '1996-03-25'),
('66666666F', 'Elena', 'Perez', 5, 5, '2022-09-05', 2500.00, 'elena@empresa.com', '8888-6666', 45, 'F', '1980-07-19'),
('77777777G', 'Pedro', 'Guti', 1, 1, '2025-11-20', 1550.00, 'pedro@empresa.com', '8888-7777', 29, 'M', '1996-12-05'),
('88888888H', 'Sofia', 'Castro', 4, 4, '2024-05-18', 450.00, 'sofia@empresa.com', '8888-8888', 22, 'F', '2003-09-30'),
('99999999I', 'Miguel', 'Sanchez', 3, 3, '2026-04-12', 400.00, 'miguel@empresa.com', '8888-9999', 35, 'M', '1991-01-12'),
('00000000J', 'Lucia', 'Fernandez', 2, 2, '2023-11-11', 1100.00, 'lucia@empresa.com', '8888-0000', 31, 'F', '1994-04-02')

insert into TProyecto (cNombreProyecto, dFechaInicio, dFechaFinalizacion) values
('Migración del Sistema', '2026-01-10', '2026-06-30'),
('Campaña de Verano', '2026-04-01', '2026-08-31'),
('Auditoría Anual', '2026-05-01', NULL)

insert into TEmpleadoProyecto (nEmpleadoID, nProyectoID) values
(1, 1), 
(5, 1), 
(7, 1),
(4, 2), 
(6, 2), 
(3, 3)

insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, cEmail, nEdad, cGenero) values 
('12345678X', 'Roberto', 'Diaz', 1, 1, 1350.00, 'roberto@empresa.com', 27, 'M')

insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, cEmail, nEdad, cGenero) values
('87654321Y', 'Laura', 'Mendoza', 5, 4, 1050.00, 'laura.m@empresa.com', 26, 'F')

insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, cEmail, nEdad, cGenero) values 
('56781234Z', 'David', 'Ruiz', 4, 4, 980.00, 'david@empresa.com', 33, 'M')

insert into TDepartamento (cNombreDepartamento) values
('Logistica'),
('Atencion al Cliente')

-- Intentar insertar un salario negativo y analizar el error[cite: 63].
/*
insert into TEmpleado (cNIF, cNombre, cApellido, nSalario) values 
('99999999X', 'Prueba', 'Error', -500.00);

-- Análisis del error: Se producirá una violación de la restricción CHECK 'CHK_Empleado_Salario' debido a que el valor asignado (-500) no cumple con la regla de integridad de ser estrictamente mayor que 300. El motor de base de datos abortará la instrucción.
*/

-- ============================================
--   Parte 4: Actualizacion de datos (UPDATE) 
-- ============================================

-- Incrementar en 10% el salario de todos los empleados
update TEmpleado 
set nSalario = nSalario * 1.10

-- Incrementar en 20% el salario de los empleados de un departamento específico
update TEmpleado 
set nSalario = nSalario * 1.20 
where nDepartamentoID = 1

-- Actualizar el correo electrónico de un empleado
update TEmpleado 
set cEmail = 'carlos.gomez.nuevo@empresa.com' 
where cNIF = '11111111A'

-- Modificar el cargo de un empleado
update TEmpleado 
set nCargoID = 5 
where cNIF = '55555555E'

-- Cambiar el departamento de dos empleados
update TEmpleado 
set nDepartamentoID = 3 
where cNIF IN ('22222222B', '00000000J')

-- Marcar como inactivos (bActivo = 0) a los empleados con salario inferior a 500
update TEmpleado 
set bActivo = 0 
where nSalario < 500

-- Actualizar la fecha de finalización de un proyecto
update TProyecto 
set dFechaFinalizacion = '2026-09-15' 
where nProyectoID = 3

-- Asignar un nuevo proyecto a un empleado
insert into TEmpleadoProyecto (nEmpleadoID, nProyectoID) values 
(2, 3)

-- ==========================================
--   Parte 5: Eliminacion de datos (DELETE)
-- ==========================================

-- Eliminar un empleado específico mediante su NIF
-- Nota: Si el empleado tiene asignados proyectos, primero se borran sus dependencias para evitar conflicto de clave foránea.
delete from TEmpleadoProyecto where nEmpleadoID = (select nEmpleadoID from TEmpleado where cNIF = '44444444D')
delete from TEmpleado where cNIF = '44444444D'

-- Eliminar todos los empleados inactivos
delete from TEmpleadoProyecto where nEmpleadoID in (select nEmpleadoID from TEmpleado where bActivo = 0)
delete from TEmpleado where bActivo = 0

-- Eliminar un proyecto específico
delete from TEmpleadoProyecto where nProyectoID = 2
delete from TProyecto where nProyectoID = 2

-- Eliminar las asignaciones de un empleado en la tabla TEmpleadoProyecto
delete from TEmpleadoProyecto where nEmpleadoID = 1

-- Eliminar un departamento que no tenga empleados asociados
delete from TDepartamento 
where nDepartamentoID not in (select distinct nDepartamentoID from TEmpleado where nDepartamentoID is not null)

-- ======================================
--   Parte 6: Consultas de verificacion
-- ======================================

--Mostrar todos los empleados ordenados por apellido
select * from TEmpleado order by cApellido asc

--Mostrar empleados con salario mayor a 1,000
select * from TEmpleado where nSalario > 1000

--Mostrar empleados activos
select * from TEmpleado where bActivo =1

--Mostrar empleados contratados durante el año actual
select * from TEmpleado where year (dFechaContratacion) = 2026

--Mostrar empleados y el nombre de su departamento
select E.nEmpleadoID, E.cNombre, E.cApellido, D.cNombreDepartamento from TEmpleado E
inner join TDepartamento D on E.nDepartamentoID = D.nDepartamentoID

--Mostrar empleados y el nombre de su cargo
select E.nEmpleadoID, E.cNombre, E.cApellido, C.cNombreCargo from TEmpleado E
inner join TCargo C ON E.nCargoID = C.nCargoID

--Mostrar empleados asignados a proyectos
select E.cNombre, E.cApellido, P.cNombreProyecto from TEmpleado E 
inner join TEmpleadoProyecto EP on E.nEmpleadoID = EP.nEmpleadoID
inner join TProyecto P on EP.nProyectoID = P.nProyectoID

--Mostrar cantidad de empleados por departamento
select D.cNombreDepartamento, count(E.nEmpleadoID) as TotalEmpleados from TDepartamento D
left join TEmpleado E on D.nDepartamentoID = E.nDepartamentoID
group by D.cNombreDepartamento

--Mostrar salario promedio por departamento
select D.cNombreDepartamento, avg(E.nSalario) as SalarioPromedio from TDepartamento D
inner join TEmpleado E on D.nDepartamentoID = E.nDepartamentoID
group by D.cNombreDepartamento

--Mostrar salario máximo y mínimo por departamento
select D.cNombreDepartamento, max(E.nSalario) as SalarioMaximo, min(E.nSalario) as SalarioMinimo from TDepartamento D
inner join TEmpleado E on D.nDepartamentoID = E.nDepartamentoID
group by D.cNombreDepartamento

--Mostrar los proyectos con más de dos empleados asignados
select P.cNombreProyecto, count(EP.nEmpleadoID) as NumeroEmpleados from TProyecto P
inner join TEmpleadoProyecto EP on P.nProyectoID = EP.nProyectoID
group by P.cNombreProyecto
having count(EP.nEmpleadoID) > 2

--Mostrar empleados cuyo apellido inicia con "G"
select * from TEmpleado where cApellido like 'G%'

--Mostrar empleados ordenados por salario descendente
select * from TEmpleado order by nSalario desc

--Mostrar los tres salarios más altos
select top 3 nSalario, cNombre, cApellido from TEmpleado order by nSalario desc

--Mostrar empleados con edad entre 25 y 40 años
select * from TEmpleado where nEdad between 25 and 40

--Mostrar cantidad total de empleados activos
select count(*) as TotalActivos from TEmpleado where bActivo = 1

--Mostrar el total de proyectos registrados
select count(*) as TotalProyectos from TProyecto 

-- ======================================
--   Parte 7: Administracion de objetos
-- ======================================

--Eliminar la restricción CHECK de edad
alter table TEmpleado drop constraint CHK_Empleado_Edad

--Eliminar la restricción UNIQUE del correo
alter table TEmpleado drop constraint UQ_Empleado_Email

--Agregar nuevamente ambas restricciones
alter table TEmpleado add constraint CHK_Empleado_Edad check (nEdad BETWEEN 18 AND 65)
alter table TEmpleado add constraint UQ_Empleado_Email unique (cEmail)

--Eliminar la tabla TEmpleadoProyecto
drop table TEmpleadoProyecto

--Eliminar la tabla TProyecto
drop table TProyecto

--Eliminar la tabla TEmpleado
drop table TEmpleado

--Eliminar la tabla TCargo
drop table TCargo

--Eliminar la tabla TDepartamento
drop table TDepartamento

--Eliminar la tabla TSucursal
drop table TSucursal

--Eliminar la base de datos EmpresaSQL
use master
go

drop database EmpresaSQL
go

-- ==========================
--    Desafios adicionales
-- ==========================

create database EmpresaDesafios;
go
use EmpresaDesafios;
go

-- Crear una tabla TCliente con al menos 8 campos y restricciones
create table TCliente (
    nClienteID int identity(1,1) primary key,
    cCedula varchar(20) unique not null,
    cNombre varchar(100) not null,
    cApellido varchar(100) not null,
    cEmail varchar(100) unique,
    cTelefono varchar(20),
    dFechaRegistro date default getdate(),
    nEdad int check (nEdad >= 18),
    bEstado bit default 1
)

-- Crear una tabla TVenta relacionada con TCliente
create table TVenta (
    nVentaID int identity(1,1) primary key,
    nClienteID int not null,
    dFechaVenta date not null default getdate(),
    nMontoTotal decimal(10,2) check (nMontoTotal >= 0),
    cMetodoPago varchar(50) default 'Efectivo',
    constraint FK_Venta_Cliente foreign key (nClienteID) references TCliente(nClienteID)
)

-- Registrar 20 clientes
insert into TCliente (cCedula, cNombre, cApellido, cEmail, cTelefono, nEdad) values
('C01', 'Juan', 'Perez', 'juan@mail.com', '555-01', 25),
('C02', 'Maria', 'Lopez', 'maria@mail.com', '555-02', 30),
('C03', 'Carlos', 'Mendoza', 'carlos@mail.com', '555-03', 45),
('C04', 'Ana', 'Gomez', 'ana@mail.com', '555-04', 22),
('C05', 'Luis', 'Torres', 'luis@mail.com', '555-05', 35),
('C06', 'Sofia', 'Ruiz', 'sofia@mail.com', '555-06', 28),
('C07', 'Pedro', 'Castro', 'pedro@mail.com', '555-07', 50),
('C08', 'Lucia', 'Silva', 'lucia@mail.com', '555-08', 19),
('C09', 'Jorge', 'Rios', 'jorge@mail.com', '555-09', 40),
('C10', 'Elena', 'Mejia', 'elena@mail.com', '555-10', 33),
('C11', 'Miguel', 'Diaz', 'miguel@mail.com', '555-11', 27),
('C12', 'Laura', 'Vega', 'laura@mail.com', '555-12', 29),
('C13', 'David', 'Soto', 'david@mail.com', '555-13', 31),
('C14', 'Carmen', 'Luna', 'carmen@mail.com', '555-14', 42),
('C15', 'Raul', 'Cruz', 'raul@mail.com', '555-15', 38),
('C16', 'Silvia', 'Pena', 'silvia@mail.com', '555-16', 24),
('C17', 'Andres', 'Flores', 'andres@mail.com', '555-17', 48),
('C18', 'Isabel', 'Morales', 'isabel@mail.com', '555-18', 26),
('C19', 'Francisco', 'Herrera', 'fran@mail.com', '555-19', 55),
('C20', 'Adriana', 'Nunez', 'adri@mail.com', '555-20', 23)

-- Registrar 50 ventas
insert into TVenta (nClienteID, dFechaVenta, nMontoTotal, cMetodoPago) values
(1, '2026-01-05', 150.00, 'Tarjeta'), (1, '2026-01-20', 45.50, 'Efectivo'),
(2, '2026-01-12', 300.00, 'Tarjeta'), (2, '2026-02-14', 120.00, 'Transferencia'),
(3, '2026-02-18', 500.00, 'Tarjeta'), (3, '2026-03-01', 250.00, 'Tarjeta'),
(4, '2026-03-05', 35.00, 'Efectivo'),  (4, '2026-03-15', 60.00, 'Efectivo'),
(5, '2026-03-22', 850.00, 'Transferencia'), (5, '2026-04-10', 150.00, 'Tarjeta'),
(6, '2026-04-12', 90.00, 'Efectivo'),  (6, '2026-04-25', 110.00, 'Tarjeta'),
(7, '2026-04-30', 1200.00, 'Transferencia'),(7, '2026-05-02', 400.00, 'Tarjeta'),
(8, '2026-05-05', 25.00, 'Efectivo'),  (8, '2026-05-12', 75.00, 'Efectivo'),
(9, '2026-05-18', 450.00, 'Tarjeta'), (9, '2026-05-25', 310.00, 'Transferencia'),
(10, '2026-06-01', 180.00, 'Tarjeta'),(10, '2026-06-05', 95.00, 'Efectivo'),
(11, '2026-01-15', 210.00, 'Tarjeta'),(11, '2026-02-20', 85.00, 'Efectivo'),
(12, '2026-02-25', 130.00, 'Tarjeta'),(12, '2026-03-10', 320.00, 'Transferencia'),
(13, '2026-03-14', 55.00, 'Efectivo'), (13, '2026-04-02', 140.00, 'Tarjeta'),
(14, '2026-04-08', 620.00, 'Transferencia'),(14, '2026-05-12', 215.00, 'Tarjeta'),
(15, '2026-05-15', 99.99, 'Efectivo'), (15, '2026-05-22', 180.00, 'Tarjeta'),
(16, '2026-05-28', 45.00, 'Efectivo'), (16, '2026-06-02', 65.00, 'Efectivo'),
(17, '2026-01-10', 750.00, 'Transferencia'),(17, '2026-03-20', 340.00, 'Tarjeta'),
(18, '2026-04-15', 115.00, 'Tarjeta'),(18, '2026-05-01', 90.00, 'Efectivo'),
(1, '2026-02-10', 85.00, 'Efectivo'),  (2, '2026-03-25', 410.00, 'Tarjeta'),
(3, '2026-04-05', 150.00, 'Efectivo'), (5, '2026-05-10', 230.00, 'Tarjeta'),
(7, '2026-05-20', 95.00, 'Efectivo'),  (9, '2026-06-02', 500.00, 'Transferencia'),
(11, '2026-03-18', 125.00, 'Tarjeta'),(12, '2026-04-22', 70.00, 'Efectivo'),
(14, '2026-05-29', 310.00, 'Tarjeta'), (17, '2026-06-04', 120.00, 'Efectivo'),
(2, '2026-05-11', 60.00, 'Efectivo'),  (5, '2026-06-01', 450.00, 'Transferencia'),
(7, '2026-06-03', 180.00, 'Tarjeta'), (9, '2026-06-06', 125.00, 'Efectivo')

-- Actualizar precios o montos de ventas según una condición
update TVenta set nMontoTotal = nMontoTotal * 1.05 where cMetodoPago = 'Tarjeta'

-- Eliminar clientes sin ventas
delete from TCliente where nClienteID not in (select distinct nClienteID from TVenta)

-- Consultar los 5 clientes con mayores compras
select top 5 C.nClienteID, C.cNombre, C.cApellido, sum(V.nMontoTotal) as TotalComprado from TCliente C
inner join TVenta V on C.nClienteID = V.nClienteID
group by C.nClienteID, C.cNombre, C.cApellido
order by TotalComprado desc

-- Consultar ventas por mes
select month(dFechaVenta) as Mes, year(dFechaVenta) as Anio, count(nVentaID) as CantidadVentas, sum(nMontoTotal) as TotalVendido from TVenta
group by month(dFechaVenta), year(dFechaVenta)
order by Anio, Mes

-- Consultar promedio de ventas por cliente
select C.cNombre, C.cApellido, avg(V.nMontoTotal) as PromedioPorCompra from TCliente C
inner join TVenta V on C.nClienteID = V.nClienteID
group by C.nClienteID, C.cNombre, C.cApellido

-- Generar un reporte consolidado utilizando JOIN entre tres tablas
select C.cNombre + ' ' + C.cApellido as NombreCliente, V.nMontoTotal, V.dFechaVenta, V.cMetodoPago
from TCliente C
inner join TVenta V on C.nClienteID = V.nClienteID