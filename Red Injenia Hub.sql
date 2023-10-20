#create database redInjenia;

#use redInjenia;

-- Crear la base de datos
CREATE DATABASE EcosistemaInnovacionFacultad;

-- Usar la base de datos
USE EcosistemaInnovacionFacultad;


-- Crear una tabla para almacenar información de los miembros
CREATE TABLE Miembros (
    MiembroID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    CorreoElectronico VARCHAR(255),
    Rol VARCHAR(255), -- Estudiante, Profesor, Mentor, etc.
    Estado VARCHAR(255), -- Busco apoyar poryectos, busco ser parte de un proyecto, tengo una idea, etc
    Carrera VARCHAR(255), -- Solo si Rol = Estudiante
    AñoIngreso INT, -- Solo si Rol = Estudiante
    OtraInformacion TEXT
);

-- Crear una tabla para almacenar información de proyectos
CREATE TABLE Proyectos (
    ProyectoID INT PRIMARY KEY AUTO_INCREMENT,
    NombreProyecto VARCHAR(255),
    Descripcion TEXT,
    Estado VARCHAR(50), -- En curso, Completado, etc.
    FechaInicio DATE,
    FechaFin DATE,
    ResponsableID INT -- Clave foránea para el miembro responsable
);


-- Crear una tabla para almacenar relaciones entre miembros y proyectos
CREATE TABLE MiembrosProyectos (
    RelacionID INT PRIMARY KEY AUTO_INCREMENT,
    MiembroID INT,
    ProyectoID INT,
    FOREIGN KEY ( MiembroID ) REFERENCES Miembros (MiembroID),  -- Clave foránea para el miembro
    FOREIGN KEY ( ProyectoID ) REFERENCES Proyectos (ProyectoID) -- Clave foránea para el proyecto
);

-- Otras tablas que puedas necesitar, como entidades de apoyo, actividades, etc.

-- Ejemplo de una tabla para entidades de apoyo
CREATE TABLE EntidadesApoyo (
    EntidadID INT PRIMARY KEY AUTO_INCREMENT,
    NombreEntidad VARCHAR(255),
    Descripcion TEXT,
    Contacto VARCHAR(255)
);



-- Tabla para definir que proyecto está siendo apoyado en que entidad
CREATE TABLE ApoyoProyectosEntes (
    ApoyoID INT PRIMARY KEY AUTO_INCREMENT,
    EntidadID INT, -- Clave foránea para la enitdad
    ProyectoID INT, -- Clave foránea para el proyecto

    FOREIGN KEY ( EntidadID ) REFERENCES EntidadesApoyo (EntidadID),  -- Clave foránea para el miembro
    FOREIGN KEY ( ProyectoID ) REFERENCES Proyectos (ProyectoID) -- Clave foránea para el proyecto

);

-- Tabla para definir que proyecto está siendo apoyado en que entidad
CREATE TABLE ApoyoProyectosMiembros (
    ApoyoID INT PRIMARY KEY AUTO_INCREMENT,

    ProyectoID INT, -- Clave foránea para el proyecto
    MiembroID INT, -- Clave foránea para el miembro
    -- Clave foránea para el miembro
    FOREIGN KEY ( ProyectoID ) REFERENCES Proyectos (ProyectoID), -- Clave foránea para el proyecto
    FOREIGN KEY ( MiembroID ) REFERENCES Miembros (MiembroID)
);

-- Tabla para definir quienes son parte de entes de apoyo
CREATE TABLE MiembrosEntidades (
    MimebrosEntidadesID INT PRIMARY KEY AUTO_INCREMENT,
    EntidadID INT, -- Clave foránea para la entidad
    MiembroID INT, -- Clave foránea para el miembro
    FOREIGN KEY ( EntidadID ) REFERENCES EntidadesApoyo (EntidadID),  -- Clave foránea para el miembro
     FOREIGN KEY ( MiembroID ) REFERENCES Miembros (MiembroID)  -- Clave foránea para el miembro
);







