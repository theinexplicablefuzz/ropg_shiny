
makeRandomString <- function(n=1, length=8) {
  randomString <- c(1:n)                  # initialize vector
  for (i in 1:n) {
    randomString[i] <- paste(sample(c(0:9, letters, LETTERS),
                                    length, replace=TRUE),
                             collapse="")
  }
  return(randomString)
} # create length 8 random string for verification

loginTest <- function(email_input, password){
  testvector <- transpose(as.data.table(c(email_input, password)))
  if(NROW(merge(testvector,
                accounts,
                by.x = c("V1", "V2"),
                by.y = c("email", "password")))==1){
    return(TRUE)
  } else {
    return(FALSE)
  }
} # compare input credentials against account and password

