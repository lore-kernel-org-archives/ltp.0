From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 7 Dec 2016 13:16:39 +0800
Subject: [LTP] [PATCH v2 4/5] ipc/msgget02.c: reconstruct && convert to new
	API
In-Reply-To: <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161123135513.GI3346@rei.lan>
 <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1481087800-20639-4-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) merge msgget04 into msgget02
2) take use of some SAFE Marcos

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                 |   1 -
 runtest/stress.part3                            |   1 -
 runtest/syscalls                                |   1 -
 runtest/syscalls-ipc                            |   1 -
 testcases/kernel/syscalls/.gitignore            |   1 -
 testcases/kernel/syscalls/ipc/msgget/msgget02.c | 235 +++++++++---------------
 testcases/kernel/syscalls/ipc/msgget/msgget04.c | 169 -----------------
 7 files changed, 90 insertions(+), 319 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/msgget/msgget04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index a05d3ed..53e5999 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -503,7 +503,6 @@ msgctl09 msgctl09
 msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
-msgget04 msgget04
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 274c8a4..8ff228d 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -419,7 +419,6 @@ msgctl09 msgctl09
 msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
-msgget04 msgget04
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
diff --git a/runtest/syscalls b/runtest/syscalls
index e9d7401..feafa3e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -682,7 +682,6 @@ msgctl13 msgctl13
 msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
-msgget04 msgget04
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 5592a00..8212222 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -15,7 +15,6 @@ msgctl13 msgctl13
 msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
-msgget04 msgget04
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 63179fe..a490bf9 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -405,7 +405,6 @@
 /ipc/msgget/msgget01
 /ipc/msgget/msgget02
 /ipc/msgget/msgget03
-/ipc/msgget/msgget04
 /ipc/msgrcv/msgrcv01
 /ipc/msgrcv/msgrcv02
 /ipc/msgrcv/msgrcv03
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index be9bc61..66484fc 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -1,176 +1,121 @@
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
+ * along with this program.
  */
 
 /*
- * NAME
- *	msgget02.c
- *
  * DESCRIPTION
- *	msgget02 - test for EEXIST and ENOENT errors
- *
- * ALGORITHM
- *	create a message queue
- *	loop if that option was specified
- *	try to recreate the same queue - test #1
- *	try to access a queue that doesn't exist - tests #2 & #3
- *	check the errno value
- *	  issue a PASS message if we get EEXIST or ENOENT depening on test
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  msgget02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
+ * 1) msgget(2) fails if a message queue exists for key and msgflg
+ *    specified both IPC_CREAT and IPC_EXCL.
+ * 2) msgget(2) fails if no message queue exists for key and msgflg
+ *    did not specify IPC_CREAT.
+ * 3) msgget(2) fails if a message queue exists for key, but the
+ *    calling process does not have permission to access the queue,
+ *    and does not have the CAP_IPC_OWNER capability.
  *
- *      28/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix concurrency issue. The second key used for this test was
- *        sometime conflicting with the key from another task.
- *        Generate a valid second key through getipckey to avoid conflicts.
- *
- * RESTRICTIONS
- *	none
  */
-
-#include "test.h"
-
-#include "ipcmsg.h"
-
-char *TCID = "msgget02";
-int TST_TOTAL = 3;
-
-struct test_case_t {
-	int error;
-	int msgkey;
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <pwd.h>
+
+#include "libnewipc.h"
+#include "tst_test.h"
+
+static key_t msgkey, msgkey1;
+static int msg_q_1 = -1;
+static struct passwd *pw;
+
+static struct tcase {
+	int *key;
 	int flags;
-} TC[] = {
-	{
-	EEXIST, 0, IPC_CREAT | IPC_EXCL}, {
-	ENOENT, 1, IPC_PRIVATE}, {
-	ENOENT, 1, IPC_EXCL}
+	int exp_err;
+	/*1: nobody expected  0: root expected */
+	int exp_user;
+} tcases[] = {
+	{&msgkey, IPC_CREAT | IPC_EXCL, EEXIST, 0},
+	{&msgkey1, IPC_PRIVATE, ENOENT, 0},
+	{&msgkey1, IPC_EXCL, ENOENT, 0},
+	{&msgkey, MSG_RD, EACCES, 1},
+	{&msgkey, MSG_WR, EACCES, 1},
+	{&msgkey, MSG_RD | MSG_WR, EACCES, 1}
 };
 
-key_t msgkey1;
-int msg_q_1 = -1;		/* The message queue id created in setup */
-
-int main(int ac, char **av)
+static void verify_msgget(struct tcase *tc)
 {
-	int lc;
-	int i;
-	key_t key;
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
-			if (TC[i].msgkey == 0)
-				key = msgkey;
-			else
-				key = msgkey1;
+	TEST(msgget(*tc->key, tc->flags));
 
-			TEST(msgget(key, TC[i].flags));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "msgget() succeeded unexpectedly");
+		return;
+	}
 
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "msgget() call succeeded "
-					 "on expected fail");
-				continue;
-			}
+	if (TEST_ERRNO == tc->exp_err)
+		tst_res(TPASS | TTERRNO, "msgget() failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "msgget() failed unexpectedly,"
+			" expected %s", tst_strerrno(tc->exp_err));
+}
 
