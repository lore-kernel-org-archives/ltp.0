From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 23 Jan 2017 18:31:16 +0800
Subject: [LTP] [PATCH v2 3/3] ipc/msgsnd0*: cleanup && convert to new API
In-Reply-To: <1485167476-18151-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170119143903.GC9193@rei.lan>
 <1485167476-18151-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1485167476-18151-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

1) The msgsnd03 was merged into msgsnd02
2) The msgsnd04 was merged into msgsnd05
3) take use of IPC related macros

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                    |   2 -
 runtest/stress.part3                               |   2 -
 runtest/syscalls                                   |   2 -
 runtest/syscalls-ipc                               |   2 -
 testcases/kernel/syscalls/.gitignore               |   2 -
 .../kernel/syscalls/ipc/msgsnd/.msgsnd02.c.swo     | Bin 0 -> 12288 bytes
 testcases/kernel/syscalls/ipc/msgsnd/Makefile      |  29 ++-
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c    | 196 ++++----------
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c    | 255 ++++++++----------
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c    | 178 -------------
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c    | 155 -----------
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c    | 287 +++++++--------------
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c    | 252 +++++-------------
 13 files changed, 326 insertions(+), 1036 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/msgsnd/.msgsnd02.c.swo
 delete mode 100644 testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c
 delete mode 100644 testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 83141d1..d4580ad 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -514,8 +514,6 @@ msgrcv08 msgrcv08
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
-msgsnd03 msgsnd03
-msgsnd04 msgsnd04
 msgsnd05 msgsnd05
 msgsnd06 msgsnd06
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index fcf27d0..41f8b25 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -429,8 +429,6 @@ msgrcv07 msgrcv07
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
-msgsnd03 msgsnd03
-msgsnd04 msgsnd04
 msgsnd05 msgsnd05
 msgsnd06 msgsnd06
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 884ab80..dd9f9a9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -693,8 +693,6 @@ msgrcv08 msgrcv08
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
-msgsnd03 msgsnd03
-msgsnd04 msgsnd04
 msgsnd05 msgsnd05
 msgsnd06 msgsnd06
 
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 8212222..91060b9 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -27,8 +27,6 @@ msgrcv08 msgrcv08
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
-msgsnd03 msgsnd03
-msgsnd04 msgsnd04
 msgsnd05 msgsnd05
 msgsnd06 msgsnd06
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 3201fa9..84c7977 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -414,8 +414,6 @@
 /ipc/msgrcv/msgrcv08
 /ipc/msgsnd/msgsnd01
 /ipc/msgsnd/msgsnd02
