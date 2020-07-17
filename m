From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 17 Jul 2020 13:10:18 +0800
Subject: [LTP] [PATCH v2] ipc/msgrcv0*: cleanup && convert to new API
In-Reply-To: <1593001917-11075-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1593001917-11075-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1594962618-26004-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) The msgrcv03,04 was merged into msgrcv02
2) take use of IPC related macros
3) test msgrcv08 on 64bit machine

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
v1->v2:
1. modify msgrcv02.c code and move msgget in do_test to avoid 
error when using -i parameters
2. modify msgrcv05.c code and remove duplicated SAFE_SIGNAL(SIGHUP,
sighandler) function
3. remove msgrcv03,04 tag in syscalls-ipc 
 runtest/syscalls                              |   2 -
 runtest/syscalls-ipc                          |   2 -
 .../kernel/syscalls/ipc/msgrcv/.gitignore     |   2 -
 testcases/kernel/syscalls/ipc/msgrcv/Makefile |   5 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv01.c     | 231 +++------------
 .../kernel/syscalls/ipc/msgrcv/msgrcv02.c     | 268 ++++++------------
 .../kernel/syscalls/ipc/msgrcv/msgrcv03.c     | 162 -----------
 .../kernel/syscalls/ipc/msgrcv/msgrcv04.c     | 181 ------------
 .../kernel/syscalls/ipc/msgrcv/msgrcv05.c     | 240 ++++------------
 .../kernel/syscalls/ipc/msgrcv/msgrcv06.c     | 248 ++++------------
 .../kernel/syscalls/ipc/msgrcv/msgrcv07.c     | 209 +++++---------
 .../kernel/syscalls/ipc/msgrcv/msgrcv08.c     | 118 +++-----
 12 files changed, 345 insertions(+), 1323 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
 delete mode 100644 testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 819e8d8ee..9d3808d66 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -811,8 +811,6 @@ msgget03 msgget03
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
-msgrcv03 msgrcv03
-msgrcv04 msgrcv04
 msgrcv05 msgrcv05
 msgrcv06 msgrcv06
 msgrcv07 msgrcv07
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index c3a35896c..61743be01 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -15,8 +15,6 @@ msgget03 msgget03
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
-msgrcv03 msgrcv03
-msgrcv04 msgrcv04
 msgrcv05 msgrcv05
 msgrcv06 msgrcv06
 msgrcv07 msgrcv07
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/.gitignore b/testcases/kernel/syscalls/ipc/msgrcv/.gitignore
index 203464f5f..0596ee00f 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgrcv/.gitignore
@@ -1,7 +1,5 @@
 /msgrcv01
 /msgrcv02
-/msgrcv03
-/msgrcv04
 /msgrcv05
 /msgrcv06
 /msgrcv07
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/Makefile b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
index f62cd1f48..56cdb6417 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
@@ -3,10 +3,9 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS  += -lltpipc
+LDLIBS += -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
index 3e89a7f90..204bf0575 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
@@ -1,210 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
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
- *	msgrcv01.c
- *
- * DESCRIPTION
- *	msgrcv01 - test that msgrcv() receives the expected message
- *
- * ALGORITHM
- *	create a message queue
- *	initialize a message buffer with a known message and type
- *	loop if that option was specified
- *	fork a child to receive the message
- *	parent enqueues the message then exits
- *	check the return code
- *	  if failure, issue a FAIL message.
- *	otherwise,
- *	  if doing functionality testing
- *		build a new message and compare it to the one received
- *	  	if they are the same,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgrcv01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- *	none
+ * msgrcv01 - test that msgrcv() receives the expected message
  */
 
 #include <string.h>
 #include <sys/wait.h>
