Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MqnrE-00039q-Hg
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 12:55:36 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mqnr7-0008D9-2X
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 12:55:34 +0000
From: Jiri Palecek <jpalecek@web.de>
Date: Thu, 24 Sep 2009 14:23:45 +0200
References: <b9d696240909211602o51c38c2ei41a8622d3250f06b@mail.gmail.com>
In-Reply-To: <b9d696240909211602o51c38c2ei41a8622d3250f06b@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200909241423.45226.jpalecek@web.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RT2uK4Hb8OkI3xk"
Subject: Re: [LTP] Buffer Overflow with ftest03 and ftest07
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
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--Boundary-00=_RT2uK4Hb8OkI3xk
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

Hi,

On Tuesday 22 September 2009 01:02:29 K.D. Lucas wrote:
> Since I started using LTP 20090831 I've been seeing buffer overflow messages
> when running ftest03 and ftest07. The back trace is:
> 
> *** buffer overflow detected ***: ftest03 terminated
> ======= Backtrace: =========
> /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xa17038]
> /lib/tls/i686/cmov/libc.so.6[0xa15140]
> /lib/tls/i686/cmov/libc.so.6[0xa14838]
> /lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x986d18]
> /lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x95981c]
> /lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0xa148e4]
> /lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0xa1482d]
> ftest03[0x804a7d9]
> ftest03[0x804a884]
> /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x92f7a5]
> ftest03[0x8049461]
> ======= Memory map: ========
> 00919000-00a75000 r-xp 00000000 08:01 132417     /lib/tls/i686/cmov/
> libc-2.9.so
> 00a75000-00a76000 ---p 0015c000 08:01 132417     /lib/tls/i686/cmov/
> libc-2.9.so
> 00a76000-00a78000 r--p 0015c000 08:01 132417     /lib/tls/i686/cmov/
> libc-2.9.so
> 00a78000-00a79000 rw-p 0015e000 08:01 132417     /lib/tls/i686/cmov/
> libc-2.9.so
> 00a79000-00a7c000 rw-p 00000000 00:00 0
> 00a8c000-00aa8000 r-xp 00000000 08:01 367        /lib/ld-2.9.so
> 00aa8000-00aa9000 r--p 0001b000 08:01 367        /lib/ld-2.9.so
> 00aa9000-00aaa000 rw-p 0001c000 08:01 367        /lib/ld-2.9.so
> 00c91000-00cbb000 r-xp 00000000 08:01 409        /lib/libgcc_s.so.1
> 00cbb000-00cbc000 r--p 00029000 08:01 409        /lib/libgcc_s.so.1
> 00cbc000-00cbd000 rw-p 0002a000 08:01 409        /lib/libgcc_s.so.1
> 00cce000-00ccf000 r-xp 00000000 00:00 0          [vdso]
> 08048000-08050000 r-xp 00000000 08:01 231138
> /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
> 08050000-08051000 r--p 00007000 08:01 231138
> /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
> 08051000-08052000 rw-p 00008000 08:01 231138
> /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
> 08052000-08056000 rw-p 00000000 00:00 0
> 09ead000-09ece000 rw-p 00000000 00:00 0          [heap]
> b7f8d000-b7f8e000 rw-p 00000000 00:00 0
> b7f9b000-b7f9d000 rw-p 00000000 00:00 0
> bff91000-bffa6000 rw-p 00000000 00:00 0          [stack]
> *** buffer overflow detected ***: ftest07 terminated
> ======= Backtrace: =========
> /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0x20e038]
> /lib/tls/i686/cmov/libc.so.6[0x20c140]
> /lib/tls/i686/cmov/libc.so.6[0x20b838]
> /lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x17dd18]
> /lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x15081c]
> /lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0x20b8e4]
> /lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0x20b82d]
> ftest07[0x804a9d1]
> ftest07[0x804aa74]
> /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x1267a5]
> ftest07[0x8049421]
> ======= Memory map: ========
> 00110000-0026c000 r-xp 00000000 08:01 132417     /lib/tls/i686/cmov/
> libc-2.9.so
> 0026c000-0026d000 ---p 0015c000 08:01 132417     /lib/tls/i686/cmov/
> libc-2.9.so
> 0026d000-0026f000 r--p 0015c000 08:01 132417     /lib/tls/i686/cmov/
> libc-2.9.so
> 0026f000-00270000 rw-p 0015e000 08:01 132417     /lib/tls/i686/cmov/
> libc-2.9.so
> 00270000-00273000 rw-p 00000000 00:00 0
> 00642000-0066c000 r-xp 00000000 08:01 409        /lib/libgcc_s.so.1
> 0066c000-0066d000 r--p 00029000 08:01 409        /lib/libgcc_s.so.1
> 0066d000-0066e000 rw-p 0002a000 08:01 409        /lib/libgcc_s.so.1
> 00d7c000-00d7d000 r-xp 00000000 00:00 0          [vdso]
> 00dfe000-00e1a000 r-xp 00000000 08:01 367        /lib/ld-2.9.so
> 00e1a000-00e1b000 r--p 0001b000 08:01 367        /lib/ld-2.9.so
> 00e1b000-00e1c000 rw-p 0001c000 08:01 367        /lib/ld-2.9.so
> 08048000-08050000 r-xp 00000000 08:01 231142
> /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
> 08050000-08051000 r--p 00007000 08:01 231142
> /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
> 08051000-08052000 rw-p 00008000 08:01 231142
> /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
> 08052000-08057000 rw-p 00000000 00:00 0
> 09fce000-09fef000 rw-p 00000000 00:00 0          [heap]
> b802f000-b8030000 rw-p 00000000 00:00 0
> b803d000-b803f000 rw-p 00000000 00:00 0
> bfdfb000-bfe10000 rw-p 00000000 00:00 0          [stack]
> 
> 
> This is running against an Ubuntu Karmic Alpha netbook remix. I don't see
> this issue when testing on dapper or hardy distros. I saw some other posts
> about this, but no one has offered any suggestions or solutions yet.