-/ipc/msgsnd/msgsnd03
-/ipc/msgsnd/msgsnd04
 /ipc/msgsnd/msgsnd05
 /ipc/msgsnd/msgsnd06
 /ipc/semctl/semctl01
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/.msgsnd02.c.swo b/testcases/kernel/syscalls/ipc/msgsnd/.msgsnd02.c.swo
new file mode 100644
index 0000000000000000000000000000000000000000..f916bda9a903750736dfb29f914eb3fd68f7c09b
GIT binary patch
literal 12288
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
NQjwM_m8$B|{{f0z*v|j}

literal 0
HcmV?d00001

diff --git a/testcases/kernel/syscalls/ipc/msgsnd/Makefile b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
index f467389..207fb16 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
@@ -1,23 +1,26 @@
 #
-#  Copyright (c) International Business Machines  Corp., 2001
+# Copyright (c) International Business Machines  Corp., 2001
 #
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
+# This program is free software;  you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
 #
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY;  without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+# the GNU General Public License for more details.
 #
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# You should have received a copy of the GNU General Public License
+# along with this program.
 #
 
 top_srcdir              ?= ../../../../..
 
+ifeq ($(UCLINUX),1)
+FILTER_OUT_MAKE_TARGETS += msgsnd05 msgsnd06
+endif
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+include $(abs_srcdir)/../Makefile2.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index 0ca2be0..49aaf1f 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -1,169 +1,79 @@
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
- *	msgsnd01.c
- *
  * DESCRIPTION
- *	msgsnd01 - test that msgsnd() enqueues a message correctly
- *
- * ALGORITHM
- *	create a message queue
- *	initialize a message buffer with a known message and type
- *	loop if that option was specified
- *	enqueue the message
- *	check the return code
- *	  if failure, issue a FAIL message.
- *	otherwise,
- *	  if doing functionality testing
- *		stat the message queue
- *		check for # of bytes = MSGSIZE and # of messages = 1
- *	  	if correct,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgsnd01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
+ * test that msgsnd() enqueues a message correctly.
  */
 
-#include "test.h"
-
-#include "ipcmsg.h"
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "msgsnd01";
-int TST_TOTAL = 1;
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
 
-int msg_q_1;
-MSGBUF msg_buf, rd_buf;
+#include "tst_test.h"
+#include "libnewipc.h"
 
-struct msqid_ds qs_buf;
+static key_t msgkey;
+static int queue_id = -1;
+static struct buf {
+	long type;
+	char text[MSGSIZE];
+} rcv_buf, snd_buf = {MSGTYPE, "hello"};
 
-int main(int ac, char **av)
+static void verify_msgsnd(void)
 {
-	int lc;
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
-		/*
-		 * Use TEST macro to make the call
-		 */
-
-		TEST(msgsnd(msg_q_1, &msg_buf, MSGSIZE, 0));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
-				 TCID, TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-
-		/* get the queue status */
-		if (msgctl(msg_q_1, IPC_STAT, &qs_buf) == -1) {
-			tst_brkm(TBROK, cleanup, "Could not "
-				 "get queue status");
-		}
+	struct msqid_ds qs_buf;
 
-		if (qs_buf.msg_cbytes != MSGSIZE) {
-			tst_resm(TFAIL, "queue bytes != MSGSIZE");
-		}
-
-		if (qs_buf.msg_qnum != 1) {
-			tst_resm(TFAIL, "queue message != 1");
-		}
+	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, 0));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "msgsnd() failed");
+		return;
+	}
 
-		tst_resm(TPASS, "queue bytes = MSGSIZE and "
-			 "queue messages = 1");
+	SAFE_MSGCTL(queue_id, IPC_STAT, &qs_buf);
 
-		/*
-		 * remove the message by reading from the queue
-		 */
-		if (msgrcv(msg_q_1, &rd_buf, MSGSIZE, 1, 0) == -1) {
-			tst_brkm(TBROK, cleanup, "Could not read from queue");
-		}
-	}
+	if (qs_buf.msg_cbytes == MSGSIZE && qs_buf.msg_qnum == 1)
+		tst_res(TPASS, "queue bytes and number of queues matched");
+	else
+		tst_res(TFAIL, "queue bytes or number of queues mismatched");
 
-	cleanup();
-	tst_exit();
+	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 1, 0);
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
+	msgkey = GETIPCKEY();
 
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
-	msgkey = getipckey();
-
-	/* create a message queue with read/write permissions */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
-	}
-
-	/* initialize the message buffer */
-	init_buf(&msg_buf, MSGTYPE, MSGSIZE);
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if it exists, remove the message queue if it exists */
-	rm_queue(msg_q_1);
-
-	tst_rmdir();
-
+	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
+		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
+			queue_id);
+	}
 }
+
+static struct tst_test test = {
+	.tid = "msgsnd01",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_msgsnd,
+	.needs_tmpdir = 1
+};
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
index 6547ab2..219d40f 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
@@ -1,175 +1,134 @@
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
- *	msgsnd02.c
- *
  * DESCRIPTION
- *	msgsnd02 - test for EACCES and EFAULT errors
- *
- * ALGORITHM
- *	create a message queue without write permission
- *	create a trivial message buffer
- *	loop if that option was specified
- *	call msgsnd() using two different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get EACCES or EFAULT
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgsnd02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
+ * 1) The calling process does not have write permission on the message
+ *    queue, so msgsnd(2) fails and sets errno to EACCES.
+ * 2) msgsnd(2) fails and sets errno to EFAULT if the message buffer address
+ *    is invalid.
+ * 3) msgsnd(2) fails and sets errno to EINVAL if the queue ID is invalid.
+ * 4) msgsnd(2) fails and sets errno to EINVAL if the message type is not
+ *    positive (0).
+ * 5) msgsnd(2) fails and sets errno to EINVAL if the message type is not
+ *    positive (>0).
+ * 6) msgsnd(2) fails and sets errno to EINVAL if the message size is less
+ *    than zero.
  */
