Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WGlYQ-0000pv-3c
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 08:33:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGlYO-0002kh-MK
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 08:33:54 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1L8Xhox025679
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 16:33:44 +0800
Message-ID: <1392971619.3069.3.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 21 Feb 2014 16:33:39 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] mq_notify/mq_notify02.c: add new error tests
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

Add EINVAL error tests for mq_notify(2).

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/.gitignore              |  1 +
 testcases/kernel/syscalls/mq_notify/mq_notify02.c | 97 +++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mq_notify/mq_notify02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index aec49ad..dcfceeb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -608,6 +608,7 @@ mprotect02 mprotect02
 mprotect03 mprotect03
 
 mq_notify01 mq_notify01
+mq_notify02 mq_notify02
 mq_open01 mq_open01
 mq_timedreceive01 mq_timedreceive01
 mq_timedsend01 mq_timedsend01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d461569..c9552c6 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -550,6 +550,7 @@
 /mprotect/mprotect02
 /mprotect/mprotect03
 /mq_notify/mq_notify01
+/mq_notify/mq_notify02
 /mq_open/mq_open01
 /mq_timedreceive/mq_timedreceive01
 /mq_timedsend/mq_timedsend01
diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify02.c b/testcases/kernel/syscalls/mq_notify/mq_notify02.c
new file mode 100644
index 0000000..46ae3e3
--- /dev/null
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify02.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
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
+/*
+ * ALGORITHM
+ *	test 1:
+ *		sevp->sigev_notify = -1, EINVAL should be returned.
+ *	test 2:
+ *		sevp->sigev_notify = SIGEV_SIGNAL and sevp->sigev_signo > _NSG,
+ *		EINVAL should be returned.
+ */
+
+#include <errno.h>
+#include <mqueue.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "mq_notify02";
+static void setup(void);
+static void cleanup(void);
+
+static struct test_case_t {
+	struct sigevent sevp;
+	int exp_errno;
+} test_cases[] = {
+	{{.sigev_notify = -1}, EINVAL},
+	{{.sigev_notify = SIGEV_SIGNAL, .sigev_signo = _NSIG+1}, EINVAL},
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static void mq_notify_verify(struct test_case_t *);
+static int exp_enos[] = { EINVAL, 0 };
+
+int main(int argc, char **argv)
+{
+	int lc;
+	int i;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	TEST_EXP_ENOS(exp_enos);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			mq_notify_verify(&test_cases[i]);
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+}
+
+static void mq_notify_verify(struct test_case_t *test)
+{
+	TEST(mq_notify(0, &(test->sevp)));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "mq_notify() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "mq_notify failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "mq_notify failed unexpectedly; expected: %d - %s",
+			 test->exp_errno, strerror(test->exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.8.4.2




------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
