Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Vw4LU-00069V-9Q
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 06:23:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vw4LS-00065F-4h
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 06:23:00 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBQ6Mm21008554
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 14:22:48 +0800
Message-ID: <52BBCB33.8010904@cn.fujitsu.com>
Date: Thu, 26 Dec 2013 14:22:43 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] semop/semop02.c: cleanup
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
To: ltp-list@lists.sourceforge.net


* Delete some useless commtents.
* Move the test body form main to a new
  semop_verify function.
* Use some SAFE_* macros.
* Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/semop/semop02.c | 175 +++++++++-----------------
 1 file changed, 58 insertions(+), 117 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index b97cc3f..08fc43c 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -18,56 +18,30 @@
  */
 
 /*
- * NAME
- *	semop02.c
- *
  * DESCRIPTION
  *	semop02 - test for E2BIG, EACCES, EFAULT and EINVAL errors
  *
- * ALGORITHM
- *	create a semaphore set with read and alter permissions
- *	create a semaphore set without read and alter permissions
- *	loop if that option was specified
- *	call semop with five different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get E2BIG, EACCES, EFAULT or EINVAL
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  semop02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
  * HISTORY
  *	03/2001 - Written by Wayne Boyer
  *
  *      10/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
  *      - Fix concurrency issue. The second key used for this test could
  *        conflict with the key from another task.
- *
- * RESTRICTIONS
- *	none
  */
-#include <pwd.h>
 
+#include <pwd.h>
+#include "test.h"
+#include "safe_macros.h"
 #include "ipcsem.h"
 
 char *TCID = "semop02";
-int TST_TOTAL = 5;
 
-int exp_enos[] = { E2BIG, EACCES, EFAULT, EINVAL, 0 };
+static void semop_verify(int i);
 
-int sem_id_1 = -1;		/* a semaphore set with read & alter permissions */
-int sem_id_2 = -1;		/* a semaphore set without read & alter permissions */
+static int exp_enos[] = { E2BIG, EACCES, EFAULT, EINVAL, 0 };
+int sem_id_1 = -1;	/* a semaphore set with read & alter permissions */
+int sem_id_2 = -1;	/* a semaphore set without read & alter permissions */
 int bad_id = -1;
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
 
 struct sembuf s_buf[PSEMS];
 
@@ -78,143 +52,110 @@ int badbuf = -1;
 				/* of semop operations that are permitted   */
 
 struct test_case_t {
-	int *semid;		/* the semaphore id */
-	struct sembuf *t_sbuf;	/* the first in an array of sembuf structures */
-	unsigned t_ops;		/* the number of elements in the above array */
-	int error;		/* the expected error number */
+	int *semid;
+	struct sembuf *t_sbuf;
+	unsigned t_ops;
+	int error;
 } TC[] = {
-	/* E2BIG - the number of operations is too big */
-	{
-	&sem_id_1, (struct sembuf *)&s_buf, BIGOPS, E2BIG},
-	    /* EACCES - the semaphore set has no access permission */
-	{
-	&sem_id_2, (struct sembuf *)&s_buf, NSOPS, EACCES},
-	    /* EFAULT - the address for the s_buf value is not accessible */
-	{
-	&sem_id_1, (struct sembuf *)-1, NSOPS, EFAULT},
-	    /* EINVAL - the number of elments (t_ops) is 0 */
-	{
-	&sem_id_1, (struct sembuf *)&s_buf, 0, EINVAL},
-	    /* EINVAL - the semaphore set doesn't exist */
-	{
-	&bad_id, (struct sembuf *)&s_buf, NSOPS, EINVAL}
+	{&sem_id_1, (struct sembuf *)&s_buf, BIGOPS, E2BIG},
+	{&sem_id_2, (struct sembuf *)&s_buf, NSOPS, EACCES},
+	{&sem_id_1, (struct sembuf *)-1, NSOPS, EFAULT},
+	{&sem_id_1, (struct sembuf *)&s_buf, 0, EINVAL},
+	{&bad_id, (struct sembuf *)&s_buf, NSOPS, EINVAL}
 };
 
+int TST_TOTAL = ARRAY_SIZE(TC);
+
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
 	int i;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
-
-	setup();		/* global setup */
 
-	/* The following loop checks looping state if -i option given */
+	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		for (i = 0; i < TST_TOTAL; i++) {
-			/*
-			 * use the TEST macro to make the call
-			 */
-
-			TEST(semop(*(TC[i].semid), TC[i].t_sbuf, TC[i].t_ops));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			}
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			semop_verify(i);
 	}
 
 	cleanup();
-
 	tst_exit();
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
 void setup(void)
 {
+	char nobody_uid[] = "nobody";
+	struct passwd *ltpuser;
 	key_t semkey2;
 
-	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-	ltpuser = getpwnam(nobody_uid);
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setreuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setreuid");
-	}
+	tst_require_root(NULL);
+
+	ltpuser = SAFE_GETPWNAM(NULL, nobody_uid);
+	SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Set up the expected error numbers for -e option */
 	TEST_EXP_ENOS(exp_enos);
 
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
-		tst_brkm(TBROK, cleanup, "couldn't create semaphore in setup");
+	sem_id_1 = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	if (sem_id_1 == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "couldn't create semaphore in setup");
 	}
 
 	/* Get an new IPC resource key. */
 	semkey2 = getipckey();
 
 	/* create a semaphore set without read and alter permissions */
-	if ((sem_id_2 = semget(semkey2, PSEMS, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create semaphore in setup");
+	sem_id_2 = semget(semkey2, PSEMS, IPC_CREAT | IPC_EXCL);
+	if (sem_id_2 == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "couldn't create semaphore in setup");
+	}
+}
+
+static void semop_verify(int i)
+{
+	TEST(semop(*(TC[i].semid), TC[i].t_sbuf, TC[i].t_ops));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "call succeeded unexpectedly");
+		return;
+	}
+
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == TC[i].error) {
+		tst_resm(TPASS | TTERRNO, "semop failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "semop failed unexpectedly; expected: "
+			 "%d - %s", TC[i].error, strerror(TC[i].error));
 	}
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
 void cleanup(void)
 {
 	/* if they exist, remove the semaphore resources */
 	rm_sema(sem_id_1);
 	rm_sema(sem_id_2);
 
-	tst_rmdir();
-
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
+	tst_rmdir();
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
