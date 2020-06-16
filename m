From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 16 Jun 2020 17:01:22 +0800
Subject: [LTP] [PATCH v1 2/2] syscalls/msgstress: scale number of processes
 accodingly to available RAM
In-Reply-To: <1592298082-21792-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1592298082-21792-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1592298082-21792-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In these tests, fork may fail because of EAGAIN error in the following situations:
 1)Reaching the RLIMIT_NPROC soft resource limit
 2)Reaching /proc/sys/kernel/threads-max limit
 3)Reaching /proc/sys/kernel/pid_max limit
 4)the PID limit (pids.max) imposed by the cgroup "process number" (PIDs) controller was reached

According to kernel code kernel/fork.c, for thread_max it has the following
calculation formula:
	THREAD_SIZE = PAGE_SIZE << THREAD_SIZE_ORDER
	max_threads = totalram_pages / (8 * THREAD_SIZE / PAGE_SIZE);
The default maximum number of threads is set to a safe value: the thread structures can take up
at most one eighth of the memory. the pid limit is equal to max_threads/2.
 For example(on x86_64), 4G memory, page_size is 4k,THREAD_SIZE_ORDER is 1
 max_threads = 2^32/(8 * 8 * 1024) = 65536
 RLIMIT_NPROC = 32768  // 0.5

Also, pids cgroup and systemd also has this limit. On old systemd version, ths limit is 0.8 *thread_num.
On newer systemd version, the limit is 0.33 *thread_num. In here, we use 0.3.

Aparting from this changes, use new api for these cases and use some SAFE MACRO. Merge msgstress03.c into
msgstress01.c and use -r option to read actual msgmni value on procfs instead.

Fixes #509

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |   4 +-
 runtest/syscalls-ipc                          |   4 +-
 .../kernel/syscalls/ipc/msgstress/.gitignore  |   1 -
 .../kernel/syscalls/ipc/msgstress/Makefile    |   4 +-
 .../syscalls/ipc/msgstress/msgstress01.c      | 303 ++++++---------
 .../syscalls/ipc/msgstress/msgstress02.c      | 301 +++++---------
 .../syscalls/ipc/msgstress/msgstress03.c      | 290 --------------
 .../syscalls/ipc/msgstress/msgstress04.c      | 367 ++++++------------
 8 files changed, 311 insertions(+), 963 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/msgstress/msgstress03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bee03e93f..18e5fa5b5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -797,9 +797,9 @@ msgctl01 msgctl01
 msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
-msgstress01 msgstress01
+msgstress01 msgstress01 -l 100000
 msgstress02 msgstress02
-msgstress03 msgstress03
+msgstress03 msgstress01 -r y
 msgstress04 msgstress04
 msgctl12 msgctl12
 
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 54d8622d4..b2688e25b 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -2,9 +2,9 @@ msgctl01 msgctl01
 msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
-msgstress01 msgstress01
+msgstress01 msgstress01 -l 100000
 msgstress02 msgstress02
-msgstress03 msgstress03
+msgstress03 msgstress03 -r y
 msgstress04 msgstress04
 msgctl12 msgctl12
 
diff --git a/testcases/kernel/syscalls/ipc/msgstress/.gitignore b/testcases/kernel/syscalls/ipc/msgstress/.gitignore
index a8f675399..e1df4cda8 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgstress/.gitignore
@@ -1,4 +1,3 @@
 /msgstress01
 /msgstress02
-/msgstress03
 /msgstress04
diff --git a/testcases/kernel/syscalls/ipc/msgstress/Makefile b/testcases/kernel/syscalls/ipc/msgstress/Makefile
index f62cd1f48..a11cbcf2e 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgstress/Makefile
@@ -3,10 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS  += -lltpipc
+LDLIBS  += -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 0a660c042..bf132d4dc 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -1,29 +1,14 @@
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
  * 11/06/2002   Port to LTP     dbarrera@us.ibm.com
- */
-
-/*
+ * 06/15/2020   Convert to new api xuyang2018.jy@cn.fujitsu.com
+ *
  * Get and manipulate a message queue.
  */
 
-#define _XOPEN_SOURCE 500
 #include <signal.h>
 #include <errno.h>
 #include <string.h>
@@ -31,101 +16,66 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
-#include <values.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <sys/ipc.h>
 #include <sys/msg.h>
-#include "test.h"
-#include "ipcmsg.h"
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "tst_safe_sysv_ipc.h"
 #include "libmsgctl.h"
 
-char *TCID = "msgstress01";
-int TST_TOTAL = 1;
-
-#ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	1000000	/* This value is set to an arbitrary high limit. */
-#else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
-#endif
+#define MAXNPROCS       1000000
 #define MAXNREPS	100000
 
 static key_t keyarray[MAXNPROCS];
 static int pidarray[MAXNPROCS];
 static int tid;
 static int MSGMNI, nprocs, nreps;
-static int procstat;
-static int mykid;
-
-void setup(void);
-void cleanup(void);
-
-static int dotest(key_t key, int child_process);
-static void sig_handler();
-
 static char *opt_nprocs;
 static char *opt_nreps;
