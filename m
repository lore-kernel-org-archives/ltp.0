From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 12 Mar 2021 20:02:20 +0800
Subject: [LTP] [PATCH v4 4/5] sycalls/msgstress04: Convert into new api
In-Reply-To: <1615550541-21714-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20201111163114.GB23576@yuki.lan>
 <1615550541-21714-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1615550541-21714-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It also missed process num check according to available memory.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/ipc/msgstress/Makefile    |   5 +-
 .../syscalls/ipc/msgstress/msgstress04.c      | 489 +++++-------------
 2 files changed, 142 insertions(+), 352 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/Makefile b/testcases/kernel/syscalls/ipc/msgstress/Makefile
index d80d0bf98..b1201281d 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgstress/Makefile
@@ -3,11 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc ltpnewipc
+LTPLIBS = ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-msgstress01 msgstress02: LTPLDLIBS = -lltpnewipc
-msgstress04: LTPLDLIBS = -lltpipc
+LTPLDLIBS = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index f1c124990..b6536e349 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -1,30 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2002
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
  * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
  * 11/11/2002   Port to LTP     dbarrera@us.ibm.com
+ * 03/12/2021   Convert to new api xuyang2018.jy@cn.fujitsu.com
  */
 
-/*
+/*\
+ * [DESCRIPTION]
+ *
  * Get and manipulate a message queue.
- * Same as msgstress02 but gets the actual msgmni value under procfs.
- */
+ * Fork a number of processes, each of which will create a message queue
+ * with several (nkids) reader/writer pairs which will read and write a
+ * number (iterations) of random length messages with specific values (keys).
+ * We do not fork more than maxnprocs at a time and we fork until all the
+ * message queues get used.
+\*/
 
-#define _XOPEN_SOURCE 500
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/ipc.h>
@@ -36,415 +29,213 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include "test.h"
-#include "ipcmsg.h"
-#include "libmsgctl.h"
-
-char *TCID = "msgstress04";
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "tst_safe_sysv_ipc.h"
 
-#define MAXNREPS	1000
-#ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	 1000000	/* This value is set to an arbitrary high limit. */
-#else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
-#endif
 #define MAXNKIDS	10
-#define DEFNKIDS	2
 
-static int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
-static key_t keyarray[MAXNPROCS];
-static int pidarray[MAXNPROCS];
 static int rkidarray[MAXNKIDS];
 static int wkidarray[MAXNKIDS];
-static int tid;
-static int nprocs, nreps, nkids, MSGMNI;
-static int maxnprocs;
-static int procstat;
-
-void setup(void);
-void cleanup(void);
-
-static void term(int);
-static int dotest(key_t, int);
-static void dotest_iteration(int off);
-static void cleanup_msgqueue(int i, int tid);
-
+static int tid[MAXNPROCS];
+static int maxnprocs = MAXNPROCS;
+static int nreps = 1000;
+static int nkids = MAXNKIDS;
+static int MSGMNI, nprocs;
 static char *opt_maxnprocs;
 static char *opt_nkids;
 static char *opt_nreps;
 