-
-#include "test.h"
-
-#include "ipcmsg.h"
-
-void cleanup(void);
-void setup(void);
-void do_child(void);
-
-char *TCID = "msgrcv01";
-int TST_TOTAL = 1;
-
-int msg_q_1;
-MSGBUF snd_buf, rcv_buf, cmp_buf;
-
-pid_t c_pid;
-
-int main(int ac, char **av)
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+static key_t msgkey;
+static int queue_id = -1;
+static struct buf {
+	long type;
+	char mtext[MSGSIZE];
+} rcv_buf, snd_buf = {MSGTYPE, "hello"};
+
+static void verify_msgrcv(void)
 {
-	int lc;
-	void check_functionality(void);
-	int status, e_code;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
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
-		/*
-		 * fork a child to read from the queue while the parent
-		 * enqueues the message to be read.
-		 */
-		if ((c_pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "could not fork");
-		}
-
-		if (c_pid == 0) {	/* child */
-#ifdef UCLINUX
-			if (self_exec(av[0], "d", msg_q_1) < 0) {
-				tst_brkm(TBROK, cleanup, "could not self_exec");
-			}
-#else
-			do_child();
-#endif
-		} else {	/* parent */
-			/* put the message on the queue */
-			if (msgsnd(msg_q_1, &snd_buf, MSGSIZE, 0) == -1) {
-				tst_brkm(TBROK, cleanup,
-					 "Couldn't enqueue" " message");
-			}
-			/* wait for the child to finish */
-			wait(&status);
-			/* make sure the child returned a good exit status */
-			e_code = status >> 8;
-			if (e_code != 0) {
-				tst_resm(TFAIL, "Failures reported above");
-			}
+	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
 
-		}
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "msgrcv failed");
+		return;
 	}
-
-	cleanup();
-	tst_exit();
-
-    /** NOT REACHED **/
-
+	if (strcmp(rcv_buf.mtext, snd_buf.mtext) == 0)
+		tst_res(TPASS, "message received(%s) = message sent(%s)",
+			rcv_buf.mtext, snd_buf.mtext);
+	else
+		tst_res(TFAIL, "message received(%s) != message sent(%s)",
+			rcv_buf.mtext, snd_buf.mtext);
 }
 
-/*
- * do_child()
- */
-void do_child(void)
+static void setup(void)
 {
-	int retval = 0;
-
-	TEST(msgrcv(msg_q_1, &rcv_buf, MSGSIZE, 1, 0));
-
-	if (TEST_RETURN == -1) {
-		retval = 1;
-		tst_resm(TFAIL, "%s call failed - errno = %d : %s",
-			 TCID, TEST_ERRNO, strerror(TEST_ERRNO));
-	} else {
-		/*
-		 * Build a new message and compare it
-		 * with the one received.
-		 */
-		init_buf(&cmp_buf, MSGTYPE, MSGSIZE);
-
-		if (strcmp(rcv_buf.mtext, cmp_buf.mtext) == 0) {
-			tst_resm(TPASS,
-				 "message received = " "message sent");
-		} else {
-			retval = 1;
-			tst_resm(TFAIL,
-				 "message received != " "message sent");
-		}
-	}
-	exit(retval);
+	msgkey = GETIPCKEY();
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void cleanup(void)
 {
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See libs/libltpipc/libipc.c for more information.
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
-	init_buf(&snd_buf, MSGTYPE, MSGSIZE);
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
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
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_msgrcv,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
index 52cffeaf4..ab5606c42 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
@@ -1,204 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * Basic error test for msgrcv(2).
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * 1)msgrcv(2) fails and sets errno to E2BIG if the message text length is
+ *    greater than msgsz and MSG_NOERROR isn't specified in msgflg.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * 2)The calling process does not have read permission on the message
+ *    queue, so msgrcv(2) fails and sets errno to EACCES.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * NAME
- *	msgrcv02.c
+ * 3)msgrcv(2) fails and sets errno to EFAULT if the message buffer address
+ *    isn't accessible.
  *
- * DESCRIPTION
- *	msgrcv02 - test for EACCES and EFAULT errors
+ * 4)msgrcv(2) fails and sets errno to EINVAL if msqid was invalid(<0).
  *
- * ALGORITHM
- *	create a message queue with read/write permissions
- *	initialize a message buffer with a known message and type
- *	enqueue the message
- *	create another message queue without read/write permissions
- *	loop if that option was specified
- *	call msgrcv() using two different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get EACCES or EFAULT
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgrcv02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *      14/03/2008 Matthieu Fertr? (Matthieu.Fertre@irisa.fr)
- *      - Fix concurrency issue. The second key used for this test could
- *        conflict with the key from another task.
-
+ * 5)msgrcv(2) fails and sets errno to EINVAL if msgsize is less than 0.
  *
- * RESTRICTIONS
- *	none
+ * 6)msgrcv(2) fails and sets errno to ENOMSG if IPC_NOWAIT was specified in
+ *   msgflg and no message of the requested type existed on the message queue.
  */
 
+#include <string.h>
+#include <sys/wait.h>
+#include <sys/msg.h>
 #include <pwd.h>