-#include <pwd.h>
-#include "test.h"
-
-#include "ipcmsg.h"
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "msgsnd02";
-int TST_TOTAL = 2;
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-MSGBUF msg_buf;			/* a buffer for the message to queue */
-int bad_q = -1;			/* a value to use as a bad queue ID */
-
-struct test_case_t {
-	int *queue_id;
-	MSGBUF *buffer;
-	int error;
-} TC[] = {
-	/* EACCES - there is no write permission for the queue */
-	{
-	&msg_q_1, &msg_buf, EACCES},
-	    /* EFAULT - the message buffer address is invalid */
-	{
-&msg_q_1, NULL, EFAULT},};
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <pwd.h>
 
-int main(int ac, char **av)
+#include "tst_test.h"
+#include "libnewipc.h"
+
+static key_t msgkey;
+static int queue_id = -1;
+static int bad_id = -1;
+static struct passwd *pw;
+static struct buf {
+	long type;
+	char text[MSGSIZE];
+} snd_buf[] = {
+	{1, "hello"},
+	{0, "hello"},
+	{-1, "hello"}
+};
+
+static struct tcase {
+	int *id;
+	struct buf *buffer;
+	int msgsz;
+	int exp_err;
+	/*1: nobody expected  0: root expected */
+	int exp_user;
+} tcases[] = {
+	{&queue_id, &snd_buf[0], MSGSIZE, EACCES, 1},
+	{&queue_id, NULL, MSGSIZE, EFAULT, 0},
+	{&bad_id, &snd_buf[0], MSGSIZE, EINVAL, 0},
+	{&queue_id, &snd_buf[1], MSGSIZE, EINVAL, 0},
+	{&queue_id, &snd_buf[2], MSGSIZE, EINVAL, 0},
+	{&queue_id, &snd_buf[0], -1, EINVAL, 0}
+};
+
+static void verify_msgsnd(struct tcase *tc)
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
-		/*
-		 * loop through the test cases
-		 */
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(msgsnd(*(TC[i].queue_id), TC[i].buffer, 1, 0));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
-		}
+	TEST(msgsnd(*tc->id, tc->buffer, tc->msgsz, 0));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "smgsnd() succeeded unexpectedly");
+		return;
 	}
 
-	cleanup();
-
-	tst_exit();
+	if (TEST_ERRNO == tc->exp_err) {
+		tst_res(TPASS | TTERRNO, "msgsnd() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO, "msgsnd() failed unexpectedly,"
+			" expected %s", tst_strerrno(tc->exp_err));
+	}
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void do_test(unsigned int n)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	pid_t pid;
+	struct tcase *tc = &tcases[n];
 
-	TEST_PAUSE;
-
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
+	if (tc->exp_user == 0) {
+		verify_msgsnd(tc);
+		return;
 	}
 
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	msgkey = getipckey();
-
-	/* create a message queue without write permission */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RD)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
+	pid = SAFE_FORK();
+	if (pid) {
+		tst_reap_children();
+	} else {
+		SAFE_SETUID(pw->pw_uid);
+		verify_msgsnd(tc);
 	}
-
-	/* initialize the message buffer with something trivial */
-	msg_buf.mtype = MSGTYPE;
-	msg_buf.mtext[0] = 'a';
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
-	/* if it exists, remove the message queue that was created */
-	rm_queue(msg_q_1);
+	msgkey = GETIPCKEY();
 
-	tst_rmdir();
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
 
+	pw = SAFE_GETPWNAM("nobody");
 }
