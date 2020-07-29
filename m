From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jul 2020 13:25:50 +0530
Subject: [LTP] [PATCH V8 2/5] syscalls: semop: Do code cleanup
In-Reply-To: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
References: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
Message-ID: <0b21c4b180da1679a4cbe6233634028a01514c43.1596008484.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This gets rid of not so useful stuff like unnecessary comments and
uClinux support which isn't used anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/ipc/semop/semop01.c |  46 +----------
 testcases/kernel/syscalls/ipc/semop/semop02.c |  31 +++-----
 testcases/kernel/syscalls/ipc/semop/semop03.c |  49 +-----------
 testcases/kernel/syscalls/ipc/semop/semop04.c |  50 ++----------
 testcases/kernel/syscalls/ipc/semop/semop05.c | 105 ++------------------------
 5 files changed, 31 insertions(+), 250 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/ipc/semop/semop01.c
index bcb45fa69320..19607ee6d653 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop01.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
@@ -1,39 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Copyright (c) International Business Machines  Corp., 2001 */
-
 /*
- * NAME
- *	semop01.c
- *
- * DESCRIPTION
- *	semop01 - test that semop() basic functionality is correct
- *
- * ALGORITHM
- *	create a semaphore set and initialize some values
- *	loop if that option was specified
- *	call semop() to set values for the primitive semaphores
- *	check the return code
- *	  if failure, issue a FAIL message.
- *	otherwise,
- *	  if doing functionality testing
- *		get the semaphore values and compare with expected values
- *		if correct,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	  else issue a PASS message
- *	call cleanup
+ * Test that semop() basic functionality is correct
  *
- * HISTORY
- *	03/2001  - Written by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ *	03/2001 - Written by Wayne Boyer
  *	17/01/02 - Modified. Manoj Iyer, IBM Austin. TX. manjo@austin.ibm.com
- *	           4th argument to semctl() system call was modified according
- *	           to man pages.
- *	           In my opinion The test should not even have compiled but
- *	           it was working due to some mysterious reason.
- *
- * RESTRICTIONS
- *	none
  */
 
 #include <stdlib.h>
@@ -57,14 +28,9 @@ static void run(void)
 	int i;
 
 	TEST(semop(sem_id, sops, NSEMS));
-
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "semop() failed");
 	} else {
-		/*
-		 * Get the values and make sure they are the same as what was
-		 * set
-		 */
 		if (semctl(sem_id, 0, GETALL, get_arr) == -1) {
 			tst_brk(TBROK | TERRNO, "semctl() failed in functional test");
 		}
@@ -80,13 +46,9 @@ static void run(void)
 			tst_res(TPASS, "semaphore values are correct");
 	}
 
-	/*
-	 * clean up things in case we are looping
-	 */
 	for (i = 0; i < NSEMS; i++) {
-		if (semctl(sem_id, i, SETVAL, arr) == -1) {
+		if (semctl(sem_id, i, SETVAL, arr) == -1)
 			tst_brk(TBROK | TERRNO, "semctl failed");
-		}
 	}
 }
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index f24d284776a4..66b0bef56257 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -1,16 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Copyright (c) International Business Machines  Corp., 2001 */
-
 /*
- * DESCRIPTION
- *	semop02 - test for E2BIG, EACCES, EFAULT, EINVAL and ERANGE errors
+ * semop02 - test for E2BIG, EACCES, EFAULT, EINVAL and ERANGE errors
  *
- * HISTORY
+ * Copyright (c) International Business Machines  Corp., 2001
  *	03/2001 - Written by Wayne Boyer
- *
- *      10/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix concurrency issue. The second key used for this test could
- *        conflict with the key from another task.
+ *	10/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
  */
 
 #define _GNU_SOURCE
@@ -27,21 +21,21 @@ static int bad_id = -1;
 static key_t semkey;
 static struct sembuf s_buf[PSEMS];
 
