-- set to auto-commit for create database statement to work
CREATE ROLE jgp WITH
    LOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    INHERIT
    NOREPLICATION
    CONNECTION LIMIT -1
    PASSWORD 'Spark<3Java';
CREATE DATABASE spark_labs
    WITH
    OWNER = jgp
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;