+
+static void cleanup(void)
+{
+	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
+		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
+			queue_id);
+	}
+}
+
+static struct tst_test test = {
+	.tid = "msgsnd02",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = do_test
+};
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c
deleted file mode 100644
index ef6e58e..0000000
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c
+++ /dev/null
@@ -1,178 +0,0 @@
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
- *	msgsnd03.c
- *
- * DESCRIPTION
- *	msgsnd03 - test for EINVAL error
- *
- * ALGORITHM
- *	create a message queue with read/write permissions
- *	create a trivial message buffer
- *	loop if that option was specified
- *	call msgsnd() using four different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get EINVAL
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgsnd03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
-
-#include "test.h"
-
-#include "ipcmsg.h"
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "msgsnd03";
-int TST_TOTAL = 4;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-MSGBUF msg_buf;			/* a buffer for the message to queue */
-int bad_q = -1;			/* a value to use as a bad queue ID */
-
-struct test_case_t {
-	int *queue_id;
-	MSGBUF *buffer;
-	long mtype;
-	int msg_size;
-	int error;
-} TC[] = {
-	/* EINVAL - the queue ID is invalid */
-	{
-	&bad_q, &msg_buf, 1, 1, EINVAL},
-	    /* EINVAL - the message type is not positive (0) */
-	{
-	&msg_q_1, &msg_buf, 0, 1, EINVAL},
-	    /* EINVAL - the message type is not positive (>0) */
-	{
-	&msg_q_1, &msg_buf, -1, 1, EINVAL},
-	    /* EINVAL - the message size is less than zero */
-	{
-	&msg_q_1, &msg_buf, 1, -1, EINVAL}
-};
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
-		/*
-		 * loop through the test cases
-		 */
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			/* set the message type */
-			msg_buf.mtype = TC[i].mtype;
-
-			/* make the call with the TEST macro */
-			TEST(msgsnd(*(TC[i].queue_id), TC[i].buffer,
-				    TC[i].msg_size, 0));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
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
-	msgkey = getipckey();
-
-	/* create a message queue with read/write permission */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
-	}
-
-	/* initialize the message buffer with something trivial */
-	msg_buf.mtype = MSGTYPE;
-	msg_buf.mtext[0] = 'a';
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test@completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-	/* if it exists, remove the message queue that was created */
-	rm_queue(msg_q_1);
-
-	tst_rmdir();
-
-}
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c
deleted file mode 100644
index 4432d67..0000000
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c
+++ /dev/null
@@ -1,155 +0,0 @@
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
- *	msgsnd04.c
- *
- * DESCRIPTION
- *	msgsnd04 - test for EAGAIN error
- *
- * ALGORITHM
- *	create a message queue with read/write permissions
- *	initialize a message buffer with a known message and type
- *	enqueue the message in a loop until the queue is full
- *	loop if that option was specified
- *	attempt to enqueue another message - msgsnd()
- *	check the errno value
- *	  issue a PASS message if we get EAGAIN
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgsnd04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
-
-#include "test.h"
-
-#include "ipcmsg.h"
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "msgsnd04";
-int TST_TOTAL = 1;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-MSGBUF msg_buf;
-
-int main(int ac, char **av)
-{
-	int lc;
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
-		/*
-		 * Attempt to write another message to the full queue.
-		 */
-
-		TEST(msgsnd(msg_q_1, &msg_buf, MSGSIZE, IPC_NOWAIT));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded when error expected");
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case EAGAIN:
-			tst_resm(TPASS, "expected failure - errno = %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed with an "
-				 "unexpected error - %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
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
-	msgkey = getipckey();
-
-	/* create a message queue with read/write permission */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
-	}
-
-	/* initialize the message buffer */
-	init_buf(&msg_buf, MSGTYPE, MSGSIZE);
-
-	/* write messages to the queue until it is full */
-	while (msgsnd(msg_q_1, &msg_buf, MSGSIZE, IPC_NOWAIT) != -1) {
-		msg_buf.mtype += 1;
-	}
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-	/* if it exists, remove the message queue that was created */
-	rm_queue(msg_q_1);
-
-	tst_rmdir();
-
-}
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index 16d62f8..42c89a8 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -1,234 +1,127 @@
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
- *	msgsnd05.c
- *
  * DESCRIPTION
