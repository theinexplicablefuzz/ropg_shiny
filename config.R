# this file is for managing keys for external sources

library(data.table)

# function to import config files as data table
read_config <- function (file) {
  dframe <- read.table(file=file,header=FALSE,
                       sep=' ')
  return(as.data.table(dframe))
}

configure <- function() {
  # load default config file to check required valuse
  config <- read_config("config_default.txt")
  
  # if config.R exists then merge with config_default.R to update new fields
  if(file.exists("config.txt")) {
    config_custom <- read_config("config.txt")
    config <- merge(config,config_custom, by = 'V1', all.x = TRUE)
    if(!is.null(config$V2.y)) {config <- config[,c(1,3)]}
  }
  # save updated output
  write.table(config,"config.txt", row.names = FALSE, col.names = FALSE)
  names(config) <- c("key", "value")
  
  # prompt the user for missing values
  for (i in config[is.na(value)]$key){
    return(stop(paste0("'",i,"'", " not found in config.txt. Please update your local config file")))
  }
  return(config)
}