-			switch (TEST_ERRNO) {
-			case ENOENT:
-			 /*FALLTHROUGH*/ case EEXIST:
-				if (TEST_ERRNO == TC[i].error) {
-					tst_resm(TPASS, "expected failure - "
-						 "errno = %d : %s", TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-					break;
-				}
-			/*FALLTHROUGH*/ default:
-				tst_resm(TFAIL, "call failed with an "
-					 "unexpected error - %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-				break;
-			}
+static void do_test(unsigned int n)
+{
+	pid_t pid;
+	struct tcase *tc = &tcases[n];
+
+	if (tc->exp_user == 0) {
+		verify_msgget(tc);
+	} else {
+		pid = SAFE_FORK();
+		if (pid) {
+			tst_reap_children();
+		} else {
+			SAFE_SETUID(pw->pw_uid);
+			verify_msgget(tc);
+			exit(0);
 		}
 	}
-
-	cleanup();
-
-	tst_exit();
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
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
 	msgkey = getipckey();
 	msgkey1 = getipckey();
 
-	/* now we have a key, so let's create a message queue */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL)) == -1) {
-		system("ipcs > /tmp/toto");
-		system("ps -aux >> /tmp/toto");
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
-	}
+	msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL);
+	if (msg_q_1 == -1)
+		tst_brk(TBROK | TERRNO, "Can't create message queue");
+
+	pw = SAFE_GETPWNAM("nobody");
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if it exists, remove the message queue that was created. */
 	rm_queue(msg_q_1);
 
-	tst_rmdir();
-
+	msg_q_1 = -1;
 }
+
+static struct tst_test test = {
+	.tid = "msgget02",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = do_test
+};
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
deleted file mode 100644
index 22f8b38..0000000
--- a/testcases/kernel/syscalls/ipc/msgget/msgget04.c
+++ /dev/null
@@ -1,169 +0,0 @@
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
- *	msgget04.c
- *
- * DESCRIPTION
- *	msgget04 - test for an EACCES error by creating a message queue
- *		   with no read or write permission and then attempting
- *		   to access it with various permissions.
- *
- * ALGORITHM
- *	Create a message queue with no read or write permission
- *	loop if that option was specified
- *	Try to access the message queue with various permissions
- *	check the errno value
- *	  issue a PASS message if we get EACCES
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  msgget04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *	none
- */
-#include <pwd.h>
-#include "test.h"
-
-#include "ipcmsg.h"
-
-char *TCID = "msgget04";
-int TST_TOTAL = 3;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int msg_q_1 = -1;		/* to hold the message queue id */
-
-int test_flags[] = { MSG_RD, MSG_WR, MSG_RD | MSG_WR };
-
-int main(int ac, char **av)
-{
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
-			/*
-			 * Try to access the message queue with specified
-			 * permissions.
-			 */
-
-			TEST(msgget(msgkey, test_flags[i]));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded "
-					 "when EACCES error expected");
-				continue;
-			}
-
-			switch (TEST_ERRNO) {
-			case EACCES:
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-				break;
-			default:
-				tst_resm(TFAIL, "call failed with an "
-					 "unexpected error - %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-				break;
-			}
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
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
-	/*
-	 * Create the message queue without specifying permissions.
-	 */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create message queue"
-			 " - errno = %d : %s", errno, strerror(errno));
-	}
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-	/* if it exists, remove the message queue */
-	rm_queue(msg_q_1);
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