-
-static option_t options[] = {
-	{"n:", NULL, &opt_nprocs},
-	{"l:", NULL, &opt_nreps},
-	{NULL, NULL, NULL},
+static char *opt_msgmnifile;
+static void cleanup(void);
+
+static struct tst_option options[] = {
+	{"n:", &opt_nprocs, "-n N     Number of processes"},
+	{"l:", &opt_nreps, "-l N     Number of iterations"},
+	{"r:", &opt_msgmnifile, "-r Y/N use actual msgmni value under procfs"},
+	{NULL, NULL, NULL}
 };
 
-static void usage(void)
-{
-	printf("  -n      Number of processes\n");
-	printf("  -l      Number of iterations\n");
-}
-
-int main(int argc, char **argv)
+static int dotest(key_t key, int child_process)
 {
-	int i, j, ok, pid;
-	int count, status;
-	struct sigaction act;
+	int pid;
+	int ret, status;
 
-	tst_parse_opts(argc, argv, options, usage);
+	tid = SAFE_MSGGET(key, IPC_CREAT | S_IRUSR | S_IWUSR);
 
-	setup();
+	pid = SAFE_FORK();
+	if (pid == 0)
+		exit(doreader(key, tid, 1, child_process, nreps));
+	ret = dowriter(key, tid, 1, child_process, nreps);
+	SAFE_WAIT(&status);
 
-	nreps = MAXNREPS;
-	nprocs = MSGMNI;
+	if (ret != PASS)
+		exit(FAIL);
+	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
+		exit(FAIL);
 
-	if (opt_nreps) {
-		nreps = atoi(opt_nreps);
-		if (nreps > MAXNREPS) {
-			tst_resm(TINFO,
-				 "Requested number of iterations too large, "
-				 "setting to Max. of %d", MAXNREPS);
-			nreps = MAXNREPS;
-		}
-	}
+	SAFE_MSGCTL(tid, IPC_RMID, NULL);
+	return PASS;
+}
 
-	if (opt_nprocs) {
-		nprocs = atoi(opt_nprocs);
-		if (nprocs > MSGMNI) {
-			tst_resm(TINFO,
-				 "Requested number of processes too large, "
-				 "setting to Max. of %d", MSGMNI);
-			nprocs = MSGMNI;
-		}
-	}
+static void verify_msgstress(void)
+{
+	int i, j, ok, pid;
+	int count, status;
 
 	srand(getpid());
 	tid = -1;
 
-	/* Setup signal handling routine */
-	memset(&act, 0, sizeof(act));
-	act.sa_handler = sig_handler;
-	sigemptyset(&act.sa_mask);
-	sigaddset(&act.sa_mask, SIGTERM);
-	if (sigaction(SIGTERM, &act, NULL) < 0) {
-		tst_brkm(TFAIL, NULL, "Sigset SIGTERM failed");
-	}
-	/* Set up array of unique keys for use in allocating message
-	 * queues
-	 */
+	/* Set up array of unique keys for use in allocating message queues */
 	for (i = 0; i < nprocs; i++) {
 		ok = 1;
 		do {
@@ -146,24 +96,17 @@ int main(int argc, char **argv)
 		} while (ok == 0);
 	}
 
-	/* Fork a number of processes, each of which will
+	/*
+	 * Fork a number of processes, each of which will
 	 * create a message queue with one reader/writer
 	 * pair which will read and write a number (iterations)
 	 * of random length messages with specific values.
 	 */
 
 	for (i = 0; i < nprocs; i++) {
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "\tFork failed (may be OK if under stress)");
-		}
-		/* Child does this */
-		if (pid == 0) {
-			procstat = 1;
+		pid = SAFE_FORK();
+		if (pid == 0)
 			exit(dotest(keyarray[i], i));
-		}
 		pidarray[i] = pid;
 	}
 
@@ -171,131 +114,105 @@ int main(int argc, char **argv)
 	while (1) {
 		if ((wait(&status)) > 0) {
 			if (status >> 8 != 0) {
-				tst_brkm(TFAIL, NULL,
-					 "Child exit status = %d",
-					 status >> 8);
+				tst_brk(TFAIL, "Child exit status = %d", status >> 8);
 			}
 			count++;
 		} else {
 			if (errno != EINTR) {
 				break;
 			}
-#ifdef DEBUG
-			tst_resm(TINFO, "Signal detected during wait");
-#endif
+			tst_res(TINFO, "Signal detected during wait");
+
 		}
 	}
 	/* Make sure proper number of children exited */
 	if (count != nprocs) {
-		tst_brkm(TFAIL,
-			 NULL,
+		tst_brk(TFAIL,
 			 "Wrong number of children exited, Saw %d, Expected %d",
 			 count, nprocs);
 	}
 
-	tst_resm(TPASS, "Test ran successfully!");
-
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "Test ran successfully!");
 }
 
