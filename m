Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Xf8Br-0002DO-Dm
	for ltp-list@lists.sourceforge.net; Fri, 17 Oct 2014 14:07:35 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xf8Bo-0007kt-CZ
	for ltp-list@lists.sourceforge.net; Fri, 17 Oct 2014 14:07:35 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s9HE7LEK015102
	for <ltp-list@lists.sourceforge.net>; Fri, 17 Oct 2014 22:07:21 +0800
Message-ID: <1413554791.5750.27.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 17 Oct 2014 22:06:31 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] stress_cd: Cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

* Delete some useless commtents.

* Add 'static' before functions and global variables.

* In 'read_data' the second variable is local and it would not change after
  'read_data' is over. Defined it as a pointer.

* Remove 'return' that follows 'pthread_exit'.

* Add branch 'read() returndd 0' that indicates end of file.

* Merge 'syserror' and 'error'.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/io/stress_cd/stress_cd.c | 197 ++++++++----------------------
 1 file changed, 53 insertions(+), 144 deletions(-)

diff --git a/testcases/kernel/io/stress_cd/stress_cd.c b/testcases/kernel/io/stress_cd/stress_cd.c
index 0209a1f..6e13afa 100644
--- a/testcases/kernel/io/stress_cd/stress_cd.c
+++ b/testcases/kernel/io/stress_cd/stress_cd.c
@@ -1,6 +1,7 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *    06/20/2001 Robbie Williamson (robbiew@us.ibm.com)
+ *    11/08/2001 Manoj Iyer (manjo@austin.ibm.com)
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,37 +14,19 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- *  FILE        : stress_cd.c
- *  DESCRIPTION : creates multiple read threads on the cdrom device.
- *  HISTORY:
- *    06/20/2001 Robbie Williamson (robbiew@us.ibm.com)
- *      -Ported
- *    11/08/2001 Manoj Iyer (manjo@austin.ibm.com)
- *      - Modified.
- *	- removed compiler warnings.
- *	- Added #include <sys/types.h>, #include <unistd.h> and
- *	  #include <string.h>
- *	- print unsigned long correctly in printf() use "lx" instead of "x"
- *	- added missing parameter in usage message.
- *
-+--------------------------------------------------------------------+
-|                                                                    |
-| Usage:        cdtest [-n n] [-f file] [-m xx] [-d]                 |
-|                                                                    |
-|               where:                                               |
-|                 -n n     Number of threads to create               |
-|                 -f file  File or device to read from               |
-|                 -m xx    Number of MB to read from file            |
-|                 -b xx    Number of bytes to read from file         |
-|                 -d       Enable debugging messages                 |
-|                                                                    |
-|                                                                    |
-+-------------------------------------------------------------------*/
+ * Usage:	stress_cd [-n n] [-f file] [-m xx] [-d]
+ *		where:
+ *		  -n n     Number of threads to create
+ *		  -f file  File or device to read from
+ *		  -m xx    Number of MB to read from file
+ *		  -b xx    Number of bytes to read from file
+ *		  -d       Enable debugging messages
+ */
 
 #include <pthread.h>
 #include <fcntl.h>
@@ -55,46 +38,21 @@
 #include <unistd.h>
 #include <string.h>
 
-/* Defines
- *
- * DEFAULT_NUM_THREADS: Default number of threads to create,
- * user can specifiy with [-n] command line option.
- *
- * USAGE: usage statement
- */
-#define DEFAULT_NUM_THREADS 	10
-#define DEFAULT_NUM_BYTES   	1024*1024*100	/* 100Mb */
-#define DEFAULT_FILE        	"/dev/cdrom"
+#define DEFAULT_NUM_THREADS	10
+#define DEFAULT_NUM_BYTES	(1024*1024*100)	/* 100Mb */
+#define DEFAULT_FILE		"/dev/cdrom"
 
-/*
- * Function prototypes
- *
- * sys_error (): System error message function
- * error (): Error message function
- * parse_args (): Parses command line arguments
- */
 static void sys_error(const char *, int);
-static void error(const char *, int);
 static void parse_args(int, char **);
