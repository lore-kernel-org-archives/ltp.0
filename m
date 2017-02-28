From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:38 +0100
Subject: [LTP] [COMMITTED] [PATCH 16/23] syscalls/ipc/msgctl*: Cleanups
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-16-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of useless comments

* Get rid of UCLINUX ifdefs

* Unify options, make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c |  49 ++------
 testcases/kernel/syscalls/ipc/msgctl/msgctl07.c |  22 +---
 testcases/kernel/syscalls/ipc/msgctl/msgctl08.c | 113 +++++-------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl09.c | 152 +++++++-----------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl10.c | 115 ++++++------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c | 145 +++++++---------------
 6 files changed, 164 insertions(+), 432 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index 2710980..297b593 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -35,10 +35,10 @@
  *
  */
 
-#include <sys/types.h>		/* needed for test              */
-#include <sys/ipc.h>		/* needed for test              */
-#include <sys/msg.h>		/* needed for test              */
-#include <stdio.h>		/* needed by testhead.h         */
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <stdio.h>
 #include "test.h"
 #include "ipcmsg.h"
 
@@ -61,11 +61,12 @@ extern int local_flag;
 int msqid, status;
 struct msqid_ds buf;
 
-/*--------------------------------------------------------------*/
-
-int main(void)
+int main(int argc, char *argv[])
 {
 	key_t key;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
 	setup();
 
 	key = getipckey();
@@ -110,55 +111,26 @@ int main(void)
 	}
 
 	tst_resm(TPASS, "msgctl06 ran successfully!");
-    /***************************************************************
-     * cleanup and exit
-     ***************************************************************/
-	cleanup();
 
+	cleanup();
 	tst_exit();
 }
 
-/***************************************************************
- *  * setup() - performs all ONE TIME setup for this test.
- *   ****************************************************************/
 void setup(void)
 {
 	tst_require_root();
 
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
-	 */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
-	 * fork the test with the -c option.  You want to make sure you do this
-	 * before you create your temporary directory.
-	 */
 	TEST_PAUSE;
 
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
 	tst_tmpdir();
 }
 
-/***************************************************************
- *  *  * cleanup() - performs all ONE TIME cleanup for this test at
- *   *   *              completion or premature exit.
- *    *    ***************************************************************/
 void cleanup(void)
 {
 	int status;
 
-	/*
-	 * Remove the message queue from the system
-	 */
-#ifdef DEBUG
-	tst_resm(TINFO, "Remove the message queue");
-#endif
-	fflush(stdout);
 	(void)msgctl(msqid, IPC_RMID, NULL);
 	if ((status = msgctl(msqid, IPC_STAT, &buf)) != -1) {
 		(void)msgctl(msqid, IPC_RMID, NULL);
@@ -166,8 +138,5 @@ void cleanup(void)
 
 	}
 
-	fflush(stdout);
-
 	tst_rmdir();
-
 }
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
index 9be3cd4..b978692 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
@@ -68,22 +68,15 @@ struct my_msgbuf {
 	char text[BYTES];
 } p1_msgp, p2_msgp, p3_msgp, c1_msgp, c2_msgp, c3_msgp;
 
