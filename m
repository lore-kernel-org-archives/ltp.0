From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:24 +0100
Subject: [LTP] [COMMITTED] [PATCH 02/23] syscalls/mkdir09: Small cleanup
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of UCLINUX ifdefs

* Remove useless comments

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/mkdir/mkdir09.c | 184 ++++++------------------------
 1 file changed, 32 insertions(+), 152 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/mkdir09.c b/testcases/kernel/syscalls/mkdir/mkdir09.c
index de1cb69..88034d2 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir09.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir09.c
@@ -21,11 +21,7 @@
 /* 10/30/2002	Port to LTP	dbarrera@us.ibm.com */
 
 /*
- * NAME
- *	mkdir.c - Stress test of mkdir call.
- *
- * CALLS
- *	mkdir, rmdir
+ * Stress test of mkdir call.
  *
  * ALGORITHM
  *	Create multiple processes which create subdirectories in the
@@ -37,12 +33,10 @@
  *              -t = number of seconds to run test
  *              -d = number of directories created in test directory
  *
- * RESTRICTIONS
- *
  */
 
-#include <stdio.h>		/* needed by testhead.h         */
-#include <sys/wait.h>		/* needed by testhead.h         */
+#include <stdio.h>
+#include <sys/wait.h>
 #include <sys/types.h>
 #include <sys/param.h>
 #include <sys/stat.h>
@@ -62,16 +56,9 @@
 #define MODE_RWX	07770
 #define DIR_NAME	"./X.%d"
 
-/* used by getopt */
-extern char *optarg;
-extern int optind, opterr;
-char *goodopts = "c:t:d:";
-int errflg;
-
 char *TCID = "mkdir09";
 int TST_TOTAL = 1;
 
-int child_groups, test_time, nfiles;
 char testdir[MAXPATHLEN];
 int parent_pid, sigchld, sigterm, jump;
 void term(int sig);
@@ -88,88 +75,60 @@ int runtest(void);
 void setup(void);
 void cleanup(void);
 
-#ifdef UCLINUX
-static char *argv0;
-void dochild1_uclinux(void);
-void dochild2_uclinux(void);
-void dochild3_uclinux(void);
-static int group_uclinux;
-#endif
-
-/*--------------------------------------------------------------*/
-/*--------------------------------------------------------------*/
-/*--------------------------------------------------------------*/
+static int child_groups = 2;
+static int test_time = 5;
+static int nfiles = 5;
+
+static char *opt_child_groups;
+static char *opt_test_time;
+static char *opt_nfiles;
+
+static option_t options[] = {
+	{"c:", NULL, &opt_child_groups},
+	{"t:", NULL, &opt_test_time},
+	{"d:", NULL, &opt_nfiles},
+	{NULL, NULL, NULL}
+};
+
+static void usage(void)
+{
+	printf("  -c      Child groups\n");
+	printf("  -t      Test runtime\n");
+	printf("  -d      Directories\n");
+}
+
 int main(int argc, char *argv[])
 {
-	int c;
+	tst_parse_opts(argc, argv, options, usage);
 
-#ifdef UCLINUX
+	if (opt_child_groups)
+		child_groups = atoi(opt_child_groups);
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	if (opt_test_time)
+		test_time = atoi(opt_test_time);
 
-	argv0 = argv[0];
-	maybe_run_child(&dochild1_uclinux, "nd", 1, &nfiles);
-	maybe_run_child(&dochild2_uclinux, "n", 2);
-	maybe_run_child(&dochild3_uclinux, "nd", 3, &group_uclinux);
-#endif
+	if (opt_nfiles)
+		nfiles = atoi(opt_nfiles);
 
 	setup();
 
-	/* Set up to catch SIGTERM signal */
 	if (signal(SIGTERM, term) == SIG_ERR) {
 		tst_brkm(TFAIL, cleanup,
 			 "Error setting up SIGTERM signal, ERRNO = %d", errno);
 
 	}
 
-	/* Set up to catch SIGCHLD signal */
 	if (signal(SIGCHLD, chld) == SIG_ERR) {
 		tst_brkm(TFAIL, cleanup,
 			 "Error setting up SIGCHLD signal, ERRNO = %d", errno);
 
 	}
 
-	/* Default argument settings. */
-
-	child_groups = 2;
-	test_time = 5;		/* 0 = run forever or till signal */
-	nfiles = 5;
-
-	/* Get command line options */
-
-	while ((c = getopt(argc, argv, goodopts)) != EOF) {
-		switch (c) {
-		case 'c':
-			child_groups = atoi(optarg);
-			break;
-		case 't':
-			test_time = atoi(optarg);
-			break;
-		case 'd':
-			nfiles = atoi(optarg);
-			break;
-		case '?':
-			errflg++;
-			break;
-		default:
-			break;
-		}
-	}
-	if (errflg) {
-		tst_resm(TINFO,
-			 "USAGE : mkdir09 -c #child_groups -t#test_time -d#directories");
-		tst_resm(TINFO, "Bad argument count.");
-
-	}
-
 	runtest();
 	cleanup();
 	tst_exit();
-
 }
 
