Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MnYtF-0006EX-VM
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 14:20:17 +0000
Date: Tue, 15 Sep 2009 16:20:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090915142001.GA9600@schrodinger.suse.cz>
References: <20090909181541.GA31549@schrodinger.suse.cz>
	<1252847821.5357.39.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <1252847821.5357.39.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] ftest cleanup II
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
The previous patch had missing changes in Makefile and ftest04.c.
Fixed patch (that was tested on ltp cvs checkout) is attched.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--gBBFr7Ir9EOA20Yy
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="ftest_cleanup_II.patch"

Index: ltp/testcases/kernel/fs/ftest/ftest01.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest01.c
+++ ltp/testcases/kernel/fs/ftest/ftest01.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -58,6 +59,7 @@
 #include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
+#include "libftest.h"
 
 char *TCID = "ftest01";
 int TST_TOTAL = 1;
@@ -66,12 +68,8 @@ static void setup(void);
 static void runtest(void);
 static void dotest(int, int, int);
 static void domisc(int, int, char*);
-static void bfill(char*, char, int);
-static void dumpbuf(char*);
-static void dumpbits(char*, int);
-static void orbits(char*, char*, int);
 static void cleanup(void);
-static void term(int);
+static void term(int sig);
 
 #define PASSED 1
 #define FAILED 0
@@ -81,26 +79,23 @@ static void term(int);
 #define K_2		2048
 #define K_4		4096
 
-char progname[]= "ftest1()";	/* replace ++ with test name	*/
+static int csize;             /* chunk size */
+static int iterations;        /* # total iterations */
+static int max_size;          /* max file size */
+static int misc_intvl;        /* for doing misc things; 0 ==> no */
+static int nchild;            /* how many children */
+static int nwait;
+static int fd;                /* file descriptor used by child */
+static int parent_pid;
+static int pidlist[MAXCHILD];
+static char test_name[2];
 
-int	csize;				/* chunk size */
-int	iterations;			/* # total iterations */
-int	max_size;			/* max file size */
-int	misc_intvl;			/* for doing misc things; 0 ==> no */
-int	nchild;				/* how many children */
-int	nwait;
-int	fd;				/* file descriptor used by child */
-int	parent_pid;
-int	pidlist[MAXCHILD];
-char	test_name[2];
-char	*prog;
+static char fuss[40];         /* directory to do this in */
+static char homedir[200];     /* where we started */
 
-char	fuss[40] = "";		/* directory to do this in */
-char	homedir[200]= "";	/* where we started */
+static int local_flag;
 
-int 	local_flag;
-
-int main (int ac, char *av[])
+int main(int ac, char *av[])
 {
 	int lc;
         char *msg;
@@ -108,7 +103,7 @@ int main (int ac, char *av[])
         /*
          * parse standard options
          */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != NULL)
+        if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
                 tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
