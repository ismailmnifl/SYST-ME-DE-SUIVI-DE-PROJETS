-- Database: SYSTEME_DE_SUIVI_DE_PROJETS

-- DROP DATABASE IF EXISTS "SYSTEME_DE_SUIVI_DE_PROJETS";

CREATE DATABASE "SYSTEME_DE_SUIVI_DE_PROJETS"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'French_France.1252'
    LC_CTYPE = 'French_France.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

/* droits table anable me to assign diffrent privilages to the roles table*/
CREATE TABLE IF NOT EXISTS Droits (
	
	index_droits serial PRIMARY KEY,
	libelle varchar(50) NOT NULL UNIQUE,
	description varchar(255)
);
/*roles table contains all the roles for eache user in the systeme*/
create table IF NOT EXISTS roles (
	
	index_role serial PRIMARY KEY,
	libelle varchar(50) NOT NULL UNIQUE,
	description varchar(255),
	index_droits integer not NULL,
	FOREIGN KEY (index_droits) REFERENCES droits (index_droits) ON DELETE CASCADE
);
/*table users contains all the humain antities that uses the systeme */
CREATE TABLE IF NOT EXISTS Utilisateur (
	
	code serial PRIMARY KEY,
	nom VARCHAR ( 50 ) NOT NULL,
	prenom VARCHAR ( 50 ) NOT NULL,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL,
	nom_du_contact VARCHAR (50),
	telephone VARCHAR ( 50 ),
	created_on TIMESTAMP NOT NULL,
	index_role INT NOT NULL,
	FOREIGN KEY (index_role) REFERENCES roles (index_role)
);
/*table project contains all the old and the existing project in the systeme*/
CREATE TABLE IF NOT EXISTS project (
	
	code serial PRIMARY KEY,
	description varchar(255) NOT NULL,
	organisme_client varchar(255) NOT NULL,
	date_de_debut DATE NOT NULL,
	date_de_fin DATE NOT NULL,
	montant FLOAT
);
/*table phase */
CREATE TABLE IF NOT EXISTS Phase (
	
	code serial PRIMARY KEY,
	libelle varchar(255) NOT NULL,
	description varchar(255) NOT NULL,
	organisme_client varchar(255) NOT NULL,
	date_de_debut DATE NOT NULL,
	date_de_fin DATE NOT NULL,
	montant_de_phase FLOAT NOT NULL,
	etat_de_realisation BOOLEAN NOT NULL DEFAULT FALSE,
	etat_de_facture  BOOLEAN NOT NULL DEFAULT FALSE,
	etat_de_paiement BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE IF NOT EXISTS Documents (
	
	index_document serial PRIMARY KEY,
	referance varchar(255) NOT NULL UNIQUE,
	description varchar(255),
	lien varchar(255),
	phase_code integer default null,
	project_code integer default null,
	FOREIGN KEY (phase_code) REFERENCES Phase (code) ON DELETE CASCADE,
	FOREIGN KEY (project_code) REFERENCES project (code) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Livrable (
	
	code serial PRIMARY KEY,
	libelle varchar(255) NOT NULL,
	description varchar(255) NOT NULL,
	matricule varchar(255) NOT NULL,
	nom_du_contact varchar(255) NOT NULL,
	project_code integer NOT NULL,
	FOREIGN KEY (project_code) REFERENCES project (code) ON DELETE CASCADE
);