It seems the problem is with some sprintf() call, and indeed, there is one in the code. I propose deleting it (with other code) altogether, because it  was needed just for creation of a temporary directory and we have tst_tmpdir() for that. See the attachment and please report whether it works and whether such solution is acceptable.

Note that the code was not tested in any way.

Regards
    Jiri Palecek

--Boundary-00=_RT2uK4Hb8OkI3xk
Content-Type: text/x-patch;
  charset="iso-8859-2";
  name="test-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test-patch.diff"

commit 74c9729d10fcf866eff93ae830005fb13b464e16
Author: Jiri Palecek <jirka@debian.(none)>
Date:   Thu Sep 24 13:18:25 2009 +0200

    Remove fuss from ftest testcases
    
     The testcases contained logic for creating their temporary
     directories. IMHO, this was superseded with the introduction of
     tst_tmpdir, and the code might invoke buffer overflow errors, so it's
     better deleted.

diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index 8bbbdce..ecdc0ab 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -95,9 +95,6 @@ int	pidlist[MAXCHILD];
 char	test_name[2];			/* childs test directory name */
 char	*prog;
 
-char	fuss[40] = "";		/* directory to do this in */
-char	homedir[200]= "";	/* where we started */
-
 int 	local_flag;
 
 /*--------------------------------------------------------------*/
@@ -143,18 +140,8 @@ setup()
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	getcwd(homedir, sizeof( homedir));
 	parent_pid = getpid();
 
-	if (!fuss[0])
-		sprintf(fuss, "./ftest1.%d", getpid());
-
-	mkdir(fuss, 0755);
-
-	if (chdir(fuss) < 0) {
-		tst_brkm(TBROK,0,"Can't chdir(%s): %s", fuss, strerror(errno));
-	}
-
 	 /*
 	  * Default values for run conditions.
 	  */
