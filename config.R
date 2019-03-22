# this file is for managing keys for external sources

library(data.table)

# function to import config files as data table.
read_config <- function (file) {
  dframe <- read.table(file=file,header=FALSE,
                       sep=' ',
                       stringsAsFactors = FALSE)
  return(as.data.table(dframe))
}

# the configure function loads secret details from config.txt.
# If there is no config.txt file, it creates one using fields from config default
# and directs the user to fill in missing fields
# depends on 'read_config' function above
configure <- function() {
  
  # load default config
  config <- read_config("config_default.txt")
  
  # check if config.R exists then merge with config_default.R to update new fields
  if(file.exists("config.txt")) {
    config_custom <- read_config("config.txt")
    config <- merge(config,config_custom, by = 'V1', all.x = TRUE)
    if(!is.null(config$V2.y)) {config <- config[,c(1,3)]}
  }
  # save updated output to 'config.txt'
  write.table(config,"config.txt", row.names = FALSE, col.names = FALSE)
  names(config) <- c("key", "value")
  
  # prompt the user for missing fields
  for (i in config[is.na(value)]$key){
    return(stop(paste0("'",i,"'", " not found in config.txt. Please update your local config file")))
  }
  output_vector <- config$value
  names(output_vector) <- config$key
  
  return(output_vector)
}
