From: Sandeep Patil <sspatil@google.com>
Date: Mon, 18 Sep 2017 16:45:22 -0700
Subject: [LTP] [PATCH] mem/mmapstress: Default enable large file support in
	mmapstress tests
Message-ID: <20170918234522.101867-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tests had a lot of #ifdef checks against LARGE_FILE to switch
between 64-bit and 32-bit versions of data types and system calls.
Remove all that by always building these tests with _FILE_OFFSET_BITS=64
so their 32-bit compiled versions automatically use the 64-bit parts
where necessary.

The testcases changed due to this are mmapstress01, mmapstress07 and
mmapstress10. Their 32-bit and 64-bit built binaries were successfully built
against bionic and tested on Android.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/mem/mmapstress/Makefile       |   4 +
 testcases/kernel/mem/mmapstress/mmapstress01.c |  79 -------------------
 testcases/kernel/mem/mmapstress/mmapstress07.c |  48 +-----------
 testcases/kernel/mem/mmapstress/mmapstress10.c | 103 -------------------------
 4 files changed, 6 insertions(+), 228 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/Makefile b/testcases/kernel/mem/mmapstress/Makefile
index 5691f7d5d..ebe3275d0 100644
--- a/testcases/kernel/mem/mmapstress/Makefile
+++ b/testcases/kernel/mem/mmapstress/Makefile
@@ -20,3 +20,7 @@ top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+mmapstress01: CFLAGS += -D_FILE_OFFSET_BITS=64
+mmapstress07: CFLAGS += -D_FILE_OFFSET_BITS=64
+mmapstress10: CFLAGS += -D_FILE_OFFSET_BITS=64
diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index d2df6122b..21304924e 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -85,7 +85,6 @@ void ok_exit();
  *			  program exit.
  *	-d		- enable debug output
  *
- *  Compile with -DLARGE_FILE to enable file sizes > 2 GB.
  */
 
 #define MAXLOOPS	500	/* max pages for map children to write */
@@ -120,13 +119,8 @@ int finished = 0;
 int leavefile = 0;
 
 int debug = 0;
-#ifdef LARGE_FILE
-off64_t filesize = FILESIZE;
-off64_t sparseoffset = 0;
-#else /* LARGE_FILE */
 off_t filesize = FILESIZE;
 off_t sparseoffset = 0;
-#endif /* LARGE_FILE */
 unsigned randloops = 0;
 unsigned dosync = 0;
 unsigned do_offset = 0;
@@ -153,11 +147,7 @@ int main(int argc, char *argv[])
 	int no_prob = 0;
 	int wait_stat;
 	time_t t;
-#ifdef LARGE_FILE
-	off64_t bytes_left;
-#else /* LARGE_FILE */
 	off_t bytes_left;
-#endif /* LARGE_FILE */
 	const char *filename = "mmapstress01.out";
 
 	progname = *argv;
@@ -181,11 +171,7 @@ int main(int argc, char *argv[])
 			leavefile = 1;
 			break;
 		case 'f':
-#ifdef LARGE_FILE
 			filesize = atoll(optarg);