@@ -166,8 +153,7 @@ setup()
 	misc_intvl = 10;
 
 	if ((sigset(SIGTERM, (void (*)())term)) == SIG_ERR) {
-		tst_resm(TBROK,"sigset failed: %s", strerror(errno));
-	        tst_exit();
+		tst_brkm(TBROK, cleanup, "sigset failed: %s", strerror(errno));
 	}
 
 	local_flag = PASSED;
@@ -189,7 +175,7 @@ int runtest()
 		test_name[1] = '\0';
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
 		if (fd < 0) {
-			tst_brkm(TBROK,0, "Can't creating %s/%s: %s", fuss, test_name, strerror(errno));
+			tst_brkm(TBROK,0, "Can't creating %s: %s", test_name, strerror(errno));
 		}
 		if ((child = fork()) == 0) {		/* child */
 			dotest(nchild, i, fd);		/* do it! */
@@ -216,7 +202,7 @@ int runtest()
 	{
 		if ((child = wait(&status)) >= 0) {
 			if (status) {
-				tst_resm(TFAIL,0, "Test{%d} failed, expected 0 exit", child);
+				tst_resm(TFAIL, "Test{%d} failed, expected 0 exit", child);
 				local_flag = FAILED;
 			}
 			++count;
@@ -243,27 +229,6 @@ int runtest()
 		tst_resm(TFAIL, "Test failed in fork and wait.");
 	}
 
-	chdir(homedir);
-	pid = fork();
-	if (pid < 0) {
-
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-		          " etc are likely to fail.");
-
-		tst_resm(TBROK, "Can not remove '%s' due to inability of fork.",fuss);
-		sync();
-		tst_exit();
-	}
-	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-		tst_exit();
-	}
-
-	wait(&status);
-	if (status) {
-		tst_resm(TINFO, "CAUTION - ftest1, '%s' may not be removed", fuss);
-	}
-
 	sync();				/* safeness */
 	return 0;
 }
diff --git a/testcases/kernel/fs/ftest/ftest03.c b/testcases/kernel/fs/ftest/ftest03.c
index 35d4328..a031f72 100644
--- a/testcases/kernel/fs/ftest/ftest03.c
+++ b/testcases/kernel/fs/ftest/ftest03.c
@@ -72,6 +72,7 @@ extern int Tst_count;
 #define FAILED 0
 
 void setup();
+static void cleanup(void);
 int runtest();
 int dotest(int, int, int);
 int domisc(int, int, char*);
@@ -98,10 +99,7 @@ int	fd;				/* file descriptor used by child */
 int	parent_pid;
 int	pidlist[MAXCHILD];
 char	test_name[2];			/* childs test directory name */
-char	*prog, *getcwd() ;
-
-char	fuss[40] = "";		/* directory to do this in */
-char	homedir[200]= "";	/* where we started */
+char	*prog;
 
 int 	local_flag;
 /*--------------------------------------------------------------*/
@@ -135,9 +133,8 @@ int main (ac, av)
                         tst_resm(TFAIL, "Test failed.");
                 }
 
-		tst_rmdir();
-		tst_exit();
 	} /* end for */
+	cleanup();
 	return 0;
 }
 /*--------------------------------------------------------------*/
@@ -153,24 +150,8 @@ setup()
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	if ( (cwd = getcwd(homedir, sizeof( homedir))) == NULL ) {
-	  tst_resm(TBROK, "pwd") ;
-	  tst_exit() ;
-	}
-
 	parent_pid = getpid();
 
-	if (!fuss[0])
-		sprintf(fuss, "%s/ftest03.%d", getcwd(wdbuf, sizeof( wdbuf)), getpid());
-
-	mkdir(fuss, 0755);
-
-	if (chdir(fuss) < 0) {
-		tst_resm(TBROK,"\tCan't chdir(%s), error %d.", fuss, errno);
-		tst_exit() ;
-	}
-
-
 	/*
 	 * Default values for run conditions.
 	 */
