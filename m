From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 23 Nov 2016 15:18:31 +0800
Subject: [LTP] [PATCH 4/4] ipc/msgget03.c: cleanup && convert to new API
In-Reply-To: <1479885511-7414-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1479885511-7414-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1479885511-7414-4-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/msgget/msgget03.c | 192 ++++++++----------------
 1 file changed, 60 insertions(+), 132 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 2eda252..f096475 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -1,168 +1,96 @@
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
- *	msgget03.c
+ * NAME: msgget03.c
  *
  * DESCRIPTION
- *	msgget03 - test for an ENOSPC error by using up all available
- *		   message queues.
- *
- * ALGORITHM
- *	Get all the message queues that can be allocated
- *	loop if that option was specified
- *	Try to get one more message queue
- *	check the errno value
- *	  issue a PASS message if we get ENOSPC
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  msgget03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
+ * test for an ENOSPC error by using up all available
+ * message queues.
  *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
  */
 
-#include "test.h"
-
-#include "ipcmsg.h"
-
-char *TCID = "msgget03";
-int TST_TOTAL = 1;
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <stdlib.h>
 
-int maxmsgs = 0;
+#include "tst_ipcmsg.h"
+#include "tst_test.h"
 
-int *msg_q_arr = NULL;		/* hold the id's that we create */
-int num_queue = 0;		/* count the queues created */
+static int maxmsgs;
+static int *msg_q_arr;
 
-int main(int ac, char **av)
+static void verify_msgget(void)
 {
-	int lc;
-	int msg_q;
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
-		 * Use a while loop to create the maximum number of queues.
-		 * When we get an error, check for ENOSPC.
-		 */
-		while ((msg_q =
-			msgget(msgkey + num_queue,
-			       IPC_CREAT | IPC_EXCL)) != -1) {
-			msg_q_arr[num_queue] = msg_q;
-			if (num_queue == maxmsgs) {
-				tst_resm(TINFO, "The maximum number of message"
-					 " queues (%d) has been reached",
-					 maxmsgs);
-				break;
-			}
-			num_queue++;
-		}
-
-		switch (errno) {
-		case ENOSPC:
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
+	TEST(msgget(msgkey + maxmsgs, IPC_CREAT | IPC_EXCL));
+	if (TEST_RETURN != -1)
+		tst_res(TFAIL, "msgget() succeeded unexpectedly");
+
+	if (TEST_ERRNO == ENOSPC)
+		tst_res(TPASS | TTERRNO, "msgget() failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "msgget() failed unexpectedly,"
+			" expected %s", tst_strerrno(ENOSPC));
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
+	int res, num;
 
 	msgkey = getipckey();
 
 	maxmsgs = get_max_msgqueues();
 	if (maxmsgs < 0)
-		tst_brkm(TBROK, cleanup, "get_max_msgqueues failed");
+		tst_brk(TBROK, "get_max_msgqueues failed");
 
 	msg_q_arr = (int *)calloc(maxmsgs, sizeof(int));
-	if (msg_q_arr == NULL) {
-		tst_brkm(TBROK, cleanup, "Couldn't allocate memory "
+	if (!msg_q_arr) {
+		tst_brk(TBROK, "Couldn't allocate memory "
 			 "for msg_q_arr: calloc() failed");
 	}
+
+	for (num = 0; num < maxmsgs; num++) {
+		msg_q_arr[num] = -1;
+
+		res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
+		if (res != -1)
+			msg_q_arr[num] = res;
+	}
+
+	tst_res(TINFO, "The maximum number of message queues (%d) has been reached", maxmsgs);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test@completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	int i;
+	int num;
 
-	/*
-	 * remove the message queues if they were created
-	 */
+	if (msg_q_arr) {
+		for (num = 0; num < maxmsgs; num++)
+			rm_queue(msg_q_arr[num]);
 
-	if (msg_q_arr != NULL) {
-		for (i = 0; i < num_queue; i++) {
-			rm_queue(msg_q_arr[i]);
-		}
 		(void)free(msg_q_arr);
 	}
-
-	tst_rmdir();
-
 }
+
+static struct tst_test test = {
+	.tid = "msgget03",
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_msgget
+};
-- 
1.8.3.1