-#define NSOPS	5		/* a resonable number of operations */
+#define NSOPS	5		/* a reasonable number of operations */
 #define	BIGOPS	1024		/* a value that is too large for the number */
-				/* of semop operations that are permitted   */
+				/* of semop operations that are permitted */
 static struct test_case_t {
 	int *semid;
 	struct sembuf *t_sbuf;
 	unsigned t_ops;
 	int error;
 } tc[] = {
-	{&sem_id_1, (struct sembuf *)&s_buf, BIGOPS, E2BIG},
-	{&sem_id_2, (struct sembuf *)&s_buf, NSOPS, EACCES},
+	{&sem_id_1, s_buf, BIGOPS, E2BIG},
+	{&sem_id_2, s_buf, NSOPS, EACCES},
 	{&sem_id_1, (struct sembuf *)-1, NSOPS, EFAULT},
-	{&sem_id_1, (struct sembuf *)&s_buf, 0, EINVAL},
-	{&bad_id, (struct sembuf *)&s_buf, NSOPS, EINVAL},
-	{&sem_id_1, (struct sembuf *)&s_buf, 1, ERANGE}
+	{&sem_id_1, s_buf, 0, EINVAL},
+	{&bad_id, s_buf, NSOPS, EINVAL},
+	{&sem_id_1, s_buf, 1, ERANGE}
 };
 
 static void setup(void)
@@ -55,18 +49,14 @@ static void setup(void)
 	ltpuser = SAFE_GETPWNAM(nobody_uid);
 	SAFE_SETUID(ltpuser->pw_uid);
 
-	/* get an IPC resource key */
 	semkey = GETIPCKEY();
 
-	/* create a semaphore set with read and alter permissions */
 	sem_id_1 = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
 	if (sem_id_1 == -1)
 		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
 
-	/* Get an new IPC resource key. */
 	semkey2 = GETIPCKEY();
 
-	/* create a semaphore set without read and alter permissions */
 	sem_id_2 = semget(semkey2, PSEMS, IPC_CREAT | IPC_EXCL);
 	if (sem_id_2 == -1)
 		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
@@ -75,7 +65,6 @@ static void setup(void)
 	if (semctl(sem_id_1, 0, IPC_INFO, arr) == -1)
 		tst_brk(TBROK | TERRNO, "semctl() IPC_INFO failed");
 
-	/* for ERANGE errno test */
 	arr.val = 1;
 	s_buf[0].sem_op = ipc_buf.semvmx;
 	if (semctl(sem_id_1, 0, SETVAL, arr) == -1)
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
index 4f5f78eb6d8d..c569033eebc2 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
@@ -1,37 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Copyright (c) International Business Machines  Corp., 2001 */
-
 /*
- * NAME
- *	semop03.c
- *
- * DESCRIPTION
- *	semop03 - test for EFBIG error
- *
- * ALGORITHM
- *	create a semaphore set with read and alter permissions
- *	loop if that option was specified
- *	call semop() using two different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get EFBIG
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  semop03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
+ * semop03 - test for EFBIG error
  *
- * HISTORY
+ * Copyright (c) International Business Machines  Corp., 2001
  *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
  */
 
 #include <sys/sem.h>
@@ -47,22 +19,11 @@ static int tc[] = { -1, PSEMS + 1 }; /* negative and too many "primitive" semas
 
 static void run(unsigned int i)
 {
-	/* initialize two fields in the sembuf structure here */
-	s_buf.sem_op = 1;	/* add this value to struct sem.semval */
-	s_buf.sem_flg = SEM_UNDO;	/* undo when process exits */
-
-	/*
-	 * initialize the last field in the sembuf structure to the test
-	 * dependent value.
-	 */
+	s_buf.sem_op = 1;
+	s_buf.sem_flg = SEM_UNDO;
 	s_buf.sem_num = tc[i];
 
-	/*
-	 * use the TEST macro to make the call
-	 */
-
 	TEST(semop(sem_id, &s_buf, 1));
