-- Do we need a payload column?
-- I dont think that we need an Id column... each should have it own from the request

CREATE TABLE IF NOT EXISTS "client" { 
    "clientId" VARCHAR (255) NOT NULL,
    "clientEmailEnabled" BOOLEAN NOT NULL DEFAULT (false),
    "clientSmsEnabled" BOOLEAN NOT NULL DEFAULT (false),
    "SMSMonthlyClientLimit" INTEGER NOT NULL,
    "address" VARCHAR (255),
    "city" VARCHAR (255),
    "region" VARCHAR (255),
    "active" BOOLEAN NOT NULL DEFAULT (false),
    "customClientLink1" VARCHAR (255),
    "customClientLink1DisplayName" VARCHAR (255),
    "customClientLink2" VARCHAR (255),
    "customClientLink2DisplayName" VARCHAR (255),
    "customClientLink3" VARCHAR (255),
    "customClientLink3DisplayName" VARCHAR (255),
    "vCompanyName" VARCHAR (255) NOT NULL,
    "customClientLink1ToolTip" VARCHAR (255),
    "customClientLink2ToolTip" VARCHAR (255),
    "customClientLink3ToolTip" VARCHAR (255) 
}

CREATE TABLE IF NOT EXISTS "asset" {
    "Id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "clientId" VARCHAR (255) NOT NULL,
    "name" VARCHAR (255) NOT NULL,
  	"make" VARCHAR (255) NOT NULL,
 	"color" VARCHAR (255) NOT NULL,
  	"model" VARCHAR (255) NOT NULL,
  	"assetTypeId" INTEGER,
    "trackerType" VARCHAR (255),
    "status" BOOLEAN,
    "customId" VARCHAR (255),

    "ownerId" INTEGER,
    "asset_owner_name" VARCHAR (255),
    "asset_owner_phone_number" VARCHAR (255),
    "asset_reg_number" VARCHAR (255),
    "asset_chasis_number" VARCHAR (255),
    "asset_fuel_type" VARCHAR (255),
    "asset_engine_size" INTEGER,
    "fitting_company_name" VARCHAR (255),
    "fitting_company_phone_number" VARCHAR (255),
    "fitting_company_email_address" VARCHAR (255),
    "fitting_company_no" VARCHAR (255),
    "fitting_date" TIMESTAMP,
    "fitting_location" VARCHAR (255),
    "fitting_certificate_number" VARCHAR (255),
    "fitter_name" VARCHAR (255),
    "fitter_id" VARCHAR (255),
    "fitter_phone_number" VARCHAR (255),
    "owner_gender" VARCHAR (255),
    "year" INTEGER,
    "engine_no" INTEGER,
    "vin" VARCHAR (255),
    "no_of_tyres" VARCHAR (255),
    "tyre_size" VARCHAR (255),
    "cargo_capacity" VARCHAR (255),
    "asset_type" VARCHAR (255),
    "no_of_pessengers" INTEGER,
    "fuel_type" VARCHAR (255),
    "fuel_grade" VARCHAR (255),
    "tank_capacity" FLOAT,
    "fuel_consumption" FLOAT,
    "insurance_policy_no" VARCHAR (255),
    "insurance_expiry_date" TIMESTAMP,
    "insurance_policy_no_two" VARCHAR (255),
    "insurance_expiry_date_two" TIMESTAMP,
    "purchase_date" TIMESTAMP,
    "purchase_notes" VARCHAR (255),
    "selling_date" TIMESTAMP,
    "selling_notes" VARCHAR (255),
    "license_renewal_date" TIMESTAMP,
    "co2_emmission_per_km" FLOAT
}

CREATE TABLE IF NOT EXISTS "device" {
    "Id" UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
    "type" VARCHAR (255) NOT NULL,
    "hardwareName" VARCHAR (255) NOT NULL,
    "clientId" VARCHAR (255),
  	"imeiNumber" INTEGER,
    "tagNo" VARCHAR (255) 
   	"description" VARCHAR (255),
  	"serialNumber" VARCHAR (255),
  	"deviceType" VARCHAR (255),
  	"assetId" VARCHAR (255),
  	"simCardId" VARCHAR (255)    
}

CREATE TABLE IF NOT EXISTS "assignAsset" {
    "Id" UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
    "clientId" VARCHAR (255),
	"deviceId" VARCHAR (255),
  	"assetId" VARCHAR (255)
}

CREATE TABLE IF NOT EXISTS "simcard" {
    "simCardId" VARCHAR (255),
    "clientId" VARCHAR (255),
	"gsmNo" VARCHAR (255),
	"simSerial" VARCHAR (255),
	"simDesc" VARCHAR (255),
	"netProvider" VARCHAR (255),
	"PUK1" VARCHAR (255),
	"PUK2" VARCHAR (255),
	"PIN1" VARCHAR (255),
	"PIN2" VARCHAR (255),
}

CREATE TABLE IF NOT EXISTS "user" {
    "Id" UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- This may need to be a VARCHAR
    -- "userId" VARCHAR (255) NOT NULL, -- Not sure if this will be needed.. This could just be the uuid?
    "name" VARCHAR (255) NOT NULL,
    "mobile" VARCHAR (200),
    "email" VARCHAR (255) NOT NULL,
    "password" VARCHAR (255) NOT NULL,
    "parent" VARCHAR (255) NOT NULL,
    "type" VARCHAR (255) NOT NULL,
    "timeZoneId" VARCHAR (255) NOT NULL,
    "roleId" VARCHAR (255) NOT NULL,
    "status" BOOLEAN DEFAULT (false)
}

CREATE TABLE IF NOT EXISTS "custom_fields" {}