-void *thread(int *);
-int read_data(int, unsigned long);
+static void *thread(int *);
+static int read_data(int, unsigned long *);
+
+static int num_threads = DEFAULT_NUM_THREADS;
+static int num_bytes = DEFAULT_NUM_BYTES;
+static char *file = DEFAULT_FILE;
+static unsigned long checksum;
+static int debug;
 
-/*
- * Global Variables
- */
-int num_threads = DEFAULT_NUM_THREADS;
-int num_bytes = DEFAULT_NUM_BYTES;
-char *file = DEFAULT_FILE;
-unsigned long checksum = 0;
-int debug = 0;
-
-/*-------------------------------------------------------------------+
-|                               main ()                              |
-| ================================================================== |
-|                                                                    |
-| Function:  Main program  (see prolog for more details)             |
-|                                                                    |
-+-------------------------------------------------------------------*/
 int main(int argc, char **argv)
 {
 	pthread_attr_t attr;
@@ -106,17 +64,16 @@ int main(int argc, char **argv)
 	parse_args(argc, argv);
 
 	/* Read data from CDROM & compute checksum */
-	read_data(0, checksum);
+	read_data(0, &checksum);
 	if (debug)
-		printf("Thread [main] checksum: %-#12lx \n", checksum);
+		printf("\tThread [main] checksum: %-#12lx\n", checksum);
 
 	if (pthread_attr_init(&attr))
 		sys_error("pthread_attr_init failed", __LINE__);
 	if (pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE))
 		sys_error("pthread_attr_setdetachstate failed", __LINE__);
 
-	/* Create num_thread threads... */
-	printf("\tThread [main] Creating %d threads\n", num_threads);
+	printf("Thread [main] Creating %d threads\n", num_threads);
 
 	array = malloc(sizeof(pthread_t) * num_threads);
 	arg = malloc(sizeof(int) * num_threads);
@@ -126,15 +83,15 @@ int main(int argc, char **argv)
 		if (debug)
 			printf("\tThread [main]: creating thread %d\n", i + 1);
 		arg[i] = i + 1;
-		if (pthread_create
-		    ((pthread_t *) & array[i], &attr, (void *)thread,
-		     (void *)&arg[i])) {
-			if (errno == EAGAIN)
+		if (pthread_create((pthread_t *)&array[i], &attr,
+				   (void *)thread, (void *)&arg[i])) {
+			if (errno == EAGAIN) {
 				fprintf(stderr,
-					"\tThread [main]: unable to create thread %d\n",
-					i);
-			else
+					"\tThread [main]: unable to create "
+					"thread %d\n", i);
+			} else {
 				sys_error("pthread_create failed", __LINE__);
+			}
 		}
 		if (debug)
 			printf("\tThread [main]: created thread %d\n", i + 1);
@@ -144,8 +101,7 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < num_threads; i++) {
 		void *exit_value;
-		printf("\tThread [main]: waiting for thread: %d\n", i + 1);
-		/*if (pthread_join ((pthread_t*) array [i], (void **) &exit_value)) */
+		printf("Thread [main]: waiting for thread: %d\n", i + 1);
 		if (pthread_join(array[i], &exit_value))
 			sys_error("pthread_join failed", __LINE__);
 
@@ -157,25 +113,16 @@ int main(int argc, char **argv)
 	free(array);
 	free(arg);
 
-	/* One or more of the threads did not complete sucessfully! */
 	if (rc != 0) {
 		printf("test failed!\n");
 		exit(-1);
+	} else {
+		printf("Thread [main] All threads completed successfully...\n");
+		exit(0);
 	}
-
-	/* Program completed successfully... */
-	printf("\tThread [main] All threads completed successfully...\n");
-	exit(0);
 }
 
