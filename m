From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jun 2018 17:46:25 +0200
Subject: [LTP] [RFC PATCH 3/9] syscalls/ipc: Rewrite msgctl01 + merge
	msgctl06
In-Reply-To: <20180612154631.435-1-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
Message-ID: <20180612154631.435-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rewrite msgctl01 to be much more strict, now we assert all fields of the
buffer we get from IPC_STAT.

This also removes msgctl06 that was testing the very same IPC_STAT
command but checked different subset of the msqid_ds buffer.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/ltplite                                 |   1 -
 runtest/stress.part3                            |   1 -
 runtest/syscalls                                |   1 -
 runtest/syscalls-ipc                            |   1 -
 testcases/kernel/syscalls/ipc/msgctl/.gitignore |   1 -
 testcases/kernel/syscalls/ipc/msgctl/msgctl01.c | 242 ++++++++++++------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c | 142 --------------
 7 files changed, 122 insertions(+), 267 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 249262674..cb9517883 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -484,7 +484,6 @@ msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
 msgctl05 msgctl05
-msgctl06 msgctl06
 msgctl07 msgctl07
 
 msgget01 msgget01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index d9287197b..e97b08456 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -400,7 +400,6 @@ msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
 msgctl05 msgctl05
-msgctl06 msgctl06
 msgctl07 msgctl07
 msgstress01 msgstress01
 msgstress02 msgstress02
diff --git a/runtest/syscalls b/runtest/syscalls
index 65c96edab..7befd5c66 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -690,7 +690,6 @@ msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
 msgctl05 msgctl05
-msgctl06 msgctl06
 msgctl07 msgctl07
 msgstress01 msgstress01
 msgstress02 msgstress02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index c734e239d..9ae91bb4c 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -3,7 +3,6 @@ msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
 msgctl05 msgctl05
-msgctl06 msgctl06
 msgctl07 msgctl07
 msgstress01 msgstress01
 msgstress02 msgstress02
diff --git a/testcases/kernel/syscalls/ipc/msgctl/.gitignore b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
index 2edde5de4..257a2231b 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
@@ -3,7 +3,6 @@
 /msgctl03
 /msgctl04
 /msgctl05
-/msgctl06
 /msgctl07
 /msgctl12
 /msgctl13
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
index 18389627d..aa8d075e9 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
@@ -1,153 +1,155 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *	03/2001 - Written by Wayne Boyer
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software  Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	msgctl01.c
- *
- * DESCRIPTION
- *	msgctl01 - create a message queue, then issue the IPC_STAT command
- *		   and RMID commands to test the functionality
- *
- * ALGORITHM
- *	create a message queue
- *	loop if that option was specified
- *	call msgctl() with the IPC_STAT command
- *	check the return code
- *	  if failure, issue a FAIL message and break remaining tests
- *	otherwise,
- *	  if doing functionality testing
- *	  	if the max number of bytes on the queue is > 0,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	  else issue a PASS message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgctl01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
+ * Test that IPC_STAT command succeeds and the the buffer is filled with
+ * correct data.
  */
+#include <errno.h>
 
-#include "test.h"
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
 
-#include "ipcmsg.h"
+static int msg_id = -1;
+static time_t creat_time;
+static key_t msgkey;
+static uid_t uid;
+static gid_t gid;
+unsigned short mode = 0660;
 
-char *TCID = "msgctl01";
-int TST_TOTAL = 1;
-
-int msg_q_1 = -1;		/* to hold the message queue id */
+static void verify_msgctl(void)
+{
+	struct msqid_ds buf;
 
-struct msqid_ds qs_buf;
+	memset(&buf, 'a', sizeof(buf));
+	TEST(msgctl(msg_id, IPC_STAT, &buf));
 
-int main(int ac, char **av)
-{
-	int lc;
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO, "msgctl() returned %li", TEST_RETURN);
+		return;
+	}
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	tst_res(TPASS, "msgctl(IPC_STAT)");
 
-	setup();		/* global setup */
+	if (buf.msg_stime == 0)
+		tst_res(TPASS, "msg_stime = 0");
+	else
+		tst_res(TFAIL, "msg_stime = %lu", (unsigned long)buf.msg_stime);
 