-static int dotest(key_t key, int child_process)
-{
-	int id, pid;
-	int ret, status;
-
-	sighold(SIGTERM);
-	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
-	if (TEST_RETURN < 0) {
-		printf("msgget() error in child %d: %s\n",
-			child_process, strerror(TEST_ERRNO));
-
-		return FAIL;
-	}
-	tid = id = TEST_RETURN;
-	sigrelse(SIGTERM);
-
-	fflush(stdout);
-	if ((pid = FORK_OR_VFORK()) < 0) {
-		printf("\tFork failed (may be OK if under stress)\n");
-		TEST(msgctl(tid, IPC_RMID, 0));
-		if (TEST_RETURN < 0) {
-			printf("mscgtl() error in cleanup: %s\n",
-				strerror(TEST_ERRNO));
-		}
-		return FAIL;
-	}
-	/* Child does this */
-	if (pid == 0)
-		exit(doreader(key, id, 1, child_process, nreps));
-	/* Parent does this */
-	mykid = pid;
-	procstat = 2;
-	ret = dowriter(key, id, 1, child_process, nreps);
-	wait(&status);
-
-	if (ret != PASS)
-		exit(FAIL);
-
-	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
-		exit(FAIL);
-
-	TEST(msgctl(id, IPC_RMID, 0));
-	if (TEST_RETURN < 0) {
-		printf("msgctl() errno %d: %s\n",
-			TEST_ERRNO, strerror(TEST_ERRNO));
-
-		return FAIL;
-	}
-	return PASS;
-}
-
-static void sig_handler(void)
-{
-}
-
-void setup(void)
+static void setup(void)
 {
 	int nr_msgqs;
+	int threads_max;
+	int free_pids;
 
-	tst_tmpdir();
+	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%d", &nr_msgqs);
+	SAFE_FILE_SCANF("/proc/sys/kernel/threads-max", "%d", &threads_max);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	nr_msgqs -= GET_USED_QUEUES();
+	if (nr_msgqs <= 0)
+		tst_brk(TCONF, "Max number of message queues already used, cannot create more.");
 
-	TEST_PAUSE;
+	if (opt_msgmnifile)
+		MSGMNI = nr_msgqs;
+	else
+		MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
 
-	nr_msgqs = get_max_msgqueues();
-	if (nr_msgqs < 0)
-		cleanup();
+	if (opt_nreps) {
+		nreps = SAFE_STRTOL(opt_nreps, 1, INT_MAX);
+		nreps = min(nreps, MAXNREPS);
+	} else {
+		nreps = 10000;
+	}
 
-	nr_msgqs -= get_used_msgqueues();
-	if (nr_msgqs <= 0) {
-		tst_resm(TBROK,
-			 "Max number of message queues already used, cannot create more.");
-		cleanup();
+	if (opt_nprocs) {
+		nprocs = SAFE_STRTOL(opt_nprocs, 1, INT_MAX);
+		nprocs = min(nprocs, MAXNPROCS);
+		nprocs = min(nprocs, MSGMNI);
+	} else {
+		nprocs = MSGMNI;
 	}
 
 	/*
-	 * Since msgmni scales to the memory size, it may reach huge values
-	 * that are not necessary for this test.
-	 * That's why we define NR_MSGQUEUES as a high boundary for it.
+	 * fork may fail because of EAGAIN error in the following situations:
+	 * 1)Reaching the RLIMIT_NPROC soft resource limit
+	 * 2)Reaching /proc/sys/kernel/threads-max limit
+	 * 3)Reaching /proc/sys/kernel/pid_max limit
+	 * 4)the PID limit (pids.max) imposed by the cgroup "process number" (PIDs) controller was reached
+	 *
+	 * According to kernel code kernel/fork.c, for thread_max it has the following
+	 * calculation formula:
+	 * THREAD_SIZE = PAGE_SIZE << THREAD_SIZE_ORDER
+	 * max_threads = totalram_pages / (8 * THREAD_SIZE / PAGE_SIZE);
+	 * The default maximum number of threads is set to a safe value: the thread
+	 * structures can take up@most one eighth of the memory.
+	 * the pid limit is equal to max_threads/2.
+	 * For example(on x86_64), 4G memory, page_size is 4k,THREAD_SIZE_ORDER is 1
+	 * max_threads = 2^32/(8 * 8 * 1024) = 65536
+	 * RLIMIT_NPROC = 32768  // 0.5
+	 *
+	 * Also, pids cgroup and systemd also has this limit. On old systemd version,
+	 * ths limit is 0.8 *thread_num. On newer systemd version, the limit is 0.33 *
+	 * thread_num. In here, we use 0.3.
 	 */
-	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
+	nprocs = min(nprocs, 0.3 * threads_max);
+	free_pids = tst_get_free_pids();
+	if (free_pids < 0)
+		tst_brk(TBROK, "Can't obtain free_pid count");
+	if (!free_pids)
+		tst_brk(TBROK, "No free pids");
+
+	nprocs = min(nprocs, free_pids * 0.8);
+
+	tst_res(TINFO, "Number of message queues is %d, process is %d, iterations is %d", MSGMNI, nprocs, nreps);
 }
 
 void cleanup(void)
 {
-	int status;
-
-#ifdef DEBUG
-	tst_resm(TINFO, "Removing the message queue");
-#endif
-	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
-		(void)msgctl(tid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
-
-	}
-
-	tst_rmdir();
+	if (tid >= 0)
+		SAFE_MSGCTL(tid, IPC_RMID, NULL);
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
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
index e15131043..622f955dd 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
@@ -1,31 +1,15 @@
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
- */
-
-/*
+ * 06/15/2020   Convert to new api xuyang2018.jy@cn.fujitsu.com
+ *
  * Get and manipulate a message queue.
  */
-
 #define _XOPEN_SOURCE 500
 #include <sys/stat.h>
-#include <sys/types.h>
 #include <sys/ipc.h>
 #include <sys/msg.h>
 #include <sys/wait.h>
@@ -35,19 +19,13 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include "test.h"
-#include "ipcmsg.h"
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "tst_safe_sysv_ipc.h"
 #include "libmsgctl.h"
 
-char *TCID = "msgstress02";
-int TST_TOTAL = 1;
-
 #define MAXNREPS	1000
-#ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	 1000000	/* This value is set to an arbitrary high limit. */
-#else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
-#endif
+#define MAXNPROCS	1000000
 #define MAXNKIDS	10
 
 static key_t keyarray[MAXNPROCS];
@@ -58,81 +36,35 @@ static int tid;
 static int nprocs, nreps, nkids, MSGMNI;
 static int procstat;
 
-void setup(void);
-void cleanup(void);
+static void cleanup(void);
 
 static void term(int);
 static int dotest(key_t, int);
-static void cleanup_msgqueue(int i, int tid);
 
 static char *opt_nprocs;
 static char *opt_nkids;
 static char *opt_nreps;
 
-static option_t options[] = {
-	{"n:", NULL, &opt_nprocs},
-	{"c:", NULL, &opt_nkids},
-	{"l:", NULL, &opt_nreps},
-	{NULL, NULL, NULL},
+static struct tst_option options[] = {
+	{"n:", &opt_nprocs, "-n N     Number of processes"},
+	{"c:", &opt_nkids, "-c N     Number of read/write child pairs"},
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
-int main(int argc, char **argv)
+static void verify_msgstress(void)
 {
 	int i, j, ok, pid;
 	int count, status;
 
-	tst_parse_opts(argc, argv, options, usage);
-
-	setup();
-
-	nreps = MAXNREPS;
-	nprocs = MSGMNI;
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
-	if (opt_nprocs) {
-		nprocs = atoi(opt_nprocs);
-		if (nprocs > MSGMNI) {
-			tst_resm(TINFO,
-				 "Requested number of processes too large, "
-				 "setting to Max. of %d", MSGMNI);
-			nprocs = MSGMNI;
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
 	procstat = 0;
 	srand48((unsigned)getpid() + (unsigned)(getppid() << 16));
 	tid = -1;
 
 	/* Setup signal handleing routine */
+
 	if (sigset(SIGTERM, term) == SIG_ERR) {
-		tst_brkm(TFAIL, NULL, "Sigset SIGTERM failed");
+		tst_brk(TFAIL, "Sigset SIGTERM failed");
 	}
 	/* Set up array of unique keys for use in allocating message
 	 * queues
@@ -161,15 +93,8 @@ int main(int argc, char **argv)
 	 * pairs which will read and write a number (iterations)
 	 * of random length messages with specific values (keys).
 	 */
-
 	for (i = 0; i < nprocs; i++) {
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "\tFork failed (may be OK if under stress)");
-		}
-		/* Child does this */
+		pid = SAFE_FORK();
 		if (pid == 0) {
 			procstat = 1;
 			exit(dotest(keyarray[i], i));
@@ -180,81 +105,40 @@ int main(int argc, char **argv)
 	count = 0;
 	while (1) {
 		if ((wait(&status)) > 0) {
-			if (status >> 8 != PASS) {
-				tst_brkm(TFAIL, NULL,
-					 "Child exit status = %d",
-					 status >> 8);
-			}
+			if (status >> 8 != PASS)
+				tst_brk(TFAIL, "Child exit status = %d",
+					status >> 8);
 			count++;
 		} else {
-			if (errno != EINTR) {
+			if (errno != EINTR)
 				break;
-			}
-#ifdef DEBUG
-			tst_resm(TINFO, "Signal detected during wait");
-#endif
+			tst_res(TINFO, "Signal detected during wait");
 		}
 	}
 	/* Make sure proper number of children exited */
 	if (count != nprocs) {
-		tst_brkm(TFAIL,
-			 NULL,
-			 "Wrong number of children exited, Saw %d, Expected %d",
-			 count, nprocs);
+		tst_brk(TFAIL,
+			"Wrong number of children exited, Saw %d, Expected %d",
+			count, nprocs);
 	}
 
-	tst_resm(TPASS, "Test ran successfully!");
-
+	tst_res(TPASS, "Test ran successfully!");
 	cleanup();
-	tst_exit();
-}
-
-static void cleanup_msgqueue(int i, int tid)
-{
-	/*
-	 * Decrease the value of i by 1 because it
-	 * is getting incremented even if the fork
-	 * is failing.
-	 */
-
-	i--;
-	/*
-	 * Kill all children & free message queue.
-	 */
-	for (; i >= 0; i--) {
-		(void)kill(rkidarray[i], SIGKILL);
-		(void)kill(wkidarray[i], SIGKILL);
-	}
-
-	if (msgctl(tid, IPC_RMID, 0) < 0) {
-		tst_brkm(TFAIL | TERRNO, NULL, "Msgctl error in cleanup");
-	}
 }
 
 static int dotest(key_t key, int child_process)
 {
-	int id, pid;
+	int pid;
 	int i, count, status, exit_status;
 
 	sighold(SIGTERM);
-	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		printf("msgget() error in child %d: %s\n",
-			child_process, strerror(errno));
-		return FAIL;
-	}
-	tid = id;
+	tid = SAFE_MSGGET(key, IPC_CREAT | S_IRUSR | S_IWUSR);
 	sigrelse(SIGTERM);
 
 	exit_status = PASS;
 
 	for (i = 0; i < nkids; i++) {
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the first child of child group %d\n",
-				child_process);
-			cleanup_msgqueue(i, tid);
-			return FAIL;
-		}
+		pid = SAFE_FORK();
 		/* First child does this */
 		if (pid == 0) {
 			procstat = 2;
@@ -262,18 +146,7 @@ static int dotest(key_t key, int child_process)
 					child_process, nreps));
 		}
 		rkidarray[i] = pid;
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the second child of child group %d\n",
-				child_process);
-			/*
-			 * Kill the reader child process
-			 */
-			(void)kill(rkidarray[i], SIGKILL);
-
-			cleanup_msgqueue(i, tid);
-			return FAIL;
-		}
+		pid = SAFE_FORK();
 		/* Second child does this */
 		if (pid == 0) {
 			procstat = 2;
@@ -293,10 +166,7 @@ static int dotest(key_t key, int child_process)
 					kill(rkidarray[i], SIGTERM);
 					kill(wkidarray[i], SIGTERM);
 				}
-				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					printf("msgctl() error: %s\n",
-						strerror(errno));
-				}
+				SAFE_MSGCTL(tid, IPC_RMID, NULL);
 				return FAIL;
 			}
 			count++;
