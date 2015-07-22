Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZHm4x-0002Ud-Oe
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 04:56:27 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZHm4m-0004KB-Hj
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 04:56:27 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Wed, 22 Jul 2015 21:00:25 +0800
Message-ID: <1437570025-3897-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] container: new testcase pidns32
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

Kernel imposes a limit of 32 nested levels of pid namespaces.

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/pidns/.gitignore |   1 +
 testcases/kernel/containers/pidns/pidns32.c  | 113 +++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 testcases/kernel/containers/pidns/pidns32.c

diff --git a/testcases/kernel/containers/pidns/.gitignore b/testcases/kernel/containers/pidns/.gitignore
index e56c1f9..488b045 100644
--- a/testcases/kernel/containers/pidns/.gitignore
+++ b/testcases/kernel/containers/pidns/.gitignore
@@ -12,3 +12,4 @@
 /pidns20
 /pidns30
 /pidns31
+/pidns32
diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
new file mode 100644
index 0000000..8a4459b
--- /dev/null
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -0,0 +1,113 @@
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
+ * The kernel imposes a limit of 32 nested levels of pid namespaces.
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
+#include "pidns_helper.h"
+
+#define MAXNEST 32
+
+char *TCID = "pidns32";
+int TST_TOTAL = 1;
+
+static void setup(void)
+{
+	check_newpid();
+	tst_tmpdir();
+}
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+static int child_fn1(void *arg)
+{
+	pid_t cpid1;
+	long level = (long)arg;
+
+	cpid1 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD,
+		(void *)child_fn1, (void *)(level + 1));
+	if (cpid1 < 0) {
+		if (level == (MAXNEST))
+			return 0;
+		return 1;
+	}
+	if (waitpid(cpid1, NULL, 0) == -1)
+		return 1;
+	return 0;
+}
+
+static int wait4child(pid_t pid, const char *msg)
+{
+	int status;
+
+	if (waitpid(pid, &status, 0) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	} else if (WIFSIGNALED(status)) {
+		tst_resm(TFAIL, "%s: child was killed with signal = %d",
+			msg, WTERMSIG(status));
+		return WTERMSIG(status);
+	} else if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		tst_resm(TFAIL, "%s: child returns %d", msg, status);
+		return WEXITSTATUS(status);
+	}
+
+	return 0;
+}
+
+static void test_max_nest(void)
+{
+	pid_t cpid1;
+	int status;
+
+	cpid1 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD,
+		(void *)child_fn1, (void *)1);
+	if (cpid1 < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+
+	status = 0;
+	status |= wait4child(cpid1, "child1");
+	if (status == 0)
+		tst_resm(TPASS, "The function works well.");
+	else
+		tst_resm(TFAIL, "Some child reported failure.");
+}
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	setup();
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		test_max_nest();
+	}
+
+	cleanup();
+	tst_exit();
+}
-- 
1.9.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
