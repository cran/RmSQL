\name{RmSQL}
\alias{msqlConnect}
\alias{msqlSelectDB}
\alias{msqlQuery}
\alias{msqlStoreResult}
\alias{msqlFetchRow}
\alias{msqlFreeResult}
\alias{msqlDataSeek}
\alias{msqlNumRows}
\alias{msqlFetchField}
\alias{msqlFieldSeek}
\alias{msqlNumFields}
\alias{msqlClose}
\alias{msqlGetErrMsg}
\alias{msqlListDBs}
\alias{msqlListTables}
\alias{msqlListFields}
\alias{msqlListIndex}
\title{Accessing mSQL2.0 databases from R}
\usage{
msqlConnect(host)
msqlSelectDB(sock, dbName)
msqlQuery(sock, query)
msqlStoreResult()
msqlFetchRow()
msqlFreeResult()
msqlDataSeek(pos)
msqlNumRows()
msqlFetchField()
msqlFieldSeek(pos)
msqlNumFields()
msqlClose(sock)
msqlGetErrMsg()
msqlListDBs(sock)
msqlListTables(sock)
msqlListFields(sock, tableName)
msqlListIndex(sock, tableName, index)
}
\arguments{
  \item{host}{Hostname of the database server}
  \item{sock}{connection handle returned by msqlConnect(host)}
  \item{query}{a SQL statement}
  \item{dbName}{Name of the database to access}
  \item{pos}{a position number when fetching a row or field}
}
\description{	
    \code{RmSQL} implements a low-level interface between \R and mSQL 2.0 by
    Hughes Technologies. mSQL is a relational database management system.
    With \code{RmSQL}, the power of SQL is available within \R. The mSQL
    homepage is available under \url{http://www.Hughes.com.au}.
}
\details{
\code{msqlConnect(host)} establishes a connection to the msql2d at
\code{host}. It returns a integer, which is used as handle if no error
occurred, -1 otherwise.

\code{msqlSelectDB(sock, dbName)} selects the database \code{dbName} and
requires the handle \code{sock}, returned by \code{msqlConnect(host)}. 

\code{msqlQuery(sock, query)} sends the SQL statement \code{query} to the
msql2d, using connection \code{sock}, returned by \code{msqlConnect(host)}.
A integer containing the number of available rows is returned, -1 is
returned if an error occurred. NOTE: query not only means SELECT statements
but also UPDATE, CREATE TABLE, DELETE etc. 

\code{msqlStoreResult()} stores data returned by a SELECT query. This must
be done before accessing returned data (e.g. by \code{msqlFetchRow()}.
Nothing is returned. 

\code{msqlFetchRow()} returns the next available row (next row after current
cursor position) of data as character vector and an integer indicating an error by -1.
Remember to call \code{msqlFreeResult()} when the data is no longer needed.

\code{msqlFreeResult()}: When data is no longer needed, free the memory.

\code{msqlDataSeek(pos)} set the cursor to row number \code{pos}. Returns an
integer, which is -1 if an error occurred.

\code{msqlNumRows()} returns the number of rows available and an integer,
which is -1 if an error occurred (e.g. no data available).

\code{msqlFetchField()} returns the field name, table name, type of field as
integer and an integer indicating an error by the value -1.

name: 	attribute name \cr
table: 	name of table \cr
type: \cr
	1 	int \cr
	2	char \cr
	3	double \cr
	6	text \cr
	7	date \cr

\code{msqlFieldSeek(pos)} same as \code{msqlDataSeek(pos)} with fields.

\code{msqlNumFields()} same as \code{msqlNumRows()} with fields.

\code{msqlClose(sock)} closes the connection opened by
\code{msqlConnect(host)}. Nothing is returned.

\code{msqlGetErrMsg()} returns a character string with the error message, if
an error occurred.

The following functions are related to database and relation schemes.

\code{msqlListDB(sock)} lists all currently known databases at \code{host}.
Results can be read by the \code{msqlFetchRow()} mechanism. 

\code{msqlListTables(sock)} lists all tables (relations) known by the database
selected by \code{msqlSelectDB()}. Results can be read by the
\code{msqlFetchRow()} mechanism.

\code{msqlListFields(sock, tableName)} lists all fields (attribute) known by the database
selected by \code{msqlSelectDB()} and table \code{tableName} . Results can be read by the
\code{msqlFetchField()} mechanism.


\code{msqlListIndex(sock, tableName, index)} returns information about the
used index in table \code{tableName}. Results can be read by the
\code{msqlFetchField()} mechanism, the first row contains a symbolic name of
the index mechanism, the following rows contain the names of the fields that
comprise the index (well, indeed index means key attributes).  
 
For excellent information about mSQL and how to use it from other languages,
see the mSQL manual. NOTE that mSQL is commercial and NOT GPLed but open
source and free of charge for universities and noncommercial organisations. 

}

\author{Torsten Hothorn, <Torsten.Hothorn@rzmail.uni-erlangen.de>}
\examples{
# see ./RmSQL/Example/crash.R, you need a running msql2d
}

\keyword{utilities}
