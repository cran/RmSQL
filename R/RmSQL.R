.First.lib <- function(lib, pkg)
{
	library.dynam(pkg, lib.loc = lib);
}

msqlGetErrMsg <- function()
{
	erg <- .C("RgetErrMsg", err = as.character(c("e")));
	return(erg$err);
}

msqlConnect <- function(host)
{
	erg <- .C("RmsqlConnect", host, stat = as.integer(1));
	
	return(erg$stat)
};

msqlSelectDB <- function(sock, dbName)
{
	erg<-.C("RmsqlSelectDB", sock, dbName, stat = as.integer(1));
	return(erg$stat);
};

msqlQuery <- function(sock, query)
{
	erg <- .C("RmsqlQuery", sock, query, stat = as.integer(1));
	return(erg$stat);
}

msqlStoreResult <- function()
{
	erg <- .C("RmsqlStoreResult");
}

msqlFetchRow <- function()
{
	num <- msqlNumFields()$num;
	erg <- .C("RmsqlFetchRow", data = as.character(paste("D", 1:num, sep="")), num, stat = as.integer(1));
	return(erg);
}

msqlFreeResult <- function()
{
	.C("RmsqlFreeResult");
}

msqlDataSeek <- function(pos)
{
	erg <- .C("RmsqlDataSeek", as.integer(pos), stat = as.integer(1));
	return(erg$stat);
}


msqlNumRows <- function()
{
	erg <- .C("RmsqlNumRows", num = as.integer(1), stat = as.integer(1));
	return(erg);
}

msqlFetchField <- function()
{
	erg <- .C("RmsqlFetchField", attr = as.character(c("name","table")), type = as.integer(1), stat = as.integer(1));
	
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
	erg <- .C("RmsqlFieldSeek", as.integer(pos), stat = as.integer(1));
	return(erg$stat);
}

msqlNumFields <- function()
{
	erg <- .C("RmsqlNumFields", num = as.integer(1), stat = as.integer(1));
	return(erg);
}

msqlListDBs <- function(sock)
{
	erg <- .C("RmsqlListDBs", sock);
}

msqlListTables <- function(sock)
{
	erg <- .C("RmsqlListTables", sock);
}

msqlListFields <- function(sock, tableName)
{
	erg <- .C("RmsqlListFields", sock, tableName);
}

msqlListIndex <- function(sock, tableName, index)
{
	erg <- .C("RmsqlListIndex", sock, tableName, index);
}

msqlClose <- function(sock)
{
	.C("RmsqlClose", sock);
}

