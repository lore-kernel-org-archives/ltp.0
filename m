Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZL3di-00053m-3P
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 06:17:54 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZL3de-0005pg-Hc
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 06:17:54 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Fri, 31 Jul 2015 14:17:44 +0800
Message-ID: <1438323464-29672-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH V2] containers: new testcase userns05
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

  A process created via fork(2) or clone(2) without the CLONE_NEWUSER
flag is a member of the same user namespace as its parent.
  When unshare an user namespace, the calling process is moved into a
new user namespace which is not shared with any previously existing
process.

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/userns/userns05.c | 142 ++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 testcases/kernel/containers/userns/userns05.c

diff --git a/testcases/kernel/containers/userns/userns05.c b/testcases/kernel/containers/userns/userns05.c
new file mode 100644
index 0000000..18178d0
--- /dev/null
+++ b/testcases/kernel/containers/userns/userns05.c
@@ -0,0 +1,142 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd., 2015
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ */
+
+/*
+ * Verify that:
+ * A process created via fork(2) or clone(2) without the
+ * CLONE_NEWUSER flag is a member of the same user namespace as its
+ * parent.
+ * When unshare an user namespace, the calling process is moved into
+ * a new user namespace which is not shared with any previously
+ * existing process.
+ */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include "test.h"
+#include "userns_helper.h"
+
+char *TCID = "user_namespace5";
+int TST_TOTAL = 1;
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+/*
+ * child_fn1() - Inside a new user namespace
+ */
+static int child_fn1(void)
+{
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	return 0;
+}
+
+static long getusernsidbypid(int pid)
+{
+	char path[BUFSIZ];
+	char userid[BUFSIZ];
+	long id = 0;
+
+	sprintf(path, "/proc/%d/ns/user", pid);
+
+	if (readlink(path, userid, BUFSIZ) == -1)
+		tst_resm(TFAIL, "readlink failure.");
+
+	if (sscanf(userid, "user:[%ld]", &id) != 1)
+		tst_resm(TFAIL | TERRNO, "sscanf failure.");
+	return id;
+}
+
+static void test_userns_id(void)
+{
+	int cpid1, cpid2, cpid3;
+	long parentuserns, cpid1userns, cpid2userns, newparentuserns;
+
+	parentuserns = getusernsidbypid(getpid());
+	cpid1 = ltp_clone_quick(SIGCHLD, (void *)child_fn1,
+		NULL);
+	if (cpid1 < 0)
+		tst_brkm(TFAIL | TERRNO, cleanup, "clone failed");
+	cpid1userns = getusernsidbypid(cpid1);
+	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+
+	/* A process created via fork(2) or clone(2) without the
+	CLONE_NEWUSER flag is a member of the same user namespace as its
+	parent.*/
+	if (parentuserns != cpid1userns)
+		tst_resm(TFAIL, "userns:parent should be equal to cpid1");
+
+	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
+		(void *)child_fn1, NULL);
+	if (cpid2 < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+	cpid2userns = getusernsidbypid(cpid2);
+	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+
+	if (parentuserns == cpid2userns)
+		tst_resm(TFAIL, "userns:parent should be not equal to cpid2");
+
+	switch (cpid3 = fork()) {
+	case -1:
+		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+	case 0:
+		if (unshare(CLONE_NEWUSER) == -1) {
+			printf("parent pid unshare failure: (%d) %s",
+				errno, strerror(errno));
+			exit(1);
+		}
+		newparentuserns = getusernsidbypid(getpid());
+
+		/* When unshare an user namespace, the calling process
+		is moved into a new user namespace which is not shared
+		with any previously existing process.*/
+		if (parentuserns == newparentuserns)
+			exit(1);
+		exit(0);
+	}
+
+	tst_record_childstatus(cleanup, cpid1);
+	tst_record_childstatus(cleanup, cpid2);
+	tst_record_childstatus(cleanup, cpid3);
+}
+
+static void setup(void)
+{
+	check_newuser();
+
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(NULL);
+}
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		test_userns_id();
+	}
+	cleanup();
+	tst_exit();
+}
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