-int main(void)
+int main(int argc, char *argv[])
 {
 	key_t key;
 	int pid, status;
 	int i, j, k;
 	sighandler_t alrm();
 
-#ifdef UCLINUX
-
 	tst_parse_opts(argc, argv, NULL, NULL);
 
-	maybe_run_child(&do_child_1, "ndd", 1, &msqid, &c1_msgp.type);
-	maybe_run_child(&do_child_2, "ndddd", 2, &msqid, &c1_msgp.type,
-			&c2_msgp.type, &c3_msgp.type);
-#endif
-
 	setup();
 
 	key = getipckey();
@@ -98,13 +91,7 @@ int main(void)
 		tst_brkm(TFAIL, NULL,
 			 "\tFork failed (may be OK if under stress)");
 	} else if (pid == 0) {
-#ifdef UCLINUX
-		if (self_exec(argv[0], "ndd", 1, msqid, c1_msgp.type) < 0) {
-			tst_brkm(TFAIL, NULL, "\tself_exec failed");
-		}
-#else
 		do_child_1();
-#endif
 	} else {
 		struct sigaction act;
 
@@ -144,14 +131,7 @@ int main(void)
 		tst_brkm(TFAIL, NULL,
 			 "\tFork failed (may be OK if under stress)");
 	} else if (pid == 0) {
-#ifdef UCLINUX
-		if (self_exec(argv[0], "ndddd", 1, msqid, c1_msgp.type,
-			      c2_msgp.type, c3_msgp.type) < 0) {
-			tst_brkm(TFAIL, NULL, "\tself_exec failed");
-		}
-#else
 		do_child_2();
-#endif
 	} else {
 		struct sigaction act;
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
index eca50c5..7bcec50 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
@@ -64,16 +64,20 @@ void cleanup(void);
 static int dotest(key_t key, int child_process);
 static void sig_handler();
 
-#ifdef UCLINUX
-static char *argv0;
-static key_t key_uclinux;
-static int i_uclinux;
-static int id_uclinux;
-static int child_process_uclinux;
-
-static void do_child_1_uclinux(void);
-static void do_child_2_uclinux(void);
-#endif
+static char *opt_nprocs;
+static char *opt_nreps;
+
+static option_t options[] = {
+	{"n:", NULL, &opt_nprocs},
+	{"l:", NULL, &opt_nreps},
+	{NULL, NULL, NULL},
+};
+
+static void usage(void)
+{
+	printf("  -n      Number of processes\n");
+	printf("  -l      Number of iterations\n");
+}
 
 int main(int argc, char **argv)
 {
@@ -81,46 +85,31 @@ int main(int argc, char **argv)
 	int count, status;
 	struct sigaction act;
 
-#ifdef UCLINUX
-
-	argv0 = argv[0];
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	maybe_run_child(&do_child_1_uclinux, "ndd", 1, &key_uclinux,
-			&i_uclinux);
-	maybe_run_child(&do_child_2_uclinux, "nddd", 2, &id_uclinux,
-			&key_uclinux, &child_process_uclinux);
-#endif
+	tst_parse_opts(argc, argv, options, usage);
 
 	setup();
 
-	if (argc == 1) {
-		/* Set default parameters */
-		nreps = MAXNREPS;
-		nprocs = MSGMNI;
-	} else if (argc == 3) {
-		if (atoi(argv[1]) > MAXNREPS) {
-			tst_resm(TCONF,
-				 "Requested number of iterations too large, setting to Max. of %d",
-				 MAXNREPS);
+	nreps = MAXNREPS;
+	nprocs = MSGMNI;
+
+	if (opt_nreps) {
+		nreps = atoi(opt_nreps);
+		if (nreps > MAXNREPS) {
+			tst_resm(TINFO,
+				 "Requested number of iterations too large, "
+				 "setting to Max. of %d", MAXNREPS);
 			nreps = MAXNREPS;
-		} else {
-			nreps = atoi(argv[1]);
 		}
-		if (atoi(argv[2]) > MSGMNI) {
-			tst_resm(TCONF,
-				 "Requested number of processes too large, setting to Max. of %d",
-				 MSGMNI);
+	}
+
+	if (opt_nprocs) {
+		nprocs = atoi(opt_nprocs);
+		if (nprocs > MSGMNI) {
+			tst_resm(TINFO,
+				 "Requested number of processes too large, "
+				 "setting to Max. of %d", MSGMNI);
 			nprocs = MSGMNI;
-		} else {
-			nprocs = atoi(argv[2]);
 		}
-	} else {
-		tst_brkm(TCONF,
-			 NULL,
-			 " Usage: %s [ number of iterations  number of processes ]",
-			 argv[0]);
 	}
 
 	srand(getpid());
@@ -172,14 +161,8 @@ int main(int argc, char **argv)
 		}
 		/* Child does this */
 		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv[0], "ndd", 1, keyarray[i], i) < 0) {
-				tst_brkm(TFAIL, NULL, "\tself_exec failed");
-			}
-#else
 			procstat = 1;
 			exit(dotest(keyarray[i], i));
-#endif
 		}
 		pidarray[i] = pid;
 	}