@@ -310,16 +180,10 @@ static int dotest(key_t key, int child_process)
 	if (count != (nkids * 2)) {
 		printf("Wrong number of children exited in child group %d, saw %d, expected %d\n",
 			child_process, count, (nkids * 2));
-		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			printf("msgctl() error: %s\n", strerror(errno));
-		}
-		return FAIL;
-	}
-	if (msgctl(id, IPC_RMID, 0) < 0) {
-		printf("msgctl() failure in child group %d: %s\n",
-			child_process, strerror(errno));
+		SAFE_MSGCTL(tid, IPC_RMID, NULL);
 		return FAIL;
 	}
+	SAFE_MSGCTL(tid, IPC_RMID, NULL);
 	return exit_status;
 }
 
@@ -328,17 +192,9 @@ static void term(int sig LTP_ATTRIBUTE_UNUSED)
 	int i;
 
 	if (procstat == 0) {
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGTERM signal received, test killing kids");
-#endif
 		for (i = 0; i < nprocs; i++) {
-			if (pidarray[i] > 0) {
-				if (kill(pidarray[i], SIGTERM) < 0) {
-					printf("Kill failed to kill child %d",
-						i);
-					exit(FAIL);
-				}
-			}
+			if (pidarray[i] > 0)
+				SAFE_KILL(pidarray[i], SIGTERM);
 		}
 		return;
 	}