-
-#include "test.h"
-
-#include "ipcmsg.h"
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "msgrcv02";
-int TST_TOTAL = 2;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int msg_q_1 = -1;		/* The message queue ID created in setup */
-int msg_q_2 = -1;		/* Another message queue ID created in setup */
-MSGBUF snd_buf, rcv_buf;
-
-struct test_case_t {
-	int *queue_id;
-	MSGBUF *mbuf;
-	int error;
-} TC[] = {
-	/* EACCES - the queue has no read access */
-	{
-	&msg_q_2, &rcv_buf, EACCES},
-	    /* EFAULT - the message buffer address is invalid */
-	{
-	&msg_q_1, (MSGBUF *) - 1, EFAULT}
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+static key_t msgkey;
+static int queue_id = -1;
+static int bad_id = -1;
+struct passwd *pw;
+
+static struct buf {
+	long type;
+	char mtext[MSGSIZE];
+} rcv_buf, snd_buf = {MSGTYPE, "hello"};
+
+static struct tcase {
+	int *id;
+	struct buf *buffer;
+	int msgsz;
+	long msgtyp;
+	int msgflag;
+	int exp_user;
+	int exp_err;
+} tcases[] = {
+	{&queue_id, &rcv_buf, 4, 1, 0, 0, E2BIG},
+	{&queue_id, &rcv_buf, MSGSIZE, 1, 0, 1, EACCES},
+	{&queue_id, NULL, MSGSIZE, 1, 0, 0, EFAULT},
+	{&bad_id, &rcv_buf, MSGSIZE, 1, 0, 0, EINVAL},
+	{&queue_id, &rcv_buf, -1, 1, 0, 0, EINVAL},
+	{&queue_id, &rcv_buf, MSGSIZE, 2, IPC_NOWAIT, 0, ENOMSG},
 };
 
-int main(int ac, char **av)
+static void verify_msgrcv(struct tcase *tc)
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
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			/*
-			 * Use the TEST macro to make the call
-			 */
-
-			TEST(msgrcv(*(TC[i].queue_id), TC[i].mbuf, MSGSIZE,
-				    1, IPC_NOWAIT));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "call failed with an "
-					 "unexpected error - %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
-		}
+	TEST(msgrcv(*tc->id, tc->buffer, tc->msgsz, tc->msgtyp, tc->msgflag));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "smgrcv() succeeded unexpectedly");
+		return;
 	}
 
