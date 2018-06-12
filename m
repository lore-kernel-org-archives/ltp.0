From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jun 2018 17:46:28 +0200
Subject: [LTP] [RFC PATCH 6/9] syscalls/ipc: Rewrite + merge msgctl{04, 05}
In-Reply-To: <20180612154631.435-1-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
Message-ID: <20180612154631.435-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/ltplite                                 |   1 -
 runtest/stress.part3                            |   1 -
 runtest/syscalls                                |   1 -
 runtest/syscalls-ipc                            |   1 -
 testcases/kernel/syscalls/ipc/msgctl/.gitignore |   1 -
 testcases/kernel/syscalls/ipc/msgctl/msgctl04.c | 249 ++++++++----------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c | 186 ------------------
 7 files changed, 82 insertions(+), 358 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c

diff --git a/runtest/ltplite b/runtest/ltplite
index cb9517883..d6d1385b4 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -483,7 +483,6 @@ msgctl01 msgctl01
 msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
-msgctl05 msgctl05
 msgctl07 msgctl07
 
 msgget01 msgget01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index e97b08456..e3c308fba 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -399,7 +399,6 @@ msgctl01 msgctl01
 msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
-msgctl05 msgctl05
 msgctl07 msgctl07
 msgstress01 msgstress01
 msgstress02 msgstress02
diff --git a/runtest/syscalls b/runtest/syscalls
index 6b3133776..5692d3e22 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -689,7 +689,6 @@ msgctl01 msgctl01
 msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
-msgctl05 msgctl05
 msgctl07 msgctl07
 msgstress01 msgstress01
 msgstress02 msgstress02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 6cf5853dd..da0d5feea 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -2,7 +2,6 @@ msgctl01 msgctl01
 msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
-msgctl05 msgctl05
 msgctl07 msgctl07
 msgstress01 msgstress01
 msgstress02 msgstress02
diff --git a/testcases/kernel/syscalls/ipc/msgctl/.gitignore b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
index b321f0c35..4289d42dc 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
@@ -2,6 +2,5 @@
 /msgctl02
 /msgctl03
 /msgctl04
-/msgctl05
 /msgctl07
 /msgctl12
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
index 0e8fe9f79..a97a9359a 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
@@ -1,203 +1,118 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *    03/2001 - Written by Wayne Boyer
+ *    12/03/2008 Matthieu Fertré (Matthieu.Fertre@irisa.fr)
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
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
+ * along with this program;  if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * NAME
- *	msgctl04.c
- *
- * DESCRIPTION
- *	msgctl04 - test for EACCES, EFAULT and EINVAL errors using
- *		   a variety of incorrect calls.
- *
- * ALGORITHM
- *	create two message queues
- *	loop if that option was specified
- *	try to access a queue with some invalid argument
- *	check the errno value
- *	  issue a PASS message if we get EACCES, EFAULT or EINVAL
- *	  depending on the test case
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgctl04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *      12/03/2008 Matthieu Fertré (Matthieu.Fertre@irisa.fr)
- *      - Fix concurrency issue. The second key used for this test could
- *        conflict with the key from another task.
- *
- * RESTRICTIONS
- *	none
+ * Test for EACCES, EFAULT and EINVAL errors using a variety of incorrect
+ * calls.
  */
+#include <errno.h>
 #include <pwd.h>
 
-#include "test.h"
-
-#include "ipcmsg.h"
-
-char *TCID = "msgctl04";
-int TST_TOTAL = 6;
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-int msg_q_2 = -1;		/* Another queue id created in setup */
-int bad_q = -1;			/* a value to use as a bad queue id */
+static int msg_id1 = -1;
+static int msg_id2 = -1;
+static int msg_id3 = -1;
+static int bad_q = -1;
 
 struct msqid_ds q_buf;
 
