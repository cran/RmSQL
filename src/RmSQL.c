#include <stdio.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <msql.h>

m_result *result;
m_field *field;
char *errMsg;

void RgetErrMsg(msg)
	char **msg;
{
	msg[0] = errMsg;
}

void RmsqlConnect(host, stat)
	char **host;
	int *stat;
{
	stat[0] = msqlConnect(host[0]);
	if (stat[0] < 0) errMsg = msqlErrMsg; 	
}

void RmsqlSelectDB(sock, dbName, stat)
	int *sock;
	char **dbName;
	int *stat;
{
	stat[0] = msqlSelectDB(sock[0], dbName[0]);
	if (stat[0] < 0) errMsg = msqlErrMsg; 	
}

void RmsqlQuery(sock, query, stat)
	int *sock;
	char **query;
	int *stat;
{
	stat[0] = msqlQuery(sock[0], query[0]);
	if (stat[0] < 0) errMsg = msqlErrMsg; 	
}

void RmsqlStoreResult()
{
	result = msqlStoreResult();
}

void RmsqlFetchRow(data, num, stat)
	char **data;
	int *num;
	int *stat;
{
	m_row cur;
	int i;
	 
	if (!result)
	{
		errMsg = "No results available";
		stat[0] = -1;
		return;
	}
	if (cur = msqlFetchRow(result))
	{
		for (i=0; i< num[0]; i++)
			data[i] = cur[i];
	} else {
		errMsg ="No more data";
		stat[0] = -1;
	}	
}


void RmsqlFreeResult()
{
	if (!result) return;
	msqlFreeResult(result);
}

void RmsqlDataSeek(pos, stat)
	int *pos, *stat;
{
	if (!result)
	{
		errMsg = "No results available";
		stat[0] = -1;
		return;
	}
	msqlDataSeek(result, pos[0]);
}

void RmsqlNumRows(num, stat)
	int *num, *stat;
{
	if (!result)
	{
		errMsg = "No results available";
		stat[0] = -1;
		return;
	}
	num[0] = msqlNumRows(result);
}

void RmsqlFetchField(attr, type, stat)
	char **attr;
	int *type, *stat;
{
	if (!result)
	{
		errMsg = "No results available";
		stat[0] = -1;
		return;
	}
	if (field = msqlFetchField(result))
	{
		attr[0] = field->name;
		attr[1] = field->table;
		type[0] = field->type;
	} else {
		errMsg ="No more data";
		stat[0] = -1;
	}
}

void RmsqlFieldSeek(pos, stat)
	int *pos, *stat;
{
	if (!result)
	{
		errMsg = "No results available";
		stat[0] = -1;
		return;
	}
	msqlFieldSeek(result, pos[0]);
}

void RmsqlNumFields(num, stat)
	int *num, *stat;
{
	if (!result)
	{
		errMsg = "No results available";
		stat[0] = -1;
		return;
	}
	num[0] = msqlNumFields(result);
}	

void RmsqlListDBs(sock)
	int *sock;
{
	result = msqlListDBs(sock[0]);
}

void RmsqlListTables(sock)
	int *sock;
{
	result = msqlListTables(sock[0]);
}

void RmsqlListFields(sock, tableName)
	int *sock;
	char **tableName;
{
	result = msqlListFields(sock[0], tableName[0]);
}

void RmsqlListIndex(sock, tableName, index)
	int *sock;
	char **tableName, **index;
{
	result = msqlListIndex(sock[0], tableName[0], index[0]);
}

void RmsqlClose(sock)
	int *sock;
{
	msqlClose(sock[0]);
}