-	cleanup();
-
-	tst_exit();
+	if (TST_ERR == tc->exp_err) {
+		tst_res(TPASS | TTERRNO, "msgrcv() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO, "msgrcv() failed unexpectedly,"
+			" expected %s but got", tst_strerrno(tc->exp_err));
+	}
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void do_test(unsigned int n)
 {
-	key_t msgkey2;
-
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
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	msgkey = getipckey();
-
-	/* Get an new IPC resource key. */
-	msgkey2 = getipckey();
-
-	/* create a message queue with read/write permission */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue #1");
-	}
-
-	/* initialize a message buffer */
-	init_buf(&snd_buf, MSGTYPE, MSGSIZE);
-
-	/* put it on msq_q_1 */
-	if (msgsnd(msg_q_1, &snd_buf, MSGSIZE, IPC_NOWAIT) == -1) {
-		tst_brkm(TBROK, cleanup, "Couldn't put message on queue");
-	}
-
-	/* create a message queue without read/write permission */
-	if ((msg_q_2 = msgget(msgkey2, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue #2");
+	struct tcase *tc = &tcases[n];
+	pid_t pid;
+
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+
+	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		if (tc->exp_user)
+			SAFE_SETUID(pw->pw_uid);
+		verify_msgrcv(tc);
+		_exit(0);
 	}
+	tst_reap_children();
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
-	/* if it exists, remove the message queue #1 */
-	rm_queue(msg_q_1);
-
-	/* if it exists, remove the message queue #2 */
-	rm_queue(msg_q_2);
-
-	tst_rmdir();
+	msgkey = GETIPCKEY();
+	pw = SAFE_GETPWNAM("nobody");
+}
 
+static void cleanup(void)
+{
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = do_test
+};
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
deleted file mode 100644
index a81f7436d..000000000
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
+++ /dev/null
@@ -1,162 +0,0 @@
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
- *	msgrcv03.c
- *
- * DESCRIPTION
- *	msgrcv03 - test for EINVAL error
- *
- * ALGORITHM
- *	create a message queue with read/write permissions
- *	loop if that option was specified
- *	call msgrcv() using two different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get EINVAL
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgrcv03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
-char *TCID = "msgrcv03";
-int TST_TOTAL = 2;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-int bad_q = -1;			/* a value to use as a bad queue ID */
-MSGBUF rcv_buf;
-
-struct test_case_t {
-	int *queue_id;
-	int msize;
-	int error;
-} TC[] = {
-	/* EINVAL - the queue ID is invalid */
-	{
-	&bad_q, MSGSIZE, EINVAL},
-	    /* EINVAL - the message size is less than 0 */
-	{
-	&msg_q_1, -1, EINVAL}
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
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			/*
-			 * Use the TEST macro to make the call
-			 */
-
-			TEST(msgrcv(*(TC[i].queue_id), &rcv_buf, TC[i].msize,
-				    1, 0));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "call failed with an "
-					 "unexpected error - %d : %s",
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
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	msgkey = getipckey();
-
-	/* create a message queue with read/write permission */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
-	}
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
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c
deleted file mode 100644
index 573059c35..000000000
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c
+++ /dev/null
@@ -1,181 +0,0 @@
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
- *	msgrcv04.c
- *
- * DESCRIPTION
- *	msgrcv04 - test for E2BIG and ENOMSG errors
- *
- * ALGORITHM
- *	create a message queue with read/write permissions
- *	initialize a message buffer with a known message and type
- *	enqueue the message
- *	loop if that option was specified
- *	call msgrcv() using two different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get E2BIG or ENOMSG
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgrcv04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
-char *TCID = "msgrcv04";
-int TST_TOTAL = 2;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-
-#define SMSIZE	512
-
-MSGBUF snd_buf, rcv_buf;
-
-struct test_case_t {
-	int size;
-	int type;
-	int flags;
-	int error;
-} TC[] = {
-	/*
-	 * E2BIG - The receive buffer is too small for the message and
-	 *         MSG_NOERROR isn't asserted in the flags.
-	 */
-	{
-	SMSIZE, 1, 0, E2BIG},
-	    /*
-	     * ENOMSG - There is no message with the requested type and
-	     *          IPC_NOWAIT is asserted in the flags.
-	     */
-	{
-	MSGSIZE, 2, IPC_NOWAIT, ENOMSG}
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
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			/*
-			 * Use the TEST macro to make the call
-			 */
-
-			TEST(msgrcv(msg_q_1, &rcv_buf, TC[i].size, TC[i].type,
-				    TC[i].flags));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "call failed with an "
-					 "unexpected error - %d : %s",
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
-	 * See libs/libltpipc/libipc.c for more information.
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
-	/* initialize a buffer */
-	init_buf(&snd_buf, MSGTYPE, MSGSIZE);
-
-	/* put the message on the queue */
-	if (msgsnd(msg_q_1, &snd_buf, MSGSIZE, 0) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't enqueue message");
-	}
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
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
index 4c7a446e7..126c1bd05 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
@@ -1,206 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
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
+ * msgrcv error test for EINTR.
  */
 
-/*
- * NAME
- *	msgrcv05.c
- *
- * DESCRIPTION
- *	msgrcv05 - test for EINTR error
- *
- * ALGORITHM
- *	create a message queue with read/write permissions
- *	loop if that option was specified
- *	fork a child who attempts to read a non-existent message with msgrcv()
- *	parent sends a SIGHUP to the child, then waits for the child to complete
- *	check the errno value
- *	  issue a PASS message if we get EINTR
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	child exits, parent calls cleanup
- *
- * USAGE:  <for command-line>
- *  msgrcv05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *      14/03/2008 Matthieu Fertr? (Matthieu.Fertre@irisa.fr)
- *      - Fix concurrency issue. Due to the use of usleep function to
- *        synchronize processes, synchronization issues can occur on a loaded
- *        system. Fix this by using pipes to synchronize processes.
- *
- * RESTRICTIONS
- *	none
- */
-
-#include "test.h"
-#include "safe_macros.h"
-
-#include "ipcmsg.h"
-
 #include <sys/types.h>
 #include <sys/wait.h>
-
-void do_child(void);
-void cleanup(void);
-void setup(void);
-#ifdef UCLINUX
-#define PIPE_NAME	"msgrcv05"
-void do_child_uclinux(void);
-#endif
-
-char *TCID = "msgrcv05";
-int TST_TOTAL = 1;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-
-MSGBUF rcv_buf;
-pid_t c_pid;
-
-int main(int ac, char **av)
+#include <signal.h>
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+static key_t msgkey;
+static int queue_id = -1;
+static struct buf {
+	long type;
+	char mtext[MSGSIZE];
+} rcv_buf;
+
+static void sighandler(int sig)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_child_uclinux, "d", &msg_q_1);
-#endif
-
-	setup();		/* global setup */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/*
-		 * fork a child that will attempt to read a non-existent
-		 * message from the queue
-		 */
-		if ((c_pid = FORK_OR_VFORK()) == -1)
-			tst_brkm(TBROK, cleanup, "could not fork");
-
-		if (c_pid == 0) {
-			/*
-			 * Attempt to read a message without IPC_NOWAIT.
-			 * With no message to read, the child sleeps.
-			 */
-
-#ifdef UCLINUX
-			if (self_exec(av[0], "d", msg_q_1) < 0)
-				tst_brkm(TBROK, cleanup, "could not self_exec");
-#else
-			do_child();
-#endif
-		} else {
-			TST_PROCESS_STATE_WAIT(cleanup, c_pid, 'S');
-
-			/* send a signal that must be caught to the child */
-			SAFE_KILL(cleanup, c_pid, SIGHUP);
-
-			waitpid(c_pid, NULL, 0);
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
+	if (sig == SIGHUP)
+		return;
+	else
+		_exit(TBROK);
 }
 
-void do_child(void)
+static void verify_msgrcv(void)
 {
-	TEST(msgrcv(msg_q_1, &rcv_buf, MSGSIZE, 1, 0));
-
-	if (TEST_RETURN != -1)
-		tst_brkm(TFAIL, NULL, "call succeeded unexpectedly");
-
-	switch (TEST_ERRNO) {
-	case EINTR:
-		tst_resm(TPASS, "got EINTR as expected");
-		break;
-	default:
-		tst_resm(TFAIL | TTERRNO,
-			 "call failed with an unexpected error");
-		break;
-	}
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
 
-	exit(0);
-}
-
-void sighandler(int sig)
-{
-	if (sig == SIGHUP)
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "msgrcv() succeeded unexpectedly");
 		return;
+	}
+	if (TST_ERR == EINTR)
+		tst_res(TPASS | TTERRNO, "msgrcv() failed as expected");
 	else