@@ -353,56 +209,73 @@ static void term(int sig LTP_ATTRIBUTE_UNUSED)
 	}
 	for (i = 0; i < nkids; i++) {
 		if (rkidarray[i] > 0)
-			kill(rkidarray[i], SIGTERM);
+			SAFE_KILL(rkidarray[i], SIGTERM);
 		if (wkidarray[i] > 0)
-			kill(wkidarray[i], SIGTERM);
+			SAFE_KILL(wkidarray[i], SIGTERM);
 	}
 }
 
-void setup(void)
+static void setup(void)
 {
 	int nr_msgqs;
+	int threads_max;
+	int free_pids;
 
-	tst_tmpdir();
+	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%d", &nr_msgqs);
+	SAFE_FILE_SCANF("/proc/sys/kernel/threads-max", "%d", &threads_max);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	MSGMNI = nr_msgqs - GET_USED_QUEUES();
+	if (MSGMNI <= 0)
+		tst_brk(TCONF, "Max number of message queues already used, cannot create more.");
 
-	TEST_PAUSE;
+	tst_res(TINFO, "Found %d available message queues", MSGMNI);
 
-	nr_msgqs = get_max_msgqueues();
-	if (nr_msgqs < 0)
-		cleanup();
+	if (opt_nreps) {
+		nreps = SAFE_STRTOL(opt_nreps, 1, INT_MAX);
+		nreps = min(nreps, MAXNREPS);
+	} else {
+		nreps = 1000;
+	}
 
-	nr_msgqs -= get_used_msgqueues();
-	if (nr_msgqs <= 0) {
-		tst_resm(TBROK,
-			 "Max number of message queues already used, cannot create more.");
-		cleanup();
+	if (opt_nkids) {
+		nkids = SAFE_STRTOL(opt_nkids, 1, INT_MAX);
+		nkids = min(nkids, MAXNKIDS);
+	} else {
+		nkids = MAXNKIDS;
 	}
 
-	/*
-	 * Since msgmni scales to the memory size, it may reach huge values
-	 * that are not necessary for this test.
-	 * That's why we define NR_MSGQUEUES as a high boundary for it.
-	 */
-	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
+	if (opt_nprocs) {
+		nprocs = SAFE_STRTOL(opt_nprocs, 1, INT_MAX);
+		nprocs = min(nprocs, MAXNPROCS);
+		nprocs = min(nprocs, nr_msgqs);
+	} else {
+		nprocs = NR_MSGQUEUES;
+	}
+
+	free_pids = tst_get_free_pids();
+	if (free_pids < 0)
+		tst_brk(TBROK, "Can't obtain free_pid count");
+	if (!free_pids)
+		tst_brk(TBROK, "No free pids");
+
+	free_pids = min(free_pids, 0.3 * threads_max);
+	nprocs = min(nprocs, (free_pids / 2) / (1 + 2 * nkids));
+	if (!nprocs)
+		tst_brk(TBROK, "Not enough free pids");
+	tst_res(TINFO, "%d processes %d read/write pais, %d repeats", nprocs, nkids, nreps);
 }
 
 void cleanup(void)
 {
-	int status;
-
-#ifdef DEBUG
-	tst_resm(TINFO, "Removing the message queue");
-#endif
-	fflush(stdout);
-	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
-		(void)msgctl(tid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
-
-	}
-
-	fflush(stdout);
-	tst_rmdir();
+	if (tid >= 0)
+		SAFE_MSGCTL(tid, IPC_RMID, NULL);
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
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
deleted file mode 100644
index 294b401b1..000000000
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
+++ /dev/null
@@ -1,290 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2002
- *
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
- * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
- * 11/06/2002   Port to LTP     dbarrera@us.ibm.com
- */
-
-/*
- * Get and manipulate a message queue.
- * Same as msgstress01 but gets the actual msgmni value under procfs.
- */
-
-#define _XOPEN_SOURCE 500
-#include <signal.h>
-#include <errno.h>
-#include <string.h>
-#include <fcntl.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <values.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <sys/ipc.h>
-#include <sys/msg.h>
-#include "test.h"
-#include "ipcmsg.h"
-#include "libmsgctl.h"
-
-char *TCID = "msgstress03";
-int TST_TOTAL = 1;
-
-#define MAXNPROCS	10000	/*These should be sufficient */
-#define MAXNREPS	10000	/*Else they srewup the system un-necessarily */
-
-static key_t keyarray[MAXNPROCS];
-static int pidarray[MAXNPROCS];
-static int tid;
-static int MSGMNI, nprocs, nreps;
-static int procstat;
-static int mykid;
-
-void setup(void);
-void cleanup(void);
-
-static int dotest(key_t key, int child_process);
-static void sig_handler(int signo);
-
-static char *opt_nprocs;
-static char *opt_nreps;
-
-static option_t options[] = {
-	{"n:", NULL, &opt_nprocs},
-	{"l:", NULL, &opt_nreps},
-	{NULL, NULL, NULL},
-};
-
-static void usage(void)
-{
-	printf("  -n      Number of processes\n");
-	printf("  -l      Number of iterations\n");
-}
-
-int main(int argc, char **argv)
-{
-	int i, j, ok, pid;
-	int count, status;
-	struct sigaction act;
-
-	tst_parse_opts(argc, argv, options, usage);
-
-	setup();
-
-	nreps = MAXNREPS;
-	nprocs = MSGMNI;
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
-	if (opt_nprocs) {
-		nprocs = atoi(opt_nprocs);
-		if (nprocs > MSGMNI) {
-			tst_resm(TINFO,
-				 "Requested number of processes too large, "
-				 "setting to Max. of %d", MSGMNI);
-			nprocs = MSGMNI;
-		}
-	}
-
-	srand(getpid());
-	tid = -1;
-
-	/* Setup signal handling routine */
-	memset(&act, 0, sizeof(act));
-	act.sa_handler = sig_handler;
-	sigemptyset(&act.sa_mask);
-	sigaddset(&act.sa_mask, SIGTERM);
-	if (sigaction(SIGTERM, &act, NULL) < 0) {
-		tst_brkm(TFAIL, NULL, "Sigset SIGTERM failed");
-	}
-	/* Set up array of unique keys for use in allocating message
-	 * queues
-	 */
-	for (i = 0; i < nprocs; i++) {
-		ok = 1;
-		do {
-			/* Get random key */
-			keyarray[i] = (key_t) rand();
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
-
-	/* Fork a number of processes, each of which will
-	 * create a message queue with one reader/writer
-	 * pair which will read and write a number (iterations)
-	 * of random length messages with specific values.
-	 */
-
-	for (i = 0; i < nprocs; i++) {
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "\tFork failed (may be OK if under stress)");
-		}
-		/* Child does this */
-		if (pid == 0) {
-			procstat = 1;
-			exit(dotest(keyarray[i], i));
-		}
-		pidarray[i] = pid;
-	}
-
-	count = 0;
-	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != 0) {
-				tst_brkm(TFAIL, NULL,
-					 "Child exit status = %d",
-					 status >> 8);
-			}
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
-	if (count != nprocs) {
-		tst_brkm(TFAIL,
-			 NULL,
-			 "Wrong number of children exited, Saw %d, Expected %d",
-			 count, nprocs);
-	}
-
-	tst_resm(TPASS, "Test ran successfully!");
-
-	cleanup();
-	tst_exit();
-}
-
-static int dotest(key_t key, int child_process)
-{
-	int id, pid;
-	int ret, status;
-
-	sighold(SIGTERM);
-	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
-	if (TEST_RETURN < 0) {
-		printf("msgget() error in child %d: %s\n",
-			child_process, strerror(TEST_ERRNO));
-		return FAIL;
-	}
-	tid = id = TEST_RETURN;
-	sigrelse(SIGTERM);
-
-	fflush(stdout);
-	if ((pid = FORK_OR_VFORK()) < 0) {
-		printf("Fork failed (may be OK if under stress)\n");
-		TEST(msgctl(tid, IPC_RMID, 0));
-		if (TEST_RETURN < 0) {
-			printf("msgctl() error in cleanup: %s\n",
-				strerror(TEST_ERRNO));
-		}
-		return FAIL;
-	}
-	if (pid == 0)
-		exit(doreader(key, id, 1, child_process, nreps));
-
-	mykid = pid;
-	procstat = 2;
-	ret = dowriter(key, id, 1, child_process, nreps);
-	wait(&status);
-
-	if (ret != PASS)
-		exit(FAIL);
-
-	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
-		exit(FAIL);
-
-	TEST(msgctl(id, IPC_RMID, 0));
-	if (TEST_RETURN < 0) {
-		printf("msgctl() failed: %s\n",
-			strerror(TEST_ERRNO));
-		return FAIL;
-	}
-	return PASS;
-}
-
-static void sig_handler(int signo LTP_ATTRIBUTE_UNUSED)
-{
-}
-
-void setup(void)
-{
-	int nr_msgqs;
-
-	tst_tmpdir();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	nr_msgqs = get_max_msgqueues();
-	if (nr_msgqs < 0)
-		cleanup();
-
-	MSGMNI = nr_msgqs - get_used_msgqueues();
-	if (MSGMNI > MAXNPROCS)
-		MSGMNI = MAXNPROCS;
-	if (MSGMNI <= 0) {
-		tst_resm(TBROK,
-			 "Max number of message queues already used, cannot create more.");
-		cleanup();
-	}
-}
-
-void cleanup(void)
-{
-	int status;
-
-#ifdef DEBUG
-	tst_resm(TINFO, "Removing the message queue");
-#endif
-	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
-		(void)msgctl(tid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
-
-	}
-
-	tst_rmdir();
-}
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index f1c124990..6d175cd58 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -1,32 +1,16 @@
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
- */
-
-/*
+ * 06/15/2020   Convert to new api xuyang2018.jy@cn.fujitsu.com
+ *
  * Get and manipulate a message queue.
  * Same as msgstress02 but gets the actual msgmni value under procfs.
  */
-
 #define _XOPEN_SOURCE 500
 #include <sys/stat.h>
-#include <sys/types.h>
 #include <sys/ipc.h>
 #include <sys/msg.h>
 #include <sys/wait.h>
@@ -36,23 +20,15 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include "test.h"
-#include "ipcmsg.h"
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "tst_safe_sysv_ipc.h"
 #include "libmsgctl.h"
 
-char *TCID = "msgstress04";
-int TST_TOTAL = 1;
-
 #define MAXNREPS	1000
-#ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	 1000000	/* This value is set to an arbitrary high limit. */
-#else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
-#endif
+#define MAXNPROCS	1000000
 #define MAXNKIDS	10
-#define DEFNKIDS	2
 
-static int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
 static key_t keyarray[MAXNPROCS];
 static int pidarray[MAXNPROCS];
 static int rkidarray[MAXNKIDS];
@@ -62,83 +38,71 @@ static int nprocs, nreps, nkids, MSGMNI;
 static int maxnprocs;
 static int procstat;
 
-void setup(void);
-void cleanup(void);
+static void cleanup(void);
 
 static void term(int);
 static int dotest(key_t, int);
-static void dotest_iteration(int off);
-static void cleanup_msgqueue(int i, int tid);
 
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
+	{"c:", &opt_nkids, "-c N     Number of read/write child pairs"},
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
+static void dotest_iteration(int off)
 {
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
+	key_t key;
+	int i, count, status;
+	pid_t pid;
+	memset(pidarray, 0, sizeof(pidarray));
 
-	if (opt_nkids) {
-		nkids = atoi(opt_nkids);
-		if (nkids > MAXNKIDS) {
-			tst_resm(TINFO,
-				 "Requested number of read/write pairs too "
-				 "large, setting to Max. of %d", MAXNKIDS);
-			nkids = MAXNKIDS;
+	for (i = 0; i < nprocs; i++) {
+		key = keyarray[off + i];
+		pid = SAFE_FORK();
+		if (pid == 0) {
+			procstat = 1;
+			exit(dotest(key, i));
 		}
+		pidarray[i] = pid;
 	}
 
-
-	if (opt_maxnprocs) {
-		if (atoi(opt_maxnprocs) > maxnprocs) {
-			tst_resm(TINFO,
-				 "Requested number of processes too large, "
-				 "setting to Max. of %d", MSGMNI);
+	count = 0;
+	while (1) {
+		if ((wait(&status)) > 0) {
+			if (status >> 8 != PASS)
+				tst_brk(TFAIL,
+					"Child exit status = %d", status >> 8);
+			count++;
 		} else {
-			maxnprocs = atoi(opt_maxnprocs);
+			if (errno != EINTR)
+				break;
+			tst_res(TINFO, "Signal detected during wait");
 		}
 	}
+	/* Make sure proper number of children exited */
+	if (count != nprocs)
+		tst_brk(TFAIL,
+			"Wrong number of children exited, Saw %d, Expected %d",
+			count, nprocs);
+}
+
+static void verify_msgstress(void)
+{
+	int i, j, ok;
 
 	procstat = 0;
 	srand48((unsigned)getpid() + (unsigned)(getppid() << 16));
 	tid = -1;
 
-	/* Setup signal handling routine */
-	if (sigset(SIGTERM, term) == SIG_ERR)
-		tst_brkm(TFAIL, cleanup, "Sigset SIGTERM failed");
-
+	/* Setup signal handleing routine */
+	if (sigset(SIGTERM, term) == SIG_ERR) {
+		tst_brk(TFAIL, "Sigset SIGTERM failed");
+	}
 	/* Set up array of unique keys for use in allocating message
 	 * queues
 	 */
@@ -161,15 +125,11 @@ int main(int argc, char **argv)
 			}
 		} while (ok == 0);
 	}
-	/* Fork a number of processes, each of which will
+	/* Fork a number of processes (nprocs), each of which will
 	 * create a message queue with several (nkids) reader/writer
 	 * pairs which will read and write a number (iterations)
 	 * of random length messages with specific values (keys).
-	 *
-	 * We do not fork more than maxnprocs@a time and
-	 * we fork until all the message queues get used.
 	 */
-
 	if (MSGMNI <= maxnprocs) {
 		nprocs = MSGMNI;
 		dotest_iteration(0);
@@ -178,84 +138,12 @@ int main(int argc, char **argv)
 			nprocs = maxnprocs;
 			dotest_iteration(i * maxnprocs);
 		}
-
 		nprocs = MSGMNI % maxnprocs;
 		dotest_iteration(i * maxnprocs);
 	}
 
-	tst_resm(TPASS, "Test ran successfully!");
-
+	tst_res(TPASS, "Test ran successfully!");
 	cleanup();
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
-{
-	/*
-	 * Decrease the value of i by 1 because it
-	 * is getting incremented even if the fork
-	 * is failing.
-	 */
-
-	i--;
-	/*
-	 * Kill all children & free message queue.
-	 */
-	for (; i >= 0; i--) {
-		(void)kill(rkidarray[i], SIGKILL);
-		(void)kill(wkidarray[i], SIGKILL);
-	}
-
-	if (msgctl(tid, IPC_RMID, 0) < 0) {
-		printf("Msgctl error in cleanup_msgqueue %d\n", errno);
-		exit(FAIL);
-	}
 }
 
 static int dotest(key_t key, int child_process)
@@ -264,42 +152,21 @@ static int dotest(key_t key, int child_process)
 	int i, count, status, exit_status;
 
 	sighold(SIGTERM);
-	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		printf("msgget() error in child %d: %s\n",
-			child_process, strerror(errno));
-		return FAIL;
-	}
+	id = SAFE_MSGGET(key, IPC_CREAT | S_IRUSR | S_IWUSR);
 	tid = id;
 	sigrelse(SIGTERM);
 
 	exit_status = PASS;
 
 	for (i = 0; i < nkids; i++) {
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the first child of child group %d\n",
-				child_process);
-			cleanup_msgqueue(i, tid);
-			return FAIL;
-		}
-		/* First child does this */
+		pid = SAFE_FORK();
 		if (pid == 0) {
 			procstat = 2;
 			exit(doreader(key, tid, getpid(),
 					child_process, nreps));
 		}
 		rkidarray[i] = pid;
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the second child of child group %d\n",
-				child_process);
-			/*
-			 * Kill the reader child process
-			 */
-			(void)kill(rkidarray[i], SIGKILL);
-
-			cleanup_msgqueue(i, tid);
-			return FAIL;
-		}
-		/* Second child does this */
+		pid = SAFE_FORK();
 		if (pid == 0) {
 			procstat = 2;
 			exit(dowriter(key, tid, rkidarray[i],
@@ -318,10 +185,7 @@ static int dotest(key_t key, int child_process)
 					kill(rkidarray[i], SIGTERM);
 					kill(wkidarray[i], SIGTERM);
 				}
-				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					printf("msgctl() error: %s\n",
-						strerror(errno));
-				}
+				SAFE_MSGCTL(tid, IPC_RMID, NULL);
 				return FAIL;
 			}
 			count++;
