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

--Tablas de prueba
create table Pacientes.TablaTemporal (Id int, Created_at datetime, Updated_at datetime, Deleted_at datetime);
go
drop table Pacientes.TablaTemporal;
go

create table Personal.Auditoria (Id int, Created_at datetime, Updated_at datetime, Deleted_at datetime);
go
drop table Personal.Auditoria;
go

create table Personal.Logs (Id int, Created_at datetime, Updated_at datetime, Deleted_at datetime);
go
drop table Personal.Logs;
go

create table Farmacia.MedicamentosPrueba (Id int, Created_at datetime, Updated_at datetime, Deleted_at datetime);
go
drop table Farmacia.MedicamentosPrueba;
go

create table Pacientes.TablaPruebas (Id int, Created_at datetime, Updated_at datetime, Deleted_at datetime);
go
drop table Pacientes.TablaPruebas;
go

--Eliminar restricciones especificas
alter table Pacientes.Pacientes drop constraint CK_EdadPaciente
alter table Pacientes.Pacientes drop constraint UQ_CorreoPaciente
alter table Pacientes.Pacientes drop constraint FK_Medicamentos_Tratamientos
go

--Crear y eliminar una base de datos externas de pruebas
create database HospitalPruebaDB
go
drop database HospitalPruebaDB
go

--Insercion de datos
insert into Personal.Especialidades (Nombre_Especialidad) values
('Cardiologia'),
('Pediatria'),
('Dermatologia'),
('Ginecologia'),
('Medicina general')

insert into Personal.Medicos (Nombre_Medico, Correo_Medico, Salario, Id_Especialidad, Experiencia, Turno) values
('Dr. Juan Pérez', 'juan.perez@hospital.com', 2500.00, 1, 10, 'Mañana'),
('Dra. Maria Gomez', 'maria.gomez@hospital.com', 2800.00, 2, 8, 'Tarde'),
('Dr. Luis Castro', 'luis.castro@hospital.com', 2400.00, 3, 5, 'Mañana'),
('Dra. Ana Rios', 'ana.rios@hospital.com', 3000.00, 4, 12, 'Noche'),
('Dr. Carlos Vega', 'carlos.vega@hospital.com', 2000.00, 5, 4, 'Tarde'),
('Dr. José Torres', 'jose.torres@hospital.com', 2600.00, 1, 9, 'Noche'),
('Dra. Elena Mas', 'elena.mas@hospital.com', 2900.00, 2, 11, 'Mañana'),
('Dr. Pedro Ruiz', 'pedro.ruiz@hospital.com', 2100.00, 5, 3, 'Tarde'),
('Dra. Laura Soto', 'laura.soto@hospital.com', 3100.00, 4, 15, 'Mañana'),
('Dr. Jorge Luna', 'jorge.luna@hospital.com', 2300.00, 3, 6, 'Tarde')

insert into Pacientes.Pacientes (Nombre_Paciente, Correo_Paciente, Edad, Telefono, Direccion, Genero, Tipo_Sangre, Fecha_Nacimiento) values
('Carlos Lopez', 'carlos@mail.com', 30, '555-1234', 'Av. Central 123', 'M', 'O+', '1996-05-12'),
('Ana Martinez', 'ana@mail.com', 25, '555-5678', 'Calle Flores 45', 'F', 'A+', '2001-08-22'),
('Luis Rodriguez', 'luis@mail.com', 45, '555-9012', 'Plaza Mayor 8', 'M', 'O-', '1981-01-30'),
('Sofia Repetto', 'sofia@mail.com', 12, '555-3456', 'Av. Sol 890', 'F', 'B+', '2014-03-15'),
('Miguel Angel', 'miguel@mail.com', 60, '555-7890', 'Jr. Trujillo 412', 'M', 'AB+', '1966-11-04'),
('Lucia Diaz', 'lucia@mail.com', 34, '555-2345', 'Urb. Las Girasoles', 'F', 'O+', '1992-07-19'),
('Diego Tello', 'diego@mail.com', 28, '555-6789', 'Calle Real 102', 'M', 'A-', '1998-10-25'),
('Elena Silva', 'elena@mail.com', 50, '555-0123', 'Av. Pardo 555', 'F', 'B-', '1976-04-02'),
('Javier Saenz', 'javier@mail.com', 19, '555-4567', 'Calle Lima 234', 'M', 'O+', '2007-12-12'),
('Valeria Cruz', 'valeria@mail.com', 41, '555-8901', 'Av. Larco 789', 'F', 'A+', '1985-09-05'),
('Andres Alba', 'andres@mail.com', 67, '555-1122', 'Pasaje Olaya 11', 'M', 'O+', '1959-02-14'),
('Carmen Ruiz', 'carmen@mail.com', 31, '555-3344', 'Av. Brasil 1420', 'F', 'AB-', '1995-06-21'),
('Roberto Arce', 'roberto@mail.com', 55, '555-5566', 'Calle Ica 303', 'M', 'B+', '1971-03-17'),
('Martha Ortiz', 'martha@mail.com', 8, '555-7788', 'Jr. Junin 980', 'F', 'O+', '2018-10-10'),
('Raul Peña', 'raul@mail.com', 23, '555-9900', 'Av. Grau 456', 'M', 'A+', '2003-05-29'),
('Patricia Paz', 'patricia@mail.com', 37, '555-2233', 'Calle Colon 112', 'F', 'O-', '1989-11-12'),
('Fernando Cas', 'fernando@mail.com', 48, '555-4455', 'Av. Ejercito 731', 'M', 'O+', '1978-08-08'),
('Isabel Vega', 'isabel@mail.com', 29, '555-6677', 'Urb. San Andrés', 'F', 'A+', '1997-01-24'),
('Hugo Mendoza', 'hugo@mail.com', 62, '555-8899', 'Calle San Jose 55', 'M', 'B+', '1964-07-07'),
('Gabriela Rodriguez', 'gabriela@mail.com', 26, '555-0011', 'Av. Primavera 90', 'F', 'O+', '2000-12-30')