-struct test_case_t {		/* This allows testing of many negative */
-	int *queue_id;		/* test cases that can all use the same */
-	int ipc_cmd;		/* basic test setup.                    */
+struct tcase {
+	int *msg_id;
+	int cmd;
 	struct msqid_ds *buf;
 	int error;
-} TC[] = {
+} tc[] = {
 	/* EACCES - there is no read permission for the queue */
-	{
-	&msg_q_1, IPC_STAT, &q_buf, EACCES},
-	    /* EFAULT - the structure address is invalid - IPC_STAT */
-	{
-	&msg_q_2, IPC_STAT, (struct msqid_ds *)-1, EFAULT},
-	    /* EFAULT - the structure address is invalid - IPC_SET */
-	{
-	&msg_q_2, IPC_SET, (struct msqid_ds *)-1, EFAULT},
-	    /* EINVAL - the command (-1) is invalid */
-	{
-	&msg_q_2, -1, &q_buf, EINVAL},
-	    /* EINVAL - the queue id is invalid - IPC_STAT */
-	{
-	&bad_q, IPC_STAT, &q_buf, EINVAL},
-	    /* EINVAL - the queue id is invalid - IPC_SET */
-	{
-	&bad_q, IPC_SET, &q_buf, EINVAL}
+	{&msg_id1, IPC_STAT, &q_buf, EACCES},
+	/* EFAULT - the structure address is invalid - IPC_STAT */
+	{&msg_id2, IPC_STAT, (struct msqid_ds *)-1, EFAULT},
+	/* EFAULT - the structure address is invalid - IPC_SET */
+	{&msg_id2, IPC_SET, (struct msqid_ds *)-1, EFAULT},
+	/* EINVAL - the command (-1) is invalid */
+	{&msg_id2, -1, &q_buf, EINVAL},
+	/* EINVAL - the queue id is invalid - IPC_STAT */
+	{&bad_q, IPC_STAT, &q_buf, EINVAL},
+	/* EINVAL - the queue id is invalid - IPC_SET */
+	{&bad_q, IPC_SET, &q_buf, EINVAL},
+	/* EPERM - cannot delete root owned queue */
+	{&msg_id3, IPC_RMID, NULL, EPERM},
 };
 
-int main(int ac, char **av)
+static void verify_msgctl(unsigned int i)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* loop through the test cases */
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(msgctl(*(TC[i].queue_id), TC[i].ipc_cmd,
-				    TC[i].buf));
+	TEST(msgctl(*(tc[i].msg_id), tc[i].cmd, tc[i].buf));
 
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "msgctl() call succeeded "
-					 "on expected fail");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS | TTERRNO, "expected failure");
-			} else {
-				tst_resm(TFAIL | TTERRNO, "unexpected error");
-				tst_resm(TINFO, "expected error is - %d : %s",
-					 TC[i].error, strerror(TC[i].error));
-			}
-		}
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "msgctl() returned %li", TEST_RETURN);
+		return;
 	}
 
-	cleanup();
+	if (TEST_ERRNO == tc[i].error) {
+		tst_res(TPASS | TTERRNO, "msgctl(%i, %i, %p)",
+			*tc[i].msg_id, tc[i].cmd, tc[i].buf);
+		return;
+	}
 
-	tst_exit();
+	tst_res(TFAIL | TTERRNO, "msgctl(%i, %i, %p) expected %s",
+		*tc[i].msg_id, tc[i].cmd, tc[i].buf, tst_strerrno(tc[i].error));
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	key_t msgkey2;
-
-	tst_require_root();
+	key_t msgkey1, msgkey2;
+	struct passwd *ltpuser;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	msg_id3 = SAFE_MSGGET(IPC_PRIVATE, IPC_CREAT | MSG_RW);
 