-		tst_brkm(TBROK, NULL, "unexpected signal %d received", sig);
+		tst_res(TFAIL | TTERRNO, "msgrcv() failed expected EINTR but got");
 }
 
-#ifdef UCLINUX
-/*
- * do_child_uclinux() - capture signals again, then run do_child()
- */
-void do_child_uclinux(void)
+static void do_test(void)
 {
-	tst_sig(FORK, sighandler, cleanup);
+	int pid;
 
-	do_child();
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		/*
+		 * Attempt to read a message without IPC_NOWAIT.
+		 * With no message to read, the child sleeps.
+		 */
+		verify_msgrcv();
+		_exit(0);
+	}
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+	/* send a signal that must be caught to the child */
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
-
-	tst_sig(FORK, sighandler, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	msgkey = getipckey();
-
-	/* create a message queue with read/write permission */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1)
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
+	msgkey = GETIPCKEY();
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	SAFE_SIGNAL(SIGHUP, sighandler);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test@completion
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
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = do_test,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
index e3458b9ad..c18330b40 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
@@ -1,219 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
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
- *	msgrcv06.c
- *
- * DESCRIPTION
- *	msgrcv06 - test for EIDRM error
- *
- * ALGORITHM
- *	loop if that option was specified
- *	create a message queue with read/write permissions
- *	fork a child who sleeps on an attempted read with msgrcv()
- *	parent removes the queue then waits for child to complete
- *	check the errno value
- *	  issue a PASS message if we get EIDRM
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *      child removes message queue if required
- *	parent callc cleanup
- *
- * USAGE:  <for command-line>
- *  msgrcv06 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *      14/03/2008 Matthieu Fertr? (Matthieu.Fertre@irisa.fr)
- *      - Fix concurrency issue. Due to the use of usleep function to
- *        synchronize processes, synchronization issues can occur on a loaded
- *        system. Fix this by using pipes to synchronize processes.
- *
- *
- * RESTRICTIONS
- *	none
+ * msgrcv error test for EIDRM.
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
-#define PIPE_NAME	"msgrcv06"
-void do_child_uclinux(void);
-#endif
-
-char *TCID = "msgrcv06";
-int TST_TOTAL = 1;
-
-int msg_q_1 = -1;		/* The message queue id created in setup */
-
-MSGBUF rcv_buf;
-pid_t c_pid;
-
-int main(int ac, char **av)
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+static key_t msgkey;
+static int queue_id = -1;
+static struct buf {
+	long type;
+	char text[MSGSIZE];
+} rcv_buf = {1, "hello"};
+
+static void verify_msgrcv(void)
 {
-	int lc;
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
-		 * set up the queue here so that multiple test iterations
-		 * will work.
-		 */
-		msgkey = getipckey();
-
-		/* create a message queue with read/write permission */
-		if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW))
-		    == -1) {
-			tst_brkm(TBROK, cleanup, "Can't create message queue");
-		}
-
-		/*
-		 * fork a child that will attempt to read a non-existent
-		 * message from the queue
-		 */
-		if ((c_pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "could not fork");
-		}
-
-		if (c_pid == 0) {	/* child */
-			/*
-			 * Attempt to read a message without IPC_NOWAIT.
-			 * With no message to read, the child sleeps.
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
-			/* remove the queue */
-			rm_queue(msg_q_1);
-
-			waitpid(c_pid, NULL, 0);
-		}
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "msgrcv() succeeded unexpectedly");
+		return;
 	}
