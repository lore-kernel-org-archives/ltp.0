Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O5JDo-0002Wu-1h
	for ltp-list@lists.sourceforge.net; Fri, 23 Apr 2010 13:47:08 +0000
Date: Fri, 23 Apr 2010 15:54:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100423135424.GA28583@saboteur.suse.cz>
References: <20100402113341.GA9430@saboteur.suse.cz>
	<20100415163103.GA21117@saboteur.suse.cz>
	<m2x364299f41004151046sad3e235mab0294d45c6e2df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <m2x364299f41004151046sad3e235mab0294d45c6e2df@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix ftest03 and ftest07 sefgault
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> Since you're touching some of the pieces in these tests:
> 
> -			tst_brkm(TBROK,0, "Can't creating %s/%s: %s", fuss, test_name,
> strerror(errno));
> +			tst_brkm(TBROK,0, "Can't creating %s: %s", test_name, strerror(errno));
> 
> Could you please change creating to create, potentially change 0 to
> cleanup, and do TBROK | TERRNO instead of TBROK ?

Done, but these tests needs more love than that (and I have that on my long term todo).

Patch attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--cWoXeonUoKmBZSoM
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="get_rid_of_fussII.patch"

diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index c4dc5c8..4fc2fb4 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -90,9 +90,6 @@ static int parent_pid;
 static int pidlist[MAXCHILD];
 static char test_name[2];
 
-static char fuss[40];         /* directory to do this in */
-static char homedir[200];     /* where we started */
-
 static int local_flag;
 
 int main(int ac, char *av[])
@@ -130,18 +127,8 @@ static void setup(void)
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	getcwd(homedir, sizeof(homedir));
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
@@ -162,16 +149,16 @@ static void setup(void)
 
 static void runtest(void)
 {
-	int i, pid, child, status, count;
+	int i, child, status, count;
 
-	for(i = 0; i < nchild; i++) {
+	for (i = 0; i < nchild; i++) {
 
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
 
 		if (fd < 0)
-			tst_brkm(TBROK,0, "Can't creating %s/%s: %s", fuss, test_name, strerror(errno));
+			tst_brkm(TBROK | TERRNO, cleanup, "Can't create %s.", test_name);
 
 		if ((child = fork()) == 0) {
 			dotest(nchild, i, fd);
@@ -221,29 +208,6 @@ static void runtest(void)
 	else
 		tst_resm(TFAIL, "Test failed in fork and wait.");
 
-	chdir(homedir);
-	pid = fork();
-
-	if (pid < 0) {
-
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-		          " etc are likely to fail.");
-
-		tst_resm(TBROK, "Can not remove '%s' due to inability of fork.",fuss);
-		sync();
-		tst_exit();
-	}
-
-	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-		tst_exit();
-	}
-
-	wait(&status);
-
-	if (status)
-		tst_resm(TINFO, "CAUTION - ftest1, '%s' may not be removed", fuss);
-
 	sync();
 }
 
diff --git a/testcases/kernel/fs/ftest/ftest03.c b/testcases/kernel/fs/ftest/ftest03.c
index 1cb6d6f..95ad60b 100644
--- a/testcases/kernel/fs/ftest/ftest03.c
+++ b/testcases/kernel/fs/ftest/ftest03.c
@@ -96,12 +96,9 @@ static int parent_pid;
 static int pidlist[MAXCHILD];
 static char test_name[2];     /* childs test directory name */
 
-static char fuss[40];         /* directory to do this in */
-static char homedir[200];     /* where we started */
-
 static int local_flag;
 
-int main (int ac, char *av[])
+int main(int ac, char *av[])
 {
         int lc;
         char *msg;
@@ -136,33 +133,22 @@ int main (int ac, char *av[])
 	return 0;
 }
 
-static void setup(void)
+static void cleanup(void)
 {
-	char wdbuf[MAXPATHLEN];
+	tst_rmdir();
+	tst_exit();
+}
 
+static void setup(void)
+{
 	/*
 	 * Make a directory to do this in; ignore error if already exists.
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
 
-	if (getcwd(homedir, sizeof(homedir)) == NULL) {
-		tst_resm(TBROK, "getcwd() failed");
-		tst_exit();
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
 	/*
 	 * Default values for run conditions.
 	 */
@@ -181,19 +167,17 @@ static void setup(void)
 
 static void runtest(void)
 {
-	int i, pid, child, status, count;
+	int i, child, status, count;
 
-	for(i = 0; i < nchild; i++) {
+	for (i = 0; i < nchild; i++) {
 
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
 
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
 
-		if (fd < 0) {
-			tst_resm(TBROK, "\tError %d creating %s/%s.", errno, fuss, test_name);
-			tst_exit();
-		}
+		if (fd < 0)
+			tst_brkm(TBROK | TERRNO, cleanup, "Can't create %s.", test_name);
 
 		if ((child = fork()) == 0) {
 			dotest(nchild, i, fd);
@@ -241,30 +225,6 @@ static void runtest(void)
 		local_flag = FAILED;
 	}
 
-	chdir(homedir);
-
-	pid = fork();
-
-	if (pid < 0) {
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-                              " etc are likely to fail.");
-                tst_resm(TBROK, "Test broken due to inability of fork.");
-		sync();
-		tst_exit();
-	}
-
-	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-		tst_exit();
-	} else
-		wait(&status);
-
-	if (status) {
-		tst_resm(TINFO, "CAUTION - ftest03, '%s' may not be removed", fuss);
-		tst_resm(TINFO, "CAUTION - ftest03, '%s' may not be removed",
-		  fuss);
-	}
-
 	sync();
 }
 
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index 220d9fd..cf7779a 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -94,9 +94,6 @@ static int parent_pid;
 static int pidlist[MAXCHILD];
 static char test_name[2];     /* childs test directory name */
 
-static char fuss[40];         /* directory to do this in */
-static char homedir[200];     /* where we started */
-
 static int local_flag;
 
 int main(int ac, char *av[])
@@ -135,19 +132,9 @@ static void setup(void)
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	getcwd(homedir, sizeof (homedir));
+	
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
 	/*
 	 * Default values for run conditions.
 	 */
@@ -167,17 +154,15 @@ static void setup(void)
 
 static void runtest(void)
 {
-	int i, pid, child, status, count;
+	int i, child, status, count;
 
 	for (i = 0; i < nchild; i++) {
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
 
-		if (fd < 0) {
-			tst_resm(TBROK, "\tError %d creating %s/%s.", errno, fuss, test_name);
-			tst_exit();
-		}
+		if (fd < 0)
+			tst_brkm(TBROK | TERRNO, cleanup, "Can't create %s.", test_name);
 
 		if ((child = fork()) == 0) {
 			dotest(nchild, i, fd);
@@ -221,28 +206,6 @@ static void runtest(void)
 		local_flag = FAILED;
 	}
 
-	chdir(homedir);
-	pid = fork();
-
-	if (pid < 0) {
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-                                 " etc are likely to fail.");
-                tst_resm(TBROK, "Test broken due to inability of fork.");
-		sync();
-                tst_exit();
-	}
-
-	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-		tst_exit();
-	}
-
-	wait(&status);
-
-	if (status) {
-		tst_resm(TINFO,"CAUTION - ftest05, '%s' may not be removed", fuss);
-	}
-
 	sync();
 }
 
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index 8cda511..7429874 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -86,6 +86,7 @@ int TST_TOTAL = 1;
 #define	MAXIOVCNT	16
 
 static void setup(void);
+static void cleanup(void);
 static void runtest(void);
 static void dotest(int, int, int);
 static void domisc(int, int, char*);
@@ -102,9 +103,6 @@ static int parent_pid;
 static int pidlist[MAXCHILD];
 static char test_name[2];     /* childs test directory name */
 
-static char fuss[40];         /* directory to do this in */
-static char homedir[200];     /* where we started */
-
 static int local_flag;
 
 int main(int ac, char *av[])
@@ -141,60 +139,45 @@ int main(int ac, char *av[])
 	return 0;
 }
 