-static option_t options[] = {
-	{"n:", NULL, &opt_maxnprocs},
-	{"c:", NULL, &opt_nkids},
-	{"l:", NULL, &opt_nreps},
-	{NULL, NULL, NULL},
+static struct tst_option options[] = {
+	{"n:", &opt_maxnprocs, "-n N     Number of processes"},
+	{"c:", &opt_nkids, "-c -N    Number of read/write child pairs"},
+	{"l:", &opt_nreps, "-l N     Number of iterations"},
+	{NULL, NULL, NULL}
 };
 
-static void usage(void)
-{
-	printf("  -n      Number of processes\n");
-	printf("  -c      Number of read/write child pairs\n");
-	printf("  -l      Number of iterations\n");
-}
-
-
-int main(int argc, char **argv)
-{
-	int i, j, ok;
-
-	tst_parse_opts(argc, argv, options, usage);
-
-	setup();
-
-	nreps = MAXNREPS;
-	nkids = MAXNKIDS;
-
-	if (opt_nreps) {
-		nreps = atoi(opt_nreps);
-		if (nreps > MAXNREPS) {
-			tst_resm(TINFO,
-				 "Requested number of iterations too large, "
-				 "setting to Max. of %d", MAXNREPS);
-			nreps = MAXNREPS;
-		}
-	}
-
-	if (opt_nkids) {
-		nkids = atoi(opt_nkids);
-		if (nkids > MAXNKIDS) {
-			tst_resm(TINFO,
-				 "Requested number of read/write pairs too "
-				 "large, setting to Max. of %d", MAXNKIDS);
-			nkids = MAXNKIDS;
-		}
-	}
-
-
-	if (opt_maxnprocs) {
-		if (atoi(opt_maxnprocs) > maxnprocs) {
-			tst_resm(TINFO,
-				 "Requested number of processes too large, "
-				 "setting to Max. of %d", MSGMNI);
-		} else {
-			maxnprocs = atoi(opt_maxnprocs);
-		}
-	}
-
-	procstat = 0;
-	srand48((unsigned)getpid() + (unsigned)(getppid() << 16));
-	tid = -1;
-
-	/* Setup signal handling routine */
-	if (sigset(SIGTERM, term) == SIG_ERR)
-		tst_brkm(TFAIL, cleanup, "Sigset SIGTERM failed");
-
-	/* Set up array of unique keys for use in allocating message
-	 * queues
-	 */
-	for (i = 0; i < MSGMNI; i++) {
-		ok = 1;
-		do {
-			/* Get random key */
-			keyarray[i] = (key_t) lrand48();
-			/* Make sure key is unique and not private */
-			if (keyarray[i] == IPC_PRIVATE) {
-				ok = 0;
-				continue;
-			}
-			for (j = 0; j < i; j++) {
-				if (keyarray[j] == keyarray[i]) {
-					ok = 0;
-					break;
-				}
-				ok = 1;
-			}
-		} while (ok == 0);
-	}
-	/* Fork a number of processes, each of which will
-	 * create a message queue with several (nkids) reader/writer
-	 * pairs which will read and write a number (iterations)
-	 * of random length messages with specific values (keys).
-	 *
-	 * We do not fork more than maxnprocs@a time and
-	 * we fork until all the message queues get used.
-	 */
-
-	if (MSGMNI <= maxnprocs) {
-		nprocs = MSGMNI;
-		dotest_iteration(0);
-	} else {
-		for (i = 0; i < (MSGMNI / maxnprocs); i++) {
-			nprocs = maxnprocs;
-			dotest_iteration(i * maxnprocs);
-		}
-
-		nprocs = MSGMNI % maxnprocs;
-		dotest_iteration(i * maxnprocs);
-	}
-
-	tst_resm(TPASS, "Test ran successfully!");
-
-	cleanup();
-	tst_exit();
-}
-
-static void dotest_iteration(int off)
-{
-	key_t key;
-	int i, count, status;
-	pid_t pid;
-
-	memset(pidarray, 0, sizeof(pidarray));
-
-	for (i = 0; i < nprocs; i++) {
-		key = keyarray[off + i];
-
-		if ((pid = FORK_OR_VFORK()) < 0)
-			tst_brkm(TFAIL, cleanup,
-				 "Fork failed (may be OK if under stress)");
-
-		/* Child does this */
-		if (pid == 0) {
-			procstat = 1;
-			exit(dotest(key, i));
-		}
-		pidarray[i] = pid;
-	}
-
-	count = 0;
-	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != PASS)
-				tst_brkm(TFAIL, cleanup,
-					"Child exit status = %d", status >> 8);
-			count++;
-		} else {
-			if (errno != EINTR) {
-				break;
-			}
-#ifdef DEBUG
-			tst_resm(TINFO, "Signal detected during wait");
-#endif
-		}
-	}
-	/* Make sure proper number of children exited */
-	if (count != nprocs)
-		tst_brkm(TFAIL, cleanup,
-			 "Wrong number of children exited, Saw %d, Expected %d",
-			 count, nprocs);
-}
-
-static void cleanup_msgqueue(int i, int tid)
+static void cleanup_msgqueue(int i, int id)
 {
 	/*
-	 * Decrease the value of i by 1 because it
-	 * is getting incremented even if the fork
-	 * is failing.
+	 * Decrease the value of i by 1 because it is getting incremented
+	 * even if the fork is failing.
 	 */
-
 	i--;
-	/*
-	 * Kill all children & free message queue.
-	 */
+	/* Kill all children & free message queue. */
 	for (; i >= 0; i--) {
 		(void)kill(rkidarray[i], SIGKILL);
 		(void)kill(wkidarray[i], SIGKILL);
 	}
-
-	if (msgctl(tid, IPC_RMID, 0) < 0) {
-		printf("Msgctl error in cleanup_msgqueue %d\n", errno);
-		exit(FAIL);
-	}
+	SAFE_MSGCTL(id, IPC_RMID, 0);
 }
 
