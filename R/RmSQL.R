.First.lib <- function(lib, pkg)
{
	library.dynam(pkg, lib.loc = lib);
}

msqlGetErrMsg <- function()
{
	erg <- .C("RgetErrMsg", err = as.character(c("e")), PACKAGE="RmSQL");
	return(erg$err);
}

msqlConnect <- function(host)
{
	erg <- .C("RmsqlConnect", host, stat = as.integer(1),
                  PACKAGE="RmSQL");
	
	return(erg$stat)
};

msqlSelectDB <- function(sock, dbName)
{
	erg<-.C("RmsqlSelectDB", sock, dbName, stat = as.integer(1),
                PACKAGE="RmSQL");
	return(erg$stat);
};

msqlQuery <- function(sock, query)
{
	erg <- .C("RmsqlQuery", sock, query, stat = as.integer(1),
                  PACKAGE="RmSQL");
	return(erg$stat);
}

msqlStoreResult <- function()
{
	erg <- .C("RmsqlStoreResult", PACKAGE="RmSQL");
}

msqlFetchRow <- function()
{
	num <- msqlNumFields()$num;
	erg <- .C("RmsqlFetchRow", data = as.character(paste("D", 1:num, sep="")), num, stat =
                  as.integer(1), PACKAGE="RmSQL");
	return(erg);
}

msqlFreeResult <- function()
{
	.C("RmsqlFreeResult", PACKAGE="RmSQL");
}

msqlDataSeek <- function(pos)
{
	erg <- .C("RmsqlDataSeek", as.integer(pos), stat = as.integer(1),
                  PACKAGE="RmSQL");
	return(erg$stat);
}


msqlNumRows <- function()
{
	erg <- .C("RmsqlNumRows", num = as.integer(1), stat = as.integer(1),
                  PACKAGE="RmSQL");
	return(erg);
}

msqlFetchField <- function()
{
	erg <- .C("RmsqlFetchField", attr = as.character(c("name","table")), type = as.integer(1), stat =
                  as.integer(1), PACKAGE="RmSQL");
	
	#	name: 	attribute name
	#	table: 	name of table
	#	type:	1 	int
	#		2	char
	#		3	double
	#		6	text
	#		7	date

	return(erg);
}

msqlFieldSeek <- function(pos)
{
	erg <- .C("RmsqlFieldSeek", as.integer(pos), stat = as.integer(1),
                  PACKAGE="RmSQL");
	return(erg$stat);
}

msqlNumFields <- function()
{
	erg <- .C("RmsqlNumFields", num = as.integer(1), stat =
                  as.integer(1), PACKAGE="RmSQL");
	return(erg);
}

msqlListDBs <- function(sock)
{
	erg <- .C("RmsqlListDBs", sock, PACKAGE="RmSQL");
}

msqlListTables <- function(sock)
{
	erg <- .C("RmsqlListTables", sock, PACKAGE="RmSQL");
}

msqlListFields <- function(sock, tableName)
{
	erg <- .C("RmsqlListFields", sock, tableName, PACKAGE="RmSQL");
}

msqlListIndex <- function(sock, tableName, index)
{
	erg <- .C("RmsqlListIndex", sock, tableName, index, PACKAGE="RmSQL");
}

msqlClose <- function(sock)
{
	.C("RmsqlClose", sock, PACKAGE="RmSQL");
}