@@ -216,20 +199,6 @@ int main(int argc, char **argv)
 	tst_exit();
 }
 
-#ifdef UCLINUX
-static void do_child_1_uclinux(void)
-{
-	procstat = 1;
-	exit(dotest(key_uclinux, i_uclinux));
-}
-
-static void do_child_2_uclinux(void)
-{
-	exit(doreader(key_uclinux, id_uclinux, 1,
-			child_process_uclinux, nreps));
-}
-#endif
-
 static int dotest(key_t key, int child_process)
 {
 	int id, pid;
@@ -257,21 +226,8 @@ static int dotest(key_t key, int child_process)
 		return FAIL;
 	}
 	/* Child does this */
-	if (pid == 0) {
-#ifdef UCLINUX
-		if (self_exec(argv0, "nddd", 2, id, key, child_process) < 0) {
-			printf("self_exec failed\n");
-			TEST(msgctl(tid, IPC_RMID, 0));
-			if (TEST_RETURN < 0) {
-				printf("msgctl() error in cleanup: %s\n",
-					strerror(errno));
-			}
-			return FAIL;
-		}
-#else
+	if (pid == 0)
 		exit(doreader(key, id, 1, child_process, nreps));
-#endif
-	}
 	/* Parent does this */
 	mykid = pid;
 	procstat = 2;
@@ -334,7 +290,6 @@ void cleanup(void)
 #ifdef DEBUG
 	tst_resm(TINFO, "Removing the message queue");
 #endif
-	fflush(stdout);
 	(void)msgctl(tid, IPC_RMID, NULL);
 	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
 		(void)msgctl(tid, IPC_RMID, NULL);
@@ -342,7 +297,5 @@ void cleanup(void)
 
 	}
 
-	fflush(stdout);
-
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
index 0291132..3d6a6e1 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
@@ -65,76 +65,65 @@ static void term(int);
 static int dotest(key_t, int);
 static void cleanup_msgqueue(int i, int tid);
 