@@ -335,37 +199,21 @@ static int dotest(key_t key, int child_process)
 	if (count != (nkids * 2)) {
 		printf("Wrong number of children exited in child group %d, saw %d, expected %d\n",
 			child_process, count, (nkids * 2));
-		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			printf("msgctl() error: %s\n", strerror(errno));
-		}
-		return FAIL;
-	}
-	if (msgctl(id, IPC_RMID, 0) < 0) {
-		printf("msgctl() failure in child group %d: %s\n",
-			child_process, strerror(errno));
+		SAFE_MSGCTL(tid, IPC_RMID, NULL);
 		return FAIL;
 	}
+	SAFE_MSGCTL(id, IPC_RMID, NULL);
 	return exit_status;
 }
 
-/* ARGSUSED */
 static void term(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	int i;
 
 	if (procstat == 0) {
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGTERM signal received, test killing kids");
-#endif
 		for (i = 0; i < nprocs; i++) {
-			if (pidarray[i] > 0) {
-				if (kill(pidarray[i], SIGTERM) < 0) {
-					tst_resm(TBROK,
-						 "Kill failed to kill child %d",
-						 i);
-					exit(FAIL);
-				}
-			}
+			if (pidarray[i] > 0)
+				SAFE_KILL(pidarray[i], SIGTERM);
 		}
 		return;
 	}
@@ -379,72 +227,73 @@ static void term(int sig LTP_ATTRIBUTE_UNUSED)
 	}
 	for (i = 0; i < nkids; i++) {
 		if (rkidarray[i] > 0)
-			kill(rkidarray[i], SIGTERM);
+			SAFE_KILL(rkidarray[i], SIGTERM);
 		if (wkidarray[i] > 0)
-			kill(wkidarray[i], SIGTERM);
+			SAFE_KILL(wkidarray[i], SIGTERM);
 	}
 }
 