-
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
 		return;
@@ -80,10 +41,8 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
-	/* get an IPC resource key */
 	semkey = GETIPCKEY();
 
-	/* create a semaphore with read and alter permissions */
 	if ((sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA)) ==
 	    -1)
 		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
index 0faf00a3585f..1904b177f71b 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop04.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
@@ -1,37 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Copyright (c) International Business Machines  Corp., 2001 */
-
 /*
- * NAME
- *	semop04.c
- *
- * DESCRIPTION
- *	semop04 - test for EAGAIN error
- *
- * ALGORITHM
- *	create a semaphore set with read and alter permissions
- *	loop if that option was specified
- *	call semop() with two different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get EAGAIN
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
+ * semop04 - test for EAGAIN error
  *
- * USAGE:  <for command-line>
- *  semop04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
+ * Copyright (c) International Business Machines  Corp., 2001
  *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
  */
 
 #include <sys/sem.h>
@@ -40,7 +12,7 @@
 #include "lapi/semun.h"
 
 static int sem_id = -1;
-static int val; /* value for SETVAL */
+static int val;
 
 static key_t semkey;
 static struct sembuf s_buf;
@@ -52,22 +24,16 @@ static struct test_case_t {
 	short num;
 	int error;
 } tc[] = {
-	/* EAGAIN sem_op = 0 */
-	{ {
-	1}, 0, IPC_NOWAIT, 2, EAGAIN},
-	    /* EAGAIN sem_op = -1 */
-	{ {
-	0}, -1, IPC_NOWAIT, 2, EAGAIN}
+	{{1}, 0, IPC_NOWAIT, 2, EAGAIN},
+	{{0}, -1, IPC_NOWAIT, 2, EAGAIN}
 };
 
 static void run(unsigned int i)
 {
-	/* initialize the s_buf buffer */
 	s_buf.sem_op = tc[i].op;
 	s_buf.sem_flg = tc[i].flg;
 	s_buf.sem_num = tc[i].num;
 
-	/* initialize all the primitive semaphores */
 	tc[i].get_arr.val = val--;
 	if (semctl(sem_id, tc[i].num, SETVAL, tc[i].get_arr) == -1)
 		tst_brk(TBROK | TERRNO, "semctl() failed");
@@ -87,14 +53,8 @@ static void run(unsigned int i)
 static void setup(void)
 {
 	val = 1;
-
-	/* get an IPC resource key */
 	semkey = GETIPCKEY();
 
-	/*
-	 * create a semaphore set with read and alter permissions and PSEMS
-	 * "primitive" semaphores.
-	 */
 	if ((sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA)) ==
 	     -1) {
 		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c b/testcases/kernel/syscalls/ipc/semop/semop05.c
index 9e8e040b0b19..df8ce7d16ee5 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop05.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop05.c
@@ -1,47 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Copyright (c) International Business Machines  Corp., 2001 */
-
 /*
- * NAME
- *	semop05.c
- *
- * DESCRIPTION
- *	semop05 - test for EINTR and EIDRM errors
- *
- * ALGORITHM
- *	create a semaphore set with read and alter permissions
- *	loop if that option was specified
- *	set up the s_buf buffer
- *	initialize the primitive semaphores
- *	fork a child process
- *	child calls semop() and sleeps
- *	parent either removes the semaphore set or sends a signal to the child
- *	parent then exits
- *	child gets a return from the semop() call
- *	check the errno value
- *	  issue a PASS message if we get EINTR or EIDRM
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
+ * semop05 - test for EINTR and EIDRM errors
  *
- * USAGE:  <for command-line>
- *  semop05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
+ * Copyright (c) International Business Machines  Corp., 2001
  *	03/2001 - Written by Wayne Boyer
- *      14/03/2008 Matthieu Fertr? (Matthieu.Fertre@irisa.fr)
- *      - Fix concurrency issue. Due to the use of usleep function to
- *        synchronize processes, synchronization issues can occur on a loaded
- *        system. Fix this by using pipes to synchronize processes.
- *
- * RESTRICTIONS
- *	none
+ *	14/03/2008 Matthieu Fertr? (Matthieu.Fertre@irisa.fr)
  */
 
 #include <stdio.h>
@@ -64,26 +27,12 @@ struct test_case_t {
 	short num;
 	int error;
 } tc[] = {
-	/* EIRDM sem_op = 0 */
-	{ {
-	1}, 0, 0, 2, EIDRM},
-	    /* EIRDM sem_op = -1 */
-	{ {
-	0}, -1, 0, 3, EIDRM},
-	    /* EINTR sem_op = 0 */
-	{ {
-	1}, 0, 0, 4, EINTR},
-	    /* EINTR sem_op = -1 */
-	{ {
-	0}, -1, 0, 5, EINTR}
+	{{1}, 0, 0, 2, EIDRM},
+	{{0}, -1, 0, 3, EIDRM},
+	{{1}, 0, 0, 4, EINTR},
+	{{0}, -1, 0, 5, EINTR}
 };
 
-#ifdef UCLINUX
-#define PIPE_NAME	"semop05"
-static void do_child_uclinux();
-static int i_uclinux;
-#endif
-
 static inline int process_state_wait2(pid_t pid, const char state)
 {
 	char proc_path[128], cur_state;
@@ -138,14 +87,8 @@ static void sighandler(int sig)
 static void setup(void)
 {
 	SAFE_SIGNAL(SIGHUP, sighandler);
-
-	/* get an IPC resource key */
 	semkey = GETIPCKEY();
 
-	/*
-	 * create a semaphore set with read and alter permissions and PSEMS
-	 * "primitive" semaphores.
-	 */
 	if ((sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA)) ==
 	    -1)
 		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
@@ -165,27 +108,17 @@ static void run(unsigned int i)
 {
 	pid_t pid;
 
-#ifdef UCLINUX
-	maybe_run_child(&do_child_uclinux, "dd", &i_uclinux, &sem_id);
-#endif
-	/* initialize the s_buf buffer */
 	s_buf.sem_op = tc[i].op;
 	s_buf.sem_flg = tc[i].flg;
 	s_buf.sem_num = tc[i].num;
 
-	/* initialize all of the primitive semaphores */
 	if (semctl(sem_id, tc[i].num, SETVAL, tc[i].semunptr) == -1)
 		tst_brk(TBROK | TERRNO, "semctl() failed");
 
 	pid = SAFE_FORK();
 
-	if (pid == 0) {	/* child */
-#ifdef UCLINUX
-		if (self_exec(av[0], "dd", i, sem_id) < 0)
-			tst_brk(TBROK, "could not self_exec");
-#else
+	if (pid == 0) {
 		do_child(i);
-#endif
 	} else {
 		process_state_wait2(pid, 'S');
 
@@ -202,13 +135,9 @@ static void run(unsigned int i)
 			SAFE_KILL(pid, SIGHUP);
 		}
 
-		/* let the child carry on */
 		waitpid(pid, NULL, 0);
 	}
 
-	/*
-	 * recreate the semaphore resource if needed
-	 */
 	if (tc[i].error == EINTR)
 		return;
 
@@ -217,24 +146,6 @@ static void run(unsigned int i)
 		tst_brk(TBROK | TERRNO, "couldn't recreate semaphore");
 }
 
-#ifdef UCLINUX
-/*
- * do_child_uclinux() - capture signals, re-initialize s_buf then call do_child
- *                      with the appropriate argument
- */
-static void do_child_uclinux(void)
-{
-	int i = i_uclinux;
-
-	/* initialize the s_buf buffer */
-	s_buf.sem_op = tc[i].op;
-	s_buf.sem_flg = tc[i].flg;
-	s_buf.sem_num = tc[i].num;
-
-	do_child(i);
-}
-#endif
-
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
-- 
2.14.1

