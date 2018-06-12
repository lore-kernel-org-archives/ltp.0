From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jun 2018 17:46:29 +0200
Subject: [LTP] [RFC PATCH 7/9] syscalls/ipc: Rewrite msgctl12 to new library
In-Reply-To: <20180612154631.435-1-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
Message-ID: <20180612154631.435-8-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl12.c | 84 +++++++++----------------
 1 file changed, 29 insertions(+), 55 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
index 2621f8040..46e9fdb44 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -14,87 +15,60 @@
  * with this program.
  */
 /*
- * DESCRIPTION
- *	msgctl12 - test for IPC_INFO MSG_INFO and MSG_STAT.
+ * msgctl12 - test for IPC_INFO MSG_INFO and MSG_STAT.
  */
 
 #define _GNU_SOURCE
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/msg.h>
 #include <errno.h>
 
-#include "test.h"
-#include "ipcmsg.h"
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
 
 static int msg_q;
 static int index_q;
 static struct msginfo msginfo_buf;
 static struct msqid_ds msgqid_buf;
 
-static struct test_case_t {
-	int *queue_id;
-	int ipc_cmd;
+static struct tcase {
+	int *msg_id;
+	int cmd;
 	char *name;
 	void *buf;
-} test_cases[] = {
+} tc[] = {
 	{&msg_q, IPC_INFO, "IPC_INFO", &msginfo_buf},
 	{&msg_q, MSG_INFO, "MSG_INFO", &msginfo_buf},
 	{&index_q, MSG_STAT, "MSG_STAT", &msgqid_buf},
 };
 
-char *TCID = "msgctl12";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int argc, char *argv[])
+static void verify_msgctl(unsigned int i)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
+	TEST(msgctl(*tc[i].msg_id,  tc[i].cmd, tc[i].buf));
 
-			TEST(msgctl(*test_cases[i].queue_id,
-				    test_cases[i].ipc_cmd, test_cases[i].buf));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL,
-					 "msgctl() test %s failed with errno: "
-					 "%d", test_cases[i].name, TEST_ERRNO);
-			} else {
-				tst_resm(TPASS, "msgctl() test %s succeeded",
-					 test_cases[i].name);
-			}
-		}
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL,
+			 "msgctl() test %s failed with errno: "
+			 "%d", tc[i].name, TEST_ERRNO);
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "msgctl() test %s succeeded", tc[i].name);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	msg_q = msgget(IPC_PRIVATE, MSG_RW);
-	if (msg_q < 0)
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
-
-	index_q = msgctl(msg_q, IPC_INFO, (struct msqid_ds *)&msginfo_buf);
-	if (index_q < 0)
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
+	msg_q = SAFE_MSGGET(IPC_PRIVATE, MSG_RW);
+	index_q = SAFE_MSGCTL(msg_q, IPC_INFO, (struct msqid_ds*)&msginfo_buf);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	rm_queue(msg_q);
+	if (msg_q > 0)
+		SAFE_MSGCTL(msg_q, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_msgctl,
+	.tcnt = ARRAY_SIZE(tc),
+};
-- 
2.13.6

