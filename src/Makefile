LD=ld

# mSQL include and lib directories

INC=-I/usr/local/Hughes/include
LIB=/usr/local/Hughes/lib/libmsql.a

all: RmSQL.so

RmSQL.so:	RmSQL.o 
	@$(LD) $(SHLIBLDFLAGS) -o RmSQL.so RmSQL.o $(LIB)

RmSQL.o:	RmSQL.c
	@$(CC)  $(INC) -o RmSQL.o -c RmSQL.c

# if somethings goes wrong (like: undefined reference...), 
# check that $RHOME/etc/Makeconf has the correct SHLIBFLAGS