-static void setup(void)
+static void cleanup(void)
 {
-	char wdbuf[MAXPATHLEN], *cwd;
+	tst_rmdir();
+	tst_exit();
+}
 
+static void setup(void)
+{
 	/*
 	 * Make a directory to do this in; ignore error if already exists.
 	 * Save starting directory.
 	 */
-	if ((cwd = getcwd(homedir, sizeof (homedir))) == NULL ) {
-		tst_resm(TBROK,"Failed to get corrent directory") ;
-		tst_exit();
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
-
+	
 	/*
 	 * Default values for run conditions.
 	 */
-
 	iterations = 10;
 	nchild = 5;
 	csize = K_2;		/* should run with 1, 2, and 4 K sizes */
 	max_size = K_1 * K_1;
 	misc_intvl = 10;
 
-	if (sigset(SIGTERM, term) == SIG_ERR) {
-		tst_resm(TBROK, " sigset failed: signo = 15") ;
-		tst_exit() ;
-	}
-
+	if (sigset(SIGTERM, term) == SIG_ERR)
+		tst_brkm(TBROK, cleanup, "Sigset failed: signo = 15");
 }
 
 static void runtest(void)
 {
-	int pid, child, status, count, i;
+	int child, status, count, i;
 
 	for (i = 0; i < nchild; i++) {
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
 		fd = open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
-		if (fd < 0) {
-			tst_resm(TBROK, "\tError %d creating %s/%s.", errno, fuss, test_name);
-			tst_exit();
-		}
+		
+		if (fd < 0)
+			tst_brkm(TBROK | TERRNO, cleanup, "Can't create %s.", test_name);
 
 		if ((child = fork()) == 0) {
 			dotest(nchild, i, fd);
@@ -241,25 +224,6 @@ static void runtest(void)
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
 	sync();
 }
 

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--cWoXeonUoKmBZSoM--

