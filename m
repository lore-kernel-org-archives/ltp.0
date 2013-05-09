Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UaMTf-00056B-HF
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 08:45:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UaMTb-0006PS-VH
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 08:45:26 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r498jCQq011670
	for <ltp-list@lists.sourceforge.net>; Thu, 9 May 2013 16:45:14 +0800
Message-ID: <518B618F.80400@cn.fujitsu.com>
Date: Thu, 09 May 2013 16:42:55 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/2]semctl/semctl01.c: cleanup
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
 testcases/kernel/syscalls/ipc/semctl/semctl01.c | 311 +++++++++---------------
 1 file changed, 117 insertions(+), 194 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index c8957c8..93d7cd7 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
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
@@ -24,32 +23,6 @@
  * DESCRIPTION
  *	semctl01 - test the 10 possible semctl() commands
  *
- * ALGORITHM
- *	create a semaphore set with read and alter permissions
- *	loop if that option was specified
- *	  loop through the test cases
- *	    do any setup required for the test case
- *	    make the semctl() call using the TEST() macro
- *	    check the return code
- *	      if failure, issue a FAIL message.
- *	    otherwise,
- *	      if doing functionality testing
- *		call the appropriate test function
- *	  	if correct,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  semctl01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
  * HISTORY
  *	03/2001 - Written by Wayne Boyer
  *
@@ -57,9 +30,6 @@
  *      - Fix concurrency issue. Due to the use of usleep function to
  *        synchronize processes, synchronization issues can occur on a loaded
  *        system. Fix this by using pipes to synchronize processes.
- *
- * RESTRICTIONS
- *	none
  */

 #include "ipcsem.h"
@@ -68,35 +38,35 @@
 char *TCID = "semctl01";
 int TST_TOTAL = 10;

-int sem_id_1 = -1;		/* a semaphore set with read and alter permissions */
+static int sem_id_1 = -1;

-int sync_pipes[2];
+static int sync_pipes[2];

 /*
  * These are the various setup and check functions for the 10 different
  * commands that are available for the semctl() call.
  */
-void func_stat(void);
-void set_setup(void), func_set(void);
-void func_gall(void);
-void cnt_setup(int), func_cnt(int);
-void pid_setup(void), func_pid(int);
-void gval_setup(void), func_gval(int);
-void sall_setup(void), func_sall(void);
-void func_sval(void);
-void func_rmid(void);
-void child_cnt(void);
-void child_pid(void);
-
-struct semid_ds buf;
-unsigned short array[PSEMS];
-struct sembuf sops;
-
-#define INCVAL 2		/* a semaphore increment value */
+static void func_stat(void);
+static void set_setup(void), func_set(void);
+static void func_gall(void);
+static void cnt_setup(int), func_cnt(int);
+static void pid_setup(void), func_pid(int);
+static void func_gval(int);
+static void sall_setup(void), func_sall(void);
+static void func_sval(void);
+static void func_rmid(void);
+static void child_cnt(void);
+static void child_pid(void);
+
+static struct semid_ds buf;
+static unsigned short array[PSEMS];
+static struct sembuf sops;
+
+#define INCVAL 2
 #define NEWMODE	066
 #define NCHILD	5
-#define SEM2	2		/* semaphore to use for GETPID and GETVAL */
-#define SEM4	4		/* semaphore to use for GETNCNT and GETZCNT */
+#define SEM2	2
+#define SEM4	4
 #define ONE	1
 #ifdef _XLC_COMPILER
 #define SEMUN_CAST
@@ -104,64 +74,54 @@ struct sembuf sops;
 #define SEMUN_CAST (union semun)
 #endif

-#ifdef _XLC_COMPILER
-#define SEMUN_CAST
-#else
-#define SEMUN_CAST (union semun)
-#endif
-
-int pid_arr[NCHILD];
+static int pid_arr[NCHILD];

 #ifdef UCLINUX
 #define PIPE_NAME	"semctl01"
 static char *argv0;
-int sem_op;
+static int sem_op;
 #endif