@@ -326,7 +321,6 @@ static void dotest(int testers, int me, 
 	 *		repeat until count = nchunks.
 	 *	++val.
 	 */
-
 	srand(getpid());
 
 	if (misc_intvl)
@@ -337,10 +331,10 @@ static void dotest(int testers, int me, 
 			misc_cnt[i] = 0;
 		ftruncate(fd, 0);
 		file_max = 0;
-		bfill(bits, 0, (nchunks+7)/8);
-		bfill(hold_bits, 0, (nchunks+7)/8);
-		bfill(val_buf, val, csize);
-		bfill(zero_buf, 0, csize);
+		memset(bits, 0, (nchunks+7)/8);
+		memset(hold_bits, 0, (nchunks+7)/8);
+		memset(val_buf, val, csize);
+		memset(zero_buf, 0, csize);
 		count = 0;
 		collide = 0;
 		while (count < nchunks) {
@@ -381,11 +375,11 @@ static void dotest(int testers, int me, 
 					tst_resm(TFAIL, "Test[%d]: last_trunc = 0x%x.",
 						me, last_trunc);
 					sync();
-					dumpbuf(buf);
-					dumpbits(bits, (nchunks+7)/8);
-					orbits(hold_bits, bits, (nchunks+7)/8);
+					ft_dumpbuf(buf, csize);
+					ft_dumpbits(bits, (nchunks+7)/8);
+					ft_orbits(hold_bits, bits, (nchunks+7)/8);
 					tst_resm(TINFO, "Hold ");
-					dumpbits(hold_bits, (nchunks+7)/8);
+					ft_dumpbits(hold_bits, (nchunks+7)/8);
 					tst_exit();
 				}
 				bits[chunk/8] |= (1<<(chunk%8));
@@ -404,11 +398,11 @@ static void dotest(int testers, int me, 
 					tst_resm(TFAIL, "Test[%d]: last_trunc = 0x%x.",
 						me, last_trunc);
 					sync();
-					dumpbuf(buf);
-					dumpbits(bits, (nchunks+7)/8);
-					orbits(hold_bits, bits, (nchunks+7)/8);
+					ft_dumpbuf(buf, csize);
+					ft_dumpbits(bits, (nchunks+7)/8);
+					ft_orbits(hold_bits, bits, (nchunks+7)/8);
 					tst_resm(TINFO, "Hold ");
-					dumpbits(hold_bits, (nchunks+7)/8);
+					ft_dumpbits(hold_bits, (nchunks+7)/8);
 					tst_exit();
 				}
 			}
@@ -436,7 +430,7 @@ static void dotest(int testers, int me, 
 			 * If hit "misc" interval, do it.
 			 */
 			if (misc_intvl && --whenmisc <= 0) {
-				orbits(hold_bits, bits, (nchunks+7)/8);
+				ft_orbits(hold_bits, bits, (nchunks+7)/8);
 				domisc(me, fd, bits);
 				whenmisc = NEXTMISC;
 			}
@@ -519,78 +513,10 @@ static void domisc(int me, int fd, char 
 	++type;
 }
 
-static void bfill(char *buf, char val, int size)
-{
-	int i;
-
-	for (i = 0; i < size; i++)
-		buf[i] = val;
-}
-
-/*
- * dumpbuf
- *	Dump the buffer.
- */
-static void dumpbuf(char *buf)
-{
-	char val;
-	int idx, nout, i;
-
-	tst_resm(TINFO, "\tBuf:");
-	nout = 0;
-	idx = 0;
-	val = buf[0];
-
-	for (i = 0; i < csize; i++) {
-		if (buf[i] != val) {
-			if (i == idx+1)
-				tst_resm(TINFO, "\t%x, ", buf[idx] & 0xff);
-			else
-				tst_resm(TINFO, "\t%d*%x, ", i-idx, buf[idx] & 0xff);
-			idx = i;
-			++nout;
-		}
-		if (nout > 10) {
-			tst_resm(TINFO, "\t ... more");
-			return;
-		}
-	}
-
-	if (i == idx+1)
-		tst_resm(TINFO, "\t%x", buf[idx] & 0xff);
-	else
-		tst_resm(TINFO, "\t%d*%x", i-idx, buf[idx]);
-}
-
-/*
- * dumpbits
- *	Dump the bit-map.
- */
-static void dumpbits(char *bits, int size)
-{
-	char *buf;
-
-	tst_resm(TINFO, "\tBits array:");
-
-	for (buf = bits; size > 0; --size, ++buf) {
-		if ((buf-bits) % 16 == 0)
-			tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
-		tst_resm(TINFO, "\t%02x ", *buf & 0xff);
-	}
-
-	tst_resm(TINFO, "\t");
-}
-
-static void orbits(char *hold, char *bits, int count)
-{
-	while (count-- > 0)
-		*hold++ |= *bits++;
-}
-
 /*
  * SIGTERM signal handler.
  */
-static void term(int sig)
+static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	int i;
 
Index: ltp/testcases/kernel/fs/ftest/ftest02.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest02.c
+++ ltp/testcases/kernel/fs/ftest/ftest02.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -44,8 +45,6 @@
 
 
 #include <stdio.h>
-#include "test.h"
-#include "usctest.h"
 #include <sys/types.h>
 #include <sys/param.h>
 #include <sys/wait.h>
@@ -55,6 +54,9 @@
 #include <sys/mount.h>
 #include <signal.h>
 #include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+#include "libftest.h"
 
 #define MAXCHILD	25
 #define K_1		1024
@@ -64,7 +66,6 @@
 
 char *TCID = "ftest02";
 int TST_TOTAL = 1;
-extern int Tst_count;
 
 #define PASSED 1
 #define FAILED 0
@@ -74,30 +75,28 @@ static void unlfile(int, int);
 static void fussdir(int, int);
 static void dotest(int, int);
 static void dowarn(int, char*, char*);
-static void mkname(char*, int, int);
 static void term(int sig);
 static void cleanup(void);
 
 #define	M	(1024*1024)
 
-int	iterations;
-int	nchild;
-int	parent_pid;
-int	pidlist[MAXCHILD];
-
-char	homedir[MAXPATHLEN];
-char	dirname[MAXPATHLEN];
-char	tmpname[MAXPATHLEN];
-char	*prog;
-int	dirlen;
-int 	mnt = 0;
-char	startdir[MAXPATHLEN], mntpoint[MAXPATHLEN], newfsstring[90];
-char	*partition;
-char 	*cwd;
-char 	*fstyp;
-int 	local_flag;
+static int iterations;
+static int nchild;
+static int parent_pid;
+static int pidlist[MAXCHILD];
+
+static char homedir[MAXPATHLEN];
+static char dirname[MAXPATHLEN];
+static char tmpname[MAXPATHLEN];
+static int dirlen;
+static int mnt = 0;
+static char startdir[MAXPATHLEN], mntpoint[MAXPATHLEN];
+static char *partition;
+static char *cwd;
+static char *fstyp;
+static int local_flag;
 
-int main(int ac, char *av[])
+int main(void)
 {
 	int k, j, pid, child, status, count;
 	char name[128];
@@ -149,7 +148,7 @@ int main(int ac, char *av[])
 	}
 
 
-	for(k = 0; k < nchild; k++) {
+	for (k = 0; k < nchild; k++) {
 		if ((child = fork()) == 0) {
 			dotest(k, iterations);
 			exit(0);
@@ -167,7 +166,7 @@ int main(int ac, char *av[])
 	 * Wait for children to finish.
 	 */
 	count = 0;
-	while((child = wait(&status)) > 0) {
+	while ((child = wait(&status)) > 0) {
 		//tst_resm(TINFO,"Test{%d} exited status = 0x%x", child, status);
 		//tst_resm(TINFO,"status is %d",status);
 		if (status) {
@@ -195,7 +194,7 @@ int main(int ac, char *av[])
 
 	for (k = 0; k < nchild; k++)
 		for (j = 0; j < iterations + 1; j++) {
-			mkname(name, k, j);
+			ft_mkname(name, dirname, k, j);
 			rmdir(name);
 			unlink(name);
 		}
@@ -258,12 +257,10 @@ char	crmsg[] = "Gee, let's write somethi
 
 static void crfile(int me, int count)
 {
-	int	fd;
-	int	val;
-	char	fname[128];
-	char	buf[128];
+	int fd, val;
+	char fname[128], buf[128];
 
-	mkname(fname, me, count);
+	ft_mkname(fname, dirname, me, count);
 
 	fd = open(fname, O_RDWR|O_CREAT|O_TRUNC, 0666);
 	if (fd < 0 && errno == EISDIR) {
@@ -307,8 +304,8 @@ static void unlfile(int me, int count)
 	if (i < 0)
 		i = 0;
 
-	for(; i < count; i++) {
-		mkname(fname, me, i);
+	for (; i < count; i++) {
+		ft_mkname(fname, dirname, me, i);
 		val = rmdir(fname);
 		if (val < 0 )
 			val = unlink(fname);
@@ -326,13 +323,12 @@ static void unlfile(int me, int count)
  */
 static void fussdir(int me, int count)
 {
-	int	val;
-	char	dir[128];
-	char	fname[128];
-	char	savedir[128];
+	int val;
+	char dir[128], fname[128], savedir[128];
 
-	mkname(dir, me, count);
-	rmdir(dir); unlink(dir);		/* insure not there */
+	ft_mkname(dir, dirname, me, count);
+	rmdir(dir);
+	unlink(dir);
 
 	val = mkdir(dir, 0755);
 	warn(val, "mkdir", dir);
@@ -340,7 +336,6 @@ static void fussdir(int me, int count)
 	/*
 	 * Arrange to create files in the directory.
 	 */
-
 	strcpy(savedir, dirname);
 	strcpy(dirname, "");
 
@@ -354,6 +349,7 @@ static void fussdir(int me, int count)
 	warn(val, "chdir", "..");
 
 	val = rmdir(dir);
+
 	if (val >= 0) {
 		tst_resm(TFAIL,"Test[%d]: rmdir of non-empty %s succeeds!", me, dir);
 		tst_exit();
@@ -362,11 +358,11 @@ static void fussdir(int me, int count)
 	val = chdir(dir);
 	warn(val, "chdir", dir);
 
-	mkname(fname, me, count);
+	ft_mkname(fname, dirname, me, count);
 	val = unlink(fname);
 	warn(val, "unlink", fname);
 
-	mkname(fname, me, count+1);
+	ft_mkname(fname, dirname, me, count+1);
 	val = unlink(fname);
 	warn(val, "unlink", fname);
 
@@ -412,7 +408,8 @@ static void dotest(int me, int count)
 	//tst_resm(TINFO,"Test %d pid %d starting.", me, getpid());
 
 	srand(getpid());
-	for(i = 0; i < count; i++) {
+
+	for (i = 0; i < count; i++) {
 		thing = (rand() >> 3) % NTHING;
 		(*ino_thing[thing].it_proc)(me, i, ino_thing[thing].it_name);
 		++thing_cnt[thing];
@@ -431,27 +428,10 @@ static void dowarn(int me, char *m1, cha
 	tst_exit();
 }
 
-static void mkname(char *name, int me, int idx)
-{
-	int len;
-
-	strcpy(name, dirname);
-
-	if (name[0]) {
-		len = dirlen+1;
-		name[len-1] = '/';
-	} else
-		len = 0;
-
-	name[len+0] = 'A' + (me % 26);
-	name[len+1] = 'a' + (idx % 26);
-	name[len+2] = '\0';
-}
-
 /*
  * SIGTERM signal handler.
  */
-static void term(int sig)
+static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	int i;
 
Index: ltp/testcases/kernel/fs/ftest/ftest03.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest03.c
+++ ltp/testcases/kernel/fs/ftest/ftest03.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -64,10 +65,10 @@
 #include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
+#include "libftest.h"
 
 char *TCID = "ftest03";
 int TST_TOTAL = 1;
-extern int Tst_count;
 
 #define PASSED 1
 #define FAILED 0
@@ -76,34 +77,29 @@ static void setup(void);
 static void runtest(void);
 static void dotest(int, int, int);
 static void domisc(int, int, char*);
-static void bfill(char*, char, int);
-static void dumpiov(struct iovec*);
-static void dumpbits(char*, int);
-static void orbits(char*, char*, int);
 static void term(int sig);
 
-#define MAXCHILD	25	/* max number of children to allow */
+#define MAXCHILD	25
 #define K_1		1024
 #define K_2		2048
 #define K_4		4096
 #define	MAXIOVCNT	16
 
-int	csize;				/* chunk size */
-int	iterations;			/* # total iterations */
-int	max_size;			/* max file size */
-int	misc_intvl;			/* for doing misc things; 0 ==> no */
-int	nchild;				/* how many children */
-int	nwait;
-int	fd;				/* file descriptor used by child */
-int	parent_pid;
-int	pidlist[MAXCHILD];
-char	test_name[2];			/* childs test directory name */
-char	*prog, *getcwd() ;
+static int csize;             /* chunk size */
+static int iterations;        /* # total iterations */
+static int max_size;          /* max file size */
+static int misc_intvl;        /* for doing misc things; 0 ==> no */
+static int nchild;            /* how many children */
+static int nwait;
+static int fd;                /* file descriptor used by child */
+static int parent_pid;
+static int pidlist[MAXCHILD];
+static char test_name[2];     /* childs test directory name */
 
-char	fuss[40] = "";		/* directory to do this in */
-char	homedir[200]= "";	/* where we started */
+static char fuss[40];         /* directory to do this in */
+static char homedir[200];     /* where we started */
 
-int 	local_flag;
+static int local_flag;
 
 int main (int ac, char *av[])
 {
@@ -399,14 +395,14 @@ static void dotest(int testers, int me, 
 
 		ftruncate(fd,0);
 		file_max = 0;
-		bfill(bits, 0, (nchunks+7) / 8);
-		bfill(hold_bits, 0, (nchunks+7) / 8);
+		memset(bits, 0, (nchunks+7) / 8);
+		memset(hold_bits, 0, (nchunks+7) / 8);
 
 		/* Have to fill the val and zero iov buffers in a different manner
 		 */
 		for (i = 0; i < MAXIOVCNT; i++) {
-			bfill(val_iovec[i].iov_base,val,val_iovec[i].iov_len);
-			bfill(zero_iovec[i].iov_base,0,zero_iovec[i].iov_len);
+			memset(val_iovec[i].iov_base,val,val_iovec[i].iov_len);
+			memset(zero_iovec[i].iov_base,0,zero_iovec[i].iov_len);
 
 		}
 
@@ -450,11 +446,11 @@ static void dotest(int testers, int me, 
 						tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 							me, last_trunc);
 						sync();
-						dumpiov(&r_iovec[i]);
-						dumpbits(bits, (nchunks+7)/8);
-						orbits(hold_bits, bits, (nchunks+7)/8);
+						ft_dumpiov(&r_iovec[i]);
+						ft_dumpbits(bits, (nchunks+7)/8);
+						ft_orbits(hold_bits, bits, (nchunks+7)/8);
 						tst_resm(TINFO, "\tHold ");
-						dumpbits(hold_bits, (nchunks+7)/8);
+						ft_dumpbits(hold_bits, (nchunks+7)/8);
 						tst_exit();
 					}
 				}
@@ -474,11 +470,11 @@ static void dotest(int testers, int me, 
 						tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 							me, last_trunc);
 						sync();
-						dumpiov(&r_iovec[i]);
-						dumpbits(bits, (nchunks+7)/8);
-						orbits(hold_bits, bits, (nchunks+7)/8);
+						ft_dumpiov(&r_iovec[i]);
+						ft_dumpbits(bits, (nchunks+7)/8);
+						ft_orbits(hold_bits, bits, (nchunks+7)/8);
 						tst_resm(TINFO, "\tHold ");
-						dumpbits(hold_bits, (nchunks+7)/8);
+						ft_dumpbits(hold_bits, (nchunks+7)/8);
 						tst_exit();
 					}
 				}
@@ -507,7 +503,7 @@ static void dotest(int testers, int me, 
 			 * If hit "misc" interval, do it.
 			 */
 			if (misc_intvl && --whenmisc <= 0) {
-				orbits(hold_bits, bits, (nchunks+7)/8);
+				ft_orbits(hold_bits, bits, (nchunks+7)/8);
 				domisc(me, fd, bits);
 				whenmisc = NEXTMISC;
 			}
@@ -586,77 +582,10 @@ static void domisc(int me, int fd, char 
 	++type;
 }
 
-static void bfill(char *buf, char val, int size)
-{
-	int i;
-
-	for (i = 0; i < size; i++)
-		buf[i] = val;
-}
-
-/*
- * dumpiov
- *	Dump the contents of the r_iovec buffer.
- */
-static void dumpiov(struct iovec *iovptr)
-{
-	int i;
-	char val, *buf;
-	int idx, nout;
-
-	nout = 0;
-	idx = 0;
-
-	buf = (char*)iovptr->iov_base;
-	val = buf[0];
-
-	for (i = 0; i < iovptr->iov_len; i++) {
-
-		if (buf[i] != val) {
-			if (i == idx+1)
-				tst_resm(TINFO, "\t%x, ", buf[idx] & 0xff);
-			else
-				tst_resm(TINFO, "\t%d*%x, ", i-idx, buf[idx] & 0xff);
-			idx = i;
-			++nout;
-		}
-
-		if (nout > 10) {
-			tst_resm(TINFO, "\t ... more");
-			return;
-		}
-	}
-
-	if (i == idx+1)
-		tst_resm(TINFO, "\t%x", buf[idx] & 0xff);
-	else
-		tst_resm(TINFO, "\t%d*%x", i-idx, buf[idx]);
-}
-
-/*
- *	Dump the bit-map.
- */
-static void dumpbits(char *bits, int size)
-{
-	char *buf;
-
-	for (buf = bits; size > 0; --size, ++buf) {
-		if ((buf-bits) % 16 == 0)
-			tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
-		tst_resm(TINFO, "\t%02x ", *buf & 0xff);
-	}
-}
-
-static void orbits(char *hold, char *bits, int count)
-{
-	while (count-- > 0)
-		*hold++ |= *bits++;
-}
-
 /*
  * SIGTERM signal handler.
  */
-static void term(int sig)
+static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	int i;
 
@@ -685,5 +614,3 @@ static void term(int sig)
 
 	tst_exit();
 }
-
-
Index: ltp/testcases/kernel/fs/ftest/libftest.c
===================================================================
--- /dev/null
+++ ltp/testcases/kernel/fs/ftest/libftest.c
@@ -0,0 +1,139 @@
+/*
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <sys/uio.h>
+#include "test.h"
+#include "libftest.h"
+
+/*
+ * Dump content of iov structure.
+ */
+void ft_dumpiov(struct iovec *iov)
+{
+	char val, *buf;
+	int idx, nout, i;
+
+	tst_resm(TINFO, "\tBuf:");
+
+	nout = 0;
+	idx  = 0;
+	buf  = (char*)iov->iov_base;
+	val  = buf[0];
+
+	for (i = 0; (unsigned int)i < iov->iov_len; i++) {
+
+		if (buf[i] != val) {
+			if (i == idx+1)
+				tst_resm(TINFO, "\t%x, ", buf[idx] & 0xff);
+			else
+				tst_resm(TINFO, "\t%d*%x, ", i-idx, buf[idx] & 0xff);
+			idx = i;
+			++nout;
+		}
+
+		if (nout > 10) {
+			tst_resm(TINFO, "\t ... more");
+			return;
+		}
+	}
+
+	if (i == idx+1)
+		tst_resm(TINFO, "\t%x", buf[idx] & 0xff);
+	else
+		tst_resm(TINFO, "\t%d*%x", i-idx, buf[idx]);
+}
+
+/*
+ * Dump bits string.
+ */
+void ft_dumpbits(char *bits, int size)
+{
+	char *buf;
+
+	tst_resm(TINFO, "\tBits array:");
+
+	for (buf = bits; size > 0; --size, ++buf) {
+		if ((buf-bits) % 16 == 0)
+			tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
+		tst_resm(TINFO, "\t%02x ", *buf & 0xff);
+	}
+
+	tst_resm(TINFO, "\t");
+}
+
+/*
+ * Do logical or of hold and bits (of size)
+ * fields and store result into hold field.
+ */
+void ft_orbits(char *hold, char *bits, int size)
+{
+	while (size-- > 0)
+		*hold++ |= *bits++;
+}
+
+/*
+ * Dumps buffer in hexadecimal format.
+ */
+void ft_dumpbuf(char *buf, int csize)
+{
+	char val;
+	int idx, nout, i;
+
+	tst_resm(TINFO, "\tBuf:");
+	nout = 0;
+	idx = 0;
+	val = buf[0];
+
+	for (i = 0; i < csize; i++) {
+		if (buf[i] != val) {
+			if (i == idx+1)
+				tst_resm(TINFO, "\t%x, ", buf[idx] & 0xff);
+			else
+				tst_resm(TINFO, "\t%d*%x, ", i-idx, buf[idx] & 0xff);
+			idx = i;
+			++nout;
+		}
+		if (nout > 10) {
+			tst_resm(TINFO, "\t ... more");
+			return;
+		}
+	}
+
+	if (i == idx+1)
+		tst_resm(TINFO, "\t%x", buf[idx] & 0xff);
+	else
+		tst_resm(TINFO, "\t%d*%x", i-idx, buf[idx]);
+}
+
+/*
+ * Creates filename from path and numbers.
+ *
+ * TODO: name is big enough?
+ */
+void ft_mkname(char *name, char *dirname, int me, int idx)
+{
+	char a, b;
+
+	a = 'A' + (me % 26);
+	b = 'a' + (idx % 26);
+
+	if (dirname[0] != '\0')
+		sprintf(name, "%s/%c%c", dirname, a, b);
+	else
+		sprintf(name, "%c%c", a, b);
+}
Index: ltp/testcases/kernel/fs/ftest/libftest.h
===================================================================
--- /dev/null
+++ ltp/testcases/kernel/fs/ftest/libftest.h
@@ -0,0 +1,55 @@
+/*
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+/*
+ * This small library was created in order to put all code that's duplicated in
+ * ftestXX.c files here.
+ */
+
+#ifndef __LIBFTEST_H__
+#define __LIBFTEST_H__
+
+struct iovec;
+
+/*
+ * Dump content of iov structure.
+ */
+void ft_dumpiov(struct iovec *iov);
+
+/*
+ * Dump bits string.
+ */
+void ft_dumpbits(char *bits, int size);
+
+/*
+ * Do logical or of hold and bits (of size)
+ * fields and store result into hold field.
+ */
+void ft_orbits(char *hold, char *bits, int size);
+
+/*
+ * Dumps buffer in hexadecimal format.
+ */
+void ft_dumpbuf(char *buf, int csize);
+
+/*
+ * Creates filename from path and numbers.
+ */
+void ft_mkname(char *name, char *dirname, int me, int idx);
+
+#endif /* __LIBFTEST_H__ */
Index: ltp/testcases/kernel/fs/ftest/ftest05.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest05.c
+++ ltp/testcases/kernel/fs/ftest/ftest05.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -50,104 +51,91 @@
  */
 
 #define _XOPEN_SOURCE 500
-#define  _LARGEFILE64_SOURCE 1
-#include <stdio.h>		/* needed by testhead.h		*/
+#define _LARGEFILE64_SOURCE 1
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
+#include "libftest.h"
 
 char *TCID = "ftest05";
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
-int term();
-void cleanup(void);
+static void setup(void);
+static void runtest();
+static void dotest(int, int, int);
+static void domisc(int, int, char*);
+static void term(int sig);
+static void cleanup(void);
 
 #define PASSED 1
 #define FAILED 0
 
-#define MAXCHILD	25	/* max number of children to allow */
+#define MAXCHILD	25
 #define K_1		1024
 #define K_2		2048
 #define K_4		4096
 
+static int csize;             /* chunk size */
+static int iterations;        /* # total iterations */
+static off64_t max_size;      /* max file size */
+static int misc_intvl;        /* for doing misc things; 0 ==> no */
+static int nchild;            /* how many children */
+static int nwait;
+static int fd;                /* file descriptor used by child */
+static int parent_pid;
+static int pidlist[MAXCHILD];
+static char test_name[2];     /* childs test directory name */
+
+static char fuss[40];         /* directory to do this in */
+static char homedir[200];     /* where we started */
 
-int	csize;				/* chunk size */
-int	iterations;			/* # total iterations */
-off64_t max_size;			/* max file size */
-int	misc_intvl;			/* for doing misc things; 0 ==> no */
-int	nchild;				/* how many children */
-int	nwait;
-int	fd;				/* file descriptor used by child */
-int	parent_pid;
-int	pidlist[MAXCHILD];
-char	test_name[2];			/* childs test directory name */
-char	*prog;
-
-char	fuss[40] = "";		/* directory to do this in */
-char	homedir[200]= "";	/* where we started */
-
-int	local_flag;
-
-/*--------------------------------------------------------------*/
-int main (ac, av)
-	int  ac;
-	char *av[];
+static int local_flag;
+
+int main(int ac, char *av[])
 {
-        int lc;                 /* loop counter */
-        char *msg;              /* message returned from parse_opts */
+	int lc;
+	char *msg;
 
 	/*
-         * parse standard options
-         */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
-                tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
-                        /*NOTREACHED*/
-        }
+	 * parse standard options
+	 */
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
 
-        setup();
+	setup();
 
 	local_flag = PASSED;
 
-        for (lc = 0; TEST_LOOPING(lc); lc++) {
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		runtest();
 
-                runtest();
+		if (local_flag == PASSED)
+			tst_resm(TPASS, "Test passed.");
+		else
+			tst_resm(TFAIL, "Test failed.");
+	}
 
-                if (local_flag == PASSED) {
-                        tst_resm(TPASS, "Test passed.");
-                } else {
-                        tst_resm(TFAIL, "Test failed.");
-                }
-         } /* end of for */
 	cleanup();
-	return 0;
+	tst_exit();
 }
-/*--------------------------------------------------------------*/
 
-void
-setup()
+static void setup(void)
 {
-
 	/*
 	 * Make a directory to do this in; ignore error if already exists.
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	getcwd(homedir, sizeof( homedir));
+	getcwd(homedir, sizeof (homedir));
 	parent_pid = getpid();
 
 	if (!fuss[0])
@@ -160,49 +148,44 @@ setup()
 		tst_exit();
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
 
-	if ((sigset(SIGTERM, (void (*)())term)) == SIG_ERR) {
+	if (sigset(SIGTERM, term) == SIG_ERR) {
 		perror("sigset failed");
 		exit(3);
 	}
 
 	local_flag = PASSED;
-
-	return;
 }
 
-int runtest()
+static void runtest(void)
 {
-	register int i;
-	int	pid;
-	int	child;
-	int	status;
-	int	count;
+	int i, pid, child, status, count;
 
-
-	for(i = 0; i < nchild; i++) {
+	for (i = 0; i < nchild; i++) {
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
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
+
 		close(fd);
+
 		if (child < 0) {
 			 tst_resm(TINFO, "System resource may be too low, fork() malloc()"
 		                          " etc are likely to fail.");
@@ -217,37 +200,30 @@ int runtest()
 	/*
 	 * Wait for children to finish.
 	 */
-
 	count = 0;
-	while(1)
-	{
-	if ((child = wait(&status)) >= 0) {
-		//tst_resm(TINFO, "\tTest{%d} exited status = 0x%x", child, status);
-		if (status != 0) {
-			tst_resm(TFAIL, "\tTest{%d} failed, expected 0 exit.", child);
-			local_flag = FAILED;
-		}
-		++count;
-	}
-	else
-	{
-		if (errno != EINTR)
-			break;
-	}
+	while (1) {
+		if ((child = wait(&status)) >= 0) {
+			if (status != 0) {
+				tst_resm(TFAIL, "\tTest{%d} failed, expected 0 exit.", child);
+				local_flag = FAILED;
+			}
+			++count;
+		} else
+			if (errno != EINTR)
+					break;
 	}
 
 	/*
 	 * Should have collected all children.
 	 */
-
 	if (count != nwait) {
 		tst_resm(TFAIL, "\tWrong # children waited on, count = %d", count);
 		local_flag = FAILED;
 	}
 
-
 	chdir(homedir);
 	pid = fork();
+
 	if (pid < 0) {
 		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
                                  " etc are likely to fail.");
@@ -255,18 +231,19 @@ int runtest()
 		sync();
                 tst_exit();
 	}
+
 	if (pid == 0) {
 		execl("/bin/rm", "rm", "-rf", fuss, NULL);
 		tst_exit();
 	}
 
 	wait(&status);
+
 	if (status) {
 		tst_resm(TINFO,"CAUTION - ftest05, '%s' may not be removed", fuss);
 	}
 
-	sync();				/* safeness */
-	return 0;
+	sync();
 }
 
 /*
@@ -279,12 +256,10 @@ int runtest()
 
 #define	NMISC	4
 enum	m_type { m_fsync, m_trunc, m_sync, m_fstat };
-char	*m_str[] = {
-		"fsync",   "trunc", "sync", "fstat"
-};
+char	*m_str[] = {"fsync", "trunc", "sync", "fstat"};
 
 int	misc_cnt[NMISC];		/* counts # of each kind of misc */
-int	 file_max;			/* file-max size */
+int	file_max;			/* file-max size */
 int	nchunks;
 int	last_trunc = -1;
 int	tr_flag;
@@ -293,42 +268,35 @@ enum	m_type type = m_fsync;
 #define	CHUNK(i)	(((off64_t)i) * csize)
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
-	char	*buf;
-	char	*val_buf;
-	char	*zero_buf;
-	int	count;
-	int	collide;
-	char	val;
-	int	chunk;
-	int	whenmisc;
-	int	xfr;
+	int i, count, collide, chunk, whenmisc, xfr;
+	char *bits, *hold_bits, *buf, *val_buf, *zero_buf;
+	char val;
 
 	nchunks = max_size / csize;
-	if( (bits = (char*)calloc((nchunks+7)/8, 1)) == 0) {
+
+	if ((bits = calloc((nchunks+7)/8, 1)) == NULL) {
 		tst_resm(TFAIL, "\tmalloc failed(bits)");
 		tst_exit();
 	}
-	if( (hold_bits = (char*)calloc((nchunks+7)/8, 1)) == 0) {
+
+	if ((hold_bits = calloc((nchunks+7)/8, 1)) == NULL) {
 		tst_resm(TFAIL, "\tmalloc failed(bold_bits)");
 		tst_exit();
 	}
-	if( (buf = (char*)(calloc(csize, 1))) == 0) {
+
+	if ((buf = (calloc(csize, 1))) == NULL) {
 		tst_resm(TFAIL, "\tmalloc failed(buf)");
 		tst_exit();
 	}
-	if( (val_buf = (char*)(calloc(csize, 1))) == 0) {
+
+	if ((val_buf = (calloc(csize, 1))) == NULL) {
 		tst_resm(TFAIL, "\tmalloc failed(val_buf)");
 		tst_exit();
 	}
-	if( (zero_buf = (char*)(calloc(csize, 1))) == 0) {
+
+	if ((zero_buf = (calloc(csize, 1))) == NULL) {
 		tst_resm(TFAIL, "\tmalloc failed(zero_buf)");
 		tst_exit();
 	}
@@ -336,7 +304,6 @@ int dotest(testers, me, fd)
 	/*
 	 * No init sectors; allow file to be sparse.
 	 */
-
 	val = (64/testers) * me + 1;
 
 	/*
@@ -361,10 +328,10 @@ int dotest(testers, me, fd)
 			misc_cnt[i] = 0;
 		ftruncate(fd, 0);
 		file_max = 0;
-		bfill(bits, 0, (nchunks+7)/8);
-		bfill(hold_bits, 0, (nchunks+7)/8);
-		bfill(val_buf, val, csize);
-		bfill(zero_buf, 0, csize);
+		memset(bits, 0, (nchunks+7)/8);
+		memset(hold_bits, 0, (nchunks+7)/8);
+		memset(val_buf, val, csize);
+		memset(zero_buf, 0, csize);
 		count = 0;
 		collide = 0;
 		while(count < nchunks) {
@@ -399,15 +366,16 @@ int dotest(testers, me, fd)
 				}
 				if (memcmp(buf, zero_buf, csize)) {
 					tst_resm(TFAIL,
-					  "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%Lx, should be %d.",
+					  "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%x, should be %d.",
 						me, CHUNK(chunk), val, count, xfr, file_max, zero_buf[0]);
 					tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 						me, last_trunc);
 					sync();
-					dumpbuf(buf);
-					dumpbits(bits, (nchunks+7)/8);
-					orbits(hold_bits, bits, (nchunks+7)/8);
-					tst_resm(TINFO, "\tHold "); dumpbits(hold_bits, (nchunks+7)/8);
+					ft_dumpbuf(buf, csize);
+					ft_dumpbits(bits, (nchunks+7)/8);
+					ft_orbits(hold_bits, bits, (nchunks+7)/8);
+					tst_resm(TINFO, "\tHold ");
+					ft_dumpbits(hold_bits, (nchunks+7)/8);
 					tst_exit();
 				}
 				bits[chunk/8] |= (1<<(chunk%8));
@@ -420,15 +388,16 @@ int dotest(testers, me, fd)
 				}
 				++collide;
 				if (memcmp(buf, val_buf, csize)) {
-					tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%Lx.",
+					tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%x.",
 						me, CHUNK(chunk), val, count, xfr, file_max);
 					tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 						me, last_trunc);
 					sync();
-					dumpbuf(buf);
-					dumpbits(bits, (nchunks+7)/8);
-					orbits(hold_bits, bits, (nchunks+7)/8);
-					tst_resm(TINFO, "\tHold "); dumpbits(hold_bits, (nchunks+7)/8);
+					ft_dumpbuf(buf, csize);
+					ft_dumpbits(bits, (nchunks+7)/8);
+					ft_orbits(hold_bits, bits, (nchunks+7)/8);
+					tst_resm(TINFO, "\tHold ");
+					ft_dumpbits(hold_bits, (nchunks+7)/8);
 					tst_exit();
 				}
 			}
@@ -456,7 +425,7 @@ int dotest(testers, me, fd)
 			 * If hit "misc" interval, do it.
 			 */
 			if (misc_intvl && --whenmisc <= 0) {
-				orbits(hold_bits, bits, (nchunks+7)/8);
+				ft_orbits(hold_bits, bits, (nchunks+7)/8);
 				domisc(me, fd, bits);
 				whenmisc = NEXTMISC;
 			}
@@ -469,32 +438,28 @@ int dotest(testers, me, fd)
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
+
+	switch (type) {
 	case m_fsync:
 		if (fsync(fd) < 0) {
 			tst_resm(TFAIL, "\tTest[%d]: fsync error %d.", me, errno);
@@ -507,13 +472,13 @@ int domisc(me, fd, bits)
 		last_trunc = file_max;
 		if (tr_flag) {
 			if (ftruncate(fd, file_max) < 0) {
-				tst_resm(TFAIL, "\tTest[%d]: ftruncate error %d @ 0x%Lx.", me, errno, file_max);
+				tst_resm(TFAIL, "\tTest[%d]: ftruncate error %d @ 0x%x.", me, errno, file_max);
 				tst_exit();
 			}
 			tr_flag = 0;
 		} else {
 			if (truncate(test_name, file_max) < 0) {
-				tst_resm(TFAIL, "\tTest[%d]: truncate error %d @ 0x%Lx.", me, errno, file_max);
+				tst_resm(TFAIL, "\tTest[%d]: truncate error %d @ 0x%x.", me, errno, file_max);
 				tst_exit();
 			}
 			tr_flag = 1;
@@ -532,105 +497,23 @@ int domisc(me, fd, bits)
 			tst_exit();
 		}
 		if (sb.st_size != file_max) {
-			tst_resm(TFAIL, "\tTest[%d]: fstat() mismatch; st_size=%x,file_max=%Lx.",
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
-}
-
-int bfill(buf, val, size)
-	register char *buf;
-	char	val;
-	register int size;
-{
-	register int i;
-
-	for(i = 0; i < size; i++)
-		buf[i] = val;
-	return 0;
-}
-
-/*
- * dumpbuf
- *	Dump the buffer.
- */
-
-int dumpbuf(buf)
-	register char *buf;
-{
-	register int i;
-	char	val;
-	int	idx;
-	int	nout;
-
-	tst_resm(TINFO, "\tBuf:");
-	nout = 0;
-	idx = 0;
-	val = buf[0];
-	for(i = 0; i < csize; i++) {
-		if (buf[i] != val) {
-			if (i == idx+1)
-				tst_resm(TINFO, "\t%x, ", buf[idx] & 0xff);
-			else
-				tst_resm(TINFO, "\t%d*%x, ", i-idx, buf[idx] & 0xff);
-			idx = i;
-			++nout;
-		}
-		if (nout > 10) {
-			tst_resm(TINFO, "\t ... more");
-			return 0;
-		}
-	}
-	if (i == idx+1)
-		tst_resm(TINFO, "\t%x", buf[idx] & 0xff);
-	else
-		tst_resm(TINFO, "\t%d*%x", i-idx, buf[idx]);
-	return 0;
-}
-
-/*
- * dumpbits
- *	Dump the bit-map.
- */
-
-int dumpbits(bits, size)
-	char	*bits;
-	register int size;
-{
-	register char *buf;
-
-	tst_resm(TINFO, "\tBits array:");
-	for(buf = bits; size > 0; --size, ++buf) {
-		if ((buf-bits) % 16 == 0)
-			tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
-		tst_resm(TINFO, "\t%02x ", (int)*buf & 0xff);
-	}
-	return 0;
-}
-
-int orbits(hold, bits, count)
-	register char *hold;
-	register char *bits;
-	register int count;
-{
-	while(count-- > 0)
-		*hold++ |= *bits++;
-	return 0;
+	++misc_cnt[type];
+	++type;
 }
 
 /* term()
  *
  *	This is called when a SIGTERM signal arrives.
  */
-
-int term()
+static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	register int i;
+	int i;
 
 	tst_resm(TINFO, "\tterm -[%d]- got sig term.", getpid());
 
@@ -638,28 +521,27 @@ int term()
 	 * If run by hand we like to have the parent send the signal to
 	 * the child processes.  This makes life easy.
 	 */
-
 	if (parent_pid == getpid()) {
 		for (i=0; i < nchild; i++)
 			if (pidlist[i])		/* avoid embarassment */
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
 		tst_resm(TINFO, "Unlink of '%s' successful.", test_name);
+
 	tst_exit();
-	return 0;
 }
 
-void
-cleanup()
+static void cleanup(void)
 {
         /*
          * print timing stats if that option was specified.
Index: ltp/testcases/kernel/fs/ftest/ftest06.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest06.c
+++ ltp/testcases/kernel/fs/ftest/ftest06.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -45,8 +46,8 @@
  *
  */
 
-#define  _LARGEFILE64_SOURCE 1
-#include <stdio.h>		/* needed by testhead.h		*/
+#define _LARGEFILE64_SOURCE 1
+#include <stdio.h>
 #include <sys/types.h>
 #include <sys/param.h>
 #include <fcntl.h>
@@ -54,101 +55,84 @@
 #include <sys/mount.h>
 #include <sys/wait.h>
 #include <errno.h>
-#include <signal.h>		/* DEM - added SIGTERM support */
+#include <signal.h>
 #include <unistd.h>
 #include "test.h"
 #include "usctest.h"
+#include "libftest.h"
 
 char *TCID = "ftest06";
 int TST_TOTAL = 1;
-extern int Tst_count;
-
 
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
+static void crfile(int, int);
+static void unlfile(int, int);
+static void fussdir(int, int);
+static void dotest(int, int);
+static void dowarn(int, char*, char*);
+static void term(int sig);
+static void cleanup(void);
 
-#define MAXCHILD	25	/* max number of children to allow */
+#define MAXCHILD	25
 #define K_1		1024
 #define K_2		2048
 #define K_4		4096
 
+static int local_flag;
 
-int	local_flag;
-
-/*--------------------------------------------------------------*/
 #define M       (1024*1024)
 
-int	iterations;			/* # total iterations */
-int	nchild;
-int	parent_pid;
-int	pidlist[MAXCHILD];
-
-char	homedir[MAXPATHLEN];
-char	dirname[MAXPATHLEN];
-char	tmpname[MAXPATHLEN];
-int	dirlen;
-int 	mnt = 0;
-char	startdir[MAXPATHLEN], mntpoint[MAXPATHLEN], newfsstring[50];
-char	*partition;
-char 	*cwd;
-char 	*fstyp;
-
-
-/*--------------------------------------------------------------*/
-int main (ac, av)
-	int  ac;
-	char *av[];
+static int iterations;
+static int nchild;
+static int parent_pid;
+static int pidlist[MAXCHILD];
+
+static char homedir[MAXPATHLEN];
+static char dirname[MAXPATHLEN];
+static char tmpname[MAXPATHLEN];
+static int dirlen;
+static int mnt = 0;
+static char startdir[MAXPATHLEN], mntpoint[MAXPATHLEN];
+static char *partition;
+static char *cwd;
+static char *fstyp;
+
+int main(int ac, char *av[])
 {
-	register int k, j;
-	int	pid;
-	int	child;
-	int	status;
-	int	count;
-	char	name[3];
+	int pid, child, status, count, k, j;
+	char name[3];
 
-        int lc;                 /* loop counter */
-        char *msg;              /* message returned from parse_opts */
+        int lc;
+        char *msg;
 
         /*
          * parse standard options
          */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
+        if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL){
                 tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);
                 tst_exit();
-                /*NOTREACHED*/
         }
 
-
 	/*
 	 * Default values for run conditions.
 	 */
-
 	iterations = 50;
 	nchild = 5;
 
-	if (signal(SIGTERM, (void (*)())term) == SIG_ERR) {
+	if (signal(SIGTERM, term) == SIG_ERR) {
 		tst_resm(TBROK,"first signal failed");
 		tst_exit();
 	}
 
 	/* use the default values for run conditions */
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		local_flag = PASSED;
 		/*
 		 * Make a directory to do this in; ignore error if already exists.
 		 */
-	
 		parent_pid = getpid();
 		tst_tmpdir();
 
@@ -157,7 +141,7 @@ int main (ac, av)
 				tst_resm(TFAIL,"getcwd failed");
 				tst_exit();
 			}
-	}
+		}
 		cwd = startdir;
 		strcat(dirname, cwd);
 		sprintf(tmpname, "/ftest06.%d", getpid());
@@ -181,11 +165,10 @@ int main (ac, av)
 		}
 
 		/* enter block */
-
-		for(k = 0; k < nchild; k++) {
-			if ((child = fork()) == 0) {		/* child */
-				dotest(k, iterations);		/* do it! */
-				tst_exit();			/* when done, exit */
+		for (k = 0; k < nchild; k++) {
+			if ((child = fork()) == 0) {
+				dotest(k, iterations);
+				tst_exit();
 			}
 			if (child < 0) {
 				tst_resm(TINFO, "System resource may be too low, fork() malloc()"
@@ -200,9 +183,8 @@ int main (ac, av)
 		/*
 		 * Wait for children to finish.
 		 */
-
 		count = 0;
-		while((child = wait(&status)) > 0) {
+		while ((child = wait(&status)) > 0) {
 			//tst_resm(TINFO,"Test{%d} exited status = 0x%x", child, status);
 			//fprintf(stdout, "status is %d",status);
 			if (status) {
@@ -215,24 +197,22 @@ int main (ac, av)
 		/*
 		 * Should have collected all children.
 		 */
-
 		if (count != nchild) {
 			tst_resm(TFAIL,"Wrong # children waited on, count = %d", count);
 			local_flag = FAILED;
 		}
 
-		if (local_flag == PASSED) {
-                        tst_resm(TPASS, "Test passed.");
-                } else {
-                        tst_resm(TFAIL, "Test failed.");
-                }
-
+		if (local_flag == PASSED)
+			tst_resm(TPASS, "Test passed.");
+		else
+			tst_resm(TFAIL, "Test failed.");
 
 		if (iterations > 26)
 			iterations = 26;
-		for (k=0; k < nchild; k++)
-			for (j=0; j < iterations + 1; j++) {
-				mkname(name, k, j);
+
+		for (k = 0; k < nchild; k++)
+			for (j = 0; j < iterations + 1; j++) {
+				ft_mkname(name, dirname, k, j);
 				rmdir(name);
 				unlink(name);
 			}
@@ -246,11 +226,13 @@ int main (ac, av)
 			tst_resm(TBROK, "Test broken due to inability of fork.");
 			tst_exit();
 		}
+
 		if (pid == 0) {
 			execl("/bin/rm", "rm", "-rf", homedir, NULL);
 			tst_exit();
 		} else
 			wait(&status);
+
 		if (status)
 			tst_resm(TINFO,"CAUTION - ftest06, '%s' may not have been removed.",
 			  homedir);
@@ -272,36 +254,29 @@ int main (ac, av)
 			  dirname);
 		}
 
-		sync();				/* safeness */
-
+		sync();
 		cleanup();
 
-	} /* end for */
-	if (local_flag == FAILED) {
+	}
+
+	if (local_flag == FAILED)
                 tst_resm(TFAIL, "Test failed.");
-        } else {
+        else
                 tst_resm(TPASS, "Test passed.");
-        }
 
 	cleanup();
-	return 0;
+	tst_exit();
 }
 
-
-/*--------------------------------------------------------------*/
-
-
-
-#define	warn(val,m1,m2)	if ((val) < 0) Warn(me,m1,m2)
+#define	warn(val,m1,m2)	if ((val) < 0) dowarn(me,m1,m2)
 
 /*
  * crfile()
  *	Create a file and write something into it.
  */
+static char crmsg[] = "Gee, let's write something in the file!\n";
 
-char	crmsg[] = "Gee, let's write something in the file!\n";
-
-void crfile(me, count)
+static void crfile(int me, int count)
 {
 	int	fd;
 	off64_t seekval;
@@ -309,7 +284,7 @@ void crfile(me, count)
 	char	fname[128];
 	char	buf[128];
 
-	mkname(fname, me, count);
+	ft_mkname(fname, dirname, me, count);
 
 	fd = open(fname, O_RDWR|O_CREAT|O_TRUNC, 0666);
 	if (fd < 0 && errno == EISDIR) {
@@ -331,7 +306,8 @@ void crfile(me, count)
 	val = read(fd, buf, sizeof(crmsg)-1);
 	warn(val, "read", 0);
 
-	if (strncmp(crmsg, buf, sizeof(crmsg)-1)) Warn(me, "compare", 0);
+	if (strncmp(crmsg, buf, sizeof(crmsg)-1))
+		dowarn(me, "compare", 0);
 
 	val = close(fd);
 	warn(val, "close", 0);
@@ -341,24 +317,22 @@ void crfile(me, count)
  * unlfile()
  *	Unlink some of the files.
  */
-
-void unlfile(me, count)
+static void unlfile(int me, int count)
 {
-	int	i;
-	int	val;
-	char	fname[128];
+	int val, i;
+	char fname[128];
 
 	i = count - 10;
 	if (i < 0)
 		i = 0;
-	for(; i < count; i++) {
-		mkname(fname, me, i);
+	for (; i < count; i++) {
+		ft_mkname(fname, dirname, me, i);
 		val = rmdir(fname);
 		if (val < 0 )
 			val = unlink(fname);
 		if (val == 0 || errno == ENOENT)
 			continue;
-		Warn(me, "unlink", fname);
+		dowarn(me, "unlink", fname);
 	}
 }
 
@@ -368,16 +342,14 @@ void unlfile(me, count)
  *
  * Randomly leave the directory there.
  */
-
-void fussdir(me, count)
+static void fussdir(int me, int count)
 {
-	int	val;
-	char	dir[128];
-	char	fname[128];
-	char	savedir[128];
+	int val;
+	char dir[128], fname[128], savedir[128];
 
-	mkname(dir, me, count);
-	rmdir(dir); unlink(dir);		/* insure not there */
+	ft_mkname(dir, dirname, me, count);
+	rmdir(dir);
+	unlink(dir);
 
 	val = mkdir(dir, 0755);
 	warn(val, "mkdir", dir);
@@ -385,7 +357,6 @@ void fussdir(me, count)
 	/*
 	 * Arrange to create files in the directory.
 	 */
-
 	strcpy(savedir, dirname);
 	strcpy(dirname, "");
 
@@ -399,6 +370,7 @@ void fussdir(me, count)
 	warn(val, "chdir", "..");
 
 	val = rmdir(dir);
+
 	if (val >= 0) {
 		tst_resm(TFAIL,"Test[%d]: rmdir of non-empty %s succeeds!", me, dir);
 		tst_exit();
@@ -407,11 +379,11 @@ void fussdir(me, count)
 	val = chdir(dir);
 	warn(val, "chdir", dir);
 
-	mkname(fname, me, count);
+	ft_mkname(fname, dirname, me, count);
 	val = unlink(fname);
 	warn(val, "unlink", fname);
 
-	mkname(fname, me, count+1);
+	ft_mkname(fname, dirname, me, count+1);
 	val = unlink(fname);
 	warn(val, "unlink", fname);
 
@@ -433,8 +405,6 @@ void fussdir(me, count)
  *
  * Randomly do an inode thing; loop for # iterations.
  */
-
-
 #define	THING(p)	{p, "p"}
 
 struct	ino_thing {
@@ -452,16 +422,14 @@ struct	ino_thing {
 int	thing_cnt[NTHING];
 int	thing_last[NTHING];
 
-int dotest(me, count)
-	int	me;
-	int	count;
+static void dotest(int me, int count)
 {
-	int	i;
-	int	thing;
+	int thing, i;
 
 	//tst_resm(TINFO,"Test %d pid %d starting.", me, getpid());
 
 	srand(getpid());
+
 	for(i = 0; i < count; i++) {
 		thing = (rand() >> 3) % NTHING;
 		(*ino_thing[thing].it_proc)(me, i, ino_thing[thing].it_name);
@@ -469,61 +437,36 @@ int dotest(me, count)
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
 
 	tst_resm(TFAIL,"Test[%d]: error %d on %s %s",
 		me, err, m1, (m2 ? m2 : ""));
 	tst_exit();
 }
 
-int mkname(name, me, idx)
-	register char	*name;
-{
-	register int len;
-
-	(void) strcpy(name, dirname);
-	if (name[0]) {
-		len = dirlen+1;
-		name[len-1] = '/';
-	} else
-		len = 0;
-	name[len+0] = 'A' + (me % 26);
-	name[len+1] = 'a' + (idx % 26);
-	name[len+2] = '\0';
-	return 0;
-}
-
-/*--------------------------------------------------------------*/
-
-
-int term()
+static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	register int i;
+	int i;
 
 	tst_resm(TINFO, "\tterm -[%d]- got sig term.", getpid());
 
 	if (parent_pid == getpid()) {
-		for (i=0; i < nchild; i++)
-			if (pidlist[i])		/* avoid embarassment */
+		for (i = 0; i < nchild; i++)
+			if (pidlist[i])
 				kill(pidlist[i], SIGTERM);
-		return 0;
+		return;
 	}
 
 	tst_resm(TBROK, "Term: Child process exiting.");
 	tst_exit();
-	return 0;
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	char mount_buffer[1024];
 
@@ -532,14 +475,14 @@ void cleanup()
 			tst_resm(TINFO,"Could not change to %s ", startdir);
 		}
 		if (!strcmp(fstyp, "cfs")) {
-			sprintf(mount_buffer, "/etc/umount %s", partition);
+			sprintf(mount_buffer, "/bin/umount %s", partition);
 			if (system(mount_buffer) != 0) {
 				tst_resm(TINFO,"Unable to unmount %s from %s ", partition, mntpoint);
 				if (umount(partition)) {
 					tst_resm(TINFO,"Unable to unmount %s from %s ", partition, mntpoint);
 				}
 				else {
-					tst_resm(TINFO, "Forced umount for %s, /etc/mnttab now dirty", partition );
+					tst_resm(TINFO, "Forced umount for %s, /etc/mtab now dirty", partition );
 				}
 			}
 		}
Index: ltp/include/compiler.h
===================================================================
--- ltp.orig/include/compiler.h
+++ ltp/include/compiler.h
@@ -8,6 +8,7 @@
 #define __LTP_COMPILER_H__
 
 #define LTP_ATTRIBUTE_NORETURN __attribute__((noreturn))
+#define LTP_ATTRIBUTE_UNUSED __attribute__((unused))
 
 #ifndef ARRAY_SIZE
 	#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
Index: ltp/testcases/kernel/fs/ftest/ftest07.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest07.c
+++ ltp/testcases/kernel/fs/ftest/ftest07.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -56,7 +57,7 @@
  */
 
 #define _XOPEN_SOURCE 500
-#define  _LARGEFILE64_SOURCE 1
+#define _LARGEFILE64_SOURCE 1
 #include <sys/types.h>
 #include <sys/param.h>
 #include <sys/wait.h>
@@ -64,104 +65,93 @@
 #include <errno.h>
 #include <sys/uio.h>
 #include <fcntl.h>
-#include <signal.h>		/* DEM - added SIGTERM support */
-#include <stdio.h>		/* needed by testhead.h		*/
+#include <signal.h>
+#include <stdio.h>
 #include <unistd.h>
+#include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
+#include "libftest.h"
 
 char *TCID = "ftest07";
 int TST_TOTAL = 1;
-extern int Tst_count;
 
 #define PASSED 1
 #define FAILED 0
 
-#define MAXCHILD	25	/* max number of children to allow */
+#define MAXCHILD	25
 #define K_1		1024
 #define K_2		2048
 #define K_4		4096
 #define	MAXIOVCNT	16
 
-void setup();
-int runtest();
-int dotest(int, int, int);
-int domisc(int, int, char*);
-int bfill(char*, char, int);
-int dumpiov(struct iovec*);
-int dumpbits(char*, int);
-int orbits(char*, char*, int);
-int term();
-
-int	csize;				/* chunk size */
-int	iterations;			/* # total iterations */
-off64_t max_size;			/* max file size */
-int	misc_intvl;			/* for doing misc things; 0 ==> no */
-int	nchild;				/* how many children */
-int	nwait;
-int	fd;				/* file descriptor used by child */
-int	parent_pid;
-int	pidlist[MAXCHILD];
-char	test_name[2];			/* childs test directory name */
-char	*prog, *getcwd() ;
-
-char	fuss[40] = "";		/* directory to do this in */
-char	homedir[200]= "";	/* where we started */
-
-int	local_flag;
-
-/*--------------------------------------------------------------*/
-int main (ac, av)
-	int  ac;
-	char *av[];
+static void setup(void);
+static void runtest(void);
+static void dotest(int, int, int);
+static void domisc(int, int, char*);
+static void term(int sig);
+
+static int csize;             /* chunk size */
+static int iterations;        /* # total iterations */
+static off64_t max_size;      /* max file size */
+static int misc_intvl;        /* for doing misc things; 0 ==> no */
+static int nchild;            /* how many children */
+static int nwait;
+static int fd;                /* file descriptor used by child */
+static int parent_pid;
+static int pidlist[MAXCHILD];
+static char test_name[2];     /* childs test directory name */
+
+static char fuss[40];         /* directory to do this in */
+static char homedir[200];     /* where we started */
+
+static int local_flag;
+
+int main(int ac, char *av[])
 {
-        int lc;                 /* loop counter */
-        char *msg;              /* message returned from parse_opts */
+	int lc;
+	char *msg;
 
-        /*
-         * parse standard options
-         */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
-                       tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);
-                 tst_exit();
-                 /*NOTREACHED*/
-        }
+	/*
+	 * parse standard options
+	 */
+        if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+		tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);
+		tst_exit();
+	}
 
-        setup();
+	setup();
 
         for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		local_flag = PASSED;
 
-		 runtest();
+		runtest();
 
-		 if (local_flag == PASSED) {
-                         tst_resm(TPASS, "Test passed.");
-                 } else {
-                         tst_resm(TFAIL, "Test failed.");
-                 }
+		if (local_flag == PASSED)
+			tst_resm(TPASS, "Test passed.");
+		else
+			tst_resm(TFAIL, "Test failed.");
 
                 tst_rmdir();
                 tst_exit();
 
-	} /* end for */
+	}
+
 	return 0;
 }
-	/*--------------------------------------------------------------*/
 
-void setup()
+static void setup(void)
 {
-	char wdbuf[MAXPATHLEN],  *cwd ;
-	int term();
+	char wdbuf[MAXPATHLEN], *cwd;
 
 	/*
 	 * Make a directory to do this in; ignore error if already exists.
 	 * Save starting directory.
 	 */
-
-	if ( (cwd = getcwd(homedir, sizeof( homedir))) == NULL ) {
-	  tst_resm(TBROK,"Failed to get corrent directory") ;
-	  tst_exit() ;
+	if ((cwd = getcwd(homedir, sizeof (homedir))) == NULL ) {
+		tst_resm(TBROK,"Failed to get corrent directory") ;
+		tst_exit();
 	}
 
 	parent_pid = getpid();
@@ -186,23 +176,18 @@ void setup()
 	max_size = K_1 * K_1;
 	misc_intvl = 10;
 
-	if (sigset(SIGTERM, (void (*)())term) == SIG_ERR) {
+	if (sigset(SIGTERM, term) == SIG_ERR) {
 		tst_resm(TBROK, " sigset failed: signo = 15") ;
 		tst_exit() ;
 	}
 
 }
 
-int runtest()
+static void runtest(void)
 {
-	register int i;
-	int	pid;
-	int	child;
-	int	status;
-	int	count;
+	int pid, child, status, count, i;
 
-
-	for(i = 0; i < nchild; i++) {
+	for (i = 0; i < nchild; i++) {
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
@@ -210,9 +195,10 @@ int runtest()
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
@@ -231,23 +217,19 @@ int runtest()
 	/*
 	 * Wait for children to finish.
 	 */
-
 	count = 0;
-	while(1)
-	{
-	if ((child = wait(&status)) >= 0) {
-		//tst_resm(TINFO, "\tTest{%d} exited status = 0x%x", child, status);
+	while(1) {
+		if ((child = wait(&status)) >= 0) {
+			//tst_resm(TINFO, "\tTest{%d} exited status = 0x%x", child, status);
 			if (status) {
 				tst_resm(TFAIL, "\tTest{%d} failed, expected 0 exit.", child);
 				local_flag = FAILED;
 			}
-		++count;
-	}
-	else
-	{
-		if (errno != EINTR)
-			break;
-	}
+			++count;
+		} else {
+			if (errno != EINTR)
+				break;
+		}
 	}
 
 	/*
@@ -278,8 +260,7 @@ int runtest()
 		tst_resm(TINFO, "CAUTION - ftest07, '%s' may not be removed", fuss);
 	}
 
-	sync();				/* safeness */
-	return 0;
+	sync();
 }
 
 /*
@@ -292,9 +273,7 @@ int runtest()
 
 #define	NMISC	4
 enum	m_type { m_fsync, m_trunc, m_sync, m_fstat };
-char	*m_str[] = {
-		"fsync",   "trunc", "sync", "fstat"
-};
+char	*m_str[] = {"fsync",   "trunc", "sync", "fstat"};
 
 int	misc_cnt[NMISC];		/* counts # of each kind of misc */
 int 	file_max;			/* file-max size */
@@ -306,20 +285,11 @@ enum	m_type type = m_fsync;
 #define	CHUNK(i)	(((off64_t)i) * csize)
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
+	int count, collide, chunk, whenmisc, xfr, i;
 
 	/* Stuff for the readv call */
 	struct	iovec	r_iovec[MAXIOVCNT];
@@ -332,11 +302,11 @@ int dotest(testers, me, fd)
 	int	w_ioveclen;
 
 	nchunks = max_size / csize;
-	if( (bits = (char*)malloc((nchunks+7) / 8)) == 0) {
+	if ((bits = malloc((nchunks+7) / 8)) == NULL) {
 		tst_resm(TBROK, "\tmalloc failed(bits)");
 		tst_exit();
 	}
-	if( (hold_bits = (char*)malloc((nchunks+7) / 8)) == 0) {
+	if ((hold_bits = malloc((nchunks+7) / 8)) == NULL) {
 		tst_resm(TBROK, "\tmalloc failed(hlod_bits)");
 		tst_exit();
 	}
@@ -350,7 +320,7 @@ int dotest(testers, me, fd)
 		 */
 
 	for (i = 0; i < MAXIOVCNT; i++) {
-		if( (r_iovec[i].iov_base = (char*)calloc(r_ioveclen, 1)) == 0) {
+		if ((r_iovec[i].iov_base = calloc(r_ioveclen, 1)) == NULL) {
 			tst_resm(TFAIL, "\tmalloc failed(r_iovec[i].iov_base)");
 			tst_exit();
 		}
@@ -360,27 +330,27 @@ int dotest(testers, me, fd)
 		 * make things more diffult for the OS.
 		 */
 
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed((i+1)*8)");
 			tst_exit();
 		}
-		if( (val_iovec[i].iov_base = (char*)calloc(w_ioveclen, 1)) == 0) {
+		if ((val_iovec[i].iov_base = calloc(w_ioveclen, 1)) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed(val_iovec[i]");
 			exit(1);
 		}
 		val_iovec[i].iov_len = w_ioveclen;
 	
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed((i+1)*8)");
 			tst_exit();
 		}
-		if( (zero_iovec[i].iov_base = (char*)calloc(w_ioveclen, 1)) == 0) {
+		if ((zero_iovec[i].iov_base = calloc(w_ioveclen, 1)) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed(zero_iover)");
 			tst_exit();
 		}
 		zero_iovec[i].iov_len = w_ioveclen;
 
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed((i+1)*8)");
 			tst_exit();
 		}
@@ -406,30 +376,32 @@ int dotest(testers, me, fd)
          */
 
 	 srand(getpid());
-	 if (misc_intvl) whenmisc = NEXTMISC;
- 	 while(iterations-- > 0) {
-		for(i = 0; i < NMISC; i++)
+	 if (misc_intvl)
+	 	whenmisc = NEXTMISC;
+
+	 while (iterations-- > 0) {
+		for (i = 0; i < NMISC; i++)
 			misc_cnt[i] = 0;
 		ftruncate(fd,0);
 		file_max = 0;
-		bfill(bits, 0, (nchunks+7) / 8);
-		bfill(hold_bits, 0, (nchunks+7) / 8);
+		memset(bits, 0, (nchunks+7) / 8);
+		memset(hold_bits, 0, (nchunks+7) / 8);
 
 		/* Have to fill the val and zero iov buffers in a different manner
 		 */
-		for(i = 0; i < MAXIOVCNT; i++) {
-			bfill(val_iovec[i].iov_base,val,val_iovec[i].iov_len);
-			bfill(zero_iovec[i].iov_base,0,zero_iovec[i].iov_len);
+		for (i = 0; i < MAXIOVCNT; i++) {
+			memset(val_iovec[i].iov_base,val,val_iovec[i].iov_len);
+			memset(zero_iovec[i].iov_base,0,zero_iovec[i].iov_len);
 
 		}
 		count = 0;
 		collide = 0;
-		while(count < nchunks) {
+		while (count < nchunks) {
 			chunk = rand() % nchunks;
 			/*
 			 * Read it.
 			 */
-			if (lseek64(fd, CHUNK(chunk), 0) < (off64_t)0) {
+			if (lseek64(fd, CHUNK(chunk), 0) < 0) {
 				tst_resm(TFAIL, "\tTest[%d]: lseek64(0) fail at %Lx, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
@@ -453,7 +425,7 @@ int dotest(testers, me, fd)
 						me, xfr, csize);
 					tst_exit();
 				}
-				for(i=0;i<MAXIOVCNT; i++) {
+				for (i = 0; i < MAXIOVCNT; i++) {
 					if (memcmp(r_iovec[i].iov_base, zero_iovec[i].iov_base, r_iovec[i].iov_len)) {
 						tst_resm(TFAIL,
 					  	"\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%x, should be 0.",
@@ -461,10 +433,11 @@ int dotest(testers, me, fd)
 						tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 							me, last_trunc);
 						sync();
-						dumpiov(&r_iovec[i]);
-						dumpbits(bits, (nchunks+7)/8);
-						orbits(hold_bits, bits, (nchunks+7)/8);
-						tst_resm(TINFO, "\tHold "); dumpbits(hold_bits, (nchunks+7)/8);
+						ft_dumpiov(&r_iovec[i]);
+						ft_dumpbits(bits, (nchunks+7)/8);
+						ft_orbits(hold_bits, bits, (nchunks+7)/8);
+						tst_resm(TINFO, "\tHold ");
+						ft_dumpbits(hold_bits, (nchunks+7)/8);
 						tst_exit();
 					}
 				}
@@ -477,17 +450,18 @@ int dotest(testers, me, fd)
 					tst_exit();
 				}
 				++collide;
-				for(i=0; i<MAXIOVCNT; i++) {
+				for (i = 0; i < MAXIOVCNT; i++) {
 					if (memcmp(r_iovec[i].iov_base, val_iovec[i].iov_base, r_iovec[i].iov_len)) {
 						tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%x.",
 							me, CHUNK(chunk), val, count, xfr, file_max);
 						tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 							me, last_trunc);
 						sync();
-						dumpiov(&r_iovec[i]);
-						dumpbits(bits, (nchunks+7)/8);
-						orbits(hold_bits, bits, (nchunks+7)/8);
-						tst_resm(TINFO, "\tHold "); dumpbits(hold_bits, (nchunks+7)/8);
+						ft_dumpiov(&r_iovec[i]);
+						ft_dumpbits(bits, (nchunks+7)/8);
+						ft_orbits(hold_bits, bits, (nchunks+7)/8);
+						tst_resm(TINFO, "\tHold ");
+						ft_dumpbits(hold_bits, (nchunks+7)/8);
 						tst_exit();
 					}
 				}
@@ -495,7 +469,7 @@ int dotest(testers, me, fd)
 			/*
 			 * Writev it.
 			 */
-			if (lseek64(fd, -((off64_t)xfr), 1) <  (off64_t)0) {
+			if (lseek64(fd, -((off64_t)xfr), 1) <  0) {
 				tst_resm(TFAIL, "\tTest[%d]: lseek64(1) fail at %Lx, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
@@ -516,7 +490,7 @@ int dotest(testers, me, fd)
 			 * If hit "misc" interval, do it.
 			 */
 			if (misc_intvl && --whenmisc <= 0) {
-				orbits(hold_bits, bits, (nchunks+7)/8);
+				ft_orbits(hold_bits, bits, (nchunks+7)/8);
 				domisc(me, fd, bits);
 				whenmisc = NEXTMISC;
 			}
@@ -527,32 +501,26 @@ int dotest(testers, me, fd)
 		/*
 		 * End of iteration, maybe before doing all chunks.
 		 */
-
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
 	switch(type) {
 	case m_fsync:
@@ -592,106 +560,24 @@ int domisc(me, fd, bits)
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
-}
-
-int bfill(buf, val, size)
-	register char *buf;
-	char	val;
-	register int size;
-{
-	register int i;
 
-	for(i = 0; i < size; i++)
-		buf[i] = val;
-	return 0;
-}
-
-/*
- * dumpiov
- *	Dump the contents of the r_iovec buffer.
- */
-
-int dumpiov(iovptr)
-	register struct iovec *iovptr;
-{
-	register int i;
-	char	val;
-	int	idx;
-	int	nout;
-
-	tst_resm(TINFO, "\tBuf:");
-	nout = 0;
-	idx = 0;
-	val = ((char *)iovptr->iov_base)[0];
-	for(i = 0; i < iovptr->iov_len; i++) {
-		if (((char *)iovptr->iov_base)[i] != val) {
-			if (i == idx+1)
-				tst_resm(TINFO, "\t%x, ", ((char *)iovptr->iov_base)[idx] & 0xff);
-			else
-				tst_resm(TINFO, "\t%d*%x, ", i-idx, ((char *)iovptr->iov_base)[idx] & 0xff);
-			idx = i;
-			++nout;
-		}
-		if (nout > 10) {
-			tst_resm(TINFO, "\t ... more");
-			return 0;
-		}
-	}
-	if (i == idx+1)
-		tst_resm(TINFO, "\t%x", ((char *)iovptr->iov_base)[idx] & 0xff);
-	else
-		tst_resm(TINFO, "\t%d*%x", i-idx, ((char *)iovptr->iov_base)[idx]);
-	return 0;
-}
-
-/*
- * dumpbits
- *	Dump the bit-map.
- */
-
-int dumpbits(bits, size)
-	char	*bits;
-	register int size;
-{
-	register char *buf;
-
-	tst_resm(TINFO, "\tBits array:");
-	for(buf = bits; size > 0; --size, ++buf) {
-		if ((buf-bits) % 16 == 0)
-			tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
-		tst_resm(TINFO, "\t%02x ", (int)*buf & 0xff);
-	}
-	return 0;
+	++misc_cnt[type];
+	++type;
 }
 
-int orbits(hold, bits, count)
-	register char *hold;
-	register char *bits;
-	register int count;
-{
-	while(count-- > 0)
-		*hold++ |= *bits++;
-	return 0;
-}
-
-
 /* term()
  *
  *	This is called when a SIGTERM signal arrives.
  */
-
-int term()
+static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	register int i;
+	int i;
 
 	tst_resm(TINFO, "\tterm -[%d]- got sig term.", getpid());
 
@@ -699,12 +585,11 @@ int term()
 	 * If run by hand we like to have the parent send the signal to
 	 * the child processes.  This makes life easy.
 	 */
-
 	if (parent_pid == getpid()) {
 		for (i=0; i < nchild; i++)
-			if (pidlist[i])		/* avoid embarassment */
+			if (pidlist[i])
 				kill(pidlist[i], SIGTERM);
-		return 0;
+		return;
 	}
 
 	tst_resm(TINFO, "\tunlinking '%s'", test_name);
@@ -715,7 +600,6 @@ int term()
 		  test_name, errno);
 	else
 		tst_resm(TINFO, "Unlink of '%s' successful.", test_name);
+
 	tst_exit();
-	return 0;
 }
-
Index: ltp/testcases/kernel/fs/ftest/ftest08.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest08.c
+++ ltp/testcases/kernel/fs/ftest/ftest08.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -40,8 +41,8 @@
  */
 
 #define _XOPEN_SOURCE 500
-#define  _LARGEFILE64_SOURCE 1
-#include <stdio.h>		/* needed by testhead.h		*/
+#define _LARGEFILE64_SOURCE 1
+#include <stdio.h>
 #include <sys/types.h>
 #include <sys/param.h>
 #include <sys/wait.h>
@@ -50,146 +51,128 @@
 #include <sys/stat.h>
 #include <sys/uio.h>
 #include <errno.h>
-#include <signal.h>		/* DEM - added SIGTERM support */
+#include <signal.h>
 #include <unistd.h>
 #include "test.h"
 #include "usctest.h"
+#include "libftest.h"
 
 char *TCID = "ftest08";
 int TST_TOTAL = 1;
-extern int Tst_count;
 
 #define PASSED 1
 #define FAILED 0
 
-#define MAXCHILD	25	/* max number of children to allow */
+#define MAXCHILD	25
 #define K_1		1024
 #define K_2		2048
 #define K_4		4096
 #define	MAXIOVCNT	16
 
-void init();
-int runtest();
-int dotest(int, int, int);
-int domisc(int, int, char*);
-int bfill(char*, char, int);
-int dumpiov(struct iovec*);
-int dumpbits(char*, int);
-int term();
-void cleanup(void);
-
-int	csize;				/* chunk size */
-int	iterations;			/* # total iterations */
-off64_t max_size;			/* max file size */
-int	misc_intvl;			/* for doing misc things; 0 ==> no */
-int	nchild;				/* number of child processes */
-int	nwait;
-int	parent_pid;
-int	pidlist[MAXCHILD];
-
-char	filename[128];
-char	*prog;
-
-int	local_flag;
-
-/*--------------------------------------------------------------*/
-int main (ac, av)
-	int  ac;
-	char *av[];
+static void init(void);
+static void runtest(void);
+static void dotest(int, int, int);
+static void domisc(int, int);
+static void term(int sig);
+static void cleanup(void);
+
+static int csize;             /* chunk size */
+static int iterations;        /* # total iterations */
+static off64_t max_size;      /* max file size */
+static int misc_intvl;        /* for doing misc things; 0 ==> no */
+static int nchild;            /* number of child processes */
+static int nwait;
+static int parent_pid;
+static int pidlist[MAXCHILD];
+
+static char	filename[128];
+static int	local_flag;
+
+int main(int ac, char *av[])
 {
-        int lc;                 /* loop counter */
-        char *msg;              /* message returned from parse_opts */
+        int lc;
+        char *msg;
 
         /*
          * parse standard options
          */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
+        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != NULL){
                 tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);
                 tst_exit();
-                /*NOTREACHED*/
         }
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-
 		local_flag = PASSED;
-
 		init();
-
 		runtest();
 
-		if (local_flag == PASSED) {
-                        tst_resm(TPASS, "Test passed.");
-                } else {
-                        tst_resm(TFAIL, "Test failed.");
-                }
+		if (local_flag == PASSED)
+			tst_resm(TPASS, "Test passed.");
+		else
+			tst_resm(TFAIL, "Test failed.");
+	}
 
-	} /* end for */
 	cleanup();
-	return 0;
+	tst_exit();
 }
 
-void init()
+static void init(void)
 {
 	int fd;
 	char wdbuf[MAXPATHLEN];
 
 	parent_pid = getpid();
 	tst_tmpdir();
+
 	/*
 	 * Make a filename for the test.
 	 */
-
 	if (!filename[0])
 		sprintf(filename, "%s/ftest08.%d", getcwd(wdbuf, MAXPATHLEN), getpid());
 
 	fd = open(filename, O_RDWR|O_CREAT|O_TRUNC, 0666);
+
 	if (fd < 0) {
 		tst_resm(TBROK, "Error %d creating file %s", errno, filename);
 		tst_exit();
 	}
+
 	close(fd);
 
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
 		tst_resm(TBROK,"first sigset failed");
 		tst_exit();
 	}
 
 }
 
-/*--------------------------------------------------------------*/
-
-
-int runtest()
+static void runtest(void)
 {
-	register int i;
-	int	child;
-	int	status;
-	int	count;
-	int	fd;
+	int i, child, status, count, fd;
 
+	for (i = 0; i < nchild; i++) {
 
-	for(i = 0; i < nchild; i++) {
-		if ((child = fork()) == 0) {		/* child */
+		if ((child = fork()) == 0) {
 			fd = open(filename, O_RDWR);
 			if (fd < 0) {
-				tst_resm(TFAIL, "\tTest[%d]: error %d openning %s.", errno, filename);
+				tst_resm(TFAIL, "\tTest[%d]: error %d openning %s.", i, errno, filename);
 				tst_exit();
 			}
-			dotest(nchild, i, fd);		/* do it! */
+			dotest(nchild, i, fd);
 			close(fd);
-			tst_exit();			/* when done, exit */
+			tst_exit();
 		}
+
 		if (child < 0) {
 			tst_resm(TINFO, "System resource may be too low, fork() malloc()"
 		                            " etc are likely to fail.");
@@ -205,11 +188,9 @@ int runtest()
 	/*
 	 * Wait for children to finish.
 	 */
-
 	count = 0;
-	while((child = wait(&status)) != -1 || errno == EINTR) {
-		if (child > 0)
-		{
+	while ((child = wait(&status)) != -1 || errno == EINTR) {
+		if (child > 0) {
 			//tst_resm(TINFO, "\tTest{%d} exited status = 0x%x", child, status);
 			if (status) {
 				tst_resm(TFAIL, "\tExpected 0 exit status - failed.");
@@ -222,16 +203,13 @@ int runtest()
 	/*
 	 * Should have collected all children.
 	 */
-
 	if (count != nwait) {
 		tst_resm(TFAIL, "\tWrong # children waited on, count = %d", count);
 		local_flag = FAILED;
 	}
 
 	unlink(filename);
-
-	sync();				/* safeness */
-	return 0;
+	sync();
 }
 
 /*
@@ -241,12 +219,9 @@ int runtest()
  * Randomly read/mod/write chunks with known pattern and check.
  * When fill sectors, iterate.
  */
-
 #define	NMISC	2
 enum	m_type { m_fsync, m_sync };
-char	*m_str[] = {
-		"fsync",   "sync"
-};
+char	*m_str[] = {"fsync", "sync"};
 
 int	misc_cnt[NMISC];		/* counts # of each kind of misc */
 int	misc_flag;
@@ -255,52 +230,41 @@ int	nchunks;
 #define	CHUNK(i)	((((off64_t)i) * testers + me) * csize)
 #define	NEXTMISC	((rand() % misc_intvl) + 5)
 
-int dotest(testers, me, fd)
-	int	testers;
-	int	me;
-	int	fd;
+static void dotest(int testers, int me, int fd)
 {
-	register int	i;
-	char	*bits;
-	char	*buf;
-	int	count;
-	int	collide;
-	char	val;
-	char	val0;
-	int	chunk;
-	int	whenmisc;
-	int	xfr;
+	char *bits, *buf;
+	char val, val0;
+	int count, collide, chunk, whenmisc, xfr, i;
 
 	/* Stuff for the readv call */
 	struct	iovec	r_iovec[MAXIOVCNT];
 	int	r_ioveclen;
 
 	/* Stuff for the writev call */
-						
 	struct	iovec	val0_iovec[MAXIOVCNT];
 	struct	iovec	val_iovec[MAXIOVCNT];
 	int	w_ioveclen;
 
 	nchunks = max_size / (testers * csize);
-	if( (bits = (char*)malloc((nchunks+7)/8)) == 0) {
+
+	if ((bits = malloc((nchunks+7)/8)) == NULL) {
 		tst_resm(TBROK, "\tmalloc failed(bits)");
 		tst_exit();
 	}
-	if( (buf = (char*)(malloc(csize))) == 0) {
+
+	if ((buf = (malloc(csize))) == NULL) {
 		tst_resm(TBROK, "\tmalloc failed(buf)");
 		tst_exit();
 	}
 
-	/*Allocate memory for the iovec buffers and init the iovec arrays
-	 */
+	/* Allocate memory for the iovec buffers and init the iovec arrays */
 	r_ioveclen = w_ioveclen = csize / MAXIOVCNT;
 
-		/* Please note that the above statement implies that csize
-		 * be evenly divisible by MAXIOVCNT.
-		 */
-
+	/* Please note that the above statement implies that csize
+	 * be evenly divisible by MAXIOVCNT.
+	 */
 	for (i = 0; i < MAXIOVCNT; i++) {
-		if( (r_iovec[i].iov_base = (char*)malloc(r_ioveclen)) == 0) {
+		if ((r_iovec[i].iov_base = malloc(r_ioveclen)) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed(iov_base)");
 			tst_exit();
 		}
@@ -309,28 +273,30 @@ int dotest(testers, me, fd)
 		/* Allocate unused memory areas between all the buffers to
 		 * make things more diffult for the OS.
 		 */
-
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed((i+1)*8)");
 			tst_exit();
 		}
-		if( (val0_iovec[i].iov_base = (char*)malloc(w_ioveclen)) == 0){
+
+		if ((val0_iovec[i].iov_base = malloc(w_ioveclen)) == NULL){
 			tst_resm(TBROK, "\tmalloc failed(val0_iovec)");
 			tst_exit();
 		}
+
 		val0_iovec[i].iov_len = w_ioveclen;
 	
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed((i+1)*8)");
 			tst_exit();
 		}
-		if( (val_iovec[i].iov_base = (char*)malloc(w_ioveclen)) == 0){
+
+		if ((val_iovec[i].iov_base = malloc(w_ioveclen)) == NULL){
 			tst_resm(TBROK, "\tmalloc failed(iov_base)");
 			tst_exit();
 		}
 		val_iovec[i].iov_len = w_ioveclen;
 
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed(((i+1)*8)");
 			tst_exit();
 		}
@@ -339,7 +305,6 @@ int dotest(testers, me, fd)
 	/*
 	 * No init sectors; file-sys makes 0 to start.
 	 */
-
 	val = (64/testers) * me + 1;
 	val0 = 0;
 
@@ -357,28 +322,32 @@ int dotest(testers, me, fd)
 	 *		repeat until count = nchunks.
 	 *	++val.
 	 */
-
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
-		bfill(bits, 0, (nchunks+7)/8);
+		memset(bits, 0, (nchunks+7)/8);
 		/* Have to fill the val0 and val iov buffers in a different manner
 		 */
-		for(i = 0; i < MAXIOVCNT; i++) {
-			bfill(val0_iovec[i].iov_base,val0,val0_iovec[i].iov_len);
-			bfill(val_iovec[i].iov_base,val,val_iovec[i].iov_len);
+		for (i = 0; i < MAXIOVCNT; i++) {
+			memset(val0_iovec[i].iov_base,val0,val0_iovec[i].iov_len);
+			memset(val_iovec[i].iov_base,val,val_iovec[i].iov_len);
 
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
-			if (lseek64(fd, CHUNK(chunk), 0) < (off64_t)0) {
+			if (lseek64(fd, CHUNK(chunk), 0) < 0) {
 				tst_resm(TFAIL, "\tTest[%d]: lseek64(0) fail at %Lx, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
@@ -401,12 +370,12 @@ int dotest(testers, me, fd)
 						me, xfr, csize);
 					tst_exit();
 				}
-				for(i = 0; i < MAXIOVCNT; i++) {
+				for (i = 0; i < MAXIOVCNT; i++) {
 					if (memcmp(r_iovec[i].iov_base, val0_iovec[i].iov_base, r_iovec[i].iov_len)) {
 						tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d.",
 							me, CHUNK(chunk), val0, count, xfr);
-						dumpiov(&r_iovec[i]);
-						dumpbits(bits, (nchunks+7)/8);
+						ft_dumpiov(&r_iovec[i]);
+						ft_dumpbits(bits, (nchunks+7)/8);
 						tst_exit();
 					}
 				}
@@ -419,12 +388,12 @@ int dotest(testers, me, fd)
 					tst_exit();
 				}
 				++collide;
-				for(i = 0; i < MAXIOVCNT; i++) {
+				for (i = 0; i < MAXIOVCNT; i++) {
 					if (memcmp(r_iovec[i].iov_base, val_iovec[i].iov_base, r_iovec[i].iov_len)) {
 						tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d.",
 							me, CHUNK(chunk), val, count, xfr);
-						dumpiov(&r_iovec[i]);
-						dumpbits(bits, (nchunks+7)/8);
+						ft_dumpiov(&r_iovec[i]);
+						ft_dumpbits(bits, (nchunks+7)/8);
 						tst_exit();
 					}
 				}
@@ -432,7 +401,7 @@ int dotest(testers, me, fd)
 			/*
 			 * Write it.
 			 */
-			if (lseek64(fd, -((off64_t)xfr), 1) <  (off64_t)0) {
+			if (lseek64(fd, -xfr, 1) < 0) {
 				tst_resm(TFAIL, "\tTest[%d]: lseek64(1) fail at %Lx, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
@@ -451,7 +420,7 @@ int dotest(testers, me, fd)
 			 * If hit "misc" interval, do it.
 			 */
 			if (misc_intvl && --whenmisc <= 0) {
-				domisc(me, fd, bits);
+				domisc(me, fd);
 				whenmisc = NEXTMISC;
 			}
 			if (count + collide > 2 * nchunks)
@@ -482,27 +451,22 @@ int dotest(testers, me, fd)
 		}
 
 		fsync(fd);
-		++misc_cnt[(int)m_fsync];
+		++misc_cnt[m_fsync];
 		//tst_resm(TINFO, "\tTest[%d] val %d done, count = %d, collide = %d.",
 		//		me, val, count, collide);
 		//for(i = 0; i < NMISC; i++)
 		//	tst_resm(TINFO, "\t\tTest[%d]: %d %s's.", me, misc_cnt[i], m_str[i]);
 		val0 = val++;
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
+static void domisc(int me, int fd)
 {
-	enum	m_type	type;
+	enum m_type type;
 
 	if (misc_flag) {
 		type = m_fsync;
@@ -511,115 +475,39 @@ int domisc(me, fd, bits)
 		type = m_sync;;
 		misc_flag = 1;
 	}
+
 	switch(type) {
-	case m_fsync:
-		if (fsync(fd) < 0) {
-			tst_resm(TFAIL, "\tTest[%d]: fsync error %d.", me, errno);
-			tst_exit();
-		}
+		case m_fsync:
+			if (fsync(fd) < 0) {
+				tst_resm(TFAIL, "\tTest[%d]: fsync error %d.", me, errno);
+				tst_exit();
+			}
 		break;
-	case m_sync:
-		sync();
+		case m_sync:
+			sync();
 		break;
 	}
-	++misc_cnt[(int)type];
-	return 0;
-}
 
-int bfill(buf, val, size)
-	register char *buf;
-	char	val;
-	register int size;
-{
-	register int i;
-
-	for(i = 0; i < size; i++)
-		buf[i] = val;
-	return 0;
+	++misc_cnt[type];
 }
 
-/*
- * dumpiov
- *	Dump the contents of the r_iovec buffer.
- */
-
-int dumpiov(iovptr)
-	register struct iovec *iovptr;
-{
-	register int i;
-	char	val;
-	int	idx;
-	int	nout;
-
-	tst_resm(TINFO, "\tBuf:");
-	nout = 0;
-	idx = 0;
-	val = ((char *)iovptr->iov_base)[0];
-	for(i = 0; i < iovptr->iov_len; i++) {
-		if (((char *)iovptr->iov_base)[i] != val) {
-			if (i == idx+1)
-				tst_resm(TINFO, "\t%x, ", ((char *)iovptr->iov_base)[idx] & 0xff);
-			else
-				tst_resm(TINFO, "\t%d*%x, ", i-idx, ((char *)iovptr->iov_base)[idx] & 0xff);
-			idx = i;
-			++nout;
-		}
-		if (nout > 10) {
-			tst_resm(TINFO, "\t ... more");
-			return 0;
-		}
-	}
-	if (i == idx+1)
-		tst_resm(TINFO, "\t%x", ((char *)iovptr->iov_base)[idx] & 0xff);
-	else
-		tst_resm(TINFO, "\t%d*%x", i-idx, ((char *)iovptr->iov_base)[idx]);
-	return 0;
-}
-
-
-/*
- * dumpbits
- *	Dump the bit-map.
- */
-
-int dumpbits(bits, size)
-	char	*bits;
-	register int size;
-{
-	register char *buf;
-
-	tst_resm(TINFO, "\tBits array:");
-	for(buf = bits; size > 0; --size, ++buf) {
-		if ((buf-bits) % 16 == 0)
-			tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
-		tst_resm(TINFO, "%02x ", (int)*buf & 0xff);
-	}
-	printf("\n");
-	return 0;
-}
-
-/*--------------------------------------------------------------*/
-
-
-int term()
+static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	register int i;
+	int i;
 
 	tst_resm(TINFO, "\tterm -[%d]- got sig term.", getpid());
 
 	if (parent_pid == getpid()) {
 		for (i=0; i < nchild; i++)
-			if (pidlist[i])		/* avoid embarassment */
+			if (pidlist[i])
 				kill(pidlist[i], SIGTERM);
-		return 0;
+		return;
 	}
 
 	tst_exit();
-	return 0;
 }
 
-void
-cleanup()
+void cleanup(void)
 {
         /*
          * print timing stats if that option was specified.
@@ -628,6 +516,5 @@ cleanup()
         TEST_CLEANUP;
 
         tst_rmdir();
-        tst_exit();
 }
 
Index: ltp/testcases/kernel/fs/ftest/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/Makefile
+++ ltp/testcases/kernel/fs/ftest/Makefile
@@ -1,5 +1,6 @@
 #
 #  Copyright (c) International Business Machines  Corp., 2001
+#  Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
 #
 #  This program is free software;  you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
@@ -20,18 +21,16 @@
 # name of file	: Makefile						  #
 # description	: make(1) description file for the send(2) tests.	  #
 ###########################################################################
-CFLAGS+=	-I../../../../include -Wall -g
-LOADLIBES+=	-L../../../../lib -lltp
+CFLAGS+=	-I../../../../include -W -Wall -g
+LOADLIBES+=	-L../../../../lib libftest.o -lltp
 
-SRCS=$(wildcard *.c)
+SRCS=$(wildcard ftest*.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
 
-all: $(TARGETS)
+all: libftest.o $(TARGETS)
 
 install:
 	@set -e; for i in $(TARGETS) ; do ln -f $$i ../../../bin/$$i ; done ;
 
 clean:
-	rm -f $(TARGETS)
-
-
+	rm -f $(TARGETS) libftest.o
Index: ltp/testcases/kernel/fs/ftest/ftest04.c
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/ftest04.c
+++ ltp/testcases/kernel/fs/ftest/ftest04.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -36,7 +37,7 @@
  *
  */
 #define _XOPEN_SOURCE 500
-#include <stdio.h>		/* needed by testhead.h		*/
+#include <stdio.h>
 #include <sys/types.h>
 #include <sys/param.h>
 #include <sys/wait.h>
@@ -45,63 +46,53 @@
 #include <sys/stat.h>
 #include <sys/uio.h>
 #include <errno.h>
-#include <signal.h>		/* DEM - added SIGTERM support */
+#include <signal.h>
 #include "test.h"
 #include "usctest.h"
+#include "libftest.h"
 
 char *TCID = "ftest04";
 int TST_TOTAL = 1;
-extern int Tst_count;
 
-void setup();
-int runtest();
-int dotest(int, int, int);
-int domisc(int, int, char*);
-int bfill(char*, char, int);
-int dumpiov(struct iovec*);
-int dumpbits(char*, int);
-int term();
+static void setup(void);
+static void runtest(void);
+static void dotest(int, int, int);
+static void domisc(int, int);
+static void term(int sig);
 
 #define PASSED 1
 #define FAILED 0
 
-
-#define MAXCHILD	25	/* max number of children to allow */
+#define MAXCHILD	25
 #define K_1		1024
 #define K_2		2048
 #define K_4		4096
 #define	MAXIOVCNT	16
 
+static int csize;              /* chunk size */
+static int iterations;         /* # total iterations */
+static int max_size;           /* max file size */
+static int misc_intvl;         /* for doing misc things; 0 ==> no */
+static int nchild;             /* number of child processes */
+static int nwait;
+static int parent_pid;
+static int pidlist[MAXCHILD];
+
+static char filename[128];
 
-int	csize;				/* chunk size */
-int	iterations;			/* # total iterations */
-int	max_size;			/* max file size */
-int	misc_intvl;			/* for doing misc things; 0 ==> no */
-int	nchild;				/* number of child processes */
-int	nwait;
-int	parent_pid;
-int	pidlist[MAXCHILD];
-
-char	filename[128];
-char	*prog;
-
-int	local_flag;
-
-/*--------------------------------------------------------------*/
-int main (ac, av)
-	int  ac;
-	char *av[];
+static int local_flag;
+
+int main(int ac, char *av[])
 {
-	int lc;                 /* loop counter */
-        char *msg;              /* message returned from parse_opts */
+	int lc;
+        char *msg;
 
         /*
          * parse standard options
          */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
+        if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL){
 	                tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);
 			tst_exit();
-                       /*NOTREACHED*/
         }
 
         setup();
@@ -110,23 +101,23 @@ int main (ac, av)
 
                	runtest();
 
-              	if (local_flag == PASSED) {
+              	if (local_flag == PASSED)
                         tst_resm(TPASS, "Test passed.");
-              	} else {
+              	else
                         tst_resm(TFAIL, "Test failed.");
-		}
+
+		/* ??? only one loop ??? */
 		tst_rmdir();
 	       	tst_exit();
-	 } /* end of for */
+	}
+
 	return 0;
 }
 
-void
-setup()
+static void setup(void)
 {
 	int fd;
 	char wdbuf[MAXPATHLEN];
-	int term();
 
 	parent_pid = getpid();
 
@@ -144,18 +135,16 @@ setup()
 	}
 	close(fd);
 
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
 		tst_resm(TFAIL,"first sigset failed");
 		tst_exit();
 	}
@@ -163,28 +152,20 @@ setup()
 	local_flag = PASSED;
 }
 
-/*--------------------------------------------------------------*/
-
-
-int runtest()
+static void runtest(void)
 {
-	register int i;
-	int	child;
-	int	status;
-	int	count;
-	int	fd;
-
+	int i, child, status, count, fd;
 
-	for(i = 0; i < nchild; i++) {
-		if ((child = fork()) == 0) {		/* child */
+	for (i = 0; i < nchild; i++) {
+		if ((child = fork()) == 0) {
 			fd = open(filename, O_RDWR);
 			if (fd < 0) {
-				tst_resm(TBROK, "\tTest[%d]: error %d openning %s.", errno, filename);
+				tst_resm(TBROK, "\tTest[%d]: error %d openning %s.", i, errno, filename);
 				tst_exit();
 			}
-			dotest(nchild, i, fd);		/* do it! */
+			dotest(nchild, i, fd);
 			close(fd);
-			tst_exit();			/* when done, exit */
+			tst_exit();
 		}
 		if (child < 0) {
 			 tst_resm(TINFO, "System resource may be too low, fork() malloc()"
@@ -201,11 +182,9 @@ int runtest()
 	/*
 	 * Wait for children to finish.
 	 */
-
 	count = 0;
-	while((child = wait(&status)) != -1 || errno == EINTR) {
-		if (child > 0)
-		{
+	while ((child = wait(&status)) != -1 || errno == EINTR) {
+		if (child > 0) {
 			//tst_resm(TINFO, "\tTest{%d} exited status = 0x%x", child, status);
 			if (status) {
 				tst_resm(TFAIL, "\tExpected 0 exit status - failed.");
@@ -218,16 +197,13 @@ int runtest()
 	/*
 	 * Should have collected all children.
 	 */
-
 	if (count != nwait) {
 		tst_resm(TFAIL, "\tWrong # children waited on, count = %d", count);
 		local_flag = FAILED;
 	}
 
 	unlink(filename);
-
-	sync();				/* safeness */
-	return 0;
+	sync();
 }
 
 /*
@@ -237,12 +213,9 @@ int runtest()
  * Randomly read/mod/write chunks with known pattern and check.
  * When fill sectors, iterate.
  */
-
 #define	NMISC	2
 enum	m_type { m_fsync, m_sync };
-char	*m_str[] = {
-		"fsync",   "sync"
-};
+char	*m_str[] = {"fsync", "sync"};
 
 int	misc_cnt[NMISC];		/* counts # of each kind of misc */
 int	misc_flag;
@@ -251,38 +224,29 @@ int	nchunks;
 #define	CHUNK(i)	(((i) * testers + me) * csize)
 #define	NEXTMISC	((rand() % misc_intvl) + 5)
 
-int dotest(testers, me, fd)
-	int	testers;
-	int	me;
-	int	fd;
+static void dotest(int testers, int me, int fd)
 {
-	register int	i;
-	char	*bits;
-	char	*buf;
-	int	count;
-	int	collide;
-	char	val;
-	char	val0;
-	int	chunk;
-	int	whenmisc;
-	int	xfr;
+	char *bits, *buf;
+	char val, val0;
+	int count, collide, chunk, whenmisc, xfr, i;
 
 	/* Stuff for the readv call */
 	struct	iovec	r_iovec[MAXIOVCNT];
 	int	r_ioveclen;
 
 	/* Stuff for the writev call */
-						
 	struct	iovec	val0_iovec[MAXIOVCNT];
 	struct	iovec	val_iovec[MAXIOVCNT];
 	int	w_ioveclen;
 
 	nchunks = max_size / (testers * csize);
-	if( (bits = (char*)malloc((nchunks+7)/8)) == 0) {
+
+	if ((bits = malloc((nchunks+7)/8)) == NULL) {
 		tst_resm(TBROK, "\tmalloc failed(bits)");
 		tst_exit();
 	}
-	if( (buf = (char*)(malloc(csize))) == 0) {
+
+	if ((buf = (malloc(csize))) == NULL) {
 		tst_resm(TBROK, "\tmalloc failed(buf)");
 		tst_exit();
 	}
@@ -291,12 +255,12 @@ int dotest(testers, me, fd)
 	 */
 	r_ioveclen = w_ioveclen = csize / MAXIOVCNT;
 
-		/* Please note that the above statement implies that csize
-		 * be evenly divisible by MAXIOVCNT.
-		 */
+	/* Please note that the above statement implies that csize
+	 * be evenly divisible by MAXIOVCNT.
+	 */
 
 	for (i = 0; i < MAXIOVCNT; i++) {
-		if( (r_iovec[i].iov_base = (char*)malloc(r_ioveclen)) == 0) {
+		if ((r_iovec[i].iov_base = malloc(r_ioveclen)) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed(r_iovec[])");
 			tst_exit();
 		}
@@ -305,28 +269,31 @@ int dotest(testers, me, fd)
 		/* Allocate unused memory areas between all the buffers to
 		 * make things more diffult for the OS.
 		 */
-
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed");
 			tst_exit();
 		}
-		if( (val0_iovec[i].iov_base = (char*)malloc(w_ioveclen)) == 0){
+
+		if ((val0_iovec[i].iov_base = malloc(w_ioveclen)) == NULL){
 			tst_resm(TBROK, "\tmalloc failed(val0_iovec[])");
 			tst_exit();
 		}
+
 		val0_iovec[i].iov_len = w_ioveclen;
 	
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed");
 			tst_exit();
 		}
-		if( (val_iovec[i].iov_base = (char*)malloc(w_ioveclen)) == 0){
+
+		if ((val_iovec[i].iov_base = malloc(w_ioveclen)) == NULL){
 			tst_resm(TBROK, "\tmalloc failed(iov_base)");
 			tst_exit();
 		}
+
 		val_iovec[i].iov_len = w_ioveclen;
 
-		if(malloc((i+1)*8) == 0) {
+		if (malloc((i+1)*8) == NULL) {
 			tst_resm(TBROK, "\tmalloc failed");
 			tst_exit();
 		}
@@ -335,7 +302,6 @@ int dotest(testers, me, fd)
 	/*
 	 * No init sectors; file-sys makes 0 to start.
 	 */
-
 	val = (64/testers) * me + 1;
 	val0 = 0;
 
@@ -353,28 +319,29 @@ int dotest(testers, me, fd)
 	 *		repeat until count = nchunks.
 	 *	++val.
 	 */
-
 	srand(getpid());
-	if (misc_intvl) whenmisc = NEXTMISC;
+
+	if (misc_intvl)
+		whenmisc = NEXTMISC;
+
 	while(iterations-- > 0) {
 		for(i = 0; i < NMISC; i++)
 			misc_cnt[i] = 0;
-		bfill(bits, 0, (nchunks+7)/8);
-		/* Have to fill the val0 and val iov buffers in a different manner
-		 */
+		memset(bits, 0, (nchunks+7)/8);
+		/* Have to fill the val0 and val iov buffers in a different manner */
 		for(i = 0; i < MAXIOVCNT; i++) {
-			bfill(val0_iovec[i].iov_base,val0,val0_iovec[i].iov_len);
-			bfill(val_iovec[i].iov_base,val,val_iovec[i].iov_len);
+			memset(val0_iovec[i].iov_base,val0,val0_iovec[i].iov_len);
+			memset(val_iovec[i].iov_base,val,val_iovec[i].iov_len);
 
 		}
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
 				tst_resm(TFAIL, "\tTest[%d]: lseek(0) fail at %x, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
@@ -401,8 +368,8 @@ int dotest(testers, me, fd)
 					if (memcmp(r_iovec[i].iov_base, val0_iovec[i].iov_base, r_iovec[i].iov_len)) {
 						tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%x for val %d count %d xfr %d.",
 							me, CHUNK(chunk), val0, count, xfr);
-						dumpiov(&r_iovec[i]);
-						dumpbits(bits, (nchunks+7)/8);
+						ft_dumpiov(&r_iovec[i]);
+						ft_dumpbits(bits, (nchunks+7)/8);
 						tst_exit();
 					}
 				}
@@ -419,8 +386,8 @@ int dotest(testers, me, fd)
 					if (memcmp(r_iovec[i].iov_base, val_iovec[i].iov_base, r_iovec[i].iov_len)) {
 						tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%x for val %d count %d xfr %d.",
 							me, CHUNK(chunk), val, count, xfr);
-						dumpiov(&r_iovec[i]);
-						dumpbits(bits, (nchunks+7)/8);
+						ft_dumpiov(&r_iovec[i]);
+						ft_dumpbits(bits, (nchunks+7)/8);
 						tst_exit();
 					}
 				}
@@ -428,7 +395,7 @@ int dotest(testers, me, fd)
 			/*
 			 * Write it.
 			 */
-			if (lseek(fd, -((long)xfr), 1) <  0) {
+			if (lseek(fd, -xfr, 1) <  0) {
 				tst_resm(TFAIL, "\tTest[%d]: lseek(1) fail at %x, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
@@ -447,7 +414,7 @@ int dotest(testers, me, fd)
 			 * If hit "misc" interval, do it.
 			 */
 			if (misc_intvl && --whenmisc <= 0) {
-				domisc(me, fd, bits);
+				domisc(me, fd);
 				whenmisc = NEXTMISC;
 			}
 			if (count + collide > 2 * nchunks)
@@ -463,7 +430,7 @@ int dotest(testers, me, fd)
 			//		me, val, count, collide);
 			for(i = 0; i < nchunks; i++) {
 				if ((bits[i/8] & (1<<(i%8))) == 0) {
-					if (lseek(fd, (long)CHUNK(i), 0) < 0) {
+					if (lseek(fd, CHUNK(i), 0) < 0) {
 						tst_resm(TFAIL, "\tTest[%d]: lseek fail at %x, errno = %d.",
 							me, CHUNK(i), errno);
 						tst_exit();
@@ -478,122 +445,40 @@ int dotest(testers, me, fd)
 		}
 
 		fsync(fd);
-		++misc_cnt[(int)m_fsync];
+		++misc_cnt[m_fsync];
 		//tst_resm(TINFO, "\tTest[%d] val %d done, count = %d, collide = %d.",
 		//		me, val, count, collide);
 		//for(i = 0; i < NMISC; i++)
 		//	tst_resm(TINFO, "\t\tTest[%d]: %d %s's.", me, misc_cnt[i], m_str[i]);
 		val0 = val++;
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
+static void domisc(int me, int fd)
 {
-
 	if (fsync(fd) < 0) {
 		tst_resm(TFAIL, "\tTest[%d]: fsync error %d.", me, errno);
 		tst_exit();
 	}
 
-	++misc_cnt[(int)1];
-	return 0;
-}
-
-int bfill(buf, val, size)
-	register char *buf;
-	char	val;
-	register int size;
-{
-	register int i;
-
-	for(i = 0; i < size; i++)
-		buf[i] = val;
-	return 0;
-}
-
-/*
- * dumpiov
- *	Dump the contents of the r_iovec buffer.
- */
-
-int dumpiov(iovptr)
-	register struct iovec *iovptr;
-{
-	register int i;
-	char	val;
-	int	idx;
-	int	nout;
-
-	tst_resm(TINFO, "\tBuf:");
-	nout = 0;
-	idx = 0;
-	val = ((char *)iovptr->iov_base)[0];
-	for(i = 0; i < iovptr->iov_len; i++) {
-		if (((char *)iovptr->iov_base)[i] != val) {
-			if (i == idx+1)
-				tst_resm(TINFO, "\t%x, ", ((char *)iovptr->iov_base)[idx] & 0xff);
-			else
-				tst_resm(TINFO, "\t%d*%x, ", i-idx, ((char *)iovptr->iov_base)[idx] & 0xff);
-			idx = i;
-			++nout;
-		}
-		if (nout > 10) {
-			tst_resm(TINFO, "\t ... more");
-			return 0;
-		}
-	}
-	if (i == idx+1)
-		tst_resm(TINFO, "\t%x", ((char *)iovptr->iov_base)[idx] & 0xff);
-	else
-		tst_resm(TINFO, "\t%d*%x", i-idx, ((char *)iovptr->iov_base)[idx]);
-	return 0;
+	++misc_cnt[1];
 }
 
-
-/*
- * dumpbits
- *	Dump the bit-map.
- */
-
-int dumpbits(bits, size)
-	char	*bits;
-	register int size;
+static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	register char *buf;
-
-	tst_resm(TINFO, "\tBits array:");
-	for(buf = bits; size > 0; --size, ++buf) {
-		if ((buf-bits) % 16 == 0)
-			tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
-		tst_resm(TINFO, "%02x ", (int)*buf & 0xff);
-	}
-	return 0;
-}
-
-/*--------------------------------------------------------------*/
-
-int term()
-{
-	register int i;
+	int i;
 
 	tst_resm(TINFO, "\tterm -[%d]- got sig term.", getpid());
 
 	if (parent_pid == getpid()) {
-		for (i=0; i < nchild; i++)
-			if (pidlist[i])		/* avoid embarassment */
+		for (i = 0; i < nchild; i++)
+			if (pidlist[i])
 				kill(pidlist[i], SIGTERM);
-		return 0;
 	}
 
 	exit(0);
 }
-

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--gBBFr7Ir9EOA20Yy--