-void setup(void)
+static void setup(void)
 {
-	int nr_msgqs, free_pids;
+	int nr_msgqs;
+	int threads_max;
+	int free_pids;
 
-	tst_tmpdir();
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
-	 */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%d", &nr_msgqs);
+	SAFE_FILE_SCANF("/proc/sys/kernel/threads-max", "%d", &threads_max);
 
-	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
-	 * fork the test with the -c option.  You want to make sure you do this
-	 * before you create your temporary directory.
-	 */
-	TEST_PAUSE;
+	MSGMNI = nr_msgqs - GET_USED_QUEUES();
+	if (MSGMNI <= 0)
+		tst_brk(TCONF, "Max number of message queues already used, cannot create more.");
 
-	nr_msgqs = get_max_msgqueues();
-	if (nr_msgqs < 0)
-		tst_brkm(TBROK, cleanup, "get_max_msgqueues() failed");
+	tst_res(TINFO, "Found %d available message queues", MSGMNI);
 
-	MSGMNI = nr_msgqs - get_used_msgqueues();
-	if (MSGMNI <= 0)
-		tst_brkm(TBROK, cleanup,
-			 "Max number of message queues already used, cannot create more.");
+	nreps = 1000;
+	nkids = MAXNKIDS;
 
-	tst_resm(TINFO, "Found %d available message queues", MSGMNI);
+	if (opt_nreps) {
+		nreps = SAFE_STRTOL(opt_nreps, 1, INT_MAX);
+		nreps = min(nreps, MAXNREPS);
+	}
 
-	free_pids = tst_get_free_pids(cleanup);
-	if (free_pids < 0) {
-		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
-	} else if (!free_pids) {
-		tst_brkm(TBROK, cleanup, "No free pids");
+	if (opt_nkids) {
+		nkids = SAFE_STRTOL(opt_nkids, 1, INT_MAX);
+		nkids = min(nkids, MAXNKIDS);
 	}
 
-	/* We don't use more than a half of available pids.
-	 * For each child we fork up to 2*maxnkids grandchildren. */
-	maxnprocs = (free_pids / 2) / (1 + 2 * maxnkids);
+	free_pids = tst_get_free_pids();
+	if (free_pids < 0)
+		tst_brk(TBROK, "Can't obtain free_pid count");
+	if (!free_pids)
+		tst_brk(TBROK, "No free pids");
 
+	/*
+	 * We don't use more than a half of available pids.
+	 * For each child we fork up to 2*maxnkids grandchildren.
+	 */
+	free_pids = min(free_pids, 0.3 * threads_max);
+	maxnprocs = (free_pids / 2) / (1 + 2 * nkids);
 	if (!maxnprocs)
-		tst_brkm(TBROK, cleanup, "Not enough free pids");
+		tst_brk(TBROK, "Not enough free pids");
+
+	if (opt_maxnprocs) {
+		maxnprocs = SAFE_STRTOL(opt_maxnprocs, 1, maxnprocs);
+	}
 
-	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
+	tst_res(TINFO, "Using upto %d pids, %d processes %d read/write pais, %d repeats", free_pids/2, maxnprocs, nkids, nreps);
 }
 
 void cleanup(void)
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
-
-	}
-
-	tst_rmdir();
+	if (tid >= 0)
+		SAFE_MSGCTL(tid, IPC_RMID, NULL);
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