-#ifdef UCLINUX
-static char *argv0;
-static key_t key_uclinux;
-static int i_uclinux;
-static int pid_uclinux;
-static int child_process_uclinux;
-static int rkid_uclinux;
-
-
-static void do_child_1_uclinux(void);
-static void do_child_2_uclinux(void);
-static void do_child_3_uclinux(void);
-#endif
+static char *opt_nprocs;
+static char *opt_nkids;
+static char *opt_nreps;
+
+static option_t options[] = {
+	{"n:", NULL, &opt_nprocs},
+	{"c:", NULL, &opt_nkids},
+	{"l:", NULL, &opt_nreps},
+	{NULL, NULL, NULL},
+};
+
+static void usage(void)
+{
+	printf("  -n      Number of processes\n");
+	printf("  -c      Number of read/write child pairs\n");
+	printf("  -l      Number of iterations\n");
+}
 
 int main(int argc, char **argv)
 {
 	int i, j, ok, pid;
 	int count, status;
 
-#ifdef UCLINUX
-
-	argv0 = argv[0];
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	maybe_run_child(&do_child_1_uclinux, "ndd", 1, &key_uclinux,
-			&i_uclinux);
-	maybe_run_child(&do_child_2_uclinux, "nddd", 2, &key_uclinux,
-			&pid_uclinux, &child_process_uclinux);
-	maybe_run_child(&do_child_3_uclinux, "nddd", 3, &key_uclinux,
-			&rkid_uclinux, &child_process_uclinux);
-#endif
+	tst_parse_opts(argc, argv, options, usage);
 
 	setup();
 
-	if (argc == 1) {
-		/* Set default parameters */
-		nreps = MAXNREPS;
-		nprocs = MSGMNI;
-		nkids = MAXNKIDS;
-	} else if (argc == 4) {
-		if (atoi(argv[1]) > MAXNREPS) {
-			tst_resm(TCONF,
-				 "Requested number of iterations too large, setting to Max. of %d",
-				 MAXNREPS);
+	nreps = MAXNREPS;
+	nprocs = MSGMNI;
+	nkids = MAXNKIDS;
+
+	if (opt_nreps) {
+		nreps = atoi(opt_nreps);
+		if (nreps > MAXNREPS) {
+			tst_resm(TINFO,
+				 "Requested number of iterations too large, "
+				 "setting to Max. of %d", MAXNREPS);
 			nreps = MAXNREPS;
-		} else {
-			nreps = atoi(argv[1]);
 		}
-		if (atoi(argv[2]) > MSGMNI) {
-			tst_resm(TCONF,
-				 "Requested number of processes too large, setting to Max. of %d",
-				 MSGMNI);
+	}
+
+	if (opt_nprocs) {
+		nprocs = atoi(opt_nprocs);
+		if (nprocs > MSGMNI) {
+			tst_resm(TINFO,
+				 "Requested number of processes too large, "
+				 "setting to Max. of %d", MSGMNI);
 			nprocs = MSGMNI;
-		} else {
-			nprocs = atoi(argv[2]);
 		}
-		if (atoi(argv[3]) > MAXNKIDS) {
-			tst_resm(TCONF,
-				 "Requested number of read/write pairs too large; setting to Max. of %d",
-				 MAXNKIDS);
+	}
+
+	if (opt_nkids) {
+		nkids = atoi(opt_nkids);
+		if (nkids > MAXNKIDS) {
+			tst_resm(TINFO,
+				 "Requested number of read/write pairs too "
+				 "large, setting to Max. of %d", MAXNKIDS);
 			nkids = MAXNKIDS;
-		} else {
-			nkids = atoi(argv[3]);
 		}
-	} else {
-		tst_brkm(TCONF,
-			 NULL,
-			 " Usage: %s [ number of iterations  number of processes number of read/write pairs ]",
-			 argv[0]);
 	}
 
 	procstat = 0;
@@ -182,14 +171,8 @@ int main(int argc, char **argv)
 		}
 		/* Child does this */
 		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv[0], "ndd", 1, keyarray[i], i) < 0) {
-				tst_brkm(TFAIL, NULL, "\tself_exec failed");
-			}
-#else
 			procstat = 1;
 			exit(dotest(keyarray[i], i));
-#endif
 		}
 		pidarray[i] = pid;
 	}
@@ -226,28 +209,6 @@ int main(int argc, char **argv)
 	tst_exit();
 }
 
-#ifdef UCLINUX
-static void do_child_1_uclinux(void)
-{
-	procstat = 1;
-	exit(dotest(key_uclinux, i_uclinux));
-}
-
-static void do_child_2_uclinux(void)
-{
-	procstat = 2;
-	exit(doreader(key_uclinux, tid, pid_uclinux,
-			child_process_uclinux, nreps));
-}
-
-static void do_child_3_uclinux(void)
-{
-	procstat = 2;
-	exit(dowriter(key_uclinux, tid, rkid_uclinux,
-			child_process_uclinux, nreps));
-}
-#endif
-
 static void cleanup_msgqueue(int i, int tid)
 {
 	/*
@@ -296,18 +257,9 @@ static int dotest(key_t key, int child_process)
 		}
 		/* First child does this */
 		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv0, "nddd", 2, key, getpid(),
-				      child_process) < 0) {
-				printf("self_exec failed\n");
-				cleanup_msgqueue(i, tid);
-				return FAIL;
-			}
-#else
 			procstat = 2;
 			exit(doreader(key, tid, getpid(),
 					child_process, nreps));
-#endif
 		}
 		rkidarray[i] = pid;
 		fflush(stdout);
@@ -324,24 +276,9 @@ static int dotest(key_t key, int child_process)
 		}
 		/* Second child does this */
 		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv0, "nddd", 3, key, rkidarray[i],
