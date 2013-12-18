Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VtEqZ-0004gz-BD
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 10:59:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VtEqX-0006xP-9o
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 10:59:23 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBIAxCcd019756
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Dec 2013 18:59:13 +0800
Message-ID: <1387364351.1634.1.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Wed, 18 Dec 2013 18:59:11 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/2] msgctl/msgctl12.c: add new tests
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Add new tests for msgctl(2):
IPC_INFO
MSG_INFO
MSG_STAT

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/syscalls                                |   1 +
 runtest/syscalls-ipc                            |   1 +
 testcases/kernel/syscalls/.gitignore            |   1 +
 testcases/kernel/syscalls/ipc/msgctl/msgctl12.c | 116 ++++++++++++++++++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl12.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c5bbe8f..3254e4d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -627,6 +627,7 @@ msgctl08 msgctl08
 msgctl09 msgctl09
 msgctl10 msgctl10
 msgctl11 msgctl11
+msgctl12 msgctl12
 
 msgget01 msgget01
 msgget02 msgget02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index f57a96e..415357b 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -9,6 +9,7 @@ msgctl08 msgctl08
 msgctl09 msgctl09
 msgctl10 msgctl10
 msgctl11 msgctl11
+msgctl12 msgctl12
 
 msgget01 msgget01
 msgget02 msgget02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index bbefb25..7be0424 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -373,6 +373,7 @@
 /ipc/msgctl/msgctl09
 /ipc/msgctl/msgctl10
 /ipc/msgctl/msgctl11
+/ipc/msgctl/msgctl12
 /ipc/msgget/msgget01
 /ipc/msgget/msgget02
 /ipc/msgget/msgget03
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
new file mode 100644
index 0000000..5dfa552
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
@@ -0,0 +1,116 @@
+/*
+ * Copyright (c) 2013 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <errno.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "ipcmsg.h"
+
+static int msg_q;
+static int index_q;
+static struct msqid_ds qs_buf;
+
+static void setup3(void);
+
+static struct test_case_t {
+	int *queue_id;
+	int ipc_cmd;
+	char *name;
+	void (*setup)(void);
+} test_cases[] = {
+	{&msg_q, IPC_INFO, "IPC_INFO", NULL},
+	{&msg_q, MSG_INFO, "MSG_INFO", NULL},
+	{&index_q, MSG_STAT, "MSG_STAT", setup3},
+};
+
+char *TCID = "acct12";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+	int i;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+
+			if (test_cases[i].setup != NULL)
+				test_cases[i].setup();
+
+			TEST(msgctl(*test_cases[i].queue_id,
+				    test_cases[i].ipc_cmd, &qs_buf));
+
+			if (TEST_RETURN == -1) {
+				tst_resm(TFAIL,
+					 "msgctl() test %s failed with errno: "
+					 "%d", test_cases[i].name, TEST_ERRNO);
+			} else {
+				tst_resm(TPASS, "msgctl() test %s succeeded",
+					 test_cases[i].name);
+			}
+		}
+	}
+
+	cleanup();
+
+	tst_exit();
+}
+
+void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	msgkey = getipckey();
+
+	msg_q = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	if (msg_q == -1)
+		tst_brkm(TBROK, cleanup, "Can't create message queue");
+}
+
+static void setup3(void)
+{
+	index_q = msgctl(msg_q, IPC_INFO, &qs_buf);
+	if (index_q < 0)
+		tst_brkm(TBROK, cleanup, "Can't create message queue");
+}
+
+void cleanup(void)
+{
+	rm_queue(msg_q);
+
+	tst_rmdir();
+
+	TEST_CLEANUP;
+}
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
