-- creating database
CREATE DATABASE IF NOT EXISTS ECOM_DATA;

-- creating schema
CREATE SCHEMA IF NOT EXISTS ECOM_SCHEMA;

-- creating table
CREATE TABLE IF NOT EXISTS ECOM_DATA.ECOM_SCHEMA.comprehensive_user_table (
    Country VARCHAR(255) NULL,
    Users_productsSold VARCHAR(255) NULL,
    Users_productsWished VARCHAR(255) NULL,
    Users_account_age_years DOUBLE NULL,
    Users_account_age_group VARCHAR(255) NULL,
    Users_hasanyapp BOOLEAN NULL,
    Users_socialnbfollowers INT NULL,
    Users_flag_long_title BOOLEAN NULL,
    Countries_Sellers INT NULL,
    Countries_TopSellers INT NULL,
    Countries_FemaleSellers INT NULL,
    Countries_MaleSellers INT NULL,
    Countries_TopFemaleSellers INT NULL,
    Countries_TopMaleSellers INT NULL,
    Buyers_Total INT NULL,
    Buyers_Top INT NULL,
    Buyers_Female INT NULL,
    Buyers_Male INT NULL,
    Buyers_TopFemale INT NULL,
    Buyers_TopMale INT NULL,
    Sellers_Total INT NULL,
    Sellers_Sex VARCHAR(255) NULL,
    Sellers_MeanProductsSold DECIMAL(10,2) NULL,
    Sellers_MeanProductsListed DECIMAL(10,2) NULL
);

-- creating storage integration
CREATE OR REPLACE STORAGE INTEGRATION ecom_storage_integration_obj
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'AZURE'
  ENABLED = TRUE
  AZURE_TENANT_ID = ''
  STORAGE_ALLOWED_LOCATIONS = ('azure://ecomstorageidenitifier.blob.core.windows.net/ecomstoragecontainer/processed_data/processed/')

-- information about storage integration
DESC STORAGE INTEGRATION ecom_storage_integration_obj;

--creating file format
CREATE OR REPLACE FILE FORMAT ECOM_DATA.ECOM_SCHEMA.CSV_FORMAT
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    FIELD_DELIMITER = ','
    RECORD_DELIMITER = '\n';

-- creating stage
CREATE OR REPLACE STAGE ECOM_DATA.ECOM_SCHEMA.my_delta_stage
    STORAGE_INTEGRATION = ecom_storage_integration_obj
    URL = 'azure://ecomstorageidenitifier.blob.core.windows.net/ecomstoragecontainer/processed_data/processed/';

-- listing stage files
LIST @ECOM_DATA.ECOM_SCHEMA.my_delta_stage;

-- loading data into snowflake table
COPY INTO ECOM_DATA.ECOM_SCHEMA.comprehensive_user_table
    FROM @ECOM_DATA.ECOM_SCHEMA.my_delta_stage
    FILE_FORMAT = ECOM_DATA.ECOM_SCHEMA.CSV_FORMAT;

-- selecting records
SELECT count(*) FROM ECOM_DATA.ECOM_SCHEMA.comprehensive_user_table;