@@ -182,13 +163,16 @@ setup()
 	misc_intvl = 10;
 
 	if (sigset(SIGTERM, (void (*)())term) == SIG_ERR) {
-		perror("sigset failed");
-		tst_resm(TBROK, " sigset failed: signo = 15") ;
-		tst_exit() ;
+		tst_brkm(TBROK|TERRNO, cleanup, " sigset failed: signo = 15") ;
 	}
 
 }
 
+static void cleanup(void)
+{
+	tst_rmdir();
+	tst_exit();
+}
 
 int runtest()
 {
@@ -205,8 +189,7 @@ int runtest()
 		test_name[1] = '\0';
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
 		if (fd < 0) {
-			tst_resm(TBROK, "\tError %d creating %s/%s.", errno, fuss, test_name);
-			tst_exit();
+			tst_brkm(TBROK, cleanup, "\tError %d creating %s.", errno, test_name);
 		}
 		if ((child = fork()) == 0) {		/* child */
 			dotest(nchild, i, fd);		/* do it! */
@@ -258,28 +241,6 @@ int runtest()
 		local_flag = FAILED;
 	}
 
-	chdir(homedir);
-
-	pid = fork();
-	if (pid < 0) {
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-                              " etc are likely to fail.");
-                tst_resm(TBROK, "Test broken due to inability of fork.");
-		sync();				/* safeness */
-		tst_exit();
-	}
-
-	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-		tst_exit();
-	} else
-		wait(&status);
-	if (status) {
-		tst_resm(TINFO, "CAUTION - ftest03, '%s' may not be removed", fuss);
-		tst_resm(TINFO, "CAUTION - ftest03, '%s' may not be removed",
-		  fuss);
-	}
-
 	sync();				/* safeness */
 	return 0;
 }
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index 24fac1d..5fe16ad 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -98,9 +98,6 @@ int	pidlist[MAXCHILD];
 char	test_name[2];			/* childs test directory name */
 char	*prog;
 
-char	fuss[40] = "";		/* directory to do this in */
-char	homedir[200]= "";	/* where we started */
-
 int	local_flag;
 
 /*--------------------------------------------------------------*/
@@ -147,20 +144,8 @@ setup()
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	getcwd(homedir, sizeof( homedir));
 	parent_pid = getpid();
 
-	if (!fuss[0])
-		sprintf(fuss, "./ftest05.%d", getpid());
-
-	mkdir(fuss, 0755);
-
-	if (chdir(fuss) < 0) {
-		tst_resm(TBROK,"\tCan't chdir(%s), error %d.", fuss, errno);
-		tst_exit();
-	}
-
-
 	/*
 	 * Default values for run conditions.
 	 */
@@ -195,8 +180,7 @@ int runtest()
 		test_name[1] = '\0';
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
 		if (fd < 0) {
-			tst_resm(TBROK, "\tError %d creating %s/%s.", errno, fuss, test_name);
-			tst_exit();
+			tst_brkm(TBROK|TERRNO, cleanup, "Error creating %s.", test_name);
 		}
 		if ((child = fork()) == 0) {		/* child */
 			dotest(nchild, i, fd);		/* do it! */
@@ -206,8 +190,7 @@ int runtest()
 		if (child < 0) {
 			 tst_resm(TINFO, "System resource may be too low, fork() malloc()"
 		                          " etc are likely to fail.");
-		         tst_resm(TBROK, "Test broken due to inability of fork.");
-		         tst_exit();
+			 tst_brkm(TBROK, cleanup, "Test broken due to inability of fork.");
 		} else {
 			pidlist[i] = child;
 			nwait++;
@@ -245,26 +228,6 @@ int runtest()
 		local_flag = FAILED;
 	}
 
-
-	chdir(homedir);
-	pid = fork();
-	if (pid < 0) {
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-                                 " etc are likely to fail.");
-                tst_resm(TBROK, "Test broken due to inability of fork.");
-		sync();
-                tst_exit();
-	}
-	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-		tst_exit();
-	}
-
-	wait(&status);
-	if (status) {
-		tst_resm(TINFO,"CAUTION - ftest05, '%s' may not be removed", fuss);
-	}
-
 	sync();				/* safeness */
 	return 0;
 }
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index 2b2aa7c..e1d22c5 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -84,6 +84,7 @@ extern int Tst_count;
 #define	MAXIOVCNT	16
 
 void setup();