- *	msgsnd05 - test for EINTR error
- *
- * ALGORITHM
- *	create a message queue with read/write permissions
- *	initialize a message buffer with a known message and type
- *	enqueue the message in a loop until the queue is full
- *	loop if that option was specified
- *	fork a child process
- *	child attempts to enqueue a message to the full queue and sleeps
- *	parent sends a SIGHUP to the child then waits for the child to complete
- *	child get a return from msgsnd()
- *	check the errno value
- *	  issue a PASS message if we get EINTR
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	child exits, parent calls cleanup
- *
- * USAGE:  <for command-line>
- *  msgsnd05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *      14/03/2008 Matthieu Fertré (Matthieu.Fertre@irisa.fr)
- *      - Fix concurrency issue. Due to the use of usleep function to
- *        synchronize processes, synchronization issues can occur on a loaded
- *        system. Fix this by using pipes to synchronize processes.
- *
- * RESTRICTIONS
- *	none
+ * 1) msgsnd(2) fails and sets errno to EAGAIN if the message can't be
+ *    sent due to the msg_qbytes limit for the queue and IPC_NOWAIT is
+ *    specified.
+ * 2) msgsnd(2) fails and sets errno to EINTR if msgsnd(2) sleeps on a
+ *    full message queue condition and the process catches a signal.
  */
 
-#include "test.h"
-
-#include "ipcmsg.h"
-
+#include <errno.h>
+#include <unistd.h>
 #include <sys/types.h>
-#include <sys/wait.h>
-
-void do_child(void);
-void cleanup(void);
-void setup(void);
-#ifdef UCLINUX
-#define PIPE_NAME	"msgsnd05"
-void do_child_uclinux(void);
-#endif
-
-char *TCID = "msgsnd05";
-int TST_TOTAL = 1;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-
-MSGBUF msg_buf;
-
-int main(int ac, char **av)
+#include <sys/ipc.h>
+#include <sys/msg.h>
+
+#include "tst_test.h"
+#include "libnewipc.h"
+
+static key_t msgkey;
+static int queue_id = -1;
+static struct buf {
+	long type;
+	char text[MSGSIZE];
+} snd_buf = {1, "hello"};
+
+static struct tcase {
+	int flag;
+	int exp_err;
+	/*1: nobody expected  0: root expected */
+	int exp_user;
+} tcases[] = {
+	{IPC_NOWAIT, EAGAIN, 0},
+	{0, EINTR, 1}
+};
+
+static void verify_msgsnd(struct tcase *tc)
 {
-	int lc;
-	pid_t c_pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_child_uclinux, "d", &msg_q_1);
-#endif
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * fork a child that will attempt to write a message
-		 * to the queue without IPC_NOWAIT
-		 */
-		if ((c_pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "could not fork");
-		}
-
-		if (c_pid == 0) {	/* child */
-			/*
-			 * Attempt to write another message to the full queue.
-			 * Without the IPC_NOWAIT flag, the child sleeps
-			 */
-
-#ifdef UCLINUX
-			if (self_exec(av[0], "d", msg_q_1) < 0) {
-				tst_brkm(TBROK, cleanup, "could not self_exec");
-			}
-#else
-			do_child();
-#endif
-		} else {
-			TST_PROCESS_STATE_WAIT(cleanup, c_pid, 'S');
-
-			/* send a signal that must be caught to the child */
-			if (kill(c_pid, SIGHUP) == -1)
-				tst_brkm(TBROK, cleanup, "kill failed");
-
-			waitpid(c_pid, NULL, 0);
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * do_child()
- */
-void do_child(void)
-{
-	TEST(msgsnd(msg_q_1, &msg_buf, MSGSIZE, 0));
-
+	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, tc->flag));
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "call succeeded when error expected");
-		exit(-1);
+		tst_res(TFAIL, "msgsnd() succeeded unexpectedly");
+		return;
 	}
 