-	/* The following loop checks looping state if -i option given */
+	if (buf.msg_rtime == 0)
+		tst_res(TPASS, "msg_rtime = 0");
+	else
+		tst_res(TFAIL, "msg_rtime = %lu", (unsigned long)buf.msg_rtime);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+	if (buf.msg_ctime == creat_time || buf.msg_ctime == creat_time + 1) {
+		tst_res(TPASS, "msg_ctime = %lu, expected %lu",
+			(unsigned long)buf.msg_ctime, (unsigned long)creat_time);
+	} else {
+		tst_res(TPASS, "msg_ctime = %lu, expected %lu",
+			(unsigned long)buf.msg_ctime, (unsigned long)creat_time);
+	}
 
-		/*
-		 * Get the msqid_ds structure values for the queue
-		 */
+	if (buf.msg_qnum == 0)
+		tst_res(TPASS, "msg_qnum = 0");
+	else
+		tst_res(TFAIL, "msg_qnum = %li", (long)buf.msg_qnum);
+
+	if (buf.msg_qbytes > 0)
+		tst_res(TPASS, "msg_qbytes = %li", (long)buf.msg_qbytes);
+	else
+		tst_res(TFAIL, "msg_qbytes = %li", (long)buf.msg_qbytes);
+
+	if (buf.msg_lspid == 0)
+		tst_res(TPASS, "msg_lspid = 0");
+	else
+		tst_res(TFAIL, "msg_lspid = %u", (unsigned)buf.msg_lspid);
+
+	if (buf.msg_lrpid == 0)
+		tst_res(TPASS, "msg_lrpid = 0");
+	else
+		tst_res(TFAIL, "msg_lrpid = %u", (unsigned)buf.msg_lrpid);
+
+	if (buf.msg_perm.__key == msgkey) {
+		tst_res(TPASS, "msg_perm.__key == %u", (unsigned)msgkey);
+	} else {
+		tst_res(TFAIL, "msg_perm.__key == %u, expected %u",
+			(unsigned)buf.msg_perm.__key, (unsigned)msgkey);
+	}
 
-		TEST(msgctl(msg_q_1, IPC_STAT, &qs_buf));
+	if (buf.msg_perm.uid == uid) {
+		tst_res(TPASS, "msg_perm.uid = %u", (unsigned)uid);
+	} else {
+		tst_res(TFAIL, "msg_perm.uid = %u, expected %u",
+			(unsigned)buf.msg_perm.uid, (unsigned)uid);
+	}
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "msgctl() call failed");
-		} else {
-			if (qs_buf.msg_qbytes > 0) {
-				tst_resm(TPASS, "qs_buf.msg_qbytes is"
-					 " a positive value");
-			} else {
-				tst_resm(TFAIL, "qs_buf.msg_qbytes did"
-					 " not change");
-			}
-		}
+	if (buf.msg_perm.gid == gid) {
+		tst_res(TPASS, "msg_perm.gid = %u", (unsigned)gid);
+	} else {
+		tst_res(TFAIL, "msg_perm.gid = %u, expected %u",
+			(unsigned)buf.msg_perm.gid, (unsigned)gid);
+	}
 
-		/*
-		 * clean up things in case we are looping
-		 */
-		qs_buf.msg_qbytes = 0x0000;
+	if (buf.msg_perm.cuid == uid) {
+		tst_res(TPASS, "msg_perm.cuid = %u", (unsigned)uid);
+	} else {
+		tst_res(TFAIL, "msg_perm.cuid = %u, expected %u",
+			(unsigned)buf.msg_perm.cuid, (unsigned)uid);
 	}
 
-	cleanup();
+	if (buf.msg_perm.cgid == gid) {
+		tst_res(TPASS, "msg_perm.cgid = %u", (unsigned)gid);
+	} else {
+		tst_res(TFAIL, "msg_perm.cgid = %u, expected %u",
+			(unsigned)buf.msg_perm.cgid, (unsigned)gid);
+	}
 