-				      child_process) < 0) {
-				printf("\tFork failure in the first child of child group %d\n",
-					child_process);
-				/*
-				 * Kill the reader child process
-				 */
-				(void)kill(rkidarray[i], SIGKILL);
-
-				cleanup_msgqueue(i, tid);
-				return FAIL;
-			}
-#else
 			procstat = 2;
 			exit(dowriter(key, tid, rkidarray[i],
 					child_process, nreps));
-#endif
 		}
 		wkidarray[i] = pid;
 	}
@@ -386,7 +323,6 @@ static int dotest(key_t key, int child_process)
 	return exit_status;
 }
 
-/* ARGSUSED */
 static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	int i;
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
index 5cf695a..f0f873f 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
@@ -61,16 +61,20 @@ void cleanup(void);
 static int dotest(key_t key, int child_process);
 static void sig_handler(int signo);
 
-#ifdef UCLINUX
-static char *argv0;
-static key_t key_uclinux;
-static int i_uclinux;
-static int id_uclinux;
-static int child_process_uclinux;
-
-static void do_child_1_uclinux(void);
-static void do_child_2_uclinux(void);
-#endif
+static char *opt_nprocs;
+static char *opt_nreps;
+
+static option_t options[] = {
+	{"n:", NULL, &opt_nprocs},
+	{"l:", NULL, &opt_nreps},
+	{NULL, NULL, NULL},
+};
+
+static void usage(void)
+{
+	printf("  -n      Number of processes\n");
+	printf("  -l      Number of iterations\n");
+}
 
 int main(int argc, char **argv)
 {
@@ -78,46 +82,31 @@ int main(int argc, char **argv)
 	int count, status;
 	struct sigaction act;
 
-#ifdef UCLINUX
-
-	argv0 = argv[0];
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	maybe_run_child(&do_child_1_uclinux, "ndd", 1, &key_uclinux,
-			&i_uclinux);
-	maybe_run_child(&do_child_2_uclinux, "nddd", 2, &id_uclinux,
-			&key_uclinux, &child_process_uclinux);
-#endif
+	tst_parse_opts(argc, argv, options, usage);
 
 	setup();
 
-	if (argc == 1) {
-		/* Set default parameters */
-		nreps = MAXNREPS;
-		nprocs = MSGMNI;
-	} else if (argc == 3) {
-		if (atoi(argv[1]) > MAXNREPS) {
-			tst_resm(TCONF,
-				 "Requested number of iterations too large, setting to Max. of %d",
-				 MAXNREPS);
+	nreps = MAXNREPS;
+	nprocs = MSGMNI;
+
+	if (opt_nreps) {
+		nreps = atoi(opt_nreps);
+		if (nreps > MAXNREPS) {
+			tst_resm(TINFO,
+				 "Requested number of iterations too large, "
+				 "setting to Max. of %d", MAXNREPS);
 			nreps = MAXNREPS;
-		} else {
-			nreps = atoi(argv[1]);
 		}
-		if (atoi(argv[2]) > MSGMNI) {
-			tst_resm(TCONF,
-				 "Requested number of processes too large, setting to Max. of %d",
-				 MSGMNI);
+	}
+
+	if (opt_nprocs) {
+		nprocs = atoi(opt_nprocs);
+		if (nprocs > MSGMNI) {
+			tst_resm(TINFO,
+				 "Requested number of processes too large, "
+				 "setting to Max. of %d", MSGMNI);
 			nprocs = MSGMNI;
-		} else {
-			nprocs = atoi(argv[2]);
 		}
-	} else {
-		tst_brkm(TCONF,
-			 NULL,
-			 " Usage: %s [ number of iterations  number of processes ]",
-			 argv[0]);
 	}
 
 	srand(getpid());
@@ -169,13 +158,8 @@ int main(int argc, char **argv)
 		}
 		/* Child does this */
 		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv[0], "ndd", 1, keyarray[i], i) < 0)
-				tst_brkm(TFAIL, NULL, "\tself_exec failed");
-#else
 			procstat = 1;
 			exit(dotest(keyarray[i], i));
-#endif
 		}
 		pidarray[i] = pid;
 	}
@@ -212,20 +196,6 @@ int main(int argc, char **argv)
 	tst_exit();
 }
 
