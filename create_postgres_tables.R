# Use this script to destroy/recreate db tables if needed

pacman::p_load(RPostgreSQL)
source("config.R")

# use config file to create postgres connection
get_config <- configure()
con <- dbConnect(drv = "PostgreSQL",
                 dbname=unname(get_config["esql_db"]),
                 host=sub(" .*","",unname(get_config["esql_server"])),
                 port=sub("/.*","",sub(".*\\.com.","",unname(get_config["esql_url"]))),
                 user=unname(get_config["esql_db"]),
                 password=unname(get_config["esql_password"]))

buildRpgDBs <- function(con) {
  dbGetQuery(con,"
  CREATE TABLE IF NOT EXISTS accounts (
             id SERIAL UNIQUE PRIMARY KEY,
             email TEXT NOT NULL UNIQUE,
             password TEXT
  )")
  dbGetQuery(con,"
  CREATE TABLE IF NOT EXISTS campaigns (
             id SERIAL UNIQUE,
             campaign VARCHAR(30),
             account_id INTEGER REFERENCES accounts(id),
             verification CHAR(8),
             PRIMARY KEY (id,account_id)
  )")
  dbGetQuery(con,"
             CREATE TABLE IF NOT EXISTS characters (
             id SERIAL UNIQUE,
             character VARCHAR(25),
             account_id INTEGER REFERENCES accounts(id),
             campaign_id INTEGER REFERENCES campaigns(id),
             data JSON,
             PRIMARY KEY (id,account_id)
             )")
  } # create database tables
dbRowInsert <- function(con, table, named_vector) {
  dbGetQuery(con, paste0("INSERT INTO ", table," (",gsub("'",'',paste(shQuote(names(named_vector)), collapse = ", "))
                         ,") VALUES (",paste(shQuote(named_vector), collapse = ", ")
                         ,")"))
} # add row to database
createTestData <- function(con) {
  for (i in 1:5) {
    dbRowInsert(con,
                "accounts",
                c(email = paste0("testuser",i,"@testmail.com"), password = paste0("userpass",i))
                )
    } # Populate accounts table with test data
  # Populate campaigns table with test data
  # Populate characters table with test data
  } 

buildRpgDBs(con)
createTestData(con)
dbDisconnect(con) # disconnect from postgresql
