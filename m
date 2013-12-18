Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VtEs0-0004pl-A0
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 11:00:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VtErt-0005XV-Mp
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 11:00:52 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBIB0bSE019869
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Dec 2013 19:00:37 +0800
Message-ID: <1387364436.1634.2.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Wed, 18 Dec 2013 19:00:36 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/2] msgctl/msgctl13.c: add EIDRM test
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

Add EIDRM test for msgctl(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/syscalls                                |   1 +
 runtest/syscalls-ipc                            |   1 +
 testcases/kernel/syscalls/.gitignore            |   1 +
 testcases/kernel/syscalls/ipc/msgctl/msgctl13.c | 107 ++++++++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3254e4d..84ab9db 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -628,6 +628,7 @@ msgctl09 msgctl09
 msgctl10 msgctl10
 msgctl11 msgctl11
 msgctl12 msgctl12
+msgctl13 msgctl13
 
 msgget01 msgget01
 msgget02 msgget02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 415357b..02b6e45 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -10,6 +10,7 @@ msgctl09 msgctl09
 msgctl10 msgctl10
 msgctl11 msgctl11
 msgctl12 msgctl12
+msgctl13 msgctl13
 
 msgget01 msgget01
 msgget02 msgget02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 7be0424..d5ecf01 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -374,6 +374,7 @@
 /ipc/msgctl/msgctl10
 /ipc/msgctl/msgctl11
 /ipc/msgctl/msgctl12
+/ipc/msgctl/msgctl13
 /ipc/msgget/msgget01
 /ipc/msgget/msgget02
 /ipc/msgget/msgget03
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
new file mode 100644
index 0000000..f5a0c38
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
@@ -0,0 +1,107 @@
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
+
+static void setup1(void);
+
+static struct test_case_t {
+	int *queue_id;
+	int ipc_cmd;
+	char *name;
+	void (*setup)(void);
+} test_cases[] = {
+	{&msg_q, IPC_RMID, "IPC_RMID", setup1},
+};
+
+char *TCID = "acct13";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+	int i;
+	struct msqid_ds qs_buf;
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
+			if (TEST_RETURN != 0 || TEST_ERRNO != IPC_RMID) {
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
+}
+
+static void setup1(void)
+{
+	msg_q = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	if (msg_q == -1)
+		tst_brkm(TBROK, cleanup, "Can't create message queue");
+}
+
+void cleanup(void)
+{
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