-#ifdef UCLINUX
-static void do_child_1_uclinux(void)
-{
-	procstat = 1;
-	exit(dotest(key_uclinux, i_uclinux));
-}
-
-static void do_child_2_uclinux(void)
-{
-	exit(doreader(key_uclinux, id_uclinux, 1,
-			child_process_uclinux, nreps));
-}
-#endif
-
 static int dotest(key_t key, int child_process)
 {
 	int id, pid;
@@ -251,23 +221,9 @@ static int dotest(key_t key, int child_process)
 		}
 		return FAIL;
 	}
-	/* Child does this */
-	if (pid == 0) {
-#ifdef UCLINUX
-		if (self_exec(argv0, "nddd", 2, id, key, child_process) < 0) {
-			printf("self_exec failed\n");
-			TEST(msgctl(tid, IPC_RMID, 0));
-			if (TEST_RETURN < 0) {
-				printf("msgctl() error in cleanup: %s\n",
-					strerror(TEST_ERRNO));
-			}
-			return FAIL;
-		}
-#else
+	if (pid == 0)
 		exit(doreader(key, id, 1, child_process, nreps));
-#endif
-	}
-	/* Parent does this */
+
 	mykid = pid;
 	procstat = 2;
 	ret = dowriter(key, id, 1, child_process, nreps);
@@ -323,7 +279,6 @@ void cleanup(void)
 #ifdef DEBUG
 	tst_resm(TINFO, "Removing the message queue");
 #endif
-	fflush(stdout);
 	(void)msgctl(tid, IPC_RMID, NULL);
 	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
 		(void)msgctl(tid, IPC_RMID, NULL);
@@ -331,7 +286,5 @@ void cleanup(void)
 
 	}
 
-	fflush(stdout);
-
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index aa59c00..89099a7 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -70,71 +70,65 @@ static int dotest(key_t, int);
 static void dotest_iteration(int off);
 static void cleanup_msgqueue(int i, int tid);
 
-#ifdef UCLINUX
-static char *argv0;
-static key_t key_uclinux;
-static int i_uclinux;
-static int pid_uclinux;
-static int child_process_uclinux;
-static int rkid_uclinux;
-
-static void do_child_1_uclinux(void);
-static void do_child_2_uclinux(void);
-static void do_child_3_uclinux(void);
-#endif
+static char *opt_maxnprocs;
+static char *opt_nkids;
+static char *opt_nreps;
+
+static option_t options[] = {
+	{"n:", NULL, &opt_maxnprocs},
+	{"c:", NULL, &opt_nkids},
+	{"l:", NULL, &opt_nreps},
+	{NULL, NULL, NULL},
+};
+
+static void usage(void)
+{
+	printf("  -n      Number of processes\n");
+	printf("  -c      Number of read/write child pairs\n");
+	printf("  -l      Number of iterations\n");
+}
+
 
 int main(int argc, char **argv)
 {
 	int i, j, ok;
 
-#ifdef UCLINUX
-
-	argv0 = argv[0];
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	maybe_run_child(&do_child_1_uclinux, "ndd", 1, &key_uclinux,
-			&i_uclinux);
-	maybe_run_child(&do_child_2_uclinux, "nddd", 2, &key_uclinux,
-			&pid_uclinux, &child_process_uclinux);
-	maybe_run_child(&do_child_3_uclinux, "nddd", 3, &key_uclinux,
-			&rkid_uclinux, &child_process_uclinux);
-#endif
+	tst_parse_opts(argc, argv, options, usage);
 
 	setup();
 
-	if (argc == 1) {
-		/* Set default parameters */
-		nreps = MAXNREPS;
-		nkids = DEFNKIDS;
-	} else if (argc == 4) {
-		if (atoi(argv[1]) > MAXNREPS) {
+	nreps = MAXNREPS;
+	nkids = MAXNKIDS;
+
+	if (opt_nreps) {
+		nreps = atoi(opt_nreps);
+		if (nreps > MAXNREPS) {
 			tst_resm(TINFO,
-				 "Requested number of iterations too large, setting to Max. of %d",
-				 MAXNREPS);
+				 "Requested number of iterations too large, "
+				 "setting to Max. of %d", MAXNREPS);
 			nreps = MAXNREPS;
-		} else {
-			nreps = atoi(argv[1]);
 		}
-		if (atoi(argv[2]) > maxnprocs) {
+	}
+
+	if (opt_nkids) {
+		nkids = atoi(opt_nkids);
+		if (nkids > MAXNKIDS) {
 			tst_resm(TINFO,
-				 "Requested number of processes too large, setting to Max. of %d",
-				 maxnprocs);
-		} else {
-			maxnprocs = atoi(argv[2]);
+				 "Requested number of read/write pairs too "
+				 "large, setting to Max. of %d", MAXNKIDS);
+			nkids = MAXNKIDS;
 		}
-		if (atoi(argv[3]) > maxnkids) {
+	}
+
+
+	if (opt_maxnprocs) {
+		if (atoi(opt_maxnprocs) > maxnprocs) {
 			tst_resm(TINFO,
-				 "Requested number of read/write pairs too large; setting to Max. of %d",
-				 maxnkids);
-			nkids = maxnkids;
+				 "Requested number of processes too large, "
+				 "setting to Max. of %d", MSGMNI);
 		} else {
-			nkids = atoi(argv[3]);
+			maxnprocs = atoi(opt_maxnprocs);
 		}
-	} else {
-		tst_brkm(TCONF, cleanup,
-			 " Usage: %s [ number of iterations  number of processes number of read/write pairs ]",
-			 argv[0]);
 	}
 
 	procstat = 0;
@@ -212,15 +206,8 @@ static void dotest_iteration(int off)
 
 		/* Child does this */
 		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv0, "ndd", 1, key, i) < 0) {
-				printf("\tself_exec failed\n");
-				exit(FAIL);
-			}
-#else
 			procstat = 1;
 			exit(dotest(key, i));
