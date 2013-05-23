Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UfR2k-0007ZG-TU
	for ltp-list@lists.sourceforge.net; Thu, 23 May 2013 08:38:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UfR2i-0000PL-8R
	for ltp-list@lists.sourceforge.net; Thu, 23 May 2013 08:38:38 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4N8cM9j025892
	for <ltp-list@lists.sourceforge.net>; Thu, 23 May 2013 16:38:25 +0800
Message-ID: <519DD4ED.3090907@cn.fujitsu.com>
Date: Thu, 23 May 2013 16:35:57 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/2] shmctl/shmctl01.c: cleanup
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
To: LTP list <ltp-list@lists.sourceforge.net>


1. Remove useless comments

2. Revise code to follow ltp-code-style

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c | 224 +++++++++---------------
 1 file changed, 80 insertions(+), 144 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index 4a1b064..34ff30c 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -1,20 +1,19 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */

 /*
@@ -35,31 +34,13 @@
  *	otherwise,
  *	  if doing functionality testing
  *		call the correct test function
- *	  	if the conditions are correct,
+ *		if the conditions are correct,
  *			issue a PASS message
  *		otherwise
  *			issue a FAIL message
  *	  otherwise
  *	    issue a PASS message
  *	call cleanup
- *
- * USAGE:  <for command-line>
- *  shmctl01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *      02/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix concurrency issue. Replace the sleep used for synchronization
- *        with the new pipe based synchronization functions.
- *
- * RESTRICTIONS
- *	none
  */

 #include "ipcshm.h"
@@ -67,59 +48,53 @@

 char *TCID = "shmctl01";

-int shm_id_1 = -1;
-struct shmid_ds buf;
-long save_time;
+static int shm_id_1 = -1;
+static struct shmid_ds buf;
+static long save_time;

 #define FIRST	0
 #define SECOND	1
-int stat_time;			/* set to either FIRST or SECOND for IPC_STAT tests */
+static int stat_time;

-void *set_shared;
+static void *set_shared;

 #define N_ATTACH	4

-pid_t pid_arr[N_ATTACH];
-int sync_pipes[2];
-
-/*
- * These are the various setup and check functions for the commands
- * that we are checking.
- */
+static pid_t pid_arr[N_ATTACH];
+static int sync_pipes[2];

 /* Setup, cleanup and check routines for IPC_STAT */
-void stat_setup(void), func_stat(void);
-void stat_cleanup(void);
+static void stat_setup(void), func_stat(void);
+static void stat_cleanup(void);

 /* Setup and check routines for IPC_SET */
-void set_setup(void), func_set(void);
+static void set_setup(void), func_set(void);

 /* Check routine for IPC_RMID */
-void func_rmid(void);
+static void func_rmid(void);

 /* Child function */
-void do_child(void);
+static void do_child(void);

