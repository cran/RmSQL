# load the library

library("RmSQL");

# read data from file

dat <- read.table(file="crash.txt", header=T);

define <- function(mydata)
{

	# there is an empty db called "crash" available
	# open a connection to msql2d 

	sock <- msqlConnect("localhost");	# use IP-Adress or DNS-Name if
						# msql2d runs remote
	
	# sock contains a handle for the connection

	if (sock < 0)				# if error
	{
		print(msqlGetErrMsg());		# print error message
		stop();				# stop it all
	}
	
	# select a database

	stat <- msqlSelectDB(sock, "crash");
	
	if (stat < 0)				# if error
	{
		print(msqlGetErrMsg());
		stop();
	}
	
	# create table definition statement

	query <- c("CREATE TABLE crashtab ( age int, sex int, alc int, street int, bcrash int, gcrash int)");

	# send it to the server

	stat <- msqlQuery(sock, query)

	if (stat < 0)				# if error
	{
		print(msqlGetErrMsg());
		stop();
	}

	# ok, now we can send our data to the server

	for (i in c(1:nrow(mydata)))
	{
		# create insert statements

		query <- "INSERT INTO crashtab VALUES (";
		
		for (j in c(1:ncol(mydata)))
		{
			query <- paste(query, as.character(mydata[i,j]));
			if (j < ncol(mydata))
			{
				query <- paste(query, ",");
			} else {
				query <- paste(query, ")");
			}
		}

		print(query);

		# send it to the server

		stat <- msqlQuery(sock, query)

		if (stat < 0)			# if error
		{
			print(msqlGetErrMsg());
			stop();
		}
	}

	msqlClose(sock);			# close the connection

	# if everything is ok, our data is now available as a relation
}

select <- function(query)
{
	# open a connection to msql2d 

	sock <- msqlConnect("localhost");	# use IP-Adress or DNS-Name if
						# msql2d runs remote
	
	# sock contains a handle for the connection

	if (sock < 0)				# if error
	{
		print(msqlGetErrMsg());		# print error message
		stop();				# stop it all
	}

	# select a database
	
	stat <- msqlSelectDB(sock, "crash");
	
	if (stat < 0)				# if error
	{
		print(msqlGetErrMsg());
		stop();
	}
	
	# send the query to the server

	stat <- msqlQuery(sock, query)
	
	if (stat < 0)				# if error
	{
		print(msqlGetErrMsg());
		stop();
	}

	if (stat > 0)				# if there is anything
	{

		msqlStoreResult();		# make results available

		# if no error occured, stat contains the number of rows returned
	
		rows <- stat;			# alternative:  msqlNumRows()
		cols <- msqlNumFields();	# number of fields
	
		if (cols$stat < 0)		# if error
		{
			print(msqlGetErrMsg());
			stop();
		}

		cols <- cols$num;
		
		# get all the attribute names 

		attrnames <- c(msqlFetchField())$attr[1];		
		if (cols > 1)
		{
			for (i in c(2:cols))
			{
				attrnames <- c(attrnames, msqlFetchField()$attr[1]);
			}
		}	

		# now get the data

		cur <- msqlFetchRow();		# get the first row
		if (cur$stat < 0)		# if error
		{
			print(msqlGetErrMsg());
			stop();
		}

		dbdata <- cur$data;

		if (rows > 1)
		{
			for (i in c(2:rows))
			{
				cur <- msqlFetchRow();		# get the next row
				if (cur$stat < 0)		
				{
					print(msqlGetErrMsg());
					stop();
				}
				# bind the data into a matrix
		
				dbdata <- rbind(dbdata,cur$data);
			}
		}

		# return the data as data.frame 

		dbdata <- as.data.frame(dbdata);

		# set the names 
		colnames(dbdata) <- attrnames;
	
		return(dbdata);
	}

	# return "null" if no data matching the query is available
	
	return("null");
}

define(dat);
sdata <- select("select alc from crashtab where sex = 0 AND age = 1");