insert into Atencion.Citas (Id_Paciente, Id_Medico, Fecha_Cita, Estado, Costo_Consulta) values
(1, 1, '2026-06-04 08:30:00', 'Atendido', 50.00),
(2, 2, '2026-06-04 09:15:00', 'Atendido', 60.00),
(3, 5, '2026-06-04 10:00:00', 'Pendiente', 40.00),
(4, 2, '2026-06-05 11:00:00', 'Pendiente', 60.00),
(5, 4, '2026-06-06 16:00:00', 'Pendiente', 70.00),
(6, 3, '2026-06-04 14:00:00', 'Pendiente', 50.00),
(7, 1, '2026-06-07 09:00:00', 'Pendiente', 50.00),
(8, 6, '2026-06-04 15:30:00', 'Cancelada', 55.00),
(9, 8, '2026-06-08 10:30:00', 'Pendiente', 40.00),
(10, 9, '2026-06-04 11:30:00', 'Pendiente', 80.00),
(11, 7, '2026-06-09 08:00:00', 'Pendiente', 65.00),
(12, 10, '2026-06-10 12:00:00', 'Pendiente', 50.00),
(13, 5, '2026-06-04 17:00:00', 'Pendiente', 40.00),
(14, 2, '2026-06-11 15:00:00', 'Pendiente', 60.00),
(15, 4, '2026-06-12 10:00:00', 'Cancelada', 70.00)

insert into Pacientes.Habitaciones (Numero_Habitacion, Id_Paciente, Disponibilidad) values
('101', 1, 'Ocupada'),
('102', 2, 'Ocupada'),
('103', NULL, 'Disponible'),
('104', 3, 'Ocupada'),
('105', NULL, 'Disponible'),
('201', NULL, 'Disponible'),
('202', 5, 'Ocupada'),
('203', NULL, 'Disponible'),
('204', NULL, 'Disponible'),
('205', NULL, 'Disponible')

insert into Farmacia.Tratamientos (Descripcion, Id_Paciente) values
('Tratamiento Hipertensión - Activo', 1),
('Control de Asma - Activo', 4),
('Rehabilitación Cardíaca - Finalizado', 5),
('Terapia Dermatológica - Activo', 3),
('Control Prenatal - Activo', 12),
('Tratamiento Diabetes - Activo', 11),
('Recuperación Quirúrgica - Finalizado', 2),
('Tratamiento Antibiótico - Activo', 6),
('Fisioterapia Lumbar - Activo', 13),
('Chequeo General - Finalizado', 20)

--Re-vincular restriccion de medicamentos
alter table Farmacia.Medicamentos add constraint FK_Medicamentos_Tratamientos 
foreign key (Id_Tratamiento) references Farmacia.Tratamientos(Id_Tratamiento)
go

insert into Farmacia.Medicamentos (Nombre_Medicamento, Id_Tratamiento) values
('Losartán', 1), 
('Amlodipino', 1), 
('Salbutamol', 2), 
('Fluticasona', 2),
('Metformina', 6), 
('Insulina', 6), 
('Amoxicilina', 8), 
('Ibuprofeno', 7),
('Paracetamol', 10), 
('Omeprazol', 3), 
('Atorvastatina', 3), 
('Clindamicina', 4),
('Betametasona', 4), 
('Ácido Fólico', 5), 
('Hierro', 5), 
('Diclofenaco', 9),
('Complejo B', 9), 
('Cetirizina', 10), 
('Losartán Potásico', 1), 
('Enalapril', 1)
