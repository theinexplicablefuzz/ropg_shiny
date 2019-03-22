
pacman::p_load(RPostgreSQL)
source("config.R")

get_config <- configure()

# db management functions
dbRowInsert <- function(table, named_vector) {
  dbGetQuery(con, paste0("INSERT INTO ", table," (",gsub("'",'',paste(shQuote(names(named_vector)), collapse = ", "))
                         ,") VALUES (",paste(shQuote(named_vector), collapse = ", ")
                         ,")"))
} # add row to database
dbRowUpdate <- function(table, key, named_vector){
  dbGetQuery(con, paste0("UPDATE ",table," (",gsub("'",'',paste(shQuote(names(named_vector)), collapse = ", "))
                         ,") VALUES (",paste(shQuote(named_vector), collapse = ", ")
                         ,")"))
} #modify database row

# use config file to create postgres connection
con <- dbConnect(drv = "PostgreSQL",
                 dbname=unname(get_config["esql_db"]),
                 host=sub(" .*","",unname(get_config["esql_server"])),
                 port=sub("/.*","",sub(".*\\.com.","",unname(get_config["esql_url"]))),
                 user=unname(get_config["esql_db"]),
                 password=unname(get_config["esql_password"]))

# pull down databases
accounts <<- as.data.table(dbGetQuery(con, "select * from accounts"))# create accounts dataset

dbDisconnect(con) # disconnect from postgresql