-#endif
 		}
 		pidarray[i] = pid;
 	}
@@ -248,28 +235,6 @@ static void dotest_iteration(int off)
 			 count, nprocs);
 }
 
-#ifdef UCLINUX
-static void do_child_1_uclinux(void)
-{
-	procstat = 1;
-	exit(dotest(key_uclinux, i_uclinux));
-}
-
-static void do_child_2_uclinux(void)
-{
-	procstat = 2;
-	exit(doreader(key_uclinux, tid, pid_uclinux,
-			child_process_uclinux, nreps));
-}
-
-static void do_child_3_uclinux(void)
-{
-	procstat = 2;
-	exit(dowriter(key_uclinux, tid, rkid_uclinux,
-			child_process_uclinux, nreps));
-}
-#endif
-
 static void cleanup_msgqueue(int i, int tid)
 {
 	/*
@@ -318,18 +283,9 @@ static int dotest(key_t key, int child_process)
 		}
 		/* First child does this */
 		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv0, "nddd", 2, key, getpid(),
-				      child_process) < 0) {
-				printf("self_exec failed\n");
-				cleanup_msgqueue(i, tid);
-				return FAIL;
-			}
-#else
 			procstat = 2;
 			exit(doreader(key, tid, getpid(),
 					child_process, nreps));
-#endif
 		}
 		rkidarray[i] = pid;
 		if ((pid = FORK_OR_VFORK()) < 0) {
@@ -345,24 +301,9 @@ static int dotest(key_t key, int child_process)
 		}
 		/* Second child does this */
 		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv0, "nddd", 3, key, rkidarray[i],
-				      child_process) < 0) {
-				printf("\tFork failure in the first child of child group %d\n",
-					child_process);
-				/*
-				 * Kill the reader child process
-				 */
-				(void)kill(rkidarray[i], SIGKILL);
-
-				cleanup_msgqueue(i, tid);
-				return FAIL;
-			}
-#else
 			procstat = 2;
 			exit(dowriter(key, tid, rkidarray[i],
 					child_process, nreps));
-#endif
 		}
 		wkidarray[i] = pid;
 	}
-- 
2.10.2