-	switch (TEST_ERRNO) {
-	case EINTR:
-		tst_resm(TPASS, "expected failure - errno = %d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
-		break;
-	default:
-		tst_resm(TFAIL,
-			 "call failed with an unexpected error - %d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
-		break;
+	if (TEST_ERRNO == tc->exp_err) {
+		tst_res(TPASS | TTERRNO, "msgsnd() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO, "msgsnd() failed unexpectedly,"
+			" expected %s", tst_strerrno(tc->exp_err));
 	}
-
-	exit(0);
 }
 
-void sighandler(int sig)
+static void sighandler(int sig)
 {
 	if (sig == SIGHUP)
 		return;
 	else
-		tst_brkm(TBROK, NULL, "received unexpected signal %d", sig);
+		_exit(TBROK);
 }
 
-#ifdef UCLINUX
-/*
- * do_child_uclinux() - capture signals, initialize buffer, then run do_child()
- */
-void do_child_uclinux(void)
+static void do_test(unsigned int n)
 {
-	/* initialize the message buffer */
-	init_buf(&msg_buf, MSGTYPE, MSGSIZE);
+	pid_t pid;
+	struct tcase *tc = &tcases[n];
 
-	tst_sig(FORK, sighandler, cleanup);
+	if (tc->exp_user == 0) {
+		verify_msgsnd(tc);
+		return;
+	}
 
-	do_child();
+	pid = SAFE_FORK();
+	if (!pid) {
+		verify_msgsnd(tc);
+		_exit(0);
+	}
+
+	TST_PROCESS_STATE_WAIT(pid, 'S');
+	SAFE_KILL(pid, SIGHUP);
+	tst_reap_children();
 }
-#endif
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	/* capture signals in our own handler */
-	tst_sig(FORK, sighandler, cleanup);
-
-	TEST_PAUSE;
+	SAFE_SIGNAL(SIGHUP, sighandler);
 
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
-	tst_tmpdir();
+	msgkey = GETIPCKEY();
 
-	msgkey = getipckey();
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
 
-	/* create a message queue with read/write permission */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
-	}
-
-	/* initialize the message buffer */
-	init_buf(&msg_buf, MSGTYPE, MSGSIZE);
-
-	/* write messages to the queue until it is full */
-	while (msgsnd(msg_q_1, &msg_buf, MSGSIZE, IPC_NOWAIT) != -1) {
-		msg_buf.mtype += 1;
-	}
+	while (msgsnd(queue_id, &snd_buf, MSGSIZE, IPC_NOWAIT) != -1)
+		snd_buf.type += 1;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if it exists, remove the message queue that was created */
-	rm_queue(msg_q_1);
-
-	tst_rmdir();
-
+	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
+		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
+			queue_id);
+	}
 }
+
+static struct tst_test test = {
+	.tid = "msgsnd05",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = do_test
+};
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
index 42f6e79..2436481 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
@@ -1,222 +1,90 @@
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
- *	msgsnd06.c
- *
  * DESCRIPTION
- *	msgsnd06 - test for EIDRM error
- *
- * ALGORITHM
- *	loop if that option was specified
- *	create a message queue with read/write permissions
- *	initialize a message buffer with a known message and type
- *	enqueue messages in a loop until the queue is full
- *	fork a child process
- *	child attempts to enqueue a message to the full queue and sleeps
- *	parent removes the queue and then exits
- *	child get a return from msgsnd()
- *	check the errno value
- *	  issue a PASS message if we get EIDRM
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgsnd06 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *      14/03/2008 Matthieu Fertré (Matthieu.Fertre@irisa.fr)
- *      - Fix concurrency issue. Due to the use of usleep function to
- *        synchronize processes, synchronization issues can occur on a loaded
- *        system. Fix this by using pipes to synchronize processes.
- *
- * RESTRICTIONS
- *	none
+ * Tests if EIDRM is returned when message queue was removed while
+ * msgsnd() was trying to send a message.
  */
 
-#include <sys/wait.h>
-#include "test.h"
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
 
-#include "ipcmsg.h"
+#include "tst_test.h"
+#include "libnewipc.h"
 