-/*-------------------------------------------------------------------+
-|                               thread ()                            |
-| ================================================================== |
-|                                                                    |
-| Function:  ...                                                     |
-|                                                                    |
-+-------------------------------------------------------------------*/
-void *thread(int *parm)
+static void *thread(int *parm)
 {
 	int num = *parm;
 	unsigned long cksum = 0;
@@ -183,7 +130,7 @@ void *thread(int *parm)
 	if (debug)
 		printf("\tThread [%d]: begin\n", num);
 
-	read_data(num, cksum);
+	read_data(num, &cksum);
 	if (checksum != cksum) {
 		fprintf(stderr, "\tThread [%d]: checksum mismatch!\n", num);
 		pthread_exit((void *)-1);
@@ -193,17 +140,9 @@ void *thread(int *parm)
 		printf("\tThread [%d]: done\n", num);
 
 	pthread_exit(NULL);
-	return (NULL);
 }
 
-/*-------------------------------------------------------------------+
-|                           read_data ()                             |
-| ================================================================== |
-|                                                                    |
-| Function:  Reads data from the CDROM                               |
-|                                                                    |
-+-------------------------------------------------------------------*/
-int read_data(int num, unsigned long cksum)
+static int read_data(int num, unsigned long *cksum)
 {
 	int fd;
 	const int bufSize = 1024;
@@ -223,23 +162,25 @@ int read_data(int num, unsigned long cksum)
 
 	lseek(fd, 1024 * 36, SEEK_SET);
 	while (bytes_read < num_bytes) {
-		if ((n = read(fd, buffer, bufSize)) < 0)
+		n = read(fd, buffer, bufSize);
+		if (n < 0)
 			sys_error("read failed", __LINE__);
+		else if (n == 0)
+			sys_error("End of file", __LINE__);
 		bytes_read += n;
 
 		for (p = buffer; p < buffer + n; p++)
-			cksum += *p;
+			*cksum += *p;
 
 		if (debug)
-			printf
-			    ("\tThread [%d] bytes read: %5d checksum: %-#12lx\n",
-			     num, bytes_read, cksum);
+			printf("\tThread [%d] bytes read: %5d checksum: "
+			       "%-#12lx\n", num, bytes_read, *cksum);
 	}
 	free(buffer);
 
 	if (debug)
 		printf("\tThread [%d] bytes read: %5d checksum: %-#12lx\n",
-		       num, bytes_read, cksum);
+		       num, bytes_read, *cksum);
 
 	if (close(fd) < 0)
 		sys_error("close failed", __LINE__);
@@ -250,20 +191,6 @@ int read_data(int num, unsigned long cksum)
 	return (0);
 }
 
-/*-------------------------------------------------------------------+
-|                             parse_args ()                          |
-| ================================================================== |
-|                                                                    |
-| Function:  Parse the command line arguments & initialize global    |
-|            variables.                                              |
-|                                                                    |
-| Updates:   (command line options)                                  |
-|                                                                    |
-|            [-n] num   number of threads to create                  |
-|                                                                    |
-|            [-d]       enable debugging messages                    |
-|                                                                    |
-+-------------------------------------------------------------------*/
 static void parse_args(int argc, char **argv)
 {
 	int i;
@@ -297,6 +224,10 @@ static void parse_args(int argc, char **argv)
 		errflag++;
 		fprintf(stderr, "ERROR: num_bytes must be greater than 0");
 	}
+	if (num_threads < 0) {
+		errflag++;
+		fprintf(stderr, "ERROR: num_threads must be greater than 0");
+	}
 
 	if (errflag) {
 		fprintf(stderr, "\nUsage: %s"
@@ -311,30 +242,8 @@ static void parse_args(int argc, char **argv)
 	}
 }
 
-/*-------------------------------------------------------------------+
-|                             sys_error ()                           |
-| ================================================================== |
-|                                                                    |
-| Function:  Creates system error message and calls error ()         |
-|                                                                    |
-+-------------------------------------------------------------------*/
 static void sys_error(const char *msg, int line)
 {
-	char syserr_msg[256];
-
-	sprintf(syserr_msg, "%s: %s\n", msg, strerror(errno));
-	error(syserr_msg, line);
-}
-
-/*-------------------------------------------------------------------+
-|                               error ()                             |
-| ================================================================== |
-|                                                                    |
-| Function:  Prints out message and exits...                         |
-|                                                                    |
-+-------------------------------------------------------------------*/
-static void error(const char *msg, int line)
-{
-	fprintf(stderr, "ERROR [line: %s] \n", msg);
+	fprintf(stderr, "ERROR [%d: %s: %s]\n", line, msg, strerror(errno));
 	exit(-1);
 }
-- 
1.9.3




------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
