# ROPG Shiny
ROPG Shiny is shiny application for creating and managing characters for the Ruins of Past Glory role-playing game.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
There are a few things you'll need:

  1. A working laptop with wifi
  2. A recent version of R and RStudio. To learn more, see [Getting Started with R](https://support.rstudio.com/hc/en-us/articles/201141096-Getting-Started-with-R)


### Deployment
There are three ways to run the this app.
 
```R
# Easiest way is to use runGithub
shiny::runGitHub("ropg_shiny", "theinexplicablefuzz")

# Run a tar or zip file directly
shiny::runUrl("https://github.com/theinexplicablefuzz/ropg_shiny/archive/master.tar.gz")
shiny::runUrl("https://github.com/theinexplicablefuzz/ropg_shiny/archive/master.zip"))
```

Or you can clone the git repository, then use `runApp()`:
```R
# First clone the repository with git. If you have cloned it into
# ~/ropg_shiny, first go to that directory, then use runApp().
setwd("~/ropg_shiny")
runApp()
```
