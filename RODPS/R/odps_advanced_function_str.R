##############################################
#'data.frame':   1000 obs. of  2 variables:
# $ x: int  1 2 3 4 5 6 7 8 9 10 ...
# $ y: int  1 2 3 4 5 6 7 8 9 10 ...
###############################################
str.rodps.data <- function( rd )
{
  rodps.str( rd@tbl )
}

rodps.str <- function( tbl )
{
  obs <- rodps.table.rows( tbl )
  des <- rodps.table.desc( tbl )
  vars<- nrow(des$columns)

  #load 10 records to display
  sql <- sprintf(" select * from %s limit 10;", tbl)
  d <- rodps.sql( sql )

  cat(sprintf("'rodps.data':\t%d obs. of %d variables:\n",obs,vars))
  for (i in seq(1:length( d ))){
    if( class(names(d)[i]) == "character"){
      rows <- min( obs, 4)
    }
    else{
      rows <- min( obs, 10)
    }
    cat(sprintf(" $ %s: %s  %s",format(names(d)[i], width=max(nchar(names(d)))),
                                format(class(d[,i]), width=max(nchar(sapply(df,'class')))),
                                paste(d[,i][1: rows],collapse=" ")))
    if( obs > 10){
      cat(' ... \n')
    }
    else{
      cat('\n')
    }
  }
}