-struct test_case_t {
-	int cmd;		/* the command to test */
-	void (*func_test) ();	/* the test function */
-	void (*func_setup) ();	/* the setup function if necessary */
+static struct test_case_t {
+	int cmd;
+	void (*func_test) ();
+	void (*func_setup) ();
 } TC[] = {
-
-	{
-	IPC_STAT, func_stat, stat_setup},
+	{IPC_STAT, func_stat, stat_setup},
 #ifndef UCLINUX
-	    /* The second test is not applicable to uClinux; shared memory segments
-	       are detached on exec(), so cannot be passed to uClinux children. */
-	{
-	IPC_STAT, func_stat, stat_setup},
+	    /*
+	     * The second test is not applicable to uClinux;
+	     * shared memory segments are detached on exec(),
+	     * so cannot be passed to uClinux children.
+	     */
+	{IPC_STAT, func_stat, stat_setup},
 #endif
-	{
-	IPC_SET, func_set, set_setup}, {
-	IPC_RMID, func_rmid, NULL}
+	{IPC_SET, func_set, set_setup},
+	{IPC_RMID, func_rmid, NULL},
 };

-int TST_TOTAL = (sizeof(TC) / sizeof(*TC));
+static int TST_TOTAL = ARRAY_SIZE(TC);

 #define NEWMODE	0066

@@ -128,31 +103,27 @@ int TST_TOTAL = (sizeof(TC) / sizeof(*TC));
 static char *argv0;
 #endif

-static int stat_i;		/* Shared between do_child and stat_setup */
+static int stat_i;

-int main(int ac, char **av)
+int main(int argc, char *argv[])
 {
 	int lc;
 	char *msg;
 	int i;
-	void check_functionality(void);

-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 #ifdef UCLINUX
-	argv0 = av[0];
+	argv0 = argv[0];
 	maybe_run_child(do_child, "ddd", &stat_i, &stat_time, &shm_id_1);
 #endif

-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+	setup();

 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;

-		/* initialize stat_time */
 		stat_time = FIRST;

 		/*
@@ -160,26 +131,20 @@ int main(int ac, char **av)
 		 * permissions.  Do this here instead of in setup()
 		 * so that looping (-i) will work correctly.
 		 */
-		if ((shm_id_1 = shmget(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL |
-				       SHM_RW)) == -1) {
+		shm_id_1 = shmget(shmkey, SHM_SIZE,
+				  IPC_CREAT | IPC_EXCL | SHM_RW);
+		if (shm_id_1 == -1)
 			tst_brkm(TBROK, cleanup, "couldn't create the shared"
 				 " memory segment");
-		}

-		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {

 			/*
 			 * if needed, set up any required conditions by
 			 * calling the appropriate setup function
 			 */
-			if (TC[i].func_setup != NULL) {
+			if (TC[i].func_setup != NULL)
 				(*TC[i].func_setup) ();
-			}
-
-			/*
-			 * Use TEST macro to make the call
-			 */

 			TEST(shmctl(shm_id_1, TC[i].cmd, &buf));

@@ -217,7 +182,7 @@ int main(int ac, char **av)
  *		 this seperate routine to avoid code duplication in
  *		 stat_setup() below.
  */
-void *set_shmat()
+void *set_shmat(void)
 {
 	void *rval;

@@ -241,7 +206,7 @@ void *set_shmat()
  *		  Make things interesting by forking some children
  *		  that will either attach or inherit the shared memory.
  */
-void stat_setup()
+void stat_setup(void)
 {
 	void *set_shmat();
 	pid_t pid;
@@ -252,34 +217,32 @@ void stat_setup()
 	 * the children inherit the memory.
 	 */

-	if (stat_time == SECOND) {
+	if (stat_time == SECOND)
 		/*
 		 * use the global "set_shared" variable here so that
 		 * it can be removed in the stat_func() routine.
 		 */
 		set_shared = set_shmat();
-	}

 	tst_flush();
 	for (stat_i = 0; stat_i < N_ATTACH; stat_i++) {
 		if (sync_pipe_create(sync_pipes, PIPE_NAME) == -1)
 			tst_brkm(TBROK, cleanup, "sync_pipe_create failed");

-		if ((pid = FORK_OR_VFORK()) == -1) {
+		pid = FORK_OR_VFORK();
+		if (pid == -1)
 			tst_brkm(TBROK, cleanup, "could not fork");
-		}

-		if (pid == 0) {	/* child */
+		if (pid == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv0, "ddd", stat_i, stat_time,
-				      shm_id_1) < 0) {
+				      shm_id_1) < 0)
 				tst_brkm(TBROK, cleanup, "could not self_exec");
-			}
 #else
 			do_child();
 #endif

-		} else {	/* parent */
+		} else {
 			/* save the child's pid for cleanup later */
 			pid_arr[stat_i] = pid;
 			if (sync_pipe_wait(sync_pipes) == -1)
@@ -295,12 +258,8 @@ void stat_setup()
 	sleep(1);
 }

-/*
- * do_child
- */
-void do_child()
+void do_child(void)
 {
-	int rval;
 	void *test;

 #ifdef UCLINUX
@@ -308,11 +267,10 @@ void do_child()
 		tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
 #endif

-	if (stat_time == FIRST) {
+	if (stat_time == FIRST)
 		test = set_shmat();
-	} else {
+	else
 		test = set_shared;
-	}

 	if (sync_pipe_notify(sync_pipes) == -1)
 		tst_brkm(TBROK, cleanup, "sync_pipe_notify failed");
@@ -323,16 +281,15 @@ void do_child()
 #endif
 		tst_brkm(TBROK, cleanup, "sync_pipe_close failed");

-	/* do an assignement for fun */
 	memcpy(test, &stat_i, sizeof(stat_i));

 	/* pause until we get a signal from stat_cleanup() */
-	rval = pause();
+	pause();

 	/* now we're back - detach the memory and exit */
-	if (shmdt(test) == -1) {
+	if (shmdt(test) == -1)
 		tst_resm(TBROK, "shmdt() failed - %d", errno);
-	}
+
 	tst_exit();
 }

@@ -341,7 +298,7 @@ void do_child()
  *		 by looking at the pid of the creator, the segement size,
  *		 the number of attaches and the mode.
  */
-void func_stat()
+void func_stat(void)
 {
 	int fail = 0;
 	pid_t pid;
@@ -373,7 +330,8 @@ void func_stat()
 	}

 	/* use MODE_MASK to make sure we are comparing the last 9 bits */
-	if (!fail && (buf.shm_perm.mode & MODE_MASK) != ((SHM_RW) & MODE_MASK)) {
+	if (!fail && (buf.shm_perm.mode & MODE_MASK) !=
+			((SHM_RW) & MODE_MASK)) {
 		tst_resm(TFAIL, "segment mode is incorrect");
 		fail = 1;
 	}
@@ -383,9 +341,8 @@ void func_stat()
 	/* save the change time for use in the next test */
 	save_time = buf.shm_ctime;

-	if (fail) {
+	if (fail)
 		return;
-	}

 	tst_resm(TPASS, "pid, size, # of attaches and mode are correct "
 		 "- pass #%d", stat_time);
@@ -396,22 +353,20 @@ void func_stat()
  *		    have the parent make dessert, er, um, make that remove
  *		    the shared memory that is no longer needed.
  */
-void stat_cleanup()
+void stat_cleanup(void)
 {
 	int i;

 	/* wake up the childern so they can detach the memory and exit */
 	for (i = 0; i < N_ATTACH; i++) {
-		if (kill(pid_arr[i], SIGUSR1) == -1) {
+		if (kill(pid_arr[i], SIGUSR1) == -1)
 			tst_brkm(TBROK, cleanup, "kill failed");
-		}
 	}

 	/* remove the parent's shared memory the second time through */
 	if (stat_time == SECOND) {
-		if (shmdt(set_shared) == -1) {
+		if (shmdt(set_shared) == -1)
 			tst_resm(TINFO, "shmdt() failed");
-		}
 	}

 	for (i = 0; i < N_ATTACH; i++) {
@@ -425,7 +380,7 @@ void stat_cleanup()
 /*
  * set_setup() - set up for the IPC_SET command with shmctl()
  */
-void set_setup()
+void set_setup(void)
 {
 	/* set up a new mode for the shared memory segment */
 	buf.shm_perm.mode = SHM_RW | NEWMODE;
@@ -437,7 +392,7 @@ void set_setup()
 /*
  * func_set() - check the functionality of the IPC_SET command with shmctl()
  */
-void func_set()
+void func_set(void)
 {
 	int fail = 0;

@@ -447,7 +402,8 @@ void func_set()
 		return;
 	}

-	if ((buf.shm_perm.mode & MODE_MASK) != ((SHM_RW | NEWMODE) & MODE_MASK)) {
+	if ((buf.shm_perm.mode & MODE_MASK) !=
+			((SHM_RW | NEWMODE) & MODE_MASK)) {
 		tst_resm(TFAIL, "new mode is incorrect");
 		fail = 1;
 	}
@@ -457,9 +413,8 @@ void func_set()
 		fail = 1;
 	}

-	if (fail) {
+	if (fail)
 		return;
-	}

 	tst_resm(TPASS, "new mode and change time are correct");
 }
@@ -467,18 +422,16 @@ void func_set()
 /*
  * func_rmid() - check the functionality of the IPC_RMID command with shmctl()
  */
-void func_rmid()
+void func_rmid(void)
 {
 	/* Do another shmctl() - we should get EINVAL */
-	if (shmctl(shm_id_1, IPC_STAT, &buf) != -1) {
+	if (shmctl(shm_id_1, IPC_STAT, &buf) != -1)
 		tst_brkm(TBROK, cleanup, "shmctl succeeded on expected fail");
-	}

-	if (errno != EINVAL) {
+	if (errno != EINVAL)
 		tst_resm(TFAIL, "returned unexpected errno %d", errno);
-	} else {
+	else
 		tst_resm(TPASS, "shared memory appears to be removed");
-	}

 	shm_id_1 = -1;
 }
@@ -486,7 +439,7 @@ void func_rmid()
 /*
  * sighandler() - handle signals, in this case SIGUSR1 is the only one expected
  */
-void sighandler(sig)
+void sighandler(int sig)
 {
 	if (sig != SIGUSR1)
 		tst_resm(TBROK, "received unexpected signal %d", sig);
@@ -494,37 +447,20 @@ void sighandler(sig)

 void setup(void)
 {
-
 	tst_sig(FORK, sighandler, cleanup);

 	TEST_PAUSE;

-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
 	tst_tmpdir();

-	/* get an IPC resource key */
 	shmkey = getipckey();
 }

-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
 void cleanup(void)
 {
-	/* if it exists, remove the shared memory segment */
 	rm_shm(shm_id_1);

 	tst_rmdir();

-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-
 }
-- 
1.8.1

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