-static int dotest(key_t key, int child_process)
+static void dotest(key_t key, int child_process, int id)
 {
-	int id, pid;
-	int i, count, status, exit_status;
-
-	sighold(SIGTERM);
-	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		printf("msgget() error in child %d: %s\n",
-			child_process, strerror(errno));
-		return FAIL;
-	}
-	tid = id;
-	sigrelse(SIGTERM);
-
-	exit_status = PASS;
+	int pid;
+	int i, count;
 
 	for (i = 0; i < nkids; i++) {
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the first child of child group %d\n",
+		pid = fork();
+		if (pid < 0) {
+			tst_res(TFAIL,
+				"Fork failure in the first child of child group %d\n",
 				child_process);
-			cleanup_msgqueue(i, tid);
-			return FAIL;
+			cleanup_msgqueue(i, id);
+			return;
 		}
 		/* First child does this */
 		if (pid == 0) {
-			procstat = 2;
-			exit(doreader(key, tid, getpid(),
-					child_process, nreps));
+			msg_do_reader(key, id, getpid(), child_process, nreps);
+			exit(0);
 		}
 		rkidarray[i] = pid;
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the second child of child group %d\n",
+		pid = fork();
+		if (pid < 0) {
+			tst_res(TFAIL,
+				"Fork failure in the first child of child group %d\n",
 				child_process);
-			/*
-			 * Kill the reader child process
-			 */
-			(void)kill(rkidarray[i], SIGKILL);
-
-			cleanup_msgqueue(i, tid);
-			return FAIL;
+			cleanup_msgqueue(i, id);
+			return;
 		}
 		/* Second child does this */
 		if (pid == 0) {
-			procstat = 2;
-			exit(dowriter(key, tid, rkidarray[i],
-					child_process, nreps));
+			msg_do_writer(key, id, rkidarray[i], child_process, nreps);
+			exit(0);
 		}
 		wkidarray[i] = pid;
 	}
 	/* Parent does this */
 	count = 0;
 	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != PASS) {
-				printf("Child exit status = %d from child group %d\n",
-					status >> 8, child_process);
-				for (i = 0; i < nkids; i++) {
-					kill(rkidarray[i], SIGTERM);
-					kill(wkidarray[i], SIGTERM);
-				}
-				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					printf("msgctl() error: %s\n",
-						strerror(errno));
-				}
-				return FAIL;
-			}
+		if (wait(NULL) > 0) {
 			count++;
 		} else {
-			if (errno != EINTR) {
+			if (errno != EINTR)
 				break;
-			}
 		}
 	}
 	/* Make sure proper number of children exited */
 	if (count != (nkids * 2)) {
-		printf("Wrong number of children exited in child group %d, saw %d, expected %d\n",
+		tst_res(TFAIL,
+			"Wrong number of children exited in child group %d, saw %d, expected %d\n",
 			child_process, count, (nkids * 2));
-		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			printf("msgctl() error: %s\n", strerror(errno));
-		}
-		return FAIL;
 	}
-	if (msgctl(id, IPC_RMID, 0) < 0) {
-		printf("msgctl() failure in child group %d: %s\n",
-			child_process, strerror(errno));
-		return FAIL;
-	}
-	return exit_status;
+	SAFE_MSGCTL(id, IPC_RMID, NULL);
 }
 