-struct test_case_t {
-	int semnum;		/* the primitive semaphore to use */
-	int cmd;		/* the command to test */
-	void (*func_test) ();	/* the test function */
+static struct test_case_t {
+	int semnum;
+	int cmd;
+	void (*func_test) ();
 	union semun arg;
-	void (*func_setup) ();	/* the setup function if necessary */
+	void (*func_setup) ();
 } TC[] = {
-	{
-	0, IPC_STAT, func_stat, SEMUN_CAST & buf, NULL}, {
-	0, IPC_SET, func_set, SEMUN_CAST & buf, set_setup}, {
-	0, GETALL, func_gall, SEMUN_CAST array, NULL}, {
-	SEM4, GETNCNT, func_cnt, SEMUN_CAST & buf, cnt_setup}, {
-	SEM2, GETPID, func_pid, SEMUN_CAST & buf, pid_setup}, {
-	SEM2, GETVAL, func_gval, SEMUN_CAST & buf, NULL}, {
-	SEM4, GETZCNT, func_cnt, SEMUN_CAST & buf, cnt_setup}, {
-	0, SETALL, func_sall, SEMUN_CAST array, sall_setup}, {
-	SEM4, SETVAL, func_sval, SEMUN_CAST INCVAL, NULL}, {
-	0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL}
+	{0, IPC_STAT, func_stat, SEMUN_CAST & buf, NULL},
+	{0, IPC_SET, func_set, SEMUN_CAST & buf, set_setup},
+	{0, GETALL, func_gall, SEMUN_CAST array, NULL},
+	{SEM4, GETNCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
+	{SEM2, GETPID, func_pid, SEMUN_CAST & buf, pid_setup},
+	{SEM2, GETVAL, func_gval, SEMUN_CAST & buf, NULL},
+	{SEM4, GETZCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
+	{0, SETALL, func_sall, SEMUN_CAST array, sall_setup},
+	{SEM4, SETVAL, func_sval, SEMUN_CAST INCVAL, NULL},
+	{0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL},
 };

-int main(int ac, char **av)
+int main(int argc, char *argv[])
 {
 	int lc;
 	char *msg;
 	int i, j;

-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
+
 #ifdef UCLINUX
-	argv0 = av[0];
+	argv0 = argv[0];
 	maybe_run_child(&child_pid, "nd", 1, &sem_id_1);
 	maybe_run_child(&child_cnt, "ndd", 2, &sem_id_1, &sem_op);
 #endif

-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+	setup();

 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;

-		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {

 			/*
@@ -182,10 +142,6 @@ int main(int ac, char **av)
 				}
 			}

-			/*
-			 * Use TEST macro to make the call
-			 */
-
 			TEST(semctl(sem_id_1, TC[i].semnum, TC[i].cmd,
 				    TC[i].arg));

@@ -202,9 +158,9 @@ int main(int ac, char **av)
 					 */
 					switch (TC[i].cmd) {
 					case GETNCNT:
-					 /*FALLTHROUGH*/ case GETZCNT:
-					 /*FALLTHROUGH*/ case GETPID:
-					 /*FALLTHROUGH*/ case GETVAL:
+					case GETZCNT:
+					case GETPID:
+					case GETVAL:
 						(*TC[i].func_test)
 						    (TEST_RETURN);
 						break;
@@ -222,12 +178,11 @@ int main(int ac, char **av)
 			 */
 			switch (TC[i].cmd) {
 			case GETNCNT:
-			 /*FALLTHROUGH*/ case GETZCNT:
+			case GETZCNT:
 				for (j = 0; j < NCHILD; j++) {
-					if (kill(pid_arr[j], SIGKILL) == -1) {
+					if (kill(pid_arr[j], SIGKILL) == -1)
 						tst_brkm(TBROK, cleanup,
 							 "child kill failed");
-					}
 				}
 				break;
 			}
@@ -236,39 +191,36 @@ int main(int ac, char **av)
 		 * recreate the semaphore resource if looping
 		 */
 		if (TEST_LOOPING(lc)) {
-			if ((sem_id_1 = semget(semkey, PSEMS,
-					       IPC_CREAT | IPC_EXCL | SEM_RA))
-			    == -1) {
+			sem_id_1 = semget(semkey, PSEMS,
+					  IPC_CREAT | IPC_EXCL | SEM_RA);
+			if (sem_id_1 == -1)
 				tst_brkm(TBROK, cleanup,
 					 "couldn't recreate " "semaphore");
-			}
 		}
 	}

 	cleanup();

 	tst_exit();
-
 }

 /*
  * func_stat() - check the functionality of the IPC_STAT command with semctl()
  */
-void func_stat()
+static void func_stat(void)
 {
 	/* check the number of semaphores and the ipc_perm.mode value */
-	if (buf.sem_nsems == PSEMS && buf.sem_perm.mode == (SEM_RA)) {
+	if (buf.sem_nsems == PSEMS && buf.sem_perm.mode == (SEM_RA))
 		tst_resm(TPASS, "buf.sem_nsems and buf.sem_perm.mode"
 			 " are correct");
-	} else {
+	else
 		tst_resm(TFAIL, "semaphore STAT info is incorrect");
-	}
 }

 /*
  * set_setup() - set up for the IPC_SET command with semctl()
  */
-void set_setup()
+static void set_setup(void)
 {
 	/* set up a new mode for the semaphore set */
 	buf.sem_perm.mode = SEM_RA | NEWMODE;
@@ -277,7 +229,7 @@ void set_setup()
 /*
  * func_set() - check the functionality of the IPC_SET command with semctl()
  */
-void func_set()
+static void func_set(void)
 {
 	/* first stat the semaphore to get the new data */
 	if (semctl(sem_id_1, 0, IPC_STAT, (union semun)&buf) == -1) {
@@ -286,17 +238,16 @@ void func_set()
 	}

 	/* check that the new mode is what we set */
-	if (buf.sem_perm.mode == (SEM_RA | NEWMODE)) {
+	if (buf.sem_perm.mode == (SEM_RA | NEWMODE))
 		tst_resm(TPASS, "buf.sem_perm.mode is correct");
-	} else {
+	else
 		tst_resm(TFAIL, "semaphore mode info is incorrect");
-	}
 }

 /*
  * func_gall() - check the functionality of the GETALL command with semctl()
  */
-void func_gall()
+static void func_gall(void)
 {
 	int i;

@@ -313,7 +264,7 @@ void func_gall()
 /*
  * cnt_setup() - set up for the GETNCNT and GETZCNT commands with semctl()
  */
-void cnt_setup(int opval)
+static void cnt_setup(int opval)
 {
 	int pid, i;

@@ -326,31 +277,31 @@ void cnt_setup(int opval)
 	if (opval == 0) {
 		/* initialize the semaphore value to ONE */
 		sops.sem_op = ONE;
-		if (semop(sem_id_1, &sops, 1) == -1) {
+		if (semop(sem_id_1, &sops, 1) == -1)
 			tst_brkm(TBROK, cleanup, "semop #1 failed - cnt_setup");
-		}
 	}

-	sops.sem_op = opval;	/* set the correct operation */
+	/* set the correct operation */
+	sops.sem_op = opval;
 	for (i = 0; i < NCHILD; i++) {
 		if (sync_pipe_create(sync_pipes, PIPE_NAME) == -1)
 			tst_brkm(TBROK, cleanup, "sync_pipe_create failed");

 		/* fork five children to wait */
-		if ((pid = FORK_OR_VFORK()) == -1)
+		pid = FORK_OR_VFORK();
+		if (pid == -1)
 			tst_brkm(TBROK, cleanup, "fork failed in cnt_setup");

-		if (pid == 0) {	/* child */
+		if (pid == 0) {
 #ifdef UCLINUX
 			sem_op = sops.sem_op;
-			if (self_exec(argv0, "ndd", 2, sem_id_1, sem_op) < 0) {
+			if (self_exec(argv0, "ndd", 2, sem_id_1, sem_op) < 0)
 				tst_brkm(TBROK, cleanup, "self_exec failed "
 					 "in cnt_setup");
-			}
 #else
 			child_cnt();
 #endif
-		} else {	/* parent */
+		} else {
 			if (sync_pipe_wait(sync_pipes) == -1)
 				tst_brkm(TBROK, cleanup,
 					 "sync_pipe_wait failed");
@@ -370,7 +321,7 @@ void cnt_setup(int opval)
 	sleep(1);
 }

-void child_cnt()
+static void child_cnt(void)
 {
 #ifdef UCLINUX
 	sops.sem_op = (short int)sem_op;
@@ -397,9 +348,9 @@ void child_cnt()
 	 * routine which should cause an error to be return
 	 * by the semop() call.
 	 */
-	if (semop(sem_id_1, &sops, 1) != -1) {
+	if (semop(sem_id_1, &sops, 1) != -1)
 		tst_resm(TBROK, "semop succeeded - cnt_setup");
-	}
+
 	exit(0);
 }

@@ -407,40 +358,37 @@ void child_cnt()
  * func_cnt() - check the functionality of the GETNCNT and GETZCNT commands
  *	        with semctl()
  */
-void func_cnt(int rval)
+static void func_cnt(int rval)
 {

-	if (rval == NCHILD) {
+	if (rval == NCHILD)
 		tst_resm(TPASS, "number of sleeping processes is correct");
-	} else {
+	else
 		tst_resm(TFAIL, "number of sleeping processes is not correct");
-	}
 }

 /*
  * pid_setup() - set up for the GETPID command with semctl()
  */
-void pid_setup()
+static void pid_setup(void)
 {
 	int pid;

-	if (sync_pipe_create(sync_pipes, PIPE_NAME) == -1) {
+	if (sync_pipe_create(sync_pipes, PIPE_NAME) == -1)
 		tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
-	}

 	/*
 	 * Fork a child to do a semop that will pass.
 	 */
-	if ((pid = FORK_OR_VFORK()) == -1) {
+	pid = FORK_OR_VFORK();
+	if (pid == -1)
 		tst_brkm(TBROK, cleanup, "fork failed in pid_setup()");
-	}

 	if (pid == 0) {		/* child */
 #ifdef UCLINUX
-		if (self_exec(argv0, "nd", 1, sem_id_1) < 0) {
+		if (self_exec(argv0, "nd", 1, sem_id_1) < 0)
 			tst_brkm(TBROK, cleanup, "self_exec failed "
 				 "in pid_setup()");
-		}
 #else
 		child_pid();
 #endif
@@ -455,7 +403,7 @@ void pid_setup()
 	}
 }

-void child_pid()
+static void child_pid(void)
 {
 #ifdef UCLINUX
 	if (sync_pipe_create(sync_pipes, PIPE_NAME) == -1)
@@ -468,53 +416,50 @@ void child_pid()
 	if (sync_pipe_close(sync_pipes, PIPE_NAME) == -1)
 		tst_brkm(TBROK, cleanup, "sync_pipe_close failed");

-	sops.sem_num = SEM2;	/* semaphore to change */
-	sops.sem_op = ONE;	/* operation is to increment semaphore */
+	sops.sem_num = SEM2;
+	sops.sem_op = ONE;
 	sops.sem_flg = 0;

 	/*
 	 * Do a semop that will increment the semaphore.
 	 */
-	if (semop(sem_id_1, &sops, 1) == -1) {
+	if (semop(sem_id_1, &sops, 1) == -1)
 		tst_resm(TBROK, "semop failed - pid_setup");
-	}
+
 	exit(0);
 }

 /*
  * func_pid() - check the functionality of the GETPID command with semctl()
  */
-void func_pid(int rval)
+static void func_pid(int rval)
 {
 	/* compare the rval (pid) to the saved pid from the setup */
-	if (rval == pid_arr[SEM2]) {
+	if (rval == pid_arr[SEM2])
 		tst_resm(TPASS, "last pid value is correct");
-	} else {
+	else
 		tst_resm(TFAIL, "last pid value is not correct");
-	}
 }

 /*
  * func_gval() - check the functionality of the GETVAL command with semctl()
  */
-void func_gval(int rval)
+static void func_gval(int rval)
 {
 	/*
 	 * This is a simple test.  The semaphore value should be equal
 	 * to ONE as it was set in the last test (GETPID).
 	 */
-	if (rval == 1) {
+	if (rval == 1)
 		tst_resm(TPASS, "semaphore value is correct");
-	} else {
+	else
 		tst_resm(TFAIL, "semaphore value is not correct");
-	}
-
 }

 /*
  * all_setup() - set up for the SETALL command with semctl()
  */
-void sall_setup()
+static void sall_setup(void)
 {
 	int i;

@@ -527,7 +472,7 @@ void sall_setup()
 /*
  * func_sall() - check the functionality of the SETALL command with semctl()
  */
-void func_sall()
+static void func_sall(void)
 {
 	int i;
 	unsigned short rarray[PSEMS];
@@ -536,9 +481,8 @@ void func_sall()
 	 * do a GETALL and compare the values to those set above
 	 */

-	if (semctl(sem_id_1, 0, GETALL, (union semun)rarray) == -1) {
+	if (semctl(sem_id_1, 0, GETALL, (union semun)rarray) == -1)
 		tst_brkm(TBROK, cleanup, "semctl failed in func_sall");
-	}

 	for (i = 0; i < PSEMS; i++) {
 		if (array[i] != rarray[i]) {
@@ -553,7 +497,7 @@ void func_sall()
 /*
  * func_sval() - check the functionality of the SETVAL command with semctl()
  */
-void func_sval()
+static void func_sval(void)
 {
 	int semv;
 	union semun arr;
@@ -562,42 +506,36 @@ void func_sval()
 	 * do a GETVAL and compare it to the value set above
 	 */

-	if ((semv = semctl(sem_id_1, SEM4, GETVAL, arr)) == -1) {
+	semv = semctl(sem_id_1, SEM4, GETVAL, arr);
+	if (semv == -1)
 		tst_brkm(TBROK, cleanup, "semctl failed in func_sval");
-	}

-	if (semv != INCVAL) {
+	if (semv != INCVAL)
 		tst_resm(TFAIL, "semaphore value is not what was set");
-	} else {
+	else
 		tst_resm(TPASS, "semaphore value is correct");
-	}
 }

 /*
  * func_rmid() - check the functionality of the IPC_RMID command with semctl()
  */
-void func_rmid()
+static void func_rmid(void)
 {

 	/*
 	 * do a semop() - we should get EINVAL
 	 */
-	if (semop(sem_id_1, &sops, 1) != -1) {
+	if (semop(sem_id_1, &sops, 1) != -1)
 		tst_resm(TFAIL, "semop succeeded on expected fail");
-	}

-	if (errno != EINVAL) {
+	if (errno != EINVAL)
 		tst_resm(TFAIL, "returned errno - %d - is not expected", errno);
-	} else {
+	else
 		tst_resm(TPASS, "semaphore appears to be removed");
-	}

 	sem_id_1 = -1;
 }

-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
 void setup(void)
 {

@@ -605,27 +543,17 @@ void setup(void)

 	TEST_PAUSE;

-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
 	tst_tmpdir();

 	/* get an IPC resource key */
 	semkey = getipckey();

 	/* create a semaphore set with read and alter permissions */
-	if ((sem_id_1 =
-	     semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA)) == -1) {
+	sem_id_1 = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	if (sem_id_1 == -1)
 		tst_brkm(TBROK, cleanup, "couldn't create semaphore in setup");
-	}
 }

-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
 void cleanup(void)
 {
 	/* if it exists, remove the semaphore resource */
@@ -633,10 +561,5 @@ void cleanup(void)

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
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