-
-	tst_exit();
+	if (TST_ERR == EIDRM)
+		tst_res(TPASS | TTERRNO, "msgrcv() failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "msgrcv() failed expected EIDRM but got");
 }
 
-/*
- * do_child()
- */
-void do_child(void)
+static void do_test(void)
 {
-	TEST(msgrcv(msg_q_1, &rcv_buf, MSGSIZE, 1, 0));
+	int pid;
 
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "call succeeded when error expected");
-		exit(-1);
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		verify_msgrcv();
+		_exit(0);
 	}
-
-	switch (TEST_ERRNO) {
-	case EIDRM:
-		tst_resm(TPASS, "expected failure - errno = %d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
-
-		/* mark the queue as invalid as it was removed */
-		msg_q_1 = -1;
-		break;
-	default:
-		tst_resm(TFAIL,
-			 "call failed with an unexpected error - %d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
-		break;
-	}
-
-	/* if it exists, remove the message queue that was created */
-	rm_queue(msg_q_1);
-
-	exit(0);
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
+	tst_reap_children();
 }
 
-#ifdef UCLINUX
-/*
- * do_child_uclinux() - capture signals again, then run do_child()
- */
-void do_child_uclinux(void)
+static void setup(void)
 {
-	tst_sig(FORK, SIG_IGN, cleanup);
-
-	do_child();
+	msgkey = GETIPCKEY();
 }
-#endif
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void cleanup(void)
 {
-
-	tst_sig(FORK, SIG_IGN, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test@completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = do_test,
+};
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
index 44f1c1d91..39fbdb67a 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
@@ -1,172 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2014 Fujitsu Ltd.
+ * Copyright (c) 2014-2020 Fujitsu Ltd.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-/*
- * Description:
- *     Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR
+ * Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR
  */
 
 #define  _GNU_SOURCE
 #include <sys/wait.h>
-#include "test.h"
-#include "ipcmsg.h"
-
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
 
 #define MSGTYPE1	1
 #define MSGTYPE2	2
-#define MSG1	"message type1"
-#define MSG2	"message type2"
-
-static void wait4child(pid_t child, char *tst_flag);
+#define MSG1	"messagetype1"
+#define MSG2	"messagetype2"
+
+static key_t msgkey;
+static int queue_id = -1;
+static struct buf {
+	long type;
+	char mtext[MSGSIZE];
+} rcv_buf, snd_buf[2] = {
+	{MSGTYPE1, MSG1},
+	{MSGTYPE2, MSG2}
+};
 
 static void test_msg_except(void);
 static void test_msg_noerror(void);
+static void cleanup(void);
+static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror};
 
-static void (*testfunc[])(void) = { test_msg_except, test_msg_noerror };
-
-char *TCID = "msgrcv07";
-int TST_TOTAL = ARRAY_SIZE(testfunc);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			(*testfunc[i])();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
+static void verify_msgcrv(unsigned int n)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	(*testfunc[n])();
 }
 
 static void test_msg_except(void)
 {
-	pid_t child_pid;
-	int msgq_id;
-	MSGBUF snd_buf1 = {.mtype = MSGTYPE1, .mtext = MSG1};
-	MSGBUF snd_buf2 = {.mtype = MSGTYPE2, .mtext = MSG2};
-	MSGBUF rcv_buf;
-
-	msgq_id = msgget(IPC_PRIVATE, MSG_RW);
-	if (msgq_id == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Can't create message queue");
-
-	if (msgsnd(msgq_id, &snd_buf1, MSGSIZE, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Can't enqueue message");
-
-	if (msgsnd(msgq_id, &snd_buf2, MSGSIZE, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Can't enqueue message");
-
-	child_pid = tst_fork();
-	if (child_pid == -1) {
-		tst_brkm(TBROK, cleanup, "fork failed");
-	} else if (child_pid > 0) {
-		wait4child(child_pid, "MSG_EXCEPT");
-	} else {
-		memset(&rcv_buf, 0, sizeof(rcv_buf));
-		TEST(msgrcv(msgq_id, &rcv_buf, MSGSIZE, MSGTYPE2, MSG_EXCEPT));
-		if (TEST_RETURN == -1) {
-			fprintf(stderr, "msgrcv(MSG_EXCEPT) failed\n");
-			exit(TBROK);
-		}
-		/* check the received message */
-		if (strcmp(rcv_buf.mtext, MSG1) == 0 &&
-		    rcv_buf.mtype == MSGTYPE1)
-			exit(TPASS);
-		else
-			exit(TFAIL);
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	SAFE_MSGSND(queue_id, &snd_buf[0], MSGSIZE, 0);
+	SAFE_MSGSND(queue_id, &snd_buf[1], MSGSIZE, 0);
+
+	memset(&rcv_buf, 0, sizeof(rcv_buf));
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, MSGTYPE2, MSG_EXCEPT));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "msgrcv(MSG_EXCEPT) failed");
+		cleanup();
+		return;
 	}
-
-	rm_queue(msgq_id);
+	tst_res(TPASS, "msgrcv(MSG_EXCEPT) succeeded");
+	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
+		tst_res(TPASS, "msgrcv(MSG_EXCEPT) excepted MSGTYPE2 and only got MSGTYPE1");
+	else
+		tst_res(TFAIL, "msgrcv(MSG_EXCEPT) didn't get MSGTYPE1 message");
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
-
 static void test_msg_noerror(void)
 {
-	pid_t child_pid;
-	int msg_len, msgq_id;
-	MSGBUF snd_buf1 = {.mtype = MSGTYPE1, .mtext = MSG1};
-	MSGBUF rcv_buf;
-
-	msgq_id = msgget(IPC_PRIVATE, MSG_RW);
-	if (msgq_id == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Can't create message queue");
-
-	if (msgsnd(msgq_id, &snd_buf1, MSGSIZE, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Can't enqueue message");
-
-	child_pid = tst_fork();
-	if (child_pid == -1) {
-		tst_brkm(TBROK, cleanup, "fork failed");
-	} else if (child_pid > 0) {
-		wait4child(child_pid, "MSG_NOERROR");
-	} else {
-		msg_len = sizeof(MSG1) / 2;
-		memset(&rcv_buf, 0, sizeof(rcv_buf));
-
-		TEST(msgrcv(msgq_id, &rcv_buf, msg_len, MSGTYPE1, MSG_NOERROR));
-		if (TEST_RETURN == -1)
-			exit(TFAIL);
-
-		if (strncmp(rcv_buf.mtext, MSG1, msg_len) == 0 &&
-		    rcv_buf.mtype == MSGTYPE1)
-			exit(TPASS);
-		exit(TFAIL);
+	int msg_len;
+
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	SAFE_MSGSND(queue_id, &snd_buf[0], MSGSIZE, 0);
+	msg_len = sizeof(MSG1) / 2;
+	memset(&rcv_buf, 0, sizeof(rcv_buf));
+
+	TEST(msgrcv(queue_id, &rcv_buf, msg_len, MSGTYPE1, MSG_NOERROR));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "msgrcv(MSG_NOERROR) failed");
+		cleanup();
+		return;
 	}
-
-	rm_queue(msgq_id);
+	tst_res(TPASS, "msgrcv(MSG_NOERROR) succeeded");
+	if (strncmp(rcv_buf.mtext, MSG1, msg_len) == 0 && rcv_buf.type == MSGTYPE1)
+		tst_res(TPASS, "msgrcv(MSG_NOERROR) truncated message text correctly");
+	else
+		tst_res(TFAIL, "msgrcv(MSG_NOERROR) truncated message text incorrectly");
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
-static void wait4child(pid_t child, char *tst_flag)
+static void setup(void)
 {
-	int status;
-	int ret;
-
-	if (waitpid(child, &status, 0) == -1)
-		tst_resm(TBROK | TERRNO, "waitpid");
-	if (WIFEXITED(status)) {
-		ret = WEXITSTATUS(status);
-		if (ret == 0)
-			tst_resm(TPASS, "test %s success", tst_flag);
-		else if (ret == 1)
-			tst_resm(TFAIL, "test %s failed", tst_flag);
-		else
-			tst_brkm(TBROK, cleanup, "msgrcv failed unexpectedly");
-	} else {
-		tst_brkm(TBROK, cleanup, "child process terminated "
-			 "abnormally. status: %d", status);
-	}
+	msgkey = GETIPCKEY();
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_msgcrv,
+	.tcnt = ARRAY_SIZE(testfunc),
+};
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
index dbe67e189..2b54ed35c 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
@@ -1,23 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015   Author: Gabriellla Schmidt <gsc@bruker.de>
  *                      Modify: Li Wang <liwang@redhat.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * you should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-/*
- * Description:
- *
  * A regression test for:
  *      commit e7ca2552369c1dfe0216c626baf82c3d83ec36bb
  *      Author: Mateusz Guzik <mguzik@redhat.com>
@@ -41,78 +25,56 @@
 #include <sys/types.h>
 #include <sys/ipc.h>
 #include <sys/msg.h>
-#include "test.h"
-#include "lapi/abisize.h"
-
-const char *TCID = "msgrcv08";
-const int TST_TOTAL = 1;
-
-#ifdef TST_ABI32
-
-struct mbuf {
-	long mtype;     /* message type, must be > 0 */
-	char mtext[16]; /* message data */
-};
-
-static void msr(int msqid)
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+static long mtype = 121;
+static key_t msgkey;
+static int queue_id = -1;
+static struct mbuf {
+	long mtype;
+	char mtext[16];
+} rcv_buf, snd_buf = {121, "hello"};
+
+static void verify_msgrcv(void)
 {
-	struct mbuf msbs;
-	struct mbuf msbr;
-	ssize_t sret;
-	long mtype = 121;
-
-	memset(&msbs, 0, sizeof(msbs));
-	msbs.mtype = mtype;
-
-	if (msgsnd(msqid, &msbs, sizeof(msbs.mtext), IPC_NOWAIT))
-		tst_brkm(TBROK | TERRNO, NULL, "msgsnd error");
-
-	sret = msgrcv(msqid, &msbr, sizeof(msbr.mtext), -mtype, IPC_NOWAIT | MSG_NOERROR);
+	memset(&rcv_buf, 0, sizeof(rcv_buf));
+	SAFE_MSGSND(queue_id, &snd_buf, sizeof(snd_buf.mtext), IPC_NOWAIT);
 
-	if (sret < 0) {
-		tst_resm(TFAIL, "Bug: No message of desired type.");
+	TEST(msgrcv(queue_id, &rcv_buf, sizeof(rcv_buf.mtext), -mtype, IPC_NOWAIT | MSG_NOERROR));
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "Bug: No message of desired type.");
 		return;
 	}
 
-	if (msbr.mtype != mtype)
-		tst_brkm(TBROK, NULL,
-			"found mtype %ld, expected %ld\n", msbr.mtype, mtype);
-
-	if ((size_t)sret != sizeof(msbs.mtext))
-		tst_brkm(TBROK, NULL, "received %zi, expected %zu\n",
-			 sret, sizeof(msbs.mtext));
+	if (rcv_buf.mtype != mtype) {
+		tst_res(TFAIL, "found mtype %ld, expected %ld\n", rcv_buf.mtype, mtype);
+		return;
+	}
+	if ((size_t)TST_RET != sizeof(snd_buf.mtext)) {
+		tst_res(TFAIL, "received %zi, expected %zu\n", (size_t)TST_RET, sizeof(snd_buf.mtext));
+		return;
+	}
 
-	tst_resm(TPASS, "No regression found.");
+	tst_res(TPASS, "No regression found.");
 }
 
-static void msgrcv_test(void)
+static void setup(void)
 {
-	int msqid = msgget(IPC_PRIVATE, IPC_CREAT | IPC_EXCL | 0666);
-
-	if (msqid < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "msgget error");
-
-	msr(msqid);
-
-	if (msgctl(msqid, IPC_RMID, 0))
-		tst_brkm(TBROK | TERRNO, NULL, "msgctl error");
+	msgkey = GETIPCKEY();
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
 }
 
-int main(int argc, char *argv[])
+static void cleanup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		msgrcv_test();
-
-	tst_exit();
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
-#else /* no 64-bit */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "not works when compiled as 64-bit application.");
-}
-#endif
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_msgrcv
+};
-- 
2.23.0