-	tst_exit();
+	if ((buf.msg_perm.mode & MODE_MASK) == (mode & MODE_MASK)) {
+		tst_res(TPASS, "msg_perm.mode = 0%ho", mode & MODE_MASK);
+	} else {
+		tst_res(TFAIL, "msg_perm.mode = 0%ho, expected %hx",
+			buf.msg_perm.mode, (mode & MODE_MASK));
+	}
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
-	/* get a message key */
-	msgkey = getipckey();
+	msg_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW | mode);
+	time(&creat_time);
 
-	/* make sure the initial # of bytes is 0 in our buffer */
-	qs_buf.msg_qbytes = 0x0000;
-
-	/* now we have a key, so let's create a message queue */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
-	}
+	uid = geteuid();
+	gid = getegid();
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if it exists, remove the message queue */
-	rm_queue(msg_q_1);
-
-	tst_rmdir();
-
+	if (msg_id > 0)
+		SAFE_MSGCTL(msg_id, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_msgctl,
+	.needs_tmpdir = 1
+};
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
deleted file mode 100644
index 297b5939f..000000000
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
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
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-/* 11/06/2002	Port to LTP	dbarrera@us.ibm.com */
-/* 12/03/2008   Fix concurrency issue     mfertre@irisa.fr */
-
-/*
- * NAME
- *	msgctl06
- *
- * CALLS
- *	msgget(2) msgctl(2)
- *
- * ALGORITHM
- *	Get and manipulate a message queue.
- *
- * RESTRICTIONS
- *
- */
-
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/msg.h>
-#include <stdio.h>
-#include "test.h"
-#include "ipcmsg.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "msgctl06";
-int TST_TOTAL = 1;
-
-/*
- * msgctl3_t -- union of msgctl(2)'s possible argument # 3 types.
- */
-typedef union msgctl3_u {
-	struct msqid_ds *msq_ds;	/* pointer to msqid_ds struct */
-	struct ipc_acl *msq_acl;	/* pointer ACL buff and size */
-} msgctl3_t;
-
-extern int local_flag;
-
-int msqid, status;
-struct msqid_ds buf;
-
-int main(int argc, char *argv[])
-{
-	key_t key;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	key = getipckey();
-	TEST(msgget(key, IPC_CREAT | IPC_EXCL));
-	msqid = TEST_RETURN;
-	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TTERRNO, NULL, "msgget() failed");
-	}
-
-	TEST(msgctl(msqid, IPC_STAT, &buf));
-	status = TEST_RETURN;
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO,
-			 "msgctl(msqid, IPC_STAT, &buf) failed");
-		(void)msgctl(msqid, IPC_RMID, NULL);
-		tst_exit();
-	}
-
-	/*
-	 * Check contents of msqid_ds structure.
-	 */
-
-	if (buf.msg_qnum != 0) {
-		tst_brkm(TFAIL, NULL, "error: unexpected nbr of messages %ld",
-			 buf.msg_qnum);
-	}
-	if (buf.msg_perm.uid != getuid()) {
-		tst_brkm(TFAIL, NULL, "error: unexpected uid %d",
-			 buf.msg_perm.uid);
-	}
-	if (buf.msg_perm.gid != getgid()) {
-		tst_brkm(TFAIL, NULL, "error: unexpected gid %d",
-			 buf.msg_perm.gid);
-	}
-	if (buf.msg_perm.cuid != getuid()) {
-		tst_brkm(TFAIL, NULL, "error: unexpected cuid %d",
-			 buf.msg_perm.cuid);
-	}
-	if (buf.msg_perm.cgid != getgid()) {
-		tst_brkm(TFAIL, NULL, "error: unexpected cgid %d",
-			 buf.msg_perm.cgid);
-	}
-
-	tst_resm(TPASS, "msgctl06 ran successfully!");
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-}
-
-void cleanup(void)
-{
-	int status;
-
-	(void)msgctl(msqid, IPC_RMID, NULL);
-	if ((status = msgctl(msqid, IPC_STAT, &buf)) != -1) {
-		(void)msgctl(msqid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(msqid, IPC_RMID) failed");
-
-	}
-
-	tst_rmdir();
-}
-- 
2.13.6