-	TEST_PAUSE;
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(ltpuser->pw_uid);
 
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_resm(TINFO, "setuid(%d) failed", ltpuser->pw_uid);
+	msgkey1 = GETIPCKEY();
+	msgkey2 = GETIPCKEY();
 
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	msgkey = getipckey();
-
-	/* Get an new IPC resource key. */
-	msgkey2 = getipckey();
-
-	/* now we have a key, so let's create a message queue */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Can't create message queue #1");
-	}
-
-	/* now let's create another message queue with read & write access */
-	if ((msg_q_2 =
-	     msgget(msgkey2, IPC_CREAT | IPC_EXCL | MSG_RD | MSG_WR)) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Can't create message queue #2");
-	}
+	msg_id1 = SAFE_MSGGET(msgkey1, IPC_CREAT | IPC_EXCL);
+	msg_id2 = SAFE_MSGGET(msgkey2, IPC_CREAT | IPC_EXCL | MSG_RD | MSG_WR);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * remove the message queues that were created.
-	 */
-	rm_queue(msg_q_1);
+	if (msg_id1 > 0)
+		SAFE_MSGCTL(msg_id1, IPC_RMID, NULL);
 
-	rm_queue(msg_q_2);
-
-	tst_rmdir();
+	if (msg_id2 > 0)
+		SAFE_MSGCTL(msg_id2, IPC_RMID, NULL);
 
+	if (msg_id3 > 0) {
+		SAFE_SETEUID(0);
+		SAFE_MSGCTL(msg_id3, IPC_RMID, NULL);
+	}
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_msgctl,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
deleted file mode 100644
index 632ff8c1f..000000000
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
+++ /dev/null
@@ -1,186 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * NAME
- *	msgctl05.c
- *
- * DESCRIPTION
- *	msgctl05 - test for EPERM error
- *
- * ALGORITHM
- *	create a message queue as root
- *	fork a child process and change its ID to nobody
- *	loop if that option was specified
- *	try to remove the queue in the child process with msgctl()
- *	check the errno value
- *	  issue a PASS message if we get EPERM
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  msgctl05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	The test must be run as root.
- *	There must be a nobody ID installed on the system.
- */
-
-#include <string.h>
-#include <pwd.h>
-#include <sys/wait.h>
-
-#include "test.h"
-
-#include "ipcmsg.h"
-
-char *TCID = "msgctl05";
-int TST_TOTAL = 1;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-uid_t ltp_uid;			/* The user ID for a non root user */
-char *ltp_user = "nobody";	/* A non root user */
-
-struct msqid_ds q_buf;
-
-int main(int ac, char **av)
-{
-	pid_t pid;
-	void do_child(void);
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	if ((pid = FORK_OR_VFORK()) == -1) {
-		tst_brkm(TBROK, cleanup, "could not fork");
-	}
-
-	if (pid == 0) {		/* child */
-		/* set the user ID of the child to nobody */
-		if (setuid(ltp_uid) == -1) {
-			tst_resm(TBROK, "setuid() failed");
-			exit(1);
-		}
-
-		do_child();
-	} else {		/* parent */
-		if (waitpid(pid, NULL, 0) == -1) {
-			tst_resm(TBROK | TERRNO, "waitpid() failed");
-		}
-
-		/* if it exists, remove the message queue */
-		rm_queue(msg_q_1);
-
-		tst_rmdir();
-	}
-
-	cleanup();
-	/**NOT REACHED**/
-	tst_exit();
-}
-
-/*
- * do_child - make the TEST call as the child process
- */
-void do_child(void)
-{
-	int lc;
-	int i;
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* loop through the test cases */
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(msgctl(msg_q_1, IPC_RMID, NULL));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "msgget() call succeeded "
-					 "on expected fail");
-				continue;
-			}
-
-			switch (TEST_ERRNO) {
-			case EPERM:
-				tst_resm(TPASS, "expected error = %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-				break;
-			default:
-				tst_resm(TFAIL, "call failed with unexpected "
-					 "error - %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-				break;
-			}
-		}
-	}
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	msgkey = getipckey();
-
-	/* now we have a key, so let's create a message queue */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue #1");
-	}
-
-	/* get the user ID for a non root user */
-	ltp_uid = getuserid(ltp_user);
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test@completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
-- 
2.13.6