-void cleanup(void);
-void setup(void);
-void do_child(void);
+static key_t msgkey;
+static int queue_id = -1;
+static struct buf {
+	long type;
+	char text[MSGSIZE];
+} snd_buf = {1, "hello"};
 
-char *TCID = "msgsnd06";
-int TST_TOTAL = 1;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-
-MSGBUF msg_buf;
-
-int main(int ac, char **av)
+static void verify_msgsnd(void)
 {
-	int lc;
-	pid_t c_pid;
-	int status, e_code;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-#define PIPE_NAME	"msgsnd06"
-	maybe_run_child(&do_child, "d", &msg_q_1);
-#endif
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		msgkey = getipckey();
-
-		/* create a message queue with read/write permission */
-		if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW))
-		    == -1) {
-			tst_brkm(TBROK, cleanup, "Can't create message queue");
-		}
-
-		/* initialize the message buffer */
-		init_buf(&msg_buf, MSGTYPE, MSGSIZE);
-
-		/* write messages to the queue until it is full */
-		while (msgsnd(msg_q_1, &msg_buf, MSGSIZE, IPC_NOWAIT) != -1) {
-			msg_buf.mtype += 1;
-		}
-
-		/*
-		 * fork a child that will attempt to write a message
-		 * to the queue without IPC_NOWAIT
-		 */
-		if ((c_pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "could not fork");
-		}
-
-		if (c_pid == 0) {	/* child */
-
-#ifdef UCLINUX
-			if (self_exec(av[0], "d", msg_q_1) < 0) {
-				tst_brkm(TBROK, cleanup, "could not self_exec");
-			}
-#else
-			do_child();
-#endif
-		} else {
-			TST_PROCESS_STATE_WAIT(cleanup, c_pid, 'S');
-
-			/* remove the queue */
-			rm_queue(msg_q_1);
-
-			/* wait for the child to finish */
-			wait(&status);
-			/* make sure the child returned a good exit status */
-			e_code = status >> 8;
-			if (e_code != 0) {
-				tst_resm(TFAIL, "Failures reported above");
-			}
-		}
+	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, 0));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "msgsnd() succeeded unexpectedly");
+		return;
 	}
 
-	cleanup();
-
-	tst_exit();
+	if (TEST_ERRNO == EIDRM) {
+		tst_res(TPASS | TTERRNO, "msgsnd() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"msgsnd() failed unexpectedly, expected EIDRM");
+	}
 }
 
-/*
- * do_child()
- */
-void do_child(void)
+static void do_test(void)
 {
-	int retval = 0;
+	pid_t pid;
 
-#ifdef UCLINUX
-	/* initialize the message buffer */
-	init_buf(&msg_buf, MSGTYPE, MSGSIZE);
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
 
-#endif
-	/*
-	 * Attempt to write another message to the full queue.
-	 * Without the IPC_NOWAIT flag, the child sleeps
-	 */
-	TEST(msgsnd(msg_q_1, &msg_buf, MSGSIZE, 0));
+	while (msgsnd(queue_id, &snd_buf, MSGSIZE, IPC_NOWAIT) != -1)
+		snd_buf.type += 1;
 
-	if (TEST_RETURN != -1) {
-		retval = 1;
-		tst_resm(TFAIL, "call succeeded when error expected");
-		exit(retval);
+	pid = SAFE_FORK();
+	if (!pid) {
+		verify_msgsnd();
+		_exit(0);
 	}
 
-	switch (TEST_ERRNO) {
-	case EIDRM:
-		tst_resm(TPASS, "expected failure - errno = %d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
+	TST_PROCESS_STATE_WAIT(pid, 'S');
 
-		/* mark the queue as invalid as it was removed */
-		msg_q_1 = -1;
-		break;
-	default:
-		retval = 1;
-		tst_resm(TFAIL,
-			 "call failed with an unexpected error - %d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
-		break;
-	}
-	exit(retval);
-}
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
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
+	tst_reap_children();
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
-
-	tst_rmdir();
-
+	msgkey = GETIPCKEY();
 }
+
+static struct tst_test test = {
+	.tid = "msgsnd06",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.test_all = do_test
+};
-- 
1.8.3.1