+static void cleanup(void);
 int runtest();
 int dotest(int, int, int);
 int domisc(int, int, char*);
@@ -103,10 +104,7 @@ int	fd;				/* file descriptor used by child */
 int	parent_pid;
 int	pidlist[MAXCHILD];
 char	test_name[2];			/* childs test directory name */
-char	*prog, *getcwd() ;
-
-char	fuss[40] = "";		/* directory to do this in */
-char	homedir[200]= "";	/* where we started */
+char	*prog;
 
 int	local_flag;
 
@@ -141,10 +139,8 @@ int main (ac, av)
                          tst_resm(TFAIL, "Test failed.");
                  }
 
-                tst_rmdir();
-                tst_exit();
-
 	} /* end for */
+	cleanup();
 	return 0;
 }
 	/*--------------------------------------------------------------*/
@@ -154,27 +150,8 @@ void setup()
 	char wdbuf[MAXPATHLEN],  *cwd ;
 	int term();
 
-	/*
-	 * Make a directory to do this in; ignore error if already exists.
-	 * Save starting directory.
-	 */
-
-	if ( (cwd = getcwd(homedir, sizeof( homedir))) == NULL ) {
-	  tst_resm(TBROK,"Failed to get corrent directory") ;
-	  tst_exit() ;
-	}
-
 	parent_pid = getpid();
 	tst_tmpdir();
-	if (!fuss[0])
-		sprintf(fuss, "%s/ftest07.%d", getcwd(wdbuf, sizeof( wdbuf)), getpid());
-
-	mkdir(fuss, 0755);
-
-	if (chdir(fuss) < 0) {
-		tst_resm(TBROK,"\tCan't chdir(%s), error %d.", fuss, errno);
-		tst_exit() ;
-	}
 
 	/*
 	 * Default values for run conditions.
@@ -187,12 +164,17 @@ void setup()
 	misc_intvl = 10;
 
 	if (sigset(SIGTERM, (void (*)())term) == SIG_ERR) {
-		tst_resm(TBROK, " sigset failed: signo = 15") ;
-		tst_exit() ;
+		tst_brkm(TBROK, cleanup, " sigset failed: signo = 15") ;
 	}
 
 }
 
+static void cleanup(void)
+{
+	tst_rmdir();
+	tst_exit();
+}
+
 int runtest()
 {
 	register int i;
@@ -259,25 +241,6 @@ int runtest()
 		local_flag = FAILED;
 	}
 
-	chdir(homedir);
-
-	pid = fork();
-	if (pid < 0) {
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-                                    " etc are likely to fail.");
-                tst_resm(TBROK, "Test broken due to inability of fork.");
-                tst_exit();
-	}
-
-	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-			exit(1);
-		} else
-			wait(&status);
-	if (status) {
-		tst_resm(TINFO, "CAUTION - ftest07, '%s' may not be removed", fuss);
-	}
-
 	sync();				/* safeness */
 	return 0;
 }

--Boundary-00=_RT2uK4Hb8OkI3xk
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
--Boundary-00=_RT2uK4Hb8OkI3xk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--Boundary-00=_RT2uK4Hb8OkI3xk--

