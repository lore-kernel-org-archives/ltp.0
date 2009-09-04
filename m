Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MjcAI-0003EJ-91
	for ltp-list@lists.sourceforge.net; Fri, 04 Sep 2009 17:01:34 +0000
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	by mx2.suse.de (Postfix) with ESMTP id 6629B74862
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2009 19:01:22 +0200 (CEST)
Date: Fri, 4 Sep 2009 19:01:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090904170121.GA16658@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
Subject: [LTP] [PATCH] formatting and ftest cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
This is first part of testcases/kernel/fs/ftest/ cleanup. It fixes printf like
formatting in pidns20.c and growfiles.c as well as huge number of bugs and
code formatting issues in ftest01.c ftest02.c and ftest03.c.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--45Z9DzgjV8m4Oswq
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="ftest_cleanup.patch"

Index: ltp/testcases/kernel/containers/pidns/pidns20.c
===================================================================
--- ltp.orig/testcases/kernel/containers/pidns/pidns20.c
+++ ltp/testcases/kernel/containers/pidns/pidns20.c
@@ -224,7 +224,7 @@ int main(int argc, char *argv[])
 			tst_resm(TFAIL, "parent: user function is not called "\
 					"inside cinit");
 		else
-			tst_resm(TBROK, "parent: cinit is terminated by %s",\
+			tst_resm(TBROK, "parent: cinit is terminated by %i",\
 					WTERMSIG(status));
 	}
 
Index: ltp/testcases/kernel/fs/doio/growfiles.c
===================================================================
--- ltp.orig/testcases/kernel/fs/doio/growfiles.c
+++ ltp/testcases/kernel/fs/doio/growfiles.c
@@ -81,6 +81,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <string.h>
+#include <inttypes.h>
 #include "dataascii.h"
 #include "random_range.h"
 #include "databin.h"
@@ -2125,8 +2126,8 @@ long *curr_size_ptr;	/* BUG:14136 */
 			if( (io_type & LIO_IO_ASYNC_TYPES) || (io_type & LIO_RANDOM) ){
 				if( tmp != Woffset + grow_incr ){
 					if( Debug > 5 ){
-						printf("%s: %d DEBUG6 %s/%d: posix fudge, forcing tmp (%d) to match Woffset+grow_incr (%d)\n",
-						       Progname, Pid, __FILE__, __LINE__, tmp, Woffset+grow_incr);
+						printf("%s: %d DEBUG6 %s/%d: posix fudge, forcing tmp (%"PRId64") to match Woffset+grow_incr (%"PRId64")\n",
+						       Progname, Pid, __FILE__, __LINE__, (int64_t)tmp, (int64_t)Woffset+grow_incr);
 					}
 					tmp = Woffset + grow_incr;
 				}
Index: ltp/testcases/kernel/fs/ftest/ftest01.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest01.c
+++ ltp/testcases/kernel/fs/ftest/ftest01.c
@@ -47,36 +47,36 @@
  *
  */
 #define _GNU_SOURCE 1
-#include <stdio.h>		/* needed by testhead.h		*/
+#include <stdio.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <errno.h>
 #include <fcntl.h>
-#include <signal.h>		/* DEM - added SIGTERM support */
+#include <signal.h>
 #include <unistd.h>
+#include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
 
 char *TCID = "ftest01";
 int TST_TOTAL = 1;
-extern int Tst_count;
 
-void setup(void);
-int runtest();
-int dotest(int, int, int);
-int domisc(int, int, char*);
-int bfill(char*, char, int);
-int dumpbuf(char*);
-int dumpbits(char*, int);
-int orbits(char*, char*, int);
-void term();
-void cleanup(void);
+static void setup(void);
+static void runtest(void);
+static void dotest(int, int, int);
+static void domisc(int, int, char*);
+static void bfill(char*, char, int);
+static void dumpbuf(char*);
+static void dumpbits(char*, int);
+static void orbits(char*, char*, int);
+static void cleanup(void);
+static void term(int);
 
 #define PASSED 1
 #define FAILED 0
 
-#define MAXCHILD	25	/* max number of children to allow */
+#define MAXCHILD	25
 #define K_1		1024
 #define K_2		2048
 #define K_4		4096
@@ -92,7 +92,7 @@ int	nwait;
 int	fd;				/* file descriptor used by child */
 int	parent_pid;
 int	pidlist[MAXCHILD];
-char	test_name[2];			/* childs test directory name */
+char	test_name[2];
 char	*prog;
 
 char	fuss[40] = "";		/* directory to do this in */
@@ -100,21 +100,16 @@ char	homedir[200]= "";	/* where we start
 
 int 	local_flag;
 
-/*--------------------------------------------------------------*/
-int main (ac, av)
-	int  ac;
-	char *av[];
+int main (int ac, char *av[])
 {
-	int lc;                 /* loop counter */
-        char *msg;              /* message returned from parse_opts */
+	int lc;
+        char *msg;
 
         /*
          * parse standard options
          */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
+        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != NULL)
                 tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
-	                /*NOTREACHED*/
-        }
 
 	setup();
 
@@ -122,20 +117,17 @@ int main (ac, av)
 
 		runtest();
 
-		if (local_flag == PASSED) {
+		if (local_flag == PASSED)
 			tst_resm(TPASS, "Test passed.");
-		} else {
+		else
 			tst_resm(TFAIL, "Test failed.");
-		}
-	} /* end of for */
+	}
+
 	cleanup();
-	return 0;
+        tst_exit();
 }
-/*--------------------------------------------------------------*/
-
 