-/* ARGSUSED */
-static void term(int sig LTP_ATTRIBUTE_UNUSED)
+static void dotest_iteration(int off)
 {
-	int i;
+	key_t key;
+	int i, count;
+	pid_t pid;
 
-	if (procstat == 0) {
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGTERM signal received, test killing kids");
-#endif
-		for (i = 0; i < nprocs; i++) {
-			if (pidarray[i] > 0) {
-				if (kill(pidarray[i], SIGTERM) < 0) {
-					tst_resm(TBROK,
-						 "Kill failed to kill child %d",
-						 i);
-					exit(FAIL);
-				}
-			}
-		}
-		return;
-	}
+	memset(pidarray, 0, sizeof(pidarray));
+
+	for (i = 0; i < nprocs; i++) {
+		key = keyarray[off + i];
+		tid[i] = SAFE_MSGGET(key, IPC_CREAT | S_IRUSR | S_IWUSR);
+		pid = SAFE_FORK();
 
-	if (procstat == 2) {
-		exit(PASS);
+		/* Child does this */
+		if (pid == 0) {
+			dotest(key, i, tid[i]);
+			exit(0);
+		}
+		pidarray[i] = pid;
 	}
 
-	if (tid == -1) {
-		exit(FAIL);
+	count = 0;
+	while (1) {
+		if (wait(NULL) > 0) {
+			count++;
+		} else {
+			if (errno != EINTR)
+				break;
+		}
 	}
-	for (i = 0; i < nkids; i++) {
-		if (rkidarray[i] > 0)
-			kill(rkidarray[i], SIGTERM);
-		if (wkidarray[i] > 0)
-			kill(wkidarray[i], SIGTERM);
+	/* Make sure proper number of children exited */
+	if (count != nprocs) {
+		tst_brk(TFAIL,
+			"Wrong number of children exited, Saw %d, Expected %d",
+			count, nprocs);
 	}
 }
 
-void setup(void)
+static void verify_msgstress(void)
 {
-	int nr_msgqs, free_pids;
+	int i;
 
-	tst_tmpdir();
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
+	/*
+	 * Set up array of unique keys for use in allocating message
+	 * queues.
 	 */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	setup_msg_key_array(MSGMNI);
 
-	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
-	 * fork the test with the -c option.  You want to make sure you do this
-	 * before you create your temporary directory.
-	 */
-	TEST_PAUSE;
+	if (MSGMNI <= maxnprocs) {
+		nprocs = MSGMNI;
+		dotest_iteration(0);
+	} else {
+		for (i = 0; i < (MSGMNI / maxnprocs); i++) {
+			nprocs = maxnprocs;
+			dotest_iteration(i * maxnprocs);
+		}
 
-	nr_msgqs = get_max_msgqueues();
-	if (nr_msgqs < 0)
-		tst_brkm(TBROK, cleanup, "get_max_msgqueues() failed");
+		nprocs = MSGMNI % maxnprocs;
+		dotest_iteration(i * maxnprocs);
+	}
 
-	MSGMNI = nr_msgqs - get_used_msgqueues();
-	if (MSGMNI <= 0)
-		tst_brkm(TBROK, cleanup,
-			 "Max number of message queues already used, cannot create more.");
+	tst_res(TPASS, "Test ran successfully!");
+}
 
-	tst_resm(TINFO, "Found %d available message queues", MSGMNI);
+static void setup(void)
+{
+	int free_pids;
 
-	free_pids = tst_get_free_pids(cleanup);
+	MSGMNI = GET_AVAIL_QUEUES();
+	if (MSGMNI <= 0)
+		tst_brk(TCONF, "Max message queues is used, cannot create more.");
+	tst_res(TINFO, "Found %d available message queues", MSGMNI);
+
+	free_pids = tst_get_free_pids();
 	if (free_pids < 0) {
-		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
+		tst_brk(TBROK, "Can't obtain free_pid count");
 	} else if (!free_pids) {
-		tst_brkm(TBROK, cleanup, "No free pids");
+		tst_brk(TBROK, "No free pids");
 	}
 
+	if (opt_nreps)
+		nreps = SAFE_STRTOL(opt_nreps, 1, MAXNREPS);
+
+	if (opt_nkids)
+		nkids = SAFE_STRTOL(opt_nkids, 1, MAXNKIDS);
+
+	if (opt_maxnprocs)
+		maxnprocs = SAFE_STRTOL(opt_maxnprocs, 1, MAXNPROCS);
+
 	/* We don't use more than a half of available pids.
 	 * For each child we fork up to 2*maxnkids grandchildren. */
-	maxnprocs = (free_pids / 2) / (1 + 2 * maxnkids);
-
+	maxnprocs = (free_pids / 2) / (1 + 2 * nkids);
 	if (!maxnprocs)
-		tst_brkm(TBROK, cleanup, "Not enough free pids");
+		tst_brk(TBROK, "Not enough free pids");
 
-	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
+	SAFE_SIGNAL(SIGTERM, SIG_IGN);
+	tst_res(TINFO,
+		"Using upto %d pids, total %d processes, per %d processs %d read/write pairs, %d repeats ",
+		free_pids/2, MSGMNI, maxnprocs, nkids, nreps);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	int status;
-
-	/*
-	 * Remove the message queue from the system
-	 */
-#ifdef DEBUG
-	tst_resm(TINFO, "Removing the message queue");
-#endif
-	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
-		(void)msgctl(tid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
+	int i = 0;
 
-	}
-
-	tst_rmdir();
+	for (i = 0; i < nprocs; i++)
+		msgctl(tid[i], IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.test_all = verify_msgstress,
+};
-- 
2.23.0



