From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jun 2018 17:46:27 +0200
Subject: [LTP] [RFC PATCH 5/9] syscalls/ipc: Convert to newlib and merge
	msgctl{13, 03}
In-Reply-To: <20180612154631.435-1-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
Message-ID: <20180612154631.435-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These two tests were both testing IPC_RMID, so I've merged then into
msgctl03 and rewritten the test to new test library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                                |   1 -
 runtest/syscalls-ipc                            |   1 -
 testcases/kernel/syscalls/ipc/msgctl/.gitignore |   1 -
 testcases/kernel/syscalls/ipc/msgctl/msgctl03.c | 159 ++++++------------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl13.c |  86 -------------
 5 files changed, 35 insertions(+), 213 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7befd5c66..6b3133776 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -696,7 +696,6 @@ msgstress02 msgstress02
 msgstress03 msgstress03
 msgstress04 msgstress04
 msgctl12 msgctl12
-msgctl13 msgctl13
 
 msgget01 msgget01
 msgget02 msgget02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 9ae91bb4c..6cf5853dd 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -9,7 +9,6 @@ msgstress02 msgstress02
 msgstress03 msgstress03
 msgstress04 msgstress04
 msgctl12 msgctl12
-msgctl13 msgctl13
 
 msgget01 msgget01
 msgget02 msgget02
diff --git a/testcases/kernel/syscalls/ipc/msgctl/.gitignore b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
index 257a2231b..b321f0c35 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
@@ -5,4 +5,3 @@
 /msgctl05
 /msgctl07
 /msgctl12
-/msgctl13
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
index 4693b89b6..836d6e76d 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
@@ -1,143 +1,54 @@
 /*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
  */
-
 /*
- * NAME
- *	msgctl03.c
- *
  * DESCRIPTION
- *	msgctl03 - create a message queue, then issue the IPC_RMID command
- *
- * ALGORITHM
- *	create a message queue
- *	loop if that option was specified
- *	call msgctl() with the IPC_RMID command
- *	check the return code
- *	  if failure, issue a FAIL message and break remaining tests
- *	otherwise,
- *	  if doing functionality testing
- *		issue an IPC_STAT on the queue that was just removed
- *	  	if the call fails
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	  else issue a PASS message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  msgctl03 [-c n] [-f] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	This test does not support looping.
+ *	msgctl13 - test for IPC_RMID
  */
+#include <errno.h>
 
-#include "test.h"
-
-#include "ipcmsg.h"
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
 
-char *TCID = "msgctl03";
-int TST_TOTAL = 1;
-
-int msg_q_1 = -1;		/* to hold the message queue id */
-
-struct msqid_ds qs_buf;
-
-int main(int ac, char **av)
+static void verify_msgctl(void)
 {
+	struct msqid_ds buf;
+	int msg_q;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
+	msg_q = SAFE_MSGGET(IPC_PRIVATE, MSG_RW);
 
-	/*
-	 * Remove the queue that was created in setup()
-	 */
-
-	TEST(msgctl(msg_q_1, IPC_RMID, NULL));
-
-	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TTERRNO, cleanup, "msgctl() call failed");
-	} else {
-		/*
-		 * if the queue is gone, then an IPC_STAT msgctl()
-		 * call should generate an EINVAL error.
-		 */
-		if ((msgctl(msg_q_1, IPC_STAT, &qs_buf) == -1)) {
-			if (errno == EINVAL) {
-				tst_resm(TPASS, "The queue is gone");
-			} else {
-				tst_resm(TFAIL, "IPC_RMID succeeded ,"
-					 " but functional test did not"
-					 " get expected EINVAL error");
-			}
-		}
+	TEST(msgctl(msg_q, IPC_RMID, NULL));
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO, "msgctl(IPC_RMID) failed");
+		return;
 	}
 
-	msg_q_1 = -1;
-
-	cleanup();
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
+	tst_res(TPASS, "msgctl(IPC_RMID)");
 
-	/* get a message key */
-	msgkey = getipckey();
-
-	/* now we have a key, so let's create a message queue */
-	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
+	TEST(msgctl(msg_q, IPC_STAT, &buf));
+	if (TEST_ERRNO == EINVAL) {
+		tst_res(TPASS | TTERRNO, "msgctl(IPC_STAT)");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"msgctl(IPC_STAT) returned %li", TEST_RETURN);
 	}
 }
 
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
+static struct tst_test test = {
+	.test_all = verify_msgctl,
+	.needs_tmpdir = 1
+};
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
deleted file mode 100644
index 50d48d4dd..000000000
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * Copyright (c) 2014 Fujitsu Ltd.
- * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program.
- */
-/*
- * DESCRIPTION
- *	msgctl13 - test for IPC_RMID
- */
-
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/msg.h>
-#include <errno.h>
-
-#include "test.h"
-#include "ipcmsg.h"
-
-char *TCID = "msgctl13";
-int TST_TOTAL = 1;
-static struct msqid_ds buf;
-
-static void msgctl_verify(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		msgctl_verify();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-static void msgctl_verify(void)
-{
-	int msg_q;
-
-	msg_q = msgget(IPC_PRIVATE, MSG_RW);
-	if (msg_q == -1)
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
-
-	TEST(msgctl(msg_q, IPC_RMID, NULL));
-
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL, "msgctl() test IPC_RMID failed with errno: %d",
-			 TEST_ERRNO);
-		return;
-	}
-
-	TEST(msgctl(msg_q, IPC_STAT, &buf));
-	if (TEST_ERRNO == EINVAL)
-		tst_resm(TPASS, "msgctl() test IPC_RMID succeeded");
-	else
-		tst_resm(TFAIL, "msgctl() test IPC_RMID failed unexpectedly");
-}
-
-void cleanup(void)
-{
-}
-- 
2.13.6