-void
-setup()
+static void setup(void)
 {
 
 	/*
@@ -143,7 +135,7 @@ setup()
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	getcwd(homedir, sizeof( homedir));
+	getcwd(homedir, sizeof(homedir));
 	parent_pid = getpid();
 
 	if (!fuss[0])
@@ -155,17 +147,16 @@ setup()
 		tst_brkm(TBROK,0,"Can't chdir(%s): %s", fuss, strerror(errno));
 	}
 
-	 /*
-	  * Default values for run conditions.
-	  */
-
+	/*
+	 * Default values for run conditions.
+	 */
 	iterations = 10;
 	nchild = 5;
 	csize = K_2;            /* should run with 1, 2, and 4 K sizes */
 	max_size = K_1 * K_1;
 	misc_intvl = 10;
 
-	if ((sigset(SIGTERM, (void (*)())term)) == SIG_ERR) {
+	if (sigset(SIGTERM, term) == SIG_ERR) {
 		tst_resm(TBROK,"sigset failed: %s", strerror(errno));
 	        tst_exit();
 	}
@@ -174,28 +165,26 @@ setup()
 }
 
 
-int runtest()
+static void runtest(void)
 {
-	register int i;
-	int	pid;
-	int	child;
-	int	status;
-	int	count;
-
-
+	int i, pid, child, status, count;
 
 	for(i = 0; i < nchild; i++) {
+
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
-		if (fd < 0) {
+
+		if (fd < 0)
 			tst_brkm(TBROK,0, "Can't creating %s/%s: %s", fuss, test_name, strerror(errno));
+
+		if ((child = fork()) == 0) {
+			dotest(nchild, i, fd);
+			exit(0);
 		}
-		if ((child = fork()) == 0) {		/* child */
-			dotest(nchild, i, fd);		/* do it! */
-			exit(0);			/* when done, exit */
-		}
+
 		close(fd);
+
 		if (child < 0) {
 			 tst_resm(TINFO, "System resource may be too low, fork() malloc()"
 				  " etc are likely to fail.");
@@ -210,19 +199,15 @@ int runtest()
 	/*
 	 * Wait for children to finish.
 	 */
-
 	count = 0;
-	while(1)
-	{
+	while (1) {
 		if ((child = wait(&status)) >= 0) {
 			if (status) {
-				tst_resm(TFAIL,0, "Test{%d} failed, expected 0 exit", child);
+				tst_resm(TFAIL, "Test{%d} failed, expected 0 exit", child);
 				local_flag = FAILED;
 			}
 			++count;
-		}
-		else
-		{
+		} else {
 			if (errno != EINTR)
 				break;
 		}
@@ -231,20 +216,19 @@ int runtest()
 	/*
 	 * Should have collected all children.
 	 */
-
 	if (count != nwait) {
 		tst_resm(TFAIL, "Wrong # children waited on, count = %d", count);
 		local_flag = FAILED;
 	}
 
-	if (local_flag == PASSED) {
+	if (local_flag == PASSED)
 		tst_resm(TPASS, "Test passed in fork and wait.");
-	} else {
+	else
 		tst_resm(TFAIL, "Test failed in fork and wait.");
-	}
 
 	chdir(homedir);
 	pid = fork();
+
 	if (pid < 0) {
 
 		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
@@ -254,18 +238,18 @@ int runtest()
 		sync();
 		tst_exit();
 	}
+
 	if (pid == 0) {
 		execl("/bin/rm", "rm", "-rf", fuss, NULL);
 		tst_exit();
 	}
 
 	wait(&status);
-	if (status) {
+
+	if (status)
 		tst_resm(TINFO, "CAUTION - ftest1, '%s' may not be removed", fuss);
-	}
 
-	sync();				/* safeness */
-	return 0;
+	sync();
 }
 
 /*
@@ -278,9 +262,7 @@ int runtest()
 
 #define	NMISC	4
 enum	m_type { m_fsync, m_trunc, m_sync, m_fstat };
-char	*m_str[] = {
-		"fsync",   "trunc", "sync", "fstat"
-};
+char	*m_str[] = { "fsync", "trunc", "sync", "fstat" };
 
 int	misc_cnt[NMISC];		/* counts # of each kind of misc */
 int	file_max;			/* file-max size */
@@ -292,50 +274,42 @@ enum	m_type type = m_fsync;
 #define	CHUNK(i)	((i) * csize)
 #define	NEXTMISC	((rand() % misc_intvl) + 5)
 
-int dotest(testers, me, fd)
-	int	testers;
-	int	me;
-	int	fd;
-{
-	register int	i;
-	char	*bits;
-	char	*hold_bits;
-	char	*buf;
-	char	*val_buf;
-	char	*zero_buf;
-	int	count;
-	int	collide;
-	char	val;
-	int	chunk;
-	int	whenmisc;
-	int	xfr;
+static void dotest(int testers, int me, int fd)
+{
+	char *bits, *hold_bits, *buf, *val_buf, *zero_buf;
+	char val;
+	int count, collide, chunk, whenmisc, xfr, i;
 
 	nchunks = max_size / csize;
-	if( (bits = (char*)calloc((nchunks+7)/8, 1)) == 0) {
+
+	if ((bits = calloc((nchunks+7)/8, 1)) == 0) {
 		tst_resm(TBROK, "Test broken due to inability of malloc(bits).");
 		tst_exit();
 	}
-	if( (hold_bits = (char*)calloc((nchunks+7)/8, 1)) == 0) {
+
+	if ((hold_bits = calloc((nchunks+7)/8, 1)) == 0) {
 		tst_resm(TBROK, "Test broken due to inability of malloc(hold_bits).");
 		tst_exit();
 	}
-	if( (buf = (char*)(calloc(csize, 1))) == 0) {
+
+	if ((buf = (calloc(csize, 1))) == 0) {
 		tst_resm(TBROK, "Test broken due to inability of malloc(buf).");
 		tst_exit();
 	}
-	if( (val_buf = (char*)(calloc(csize, 1))) == 0) {
+
+	if ((val_buf = (calloc(csize, 1))) == 0) {
 		tst_resm(TBROK, "Test broken due to inability of malloc(val_buf).");
 		tst_exit();
 	}
-	if( (zero_buf = (char*)(calloc(csize, 1))) == 0) {
-		tst_resm(TBROK, "Test broken due to inability of malloc(zero_buf)(zero_buf)(zero_buf)(zero_buf)(zero_buf)(zero_buf)(zero_buf)(zero_buf)(zero_buf).");
+
+	if ((zero_buf = (calloc(csize, 1))) == 0) {
+		tst_resm(TBROK, "Test broken due to inability of malloc(zero_buf).");
 		tst_exit();
 	}
 
 	/*
 	 * No init sectors; allow file to be sparse.
 	 */
-
 	val = (64/testers) * me + 1;
 
 	/*
@@ -354,9 +328,12 @@ int dotest(testers, me, fd)
 	 */
 
 	srand(getpid());
-	if (misc_intvl) whenmisc = NEXTMISC;
-	while(iterations-- > 0) {
-		for(i = 0; i < NMISC; i++)
+
+	if (misc_intvl)
+		whenmisc = NEXTMISC;
+
+	while (iterations-- > 0) {
+		for (i = 0; i < NMISC; i++)
 			misc_cnt[i] = 0;
 		ftruncate(fd, 0);
 		file_max = 0;
@@ -366,12 +343,12 @@ int dotest(testers, me, fd)
 		bfill(zero_buf, 0, csize);
 		count = 0;
 		collide = 0;
-		while(count < nchunks) {
+		while (count < nchunks) {
 			chunk = rand() % nchunks;
 			/*
 			 * Read it.
 			 */
-			if (lseek(fd, (long)CHUNK(chunk), 0) < 0) {
+			if (lseek(fd, CHUNK(chunk), 0) < 0) {
 				tst_resm(TFAIL, "Test[%d]: lseek(0) fail at %x, errno = %d.",
 				         me, CHUNK(chunk), errno);
 
@@ -438,7 +415,7 @@ int dotest(testers, me, fd)
 			/*
 			 * Write it.
 			 */
-			if (lseek(fd, -((long)xfr), 1) <  0) {
+			if (lseek(fd, -xfr, 1) <  0) {
 				tst_resm(TFAIL, "Test[%d]: lseek(1) fail at %x, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
@@ -470,34 +447,28 @@ int dotest(testers, me, fd)
 		/*
 		 * End of iteration, maybe before doing all chunks.
 		 */
-
 		fsync(fd);
-		++misc_cnt[(int)m_fsync];
+		++misc_cnt[m_fsync];
 		//tst_resm(TINFO, "Test{%d} val %d done, count = %d, collide = {%d}",
 		//		me, val, count, collide);
 		//for(i = 0; i < NMISC; i++)
 		//	tst_resm(TINFO, "Test{%d}: {%d} %s's.", me, misc_cnt[i], m_str[i]);
 		++val;
 	}
-	return 0;
 }
 
 /*
  * domisc()
  *	Inject misc syscalls into the thing.
  */
-
-int domisc(me, fd, bits)
-	int	me;
-	int	fd;
-	char	*bits;
+static void domisc(int me, int fd, char *bits)
 {
-	register int	chunk;
-	struct	stat sb;
+	int chunk;
+	struct stat sb;
 
-	if ((int) type > (int) m_fstat)
+	if (type > m_fstat)
 		type = m_fsync;
-	switch(type) {
+	switch (type) {
 	case m_fsync:
 		if (fsync(fd) < 0) {
 			tst_resm(TFAIL, "Test[%d]: fsync error %d.", me, errno);
@@ -523,9 +494,9 @@ int domisc(me, fd, bits)
 			}
 			tr_flag = 1;
 		}
-		for(; chunk%8 != 0; chunk++)
+		for (; chunk%8 != 0; chunk++)
 			bits[chunk/8] &= ~(1<<(chunk%8));
-		for(; chunk < nchunks; chunk += 8)
+		for (; chunk < nchunks; chunk += 8)
 			bits[chunk/8] = 0;
 		break;
 	case m_sync:
@@ -537,47 +508,40 @@ int domisc(me, fd, bits)
 			tst_exit();
 		}
 		if (sb.st_size != file_max) {
-			tst_resm(TFAIL, "\tTest[%d]: fstat() mismatch; st_size=%x,file_max=%x.",
-				me, sb.st_size, file_max);
+			tst_resm(TFAIL, "\tTest[%d]: fstat() mismatch; st_size=%"PRIx64",file_max=%x.",
+				me, (int64_t)sb.st_size, file_max);
 			tst_exit();
 		}
 		break;
 	}
-	++misc_cnt[(int)type];
-	type = (enum m_type) ((int) type + 1);
-	return 0;
+
+	++misc_cnt[type];
+	++type;
 }
 
-int bfill(buf, val, size)
-	register char *buf;
-	char	val;
-	register int size;
+static void bfill(char *buf, char val, int size)
 {
-	register int i;
+	int i;
 
-	for(i = 0; i < size; i++)
+	for (i = 0; i < size; i++)
 		buf[i] = val;
-	return 0;
 }
 
 /*
  * dumpbuf
  *	Dump the buffer.
  */
-
-int dumpbuf(buf)
-	register char *buf;
+static void dumpbuf(char *buf)
 {
-	register int i;
-	char	val;
-	int	idx;
-	int	nout;
+	char val;
+	int idx, nout, i;
 
 	tst_resm(TINFO, "\tBuf:");
 	nout = 0;
 	idx = 0;
 	val = buf[0];
-	for(i = 0; i < csize; i++) {
+
+	for (i = 0; i < csize; i++) {
 		if (buf[i] != val) {
 			if (i == idx+1)
 				tst_resm(TINFO, "\t%x, ", buf[idx] & 0xff);
@@ -588,66 +552,57 @@ int dumpbuf(buf)
 		}
 		if (nout > 10) {
 			tst_resm(TINFO, "\t ... more");
-			return 0;
+			return;
 		}
 	}
+
 	if (i == idx+1)
 		tst_resm(TINFO, "\t%x", buf[idx] & 0xff);
 	else
 		tst_resm(TINFO, "\t%d*%x", i-idx, buf[idx]);
-	return 0;
 }
 
 /*
  * dumpbits
  *	Dump the bit-map.
  */
-
-int dumpbits(bits, size)
-	char	*bits;
-	register int size;
+static void dumpbits(char *bits, int size)
 {
-	register char *buf;
+	char *buf;
 
 	tst_resm(TINFO, "\tBits array:");
-	for(buf = bits; size > 0; --size, ++buf) {
+
+	for (buf = bits; size > 0; --size, ++buf) {
 		if ((buf-bits) % 16 == 0)
 			tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
-		tst_resm(TINFO, "\t%02x ", (int)*buf & 0xff);
+		tst_resm(TINFO, "\t%02x ", *buf & 0xff);
 	}
+
 	tst_resm(TINFO, "\t");
-	return 0;
 }
 
-int orbits(hold, bits, count)
-	register char *hold;
-	register char *bits;
-	register int count;
+static void orbits(char *hold, char *bits, int count)
 {
-	while(count-- > 0)
+	while (count-- > 0)
 		*hold++ |= *bits++;
-	return 0;
 }
 
-/* term()
- *
- *	This is called when a SIGTERM signal arrives.
+/*
+ * SIGTERM signal handler.
  */
-
-void term()
+static void term(int sig)
 {
-	register int i;
+	int i;
 
 	tst_resm(TINFO, "\tterm -[%d]- got sig term.", getpid());
 
 	/*
 	 * If run by hand we like to have the parent send the signal to
-	 * the child processes.  This makes life easy.
+	 * the child processes.
 	 */
-
 	if (parent_pid == getpid()) {
-		for (i=0; i < nchild; i++)
-			if (pidlist[i])		/* avoid embarassment */
+		for (i = 0; i < nchild; i++)
+			if (pidlist[i])
 				kill(pidlist[i], SIGTERM);
 		tst_exit();
 	}
@@ -655,17 +610,17 @@ void term()
 	tst_resm(TINFO, "\tunlinking '%s'", test_name);
 
 	close(fd);
+
 	if (unlink(test_name))
 		tst_resm(TBROK, "Unlink of '%s' failed, errno = %d.",
 		  test_name, errno);
 	else
 		tst_resm(TINFO, "Unlink of '%s' successful.", test_name);
+
 	tst_exit();
 }
 
-
-void
-cleanup()
+static void cleanup(void)
 {
 	/*
          * print timing stats if that option was specified.
@@ -674,6 +629,4 @@ cleanup()
         TEST_CLEANUP;
 
 	tst_rmdir();
-        tst_exit();
 }
-
Index: ltp/testcases/kernel/fs/ftest/ftest02.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest02.c
+++ ltp/testcases/kernel/fs/ftest/ftest02.c
@@ -43,8 +43,8 @@
  */
 
 
-#include <stdio.h>		/* needed by testhead.h		*/
-#include "test.h"	/* standard test header		*/
+#include <stdio.h>
+#include "test.h"
 #include "usctest.h"
 #include <sys/types.h>
 #include <sys/param.h>
@@ -53,10 +53,10 @@
 #include <sys/stat.h>
 #include <errno.h>
 #include <sys/mount.h>
-#include <signal.h>		/* DEM - added SIGTERM support */
+#include <signal.h>
 #include <unistd.h>
 
-#define MAXCHILD	25	/* max number of children to allow */
+#define MAXCHILD	25
 #define K_1		1024
 #define K_2		2048
 #define K_4		4096
@@ -69,22 +69,18 @@ extern int Tst_count;
 #define PASSED 1
 #define FAILED 0
 
-void crfile(int, int);
-void unlfile(int, int);
-void fussdir(int, int);
-int dotest(int, int);
-void Warn(int, char*, char*);
-int mkname(char*, int, int);
-int term();
-void cleanup();
-
-/*--------------------------------------------------------------*/
-
+static void crfile(int, int);
+static void unlfile(int, int);
+static void fussdir(int, int);
+static void dotest(int, int);
+static void dowarn(int, char*, char*);
+static void mkname(char*, int, int);
+static void term(int sig);
+static void cleanup(void);
 
 #define	M	(1024*1024)
-/* #define temp stderr */
 
-int	iterations;			/* # total iterations */
+int	iterations;
 int	nchild;
 int	parent_pid;
 int	pidlist[MAXCHILD];
@@ -101,27 +97,18 @@ char 	*cwd;
 char 	*fstyp;
 int 	local_flag;
 
-/*--------------------------------------------------------------*/
-int main (ac, av)
-	int  ac;
-	char *av[];
+int main(int ac, char *av[])
 {
-	register int k, j;
-	int	pid;
-	int	child;
-	int	status;
-	int	count;
-	char	name[128];
-
+	int k, j, pid, child, status, count;
+	char name[128];
 
 	/*
 	 * Default values for run conditions.
 	 */
-
 	iterations = 50;
 	nchild = 5;
 
-	if (signal(SIGTERM, (void (*)())term) == SIG_ERR) {
+	if (signal(SIGTERM, term) == SIG_ERR) {
 		tst_resm(TFAIL, "first signal failed");
 		tst_exit();
 	}
@@ -129,8 +116,6 @@ int main (ac, av)
 	/*
 	 * Make a directory to do this in; ignore error if already exists.
 	 */
-
-
 	local_flag = PASSED;
 	parent_pid = getpid();
 	tst_tmpdir();
@@ -165,8 +150,8 @@ int main (ac, av)
 
 
 	for(k = 0; k < nchild; k++) {
-		if ((child = fork()) == 0) {		/* child */
-			dotest(k, iterations);		/* do it! */
+		if ((child = fork()) == 0) {
+			dotest(k, iterations);
 			exit(0);
 		}
 		if (child < 0) {
@@ -176,12 +161,11 @@ int main (ac, av)
 			cleanup();
 		}
 		pidlist[k] = child;
-	} /* end for */
+	}
 
-		/*
-		 * Wait for children to finish.
+	/*
+	 * Wait for children to finish.
 	 */
-
 	count = 0;
 	while((child = wait(&status)) > 0) {
 		//tst_resm(TINFO,"Test{%d} exited status = 0x%x", child, status);
@@ -196,22 +180,21 @@ int main (ac, av)
 	/*
 	 * Should have collected all children.
 	 */
-
 	if (count != nchild) {
 		tst_resm(TFAIL,"Wrong # children waited on, count = %d", count);
 		local_flag = FAILED;
 	}
 
-	if (local_flag == FAILED) {
+	if (local_flag == FAILED)
 		tst_resm(TFAIL, "Test failed in fork-wait part.");
-	} else {
+	else
 		tst_resm(TPASS, "Test passed in fork-wait part.");
-	}
 
 	if (iterations > 26)
 		iterations = 26;
-	for (k=0; k < nchild; k++)
-		for (j=0; j < iterations + 1; j++) {
+
+	for (k = 0; k < nchild; k++)
+		for (j = 0; j < iterations + 1; j++) {
 			mkname(name, k, j);
 			rmdir(name);
 			unlink(name);
@@ -220,51 +203,51 @@ int main (ac, av)
 	chdir(startdir);
 
 	pid = fork();
+
 	if (pid < 0) {
 		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
 				    " etc are likely to fail.");
 		tst_resm(TBROK, "Test broken due to inability of fork.");
 		cleanup();
 	}
+
 	if (pid == 0) {
 		execl("/bin/rm", "rm", "-rf", homedir, NULL);
 		exit(1);
 	} else
 		wait(&status);
+
 	if (status)
 		tst_resm(TINFO,"CAUTION - ftest02, '%s' may not have been removed.",
 		  homedir);
 
 	pid = fork();
+
 	if (pid < 0) {
 		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
 	                        " etc are likely to fail.");
 	        tst_resm(TBROK, "Test broken due to inability of fork.");
 	        cleanup();
 	}
+
 	if (pid == 0) {
 		execl("/bin/rm", "rm", "-rf", dirname, NULL);
 		exit(1);
 	} else
 		wait(&status);
+
 	if (status) {
 		tst_resm(TINFO,"CAUTION - ftest02, '%s' may not have been removed.",
 		  dirname);
 	}
 
-	sync();				/* safeness */
+	sync();
 
 	cleanup();
-
-	return 0;
-
+	tst_exit();
 }
 
-/*--------------------------------------------------------------*/
-
-
-
-#define	warn(val,m1,m2)	if ((val) < 0) Warn(me,m1,m2)
+#define	warn(val,m1,m2)	if ((val) < 0) dowarn(me,m1,m2)
 
 /*
  * crfile()
@@ -273,7 +256,7 @@ int main (ac, av)
 
 char	crmsg[] = "Gee, let's write something in the file!\n";
 
-void crfile(me, count)
+static void crfile(int me, int count)
 {
 	int	fd;
 	int	val;
@@ -285,7 +268,7 @@ void crfile(me, count)
 	fd = open(fname, O_RDWR|O_CREAT|O_TRUNC, 0666);
 	if (fd < 0 && errno == EISDIR) {
 		val = rmdir(fname);
-		warn(val, (char*)"rmdir", fname);
+		warn(val, "rmdir", fname);
 		fd = open(fname, O_RDWR|O_CREAT|O_TRUNC, 0666);
 	}
 	warn(fd, "creating", fname);
@@ -302,7 +285,8 @@ void crfile(me, count)
 	val = read(fd, buf, sizeof(crmsg)-1);
 	warn(val, "read", 0);
 
-	if (strncmp(crmsg, buf, sizeof(crmsg)-1)) Warn(me, "compare", 0);
+	if (strncmp(crmsg, buf, sizeof(crmsg)-1))
+		dowarn(me, "compare", 0);
 
 	val = close(fd);
 	warn(val, "close", 0);
@@ -312,16 +296,17 @@ void crfile(me, count)
  * unlfile()
  *	Unlink some of the files.
  */
-
-void unlfile(me, count)
+static void unlfile(int me, int count)
 {
 	int	i;
 	int	val;
 	char	fname[128];
 
 	i = count - 10;
+
 	if (i < 0)
 		i = 0;
+
 	for(; i < count; i++) {
 		mkname(fname, me, i);
 		val = rmdir(fname);
@@ -329,7 +314,7 @@ void unlfile(me, count)
 			val = unlink(fname);
 		if (val == 0 || errno == ENOENT)
 			continue;
-		Warn(me, "unlink", fname);
+		dowarn(me, "unlink", fname);
 	}
 }
 
@@ -339,8 +324,7 @@ void unlfile(me, count)
  *
  * Randomly leave the directory there.
  */
-
-void fussdir(me, count)
+static void fussdir(int me, int count)
 {
 	int	val;
 	char	dir[128];
@@ -404,8 +388,6 @@ void fussdir(me, count)
  *
  * Randomly do an inode thing; loop for # iterations.
  */
-
-
 #define	THING(p)	{p, "p"}
 
 struct	ino_thing {
@@ -423,12 +405,9 @@ struct	ino_thing {
 int	thing_cnt[NTHING];
 int	thing_last[NTHING];
 
-int dotest(me, count)
-	int	me;
-	int	count;
+static void dotest(int me, int count)
 {
-	int	i;
-	int	thing;
+	int i, thing;
 
 	//tst_resm(TINFO,"Test %d pid %d starting.", me, getpid());
 
@@ -440,93 +419,84 @@ int dotest(me, count)
 	}
 
 	//tst_resm(TINFO,"Test %d pid %d exiting.", me, getpid());
-	return 0;
 }
 
 
-void Warn(me, m1, m2)
-	int	me;
-	char	*m1;
-	char	*m2;
+static void dowarn(int me, char *m1, char *m2)
 {
-	int	err = errno;
+	int err = errno;
 
 	tst_resm(TBROK,"Test[%d]: error %d on %s %s",
 		me, err, m1, (m2 ? m2 : ""));
 	tst_exit();
 }
 
-int mkname(name, me, idx)
-	register char	*name;
+static void mkname(char *name, int me, int idx)
 {
-	register int len;
+	int len;
+
+	strcpy(name, dirname);
 
-	(void) strcpy(name, dirname);
 	if (name[0]) {
 		len = dirlen+1;
 		name[len-1] = '/';
 	} else
 		len = 0;
+
 	name[len+0] = 'A' + (me % 26);
 	name[len+1] = 'a' + (idx % 26);
 	name[len+2] = '\0';
-	return 0;
 }
 
-/*--------------------------------------------------------------*/
-
-/* term1()
- *
- *	Parent - this is called when a SIGTERM signal arrives.
+/*
+ * SIGTERM signal handler.
  */
-
-int term()
+static void term(int sig)
 {
-	register int i;
-
-	//tst_resm(TINFO, "term -[%d]- got sig term.", getpid());
+	int i;
 
 	if (parent_pid == getpid()) {
-		for (i=0; i < nchild; i++)
-			if (pidlist[i])		/* avoid embarassment */
+		for (i = 0; i < nchild; i++)
+			if (pidlist[i])
 				kill(pidlist[i], SIGTERM);
-		return 0;
+		return;
 	}
 
 	tst_resm(TBROK, "Child process exiting.");
 	tst_exit();
-	return 0;
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	char mount_buffer[1024];
 
 	if (mnt == 1) {
-		if (chdir(startdir) < 0) {
+
+		if (chdir(startdir) < 0)
 			tst_resm(TBROK,"Could not change to %s ", startdir);
-		}
+
 		if (!strcmp(fstyp, "cfs")) {
-			sprintf(mount_buffer, "/etc/umount %s", partition);
+
+			sprintf(mount_buffer, "/bin/umount %s", partition);
+
 			if (system(mount_buffer) != 0) {
+
 				tst_resm(TBROK,"Unable to unmount %s from %s ", partition, mntpoint);
-				if (umount(partition)) {
+
+				if (umount(partition))
 					tst_resm(TBROK,"Unable to unmount %s from %s ", partition, mntpoint);
-				}
-				else {
-					tst_resm(TINFO, "Forced umount for %s, /etc/mnttab now dirty", partition );
-				}
+				else
+					tst_resm(TINFO, "Forced umount for %s, /etc/mtab now dirty", partition);
 			}
-		}
-		else {
-			if (umount(partition)) {
+
+		} else
+			if (umount(partition))
 				tst_resm(TBROK,"Unable to unmount %s from %s ", partition, mntpoint);
-			}
-		}
-		if (rmdir(mntpoint) != 0) {
+
+		if (rmdir(mntpoint) != 0)
 			tst_resm(TBROK,"Unable to rmdir %s ", mntpoint);
-		}
+
 	}
+
 	tst_rmdir();
-	tst_exit();
 }
Index: ltp/testcases/kernel/fs/ftest/ftest03.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest03.c
+++ ltp/testcases/kernel/fs/ftest/ftest03.c
@@ -59,8 +59,9 @@
 #include <errno.h>
 #include <sys/uio.h>
 #include <fcntl.h>
-#include <signal.h>		/* DEM - added SIGTERM support */
-#include <stdio.h>		/* needed by testhead.h		*/
+#include <signal.h>
+#include <stdio.h>
+#include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
 
@@ -71,15 +72,15 @@ extern int Tst_count;
 #define PASSED 1
 #define FAILED 0
 
-void setup();
-int runtest();
-int dotest(int, int, int);
-int domisc(int, int, char*);
-int bfill(char*, char, int);
-int dumpiov(struct iovec*);
-int dumpbits(char*, int);
-int orbits(char*, char*, int);
-int term();
+static void setup(void);
+static void runtest(void);
+static void dotest(int, int, int);
+static void domisc(int, int, char*);
+static void bfill(char*, char, int);
+static void dumpiov(struct iovec*);
+static void dumpbits(char*, int);
+static void orbits(char*, char*, int);
+static void term(int sig);
 
 #define MAXCHILD	25	/* max number of children to allow */
 #define K_1		1024
@@ -87,7 +88,6 @@ int term();
 #define K_4		4096
 #define	MAXIOVCNT	16
 
-
 int	csize;				/* chunk size */
 int	iterations;			/* # total iterations */
 int	max_size;			/* max file size */
@@ -104,21 +104,18 @@ char	fuss[40] = "";		/* directory to do 
 char	homedir[200]= "";	/* where we started */
 
 int 	local_flag;
-/*--------------------------------------------------------------*/
-int main (ac, av)
-	int  ac;
-	char *av[];
+
+int main (int ac, char *av[])
 {
-        int lc;                 /* loop counter */
-        char *msg;              /* message returned from parse_opts */
+        int lc;
+        char *msg;
 
         /*
          * parse standard options
          */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
+        if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
 	                tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);
 			tst_exit();
-                        /*NOTREACHED*/
         }
 
 	setup();
@@ -136,26 +133,26 @@ int main (ac, av)
                 }
 
 		tst_rmdir();
+		/* ??? so we are doing only one loop here ??? */
 		tst_exit();
-	} /* end for */
+	}
+
 	return 0;
 }
-/*--------------------------------------------------------------*/
 
-void
-setup()
+static void setup(void)
 {
-	char wdbuf[MAXPATHLEN],  *cwd ;
-	int term();
+	char wdbuf[MAXPATHLEN];
 
 	/*
 	 * Make a directory to do this in; ignore error if already exists.
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	if ( (cwd = getcwd(homedir, sizeof( homedir))) == NULL ) {
-	  tst_resm(TBROK, "pwd") ;
-	  tst_exit() ;
+
+	if (getcwd(homedir, sizeof(homedir)) == NULL) {
+		tst_resm(TBROK, "getcwd() failed");
+		tst_exit();
 	}
 
 	parent_pid = getpid();
@@ -170,47 +167,41 @@ setup()
 		tst_exit() ;
 	}
 
-
 	/*
 	 * Default values for run conditions.
 	 */
-
 	iterations = 10;
 	nchild = 5;
 	csize = K_2;		/* should run with 1, 2, and 4 K sizes */
 	max_size = K_1 * K_1;
 	misc_intvl = 10;
 
-	if (sigset(SIGTERM, (void (*)())term) == SIG_ERR) {
+	if (sigset(SIGTERM, term) == SIG_ERR) {
 		perror("sigset failed");
 		tst_resm(TBROK, " sigset failed: signo = 15") ;
 		tst_exit() ;
 	}
-
 }
 
-
-int runtest()
+static void runtest(void)
 {
-	register int i;
-	int	pid;
-	int	child;
-	int	status;
-	int	count;
-
-
+	int i, pid, child, status, count;
 
 	for(i = 0; i < nchild; i++) {
+
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
+
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
+
 		if (fd < 0) {
 			tst_resm(TBROK, "\tError %d creating %s/%s.", errno, fuss, test_name);
 			tst_exit();
 		}
-		if ((child = fork()) == 0) {		/* child */
-			dotest(nchild, i, fd);		/* do it! */
-			tst_exit();			/* when done, exit */
+
+		if ((child = fork()) == 0) {
+			dotest(nchild, i, fd);
+			tst_exit();
 		}
 
 		close(fd);
@@ -230,29 +221,25 @@ int runtest()
 	/*
 	 * Wait for children to finish.
 	 */
-
 	count = 0;
-	while(1)
-	{
-	if ((child = wait(&status)) >= 0) {
-		//tst_resm(TINFO, "\tTest{%d} exited status = 0x%x", child, status);
-		if (status) {
-			tst_resm(TFAIL, "\tTest{%d} failed, expected 0 exit.", child);
-			local_flag = FAILED;
+
+	while (1) {
+		if ((child = wait(&status)) >= 0) {
+			//tst_resm(TINFO, "\tTest{%d} exited status = 0x%x", child, status);
+			if (status) {
+				tst_resm(TFAIL, "\tTest{%d} failed, expected 0 exit.", child);
+				local_flag = FAILED;
+			}
+			++count;
+		} else {
+			if (errno != EINTR)
+				break;
 		}
-		++count;
-	}
-	else
-	{
-		if (errno != EINTR)
-			break;
-	}
 	}
 
 	/*
 	 * Should have collected all children.
 	 */
-
 	if (count != nwait) {
 		tst_resm(TFAIL, "\tWrong # children waited on, count = %d", count);
 		local_flag = FAILED;
@@ -261,11 +248,12 @@ int runtest()
 	chdir(homedir);
 
 	pid = fork();
+
 	if (pid < 0) {
 		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
                               " etc are likely to fail.");
                 tst_resm(TBROK, "Test broken due to inability of fork.");
-		sync();				/* safeness */
+		sync();
 		tst_exit();
 	}
 
@@ -274,14 +262,14 @@ int runtest()
 		tst_exit();
 	} else
 		wait(&status);
+
 	if (status) {
 		tst_resm(TINFO, "CAUTION - ftest03, '%s' may not be removed", fuss);
 		tst_resm(TINFO, "CAUTION - ftest03, '%s' may not be removed",
 		  fuss);
 	}
 
-	sync();				/* safeness */
-	return 0;
+	sync();
 }
 
 /*
@@ -308,20 +296,11 @@ enum	m_type type = m_fsync;
 #define	CHUNK(i)	((i) * csize)
 #define	NEXTMISC	((rand() % misc_intvl) + 5)
 
-int dotest(testers, me, fd)
-	int	testers;
-	int	me;
-	int	fd;
+static void dotest(int testers, int me, int fd)
 {
-	register int	i;
-	char	*bits;
-	char	*hold_bits;
-	int	count;
-	int	collide;
-	char	val;
-	int	chunk;
-	int	whenmisc;
-	int	xfr;
+	char *bits, *hold_bits;
+	char val;
+	int chunk, whenmisc, xfr, count, collide, i;
 
 	/* Stuff for the readv call */
 	struct	iovec	r_iovec[MAXIOVCNT];
@@ -329,30 +308,29 @@ int dotest(testers, me, fd)
 
 	/* Stuff for the writev call */
 	struct	iovec	val_iovec[MAXIOVCNT];
-
 	struct	iovec	zero_iovec[MAXIOVCNT];
 	int	w_ioveclen;
 
 	nchunks = max_size / csize;
-	if( (bits = (char*)malloc((nchunks+7) / 8)) == 0) {
+
+	if ((bits = malloc((nchunks+7) / 8)) == 0) {
 		tst_resm(TBROK, "\tmalloc failed");
 		tst_exit();
 	}
-	if( (hold_bits = (char*)malloc((nchunks+7) / 8)) == 0) {
+
+	if((hold_bits = malloc((nchunks+7) / 8)) == 0) {
 		tst_resm(TBROK, "\tmalloc failed");
 		tst_exit();
 	}
 
-	/*Allocate memory for the iovec buffers and init the iovec arrays
-	 */
+	/*Allocate memory for the iovec buffers and init the iovec arrays*/
 	r_ioveclen = w_ioveclen = csize / MAXIOVCNT;
 
-		/* Please note that the above statement implies that csize
-		 * be evenly divisible by MAXIOVCNT.
-		 */
-
+	/* Please note that the above statement implies that csize
+	 * be evenly divisible by MAXIOVCNT.
+	 */
 	for (i = 0; i < MAXIOVCNT; i++) {
-		if( (r_iovec[i].iov_base = (char*)calloc(r_ioveclen, 1)) == 0) {
+		if ((r_iovec[i].iov_base = calloc(r_ioveclen, 1)) == 0) {
 			tst_brkm(TBROK, NULL, "\tmalloc failed");
 			/* tst_exit(); */
 		}
@@ -361,27 +339,30 @@ int dotest(testers, me, fd)
 		/* Allocate unused memory areas between all the buffers to
 		 * make things more diffult for the OS.
 		 */
-
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_brkm(TBROK,NULL, "\tmalloc failed");
 		}
-		if( (val_iovec[i].iov_base = (char*)calloc(w_ioveclen, 1)) == 0) {
+
+		if ((val_iovec[i].iov_base = calloc(w_ioveclen, 1)) == 0) {
 			tst_resm(TBROK, "\tmalloc failed");
 			tst_exit();
 		}
+
 		val_iovec[i].iov_len = w_ioveclen;
 	
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed");
 			tst_exit();
 		}
-		if( (zero_iovec[i].iov_base = (char*)calloc(w_ioveclen, 1)) == 0) {
+
+		if ((zero_iovec[i].iov_base = calloc(w_ioveclen, 1)) == 0) {
 			tst_resm(TBROK, "\tmalloc failed");
 			tst_exit();
 		}
+
 		zero_iovec[i].iov_len = w_ioveclen;
 
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed");
 			tst_exit();
 		}
@@ -406,11 +387,16 @@ int dotest(testers, me, fd)
 	 *	++val.
          */
 
-	 srand(getpid());
-	 if (misc_intvl) whenmisc = NEXTMISC;
- 	while(iterations-- > 0) {
+	srand(getpid());
+
+	if (misc_intvl)
+		whenmisc = NEXTMISC;
+
+	while (iterations-- > 0) {
+
 		for(i = 0; i < NMISC; i++)
 			misc_cnt[i] = 0;
+
 		ftruncate(fd,0);
 		file_max = 0;
 		bfill(bits, 0, (nchunks+7) / 8);
@@ -418,19 +404,21 @@ int dotest(testers, me, fd)
 
 		/* Have to fill the val and zero iov buffers in a different manner
 		 */
-		for(i = 0; i < MAXIOVCNT; i++) {
+		for (i = 0; i < MAXIOVCNT; i++) {
 			bfill(val_iovec[i].iov_base,val,val_iovec[i].iov_len);
 			bfill(zero_iovec[i].iov_base,0,zero_iovec[i].iov_len);
 
 		}
+
 		count = 0;
 		collide = 0;
-		while(count < nchunks) {
+
+		while (count < nchunks) {
 			chunk = rand() % nchunks;
 			/*
 			 * Read it.
 			 */
-			if (lseek(fd, (long)CHUNK(chunk), 0) < 0) {
+			if (lseek(fd, CHUNK(chunk), 0) < 0) {
 				tst_resm(TFAIL, "\tTest[%d]: lseek(0) fail at %x, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
@@ -498,7 +486,7 @@ int dotest(testers, me, fd)
 			/*
 			 * Writev it.
 			 */
-			if (lseek(fd, -((long)xfr), 1) <  0) {
+			if (lseek(fd, -xfr, 1) <  0) {
 				tst_resm(TFAIL, "\tTest[%d]: lseek(1) fail at %x, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
@@ -532,31 +520,26 @@ int dotest(testers, me, fd)
 		 */
 
 		fsync(fd);
-		++misc_cnt[(int)m_fsync];
+		++misc_cnt[m_fsync];
 		//tst_resm(TINFO, "\tTest{%d} val %d done, count = %d, collide = {%d}",
 	        //		me, val, count, collide);
 		//for(i = 0; i < NMISC; i++)
 		//	tst_resm(TINFO, "\t\tTest{%d}: {%d} %s's.", me, misc_cnt[i], m_str[i]);
 		++val;
 	}
-	return 0;
 }
 
 /*
- * domisc()
  *	Inject misc syscalls into the thing.
  */
-
-int domisc(me, fd, bits)
-	int	me;
-	int	fd;
-	char	*bits;
+static void domisc(int me, int fd, char *bits)
 {
-	register int	chunk;
-	struct	stat sb;
+	int chunk;
+	struct stat sb;
 
-	if ((int) type > (int) m_fstat)
+	if (type > m_fstat)
 		type = m_fsync;
+
 	switch(type) {
 	case m_fsync:
 		if (fsync(fd) < 0) {
@@ -592,104 +575,90 @@ int domisc(me, fd, bits)
 			tst_exit();
 		}
 		if (sb.st_size != file_max) {
-			tst_resm(TFAIL, "\tTest[%d]: fstat() mismatch; st_size=%x,file_max=%x.",
-				me, sb.st_size, file_max);
+			tst_resm(TFAIL, "\tTest[%d]: fstat() mismatch; st_size=%"PRIx64",file_max=%x.",
+				me, (int64_t)sb.st_size, file_max);
 			tst_exit();
 		}
 		break;
 	}
-	++misc_cnt[(int)type];
-	type = (enum m_type) ((int) type + 1);
-	return 0;
+
+	++misc_cnt[type];
+	++type;
 }
 
-int bfill(buf, val, size)
-	register char *buf;
-	char	val;
-	register int size;
+static void bfill(char *buf, char val, int size)
 {
-	register int i;
+	int i;
 
-	for(i = 0; i < size; i++)
+	for (i = 0; i < size; i++)
 		buf[i] = val;
-	return 0;
 }
 
 /*
  * dumpiov
  *	Dump the contents of the r_iovec buffer.
  */
-
-int dumpiov(iovptr)
-	register struct iovec *iovptr;
+static void dumpiov(struct iovec *iovptr)
 {
-	register int i;
-	char	val;
-	int	idx;
-	int	nout;
+	int i;
+	char val, *buf;
+	int idx, nout;
 
 	nout = 0;
 	idx = 0;
-	val = ((char *)iovptr->iov_base)[0];
-	for(i = 0; i < iovptr->iov_len; i++) {
-		if (((char *)iovptr->iov_base)[i] != val) {
+
+	buf = (char*)iovptr->iov_base;
+	val = buf[0];
+
+	for (i = 0; i < iovptr->iov_len; i++) {
+
+		if (buf[i] != val) {
 			if (i == idx+1)
-				tst_resm(TINFO, "\t%x, ", ((char *)iovptr->iov_base)[idx] & 0xff);
+				tst_resm(TINFO, "\t%x, ", buf[idx] & 0xff);
 			else
-				tst_resm(TINFO, "\t%d*%x, ", i-idx, ((char *)iovptr->iov_base)[idx] & 0xff);
+				tst_resm(TINFO, "\t%d*%x, ", i-idx, buf[idx] & 0xff);
 			idx = i;
 			++nout;
 		}
+
 		if (nout > 10) {
 			tst_resm(TINFO, "\t ... more");
-			return 0;
+			return;
 		}
 	}
+
 	if (i == idx+1)
-		tst_resm(TINFO, "\t%x", ((char *)iovptr->iov_base)[idx] & 0xff);
+		tst_resm(TINFO, "\t%x", buf[idx] & 0xff);
 	else
-		tst_resm(TINFO, "\t%d*%x", i-idx, ((char *)iovptr->iov_base)[idx]);
-	return 0;
+		tst_resm(TINFO, "\t%d*%x", i-idx, buf[idx]);
 }
 
 /*
- * dumpbits
  *	Dump the bit-map.
  */
-
-int dumpbits(bits, size)
-	char	*bits;
-	register int size;
+static void dumpbits(char *bits, int size)
 {
-	register char *buf;
+	char *buf;
 
-	for(buf = bits; size > 0; --size, ++buf) {
+	for (buf = bits; size > 0; --size, ++buf) {
 		if ((buf-bits) % 16 == 0)
 			tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
-		tst_resm(TINFO, "\t%02x ", (int)*buf & 0xff);
+		tst_resm(TINFO, "\t%02x ", *buf & 0xff);
 	}
-	return 0;
 }
 
-int orbits(hold, bits, count)
-	register char *hold;
-	register char *bits;
-	register int count;
+static void orbits(char *hold, char *bits, int count)
 {
-	while(count-- > 0)
+	while (count-- > 0)
 		*hold++ |= *bits++;
-	return 0;
 }
 
-
-/* term()
- *
- *	This is called when a SIGTERM signal arrives.
+/*
+ * SIGTERM signal handler.
  */
-
-int term()
+static void term(int sig)
 {
-	register int i;
+	int i;
 
 	tst_resm(TINFO, "\tterm -[%d]- got sig term.", getpid());
 
@@ -697,22 +666,22 @@ int term()
 	 * If run by hand we like to have the parent send the signal to
 	 * the child processes.  This makes life easy.
 	 */
-
 	if (parent_pid == getpid()) {
-		for (i=0; i < nchild; i++)
-			if (pidlist[i])		/* avoid embarassment */
+		for (i = 0; i < nchild; i++)
+			if (pidlist[i])
 				kill(pidlist[i], SIGTERM);
-		return 0;
+		return;
 	}
 
 	tst_resm(TINFO, "\tunlinking '%s'", test_name);
 
 	close(fd);
+
 	if (unlink(test_name))
 		tst_resm(TBROK, "Unlink of '%s' failed, errno = %d.",
 		  test_name, errno);
 	else
 		tst_resm(TBROK, "Unlink of '%s' successful.", test_name);
+
 	tst_exit();
-	return 0;
 }

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--45Z9DzgjV8m4Oswq--