-/*--------------------------------------------------------------*/
-
 int runtest(void)
 {
 	int i, j;
@@ -316,34 +275,13 @@ int getchild(int group, int child, int children)
 	} else if (pid == 0) {	/* child does this */
 		switch (children % NCHILD) {
 		case 0:
-#ifdef UCLINUX
-			if (self_exec(argv0, "nd", 1, nfiles) < 0) {
-				massmurder();
-				tst_brkm(TBROK, cleanup, "\tself_exec failed");
-			}
-#else
 			dochild1();	/* create existing directories */
-#endif
 			break;	/* so lint won't complain */
 		case 1:
-#ifdef UCLINUX
-			if (self_exec(argv0, "n", 2) < 0) {
-				massmurder();
-				tst_brkm(TBROK, cleanup, "\tself_exec failed");
-			}
-#else
 			dochild2();	/* remove nonexistant directories */
-#endif
 			break;
 		case 2:
-#ifdef UCLINUX
-			if (self_exec(argv0, "nd", 3, group) < 0) {
-				massmurder();
-				tst_brkm(TBROK, cleanup, "\tself_exec failed");
-			}
-#else
 			dochild3(group);	/* create/delete directories */
-#endif
 			break;
 		default:
 			tst_brkm(TFAIL, cleanup,
@@ -415,19 +353,6 @@ int dochild1(void)
 	exit(0);
 }
 
-#ifdef UCLINUX
-void dochild1_uclinux(void)
-{
-	/* Set up to catch SIGTERM signal */
-	if (signal(SIGTERM, term) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup,
-			 "Error setting up SIGTERM signal, ERRNO = %d", errno);
-	}
-
-	dochild1();
-}
-#endif
-
 int dochild2(void)
 {
 	/* Child routine which attempts to remove directories from the
@@ -462,19 +387,6 @@ int dochild2(void)
 	return 0;
 }
 
-#ifdef UCLINUX
-void dochild2_uclinux(void)
-{
-	/* Set up to catch SIGTERM signal */
-	if (signal(SIGTERM, term) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup,
-			 "Error setting up SIGTERM signal, ERRNO = %d", errno);
-	}
-
-	dochild2();
-}
-#endif
-
 int dochild3(int group)
 {
 	/* Child routine which creates and deletes directories in the
@@ -518,19 +430,6 @@ int dochild3(int group)
 	exit(0);
 }
 
-#ifdef UCLINUX
-void dochild3_uclinux(void)
-{
-	/* Set up to catch SIGTERM signal */
-	if (signal(SIGTERM, term) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup,
-			 "Error setting up SIGTERM signal, ERRNO = %d", errno);
-	}
-
-	dochild3(group_uclinux);
-}
-#endif
-
 int massmurder(void)
 {
 	register int j;
@@ -546,35 +445,16 @@ int massmurder(void)
 	return 0;
 }
 
-/***************************************************************
- *  * setup() - performs all ONE TIME setup for this test.
- *   ***************************************************************/
 void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* Create a temporary directory and make it current. */
 	tst_tmpdir();
-
 }
 
-/***************************************************************
- *  * cleanup() - performs all ONE TIME cleanup for this test at
- *   *              completion or premature exit.
- *    ***************************************************************/
 void cleanup(void)
 {
-
-	/*
-	 *      * Remove the temporary directory.
-	 *           */
 	tst_rmdir();
-
-	/*
-	 *      * Exit with return code appropriate for results.
-	 *           */
-
 }
-- 
2.10.2