-#else /* LARGE_FILE */
-			filesize = atoi(optarg);
-#endif /* LARGE_FILE */
 			if (filesize < 0) {
 				(void)fprintf(stderr, "error: negative "
 					      "filesize\n");
@@ -202,11 +188,7 @@ int main(int argc, char *argv[])
 			do_offset = 1;
 			break;
 		case 'S':
-#ifdef LARGE_FILE
 			sparseoffset = atoll(optarg);
-#else /* LARGE_FILE */
-			sparseoffset = atoi(optarg);
-#endif /* LARGE_FILE */
 			if (sparseoffset % pagesize != 0) {
 				fprintf(stderr,
 					"sparseoffset must be pagesize multiple\n");
@@ -233,13 +215,8 @@ int main(int argc, char *argv[])
 	pattern = seed & 0xff;
 
 	if (debug) {
-#ifdef LARGE_FILE
 		(void)printf("creating file <%s> with %Ld bytes, pattern %d\n",
 			     filename, filesize, pattern);
-#else /* LARGE_FILE */
-		(void)printf("creating file <%s> with %ld bytes, pattern %d\n",
-			     filename, filesize, pattern);
-#endif /* LARGE_FILE */
 		if (alarmtime)
 			(void)printf("running for %f minutes\n",
 				     alarmtime / 60);
@@ -279,11 +256,7 @@ int main(int argc, char *argv[])
 		}
 		(void)alarm(alarmtime);
 	}
-#ifdef LARGE_FILE
-	if ((fd = open64(filename, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#else /* LARGE_FILE */
 	if ((fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#endif /* LARGE_FILE */
 		perror("open error");
 		anyfail();
 	}
@@ -302,11 +275,7 @@ int main(int argc, char *argv[])
 		if (++data == nprocs)
 			data = 0;
 	}
-#ifdef LARGE_FILE
-	if (lseek64(fd, sparseoffset, SEEK_SET) < 0) {
-#else /* LARGE_FILE */
 	if (lseek(fd, sparseoffset, SEEK_SET) < 0) {
-#endif /* LARGE_FILE */
 		perror("lseek");
 		anyfail();
 	}
@@ -457,15 +426,9 @@ cleanup:
  */
 void child_mapper(char *file, unsigned procno, unsigned nprocs)
 {
-#ifdef LARGE_FILE
-	struct stat64 statbuf;
-	off64_t filesize;
-	off64_t offset;
-#else /* LARGE_FILE */
 	struct stat statbuf;
 	off_t filesize;
 	off_t offset;
-#endif /* LARGE_FILE */
 	size_t validsize;
 	size_t mapsize;
 	char *maddr = NULL, *paddr;
@@ -480,21 +443,13 @@ void child_mapper(char *file, unsigned procno, unsigned nprocs)
 
 	seed = initrand();	/* initialize random seed */
 
-#ifdef LARGE_FILE
-	if (stat64(file, &statbuf) == -1) {
-#else /* LARGE_FILE */
 	if (stat(file, &statbuf) == -1) {
-#endif /* LARGE_FILE */
 		perror("stat error");
 		anyfail();
 	}
 	filesize = statbuf.st_size;
 
-#ifdef LARGE_FILE
-	if ((fd = open64(file, O_RDWR)) == -1) {
-#else /* LARGE_FILE */
 	if ((fd = open(file, O_RDWR)) == -1) {
-#endif /* LARGE_FILE */
 		perror("open error");
 		anyfail();
 	}
@@ -516,25 +471,13 @@ void child_mapper(char *file, unsigned procno, unsigned nprocs)
 	nloops = (randloops) ? (lrand48() % MAXLOOPS) : MAXLOOPS;
 
 	if (debug) {
-#ifdef LARGE_FILE
 		(void)printf("child %d (pid %ld): seed %d, fsize %Ld, "
 			     "mapsize %d, off %Ld, loop %d\n",
 			     procno, getpid(), seed, filesize, mapsize,
 			     offset / pagesize, nloops);
-#else /* LARGE_FILE */
-		(void)printf("child %d (pid %d): seed %d, fsize %ld, "
-			     "mapsize %ld, off %ld, loop %d\n",
-			     procno, getpid(), seed, filesize, (long)mapsize,
-			     offset / pagesize, nloops);
-#endif /* LARGE_FILE */
 	}
-#ifdef LARGE_FILE
-	if ((maddr = mmap64(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-			    fd, offset)) == (caddr_t) - 1) {
-#else /* LARGE_FILE */
 	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
 			  fd, offset)) == (caddr_t) - 1) {
-#endif /* LARGE_FILE */
 		perror("mmap error");
 		anyfail();
 	}
@@ -595,11 +538,7 @@ void child_mapper(char *file, unsigned procno, unsigned nprocs)
  */
 int fileokay(char *file, uchar_t * expbuf)
 {
-#ifdef LARGE_FILE
-	struct stat64 statbuf;
-#else /* LARGE_FILE */
 	struct stat statbuf;
-#endif /* LARGE_FILE */
 	size_t mapsize;
 	unsigned mappages;
 	unsigned pagesize = sysconf(_SC_PAGE_SIZE);
@@ -608,11 +547,7 @@ int fileokay(char *file, uchar_t * expbuf)
 	int cnt;
 	unsigned i, j;
 
-#ifdef LARGE_FILE
-	if ((fd = open64(file, O_RDONLY)) == -1) {
-#else /* LARGE_FILE */
 	if ((fd = open(file, O_RDONLY)) == -1) {
-#endif /* LARGE_FILE */
 		perror("open error");
 		/***** LTP Port *****/
 		local_flag = FAILED;
@@ -620,11 +555,7 @@ int fileokay(char *file, uchar_t * expbuf)
 		/*****	**	*****/
 		return 0;
 	}
-#ifdef LARGE_FILE
-	if (fstat64(fd, &statbuf) == -1) {
-#else /* LARGE_FILE */
 	if (fstat(fd, &statbuf) == -1) {
-#endif /* LARGE_FILE */
 		perror("stat error");
 		/***** LTP Port *****/
 		local_flag = FAILED;
@@ -632,11 +563,7 @@ int fileokay(char *file, uchar_t * expbuf)
 		/*****	**	*****/
 		return 0;
 	}
-#ifdef LARGE_FILE
-	if (lseek64(fd, sparseoffset, SEEK_SET) < 0) {
-#else /* LARGE_FILE */
 	if (lseek(fd, sparseoffset, SEEK_SET) < 0) {
-#endif /* LARGE_FILE */
 		perror("lseek");
 		anyfail();
 	}
@@ -678,15 +605,9 @@ int fileokay(char *file, uchar_t * expbuf)
 				(void)fprintf(stderr,
 					      "read bad data: exp %c got %c)",
 					      expbuf[j], readbuf[j]);
-#ifdef LARGE_FILE
 				(void)fprintf(stderr, ", pg %d off %d, "
 					      "(fsize %Ld)\n", i, j,
 					      statbuf.st_size);
-#else /* LARGE_FILE */
-				(void)fprintf(stderr, ", pg %d off %d, "
-					      "(fsize %ld)\n", i, j,
-					      statbuf.st_size);
-#endif /* LARGE_FILE */
 				close(fd);
 				return 0;
 			}
diff --git a/testcases/kernel/mem/mmapstress/mmapstress07.c b/testcases/kernel/mem/mmapstress/mmapstress07.c
index f99bc09e8..17091172e 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress07.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress07.c
@@ -90,13 +90,8 @@ int main(int argc, char **argv)
 	int rofd, rwfd, i;
 	struct sigaction sa;
 	int e_pageskip;
-#ifdef LARGE_FILE
-	off64_t holesize;
-	off64_t sparseoff;
-#else /* LARGE_FILE */
 	off_t holesize;
 	off_t sparseoff;
-#endif /* LARGE_FILE */
 
 	(void)time(&t);
 //      (void)printf("%s: Started %s", argv[0], ctime(&t));
@@ -118,11 +113,7 @@ int main(int argc, char **argv)
 	tmpname = argv[1];
 
 	if (argc >= 3) {
-#ifdef LARGE_FILE
 		holesize = atoll(argv[2]);
-#else /* LARGE_FILE */
-		holesize = atoi(argv[2]);
-#endif /* LARGE_FILE */
 	} else
 		holesize = pagesize;
 
@@ -131,13 +122,9 @@ int main(int argc, char **argv)
 	else
 		e_pageskip = 1;
 
-	if (argc >= 5) {
-#ifdef LARGE_FILE
+	if (argc >= 5)
 		sparseoff = atoll(argv[4]);
-#else /* LARGE_FILE */
-		sparseoff = atoi(argv[4]);
-#endif /* LARGE_FILE */
-	} else
+	else
 		sparseoff = pagesize * 2;
 
 	sa.sa_handler = cleanup;
@@ -149,27 +136,15 @@ int main(int argc, char **argv)
 	CATCH_SIG(SIGINT);
 	CATCH_SIG(SIGQUIT);
 	CATCH_SIG(SIGTERM);
-#ifdef LARGE_FILE
-	if ((rofd = open64(tmpname, O_RDONLY | O_CREAT, 0777)) == -1) {
-#else /* LARGE_FILE */
 	if ((rofd = open(tmpname, O_RDONLY | O_CREAT, 0777)) == -1) {
-#endif /* LARGE_FILE */
 		ERROR("couldn't reopen rofd for reading");
 		anyfail();	/* LTP Port */
 	}
-#ifdef LARGE_FILE
-	if ((rwfd = open64(tmpname, O_RDWR)) == -1) {
-#else /* LARGE_FILE */
 	if ((rwfd = open(tmpname, O_RDWR)) == -1) {
-#endif /* LARGE_FILE */
 		CLEANERROR("couldn't reopen rwfd for read/write");
 		anyfail();	/* LTP Port */
 	}
-#ifdef LARGE_FILE
-	if (lseek64(rwfd, sparseoff, SEEK_SET) < 0) {
-#else /* LARGE_FILE */
 	if (lseek(rwfd, sparseoff, SEEK_SET) < 0) {
-#endif /* LARGE_FILE */
 		perror("lseek");
 		anyfail();	/* LTP Port */
 	}
@@ -181,11 +156,7 @@ int main(int argc, char **argv)
 		CLEANERROR("couldn't fill first part of file with junk");
 		anyfail();	/* LTP Port */
 	}
-#ifdef LARGE_FILE
-	if (lseek64(rwfd, holesize, SEEK_CUR) == -1) {
-#else /* LARGE_FILE */
 	if (lseek(rwfd, holesize, SEEK_CUR) == -1) {
-#endif /* LARGE_FILE */
 		CLEANERROR("couldn't create hole in file");
 		anyfail();	/* LTP Port */
 	}
@@ -200,16 +171,9 @@ int main(int argc, char **argv)
 	/* At this point fd contains 1 page of a's, holesize bytes skipped,
 	 * 1/2 page of b's.
 	 */
-
-#ifdef LARGE_FILE
-	if ((mapaddr = mmap64((caddr_t) 0, pagesize * 2 + holesize, PROT_READ,
-			      MAP_SHARED | MAP_FILE, rofd,
-			      sparseoff)) == (caddr_t) - 1) {
-#else /* LARGE_FILE */
 	if ((mapaddr = mmap((caddr_t) 0, pagesize * 2 + holesize, PROT_READ,
 			    MAP_SHARED | MAP_FILE, rofd,
 			    sparseoff)) == (caddr_t) - 1) {
-#endif /* LARGE_FILE */
 		CLEANERROR("mmap tmp file failed");
 		anyfail();	/* LTP Port */
 	}
@@ -225,11 +189,7 @@ int main(int argc, char **argv)
 		CLEANERROR("hole not filled with 0's");
 		anyfail();	/* LTP Port */
 	}
-#ifdef LARGE_FILE
-	if (lseek64(rwfd, sparseoff + e_pageskip * pagesize, SEEK_SET) == -1) {
-#else /* LARGE_FILE */
 	if (lseek(rwfd, sparseoff + e_pageskip * pagesize, SEEK_SET) == -1) {
-#endif /* LARGE_FILE */
 		CLEANERROR("couldn't lseek back to put e's in hole");
 		anyfail();	/*LTP Port */
 	}
@@ -244,11 +204,7 @@ int main(int argc, char **argv)
 		CLEANERROR("fsync failed");
 		anyfail();	/* LTP Port */
 	}
-#ifdef LARGE_FILE
-	if (lseek64(rofd, sparseoff, SEEK_SET) == -1) {
-#else /* LARGE_FILE */
 	if (lseek(rofd, sparseoff, SEEK_SET) == -1) {
-#endif /* LARGE_FILE */
 		CLEANERROR("couldn't lseek to begining to verify contents");
 		anyfail();	/* LTP Port */
 	}
diff --git a/testcases/kernel/mem/mmapstress/mmapstress10.c b/testcases/kernel/mem/mmapstress/mmapstress10.c
index 482933bce..4191651ac 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress10.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress10.c
@@ -95,7 +95,6 @@ void ok_exit();
  *			  program exit.
  *	-d		- enable debug outputd
  *
- *  Compile with -DLARGE_FILE to enable file sizes > 2 GB.
  */
 
 #define MAXLOOPS	500	/* max pages for map children to write */
@@ -137,13 +136,8 @@ int leavefile = 0;
 int debug = 0;
 int growsize = GROWSIZE;
 int sleeptime = SLEEPTIME;
-#ifdef LARGE_FILE
-off64_t filesize = FILESIZE;
-off64_t sparseoffset = 0;
-#else /* LARGE_FILE */
 off_t filesize = FILESIZE;
 off_t sparseoffset = 0;
-#endif /* LARGE_FILE */
 unsigned randloops = 0;
 unsigned dosync = 0;
 unsigned do_offset = 0;
@@ -181,11 +175,7 @@ int main(int argc, char *argv[])
 	int no_prob = 0;
 	int wait_stat;
 	time_t t;
-#ifdef LARGE_FILE
-	off64_t bytes_left;
-#else /* LARGE_FILE */
 	off_t bytes_left;
-#endif /* LARGE_FILE */
 
 	progname = *argv;
 	tst_tmpdir();
@@ -225,11 +215,7 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'f':
-#ifdef LARGE_FILE
 			filesize = atoll(optarg);
-#else /* LARGE_FILE */
-			filesize = atoi(optarg);
-#endif /* LARGE_FILE */
 			if (filesize < 0) {
 				(void)fprintf(stderr, "error: negative "
 					      "filesize\n");
@@ -246,11 +232,7 @@ int main(int argc, char *argv[])
 			do_offset = 1;
 			break;
 		case 'S':
-#ifdef LARGE_FILE
 			sparseoffset = atoll(optarg);
-#else /* LARGE_FILE */
-			sparseoffset = atoi(optarg);
-#endif /* LARGE_FILE */
 			if (sparseoffset % pagesize != 0) {
 				fprintf(stderr,
 					"sparseoffset must be pagesize multiple\n");
@@ -275,13 +257,8 @@ int main(int argc, char *argv[])
 	pattern = seed & 0xff;
 
 	if (debug) {
-#ifdef LARGE_FILE
 		(void)printf("creating file <%s> with %Ld bytes, pattern %d\n",
 			     filename, filesize, pattern);
-#else /* LARGE_FILE */
-		(void)printf("creating file <%s> with %ld bytes, pattern %d\n",
-			     filename, filesize, pattern);
-#endif /* LARGE_FILE */
 		if (alarmtime)
 			(void)printf("running for %f minutes\n",
 				     alarmtime / 60);
@@ -322,11 +299,7 @@ int main(int argc, char *argv[])
 		perror("sigaction error SIGTERM");
 		goto cleanup;
 	}
-#ifdef LARGE_FILE
-	if ((fd = open64(filename, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#else /* LARGE_FILE */
 	if ((fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#endif /* LARGE_FILE */
 		perror("open error");
 		anyfail();
 	}
@@ -351,11 +324,7 @@ int main(int argc, char *argv[])
 			data = 0;
 	}
 
-#ifdef LARGE_FILE
-	if (lseek64(fd, sparseoffset, SEEK_SET) < 0) {
-#else /* LARGE_FILE */
 	if (lseek(fd, sparseoffset, SEEK_SET) < 0) {
-#endif /* LARGE_FILE */
 		perror("lseek");
 		anyfail();
 	}
@@ -521,15 +490,9 @@ cleanup:
  */
 void child_mapper(char *file, unsigned procno, unsigned nprocs)
 {
-#ifdef LARGE_FILE
-	struct stat64 statbuf;
-	off64_t filesize;
-	off64_t offset;
-#else /* LARGE_FILE */
 	struct stat statbuf;
 	off_t filesize;
 	off_t offset;
-#endif /* LARGE_FILE */
 	size_t validsize;
 	caddr_t paddr;
 	int pagesize = sysconf(_SC_PAGE_SIZE);
@@ -557,19 +520,11 @@ void child_mapper(char *file, unsigned procno, unsigned nprocs)
 		perror("sigaction error SIGUSR1");
 		anyfail();
 	}
-#ifdef LARGE_FILE
-	if ((fd_mapper = open64(file, O_RDWR)) == -1) {
-#else /* LARGE_FILE */
 	if ((fd_mapper = open(file, O_RDWR)) == -1) {
-#endif /* LARGE_FILE */
 		perror("open error");
 		anyfail();
 	}
-#ifdef LARGE_FILE
-	if (fstat64(fd_mapper, &statbuf) == -1) {
-#else /* LARGE_FILE */
 	if (fstat(fd_mapper, &statbuf) == -1) {
-#endif /* LARGE_FILE */
 		perror("stat error");
 		anyfail();
 	}
@@ -589,15 +544,9 @@ void child_mapper(char *file, unsigned procno, unsigned nprocs)
 		mapsize_mapper -= byteoffset;
 		mappages -= pageoffset;
 	}
-#ifdef LARGE_FILE
-	if ((maddr_mapper = mmap64(0, mapsize_mapper, PROT_READ | PROT_WRITE,
-				   mapflags, fd_mapper,
-				   offset)) == (caddr_t) - 1) {
-#else /* LARGE_FILE */
 	if ((maddr_mapper = mmap(0, mapsize_mapper, PROT_READ | PROT_WRITE,
 				 mapflags, fd_mapper,
 				 offset)) == (caddr_t) - 1) {
-#endif /* LARGE_FILE */
 		perror("mmap error");
 		anyfail();
 	}
@@ -607,17 +556,10 @@ void child_mapper(char *file, unsigned procno, unsigned nprocs)
 	nloops = (randloops) ? (lrand48() % MAXLOOPS) : MAXLOOPS;
 
 	if (debug) {
-#ifdef LARGE_FILE
 		(void)printf("child %d (pid %ld): seed %d, fsize %Ld, "
 			     "mapsize %d, off %Ld, loop %d\n",
 			     procno, getpid(), seed, filesize, mapsize_mapper,
 			     offset / pagesize, nloops);
-#else /* LARGE_FILE */
-		(void)printf("child %d (pid %d): seed %d, fsize %ld, "
-			     "mapsize %ld, off %ld, loop %d\n",
-			     procno, getpid(), seed, filesize,
-			     (long)mapsize_mapper, offset / pagesize, nloops);
-#endif /* LARGE_FILE */
 	}
 
 	/*
@@ -700,52 +642,29 @@ void child_writer(char *file, uchar_t * buf)
 		perror("sigaction error SIGUSR1");
 		anyfail();
 	}
-#ifdef LARGE_FILE
-	struct stat64 statbuf;
-	off64_t off;
-#else /* LARGE_FILE */
 	struct stat statbuf;
 	off_t off;
-#endif /* LARGE_FILE */
 	int pagesize = sysconf(_SC_PAGE_SIZE);
 	uchar_t *p;
 	int cnt;
 
-#ifdef LARGE_FILE
-	if ((fd_writer = open64(file, O_RDWR)) == -1) {
-#else /* LARGE_FILE */
 	if ((fd_writer = open(file, O_RDWR)) == -1) {
-#endif /* LARGE_FILE */
 		perror("open error");
 		anyfail();
 	}
-#ifdef LARGE_FILE
-	if ((off = lseek64(fd_writer, 0, SEEK_END)) == -1) {
-#else /* LARGE_FILE */
 	if ((off = lseek(fd_writer, 0, SEEK_END)) == -1) {
-#endif /* LARGE_FILE */
 		perror("lseek error");
 		anyfail();
 	}
 
 	for (;;) {
-#ifdef LARGE_FILE
-		if (fstat64(fd_writer, &statbuf) == -1) {
-#else /* LARGE_FILE */
 		if (fstat(fd_writer, &statbuf) == -1) {
-#endif /* LARGE_FILE */
 			perror("fstat error");
 			anyfail();
 		}
-#ifdef LARGE_FILE
 		if (debug)
 			(void)printf("writer %d bytes at off %Ld, size %Ld\n",
 				     growsize, off, statbuf.st_size);
-#else /* LARGE_FILE */
-		if (debug)
-			(void)printf("writer %d bytes@off %ld, size %ld\n",
-				     growsize, off, statbuf.st_size);
-#endif /* LARGE_FILE */
 
 		/*
 		 *  Write some number of bytes, then sleep some
@@ -784,11 +703,7 @@ void child_writer(char *file, uchar_t * buf)
  */
 int fileokay(char *file, uchar_t * expbuf)
 {
-#ifdef LARGE_FILE
-	struct stat64 statbuf;
-#else /* LARGE_FILE */
 	struct stat statbuf;
-#endif /* LARGE_FILE */
 	size_t mapsize;
 	uchar_t *readbuf;
 	unsigned mappages;
@@ -797,27 +712,15 @@ int fileokay(char *file, uchar_t * expbuf)
 	int cnt;
 	unsigned i, j;
 
-#ifdef LARGE_FILE
-	if ((fd = open64(file, O_RDONLY)) == -1) {
-#else /* LARGE_FILE */
 	if ((fd = open(file, O_RDONLY)) == -1) {
-#endif /* LARGE_FILE */
 		perror("open error");
 		anyfail();
 	}
-#ifdef LARGE_FILE
-	if (fstat64(fd, &statbuf) == -1) {
-#else /* LARGE_FILE */
 	if (fstat(fd, &statbuf) == -1) {
-#endif /* LARGE_FILE */
 		perror("stat error");
 		anyfail();
 	}
-#ifdef LARGE_FILE
-	if (lseek64(fd, sparseoffset, SEEK_SET) < 0) {
-#else /* LARGE_FILE */
 	if (lseek(fd, sparseoffset, SEEK_SET) < 0) {
-#endif /* LARGE_FILE */
 		perror("lseek");
 		exit(1);
 	}
@@ -858,15 +761,9 @@ int fileokay(char *file, uchar_t * expbuf)
 				(void)fprintf(stderr,
 					      "read bad data: exp %c got %c",
 					      expbuf[j], readbuf[j]);
-#ifdef LARGE_FILE
 				(void)fprintf(stderr, ", pg %d off %d, "
 					      "(fsize %Ld)\n", i, j,
 					      statbuf.st_size);
-#else /* LARGE_FILE */
-				(void)fprintf(stderr, ", pg %d off %d, "
-					      "(fsize %ld)\n", i, j,
-					      statbuf.st_size);
-#endif /* LARGE_FILE */
 				close(fd);
 				return 0;
 			}
-- 
2.14.1.690.gbb1197296e-goog

