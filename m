Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Yxasp-000506-Kh
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 12:56:31 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yxasm-000442-4a
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 12:56:31 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Wed, 27 May 2015 15:00:21 -0600
Message-ID: <1432760421-14844-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH V2] containers: new testcase userns02
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
Cc: ltp-list@lists.sourceforge.net, pleasuresun@sina.com

The user ID and group ID, which are inside a container, can
be modified by its parent process.

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 runtest/containers                            |   1 +
 testcases/kernel/containers/.gitignore        |   1 +
 testcases/kernel/containers/userns/userns02.c | 113 ++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 testcases/kernel/containers/userns/userns02.c

diff --git a/runtest/containers b/runtest/containers
index ca10372..bb1beb6 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -69,3 +69,4 @@ mountns03 mountns03
 mountns04 mountns04
 
 userns01 userns01
+userns02 userns02
diff --git a/testcases/kernel/containers/.gitignore b/testcases/kernel/containers/.gitignore
index 4478b53..e3c92c9 100644
--- a/testcases/kernel/containers/.gitignore
+++ b/testcases/kernel/containers/.gitignore
@@ -4,3 +4,4 @@ mountns/mountns02
 mountns/mountns03
 mountns/mountns04
 userns/userns01
+userns/userns02
diff --git a/testcases/kernel/containers/userns/userns02.c b/testcases/kernel/containers/userns/userns02.c
new file mode 100644
index 0000000..6a4b36d
--- /dev/null
+++ b/testcases/kernel/containers/userns/userns02.c
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
+ *  The user ID and group ID, which are inside a container, can be modified
+ * by its parent process.
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
+char *TCID = "user_namespace2";
+int TST_TOTAL = 1;
+
+int childpid;
+int parentuid;
+int parentgid;
+char path[BUFSIZ];
+char content[BUFSIZ];
+static int fd;
+/*
+ * child_fn1() - Inside a new user namespace
+ */
+static int child_fn1(void)
+{
+	int exit_val;
+	int uid, gid;
+
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	uid = geteuid();
+	gid = getegid();
+
+	printf("USERNS test is running in a new user namespace.\n");
+	if (uid == 100 && gid == 100) {
+		printf("Got expected uid and gid.\n");
+		exit_val = 0;
+	} else {
+		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
+		exit_val = 1;
+	}
+
+	return exit_val;
+}
+
+static void setup(void)
+{
+	TST_CHECKPOINT_INIT(NULL);
+	check_newuser();
+}
+
+int main(int argc, char *argv[])
+{
+	int status;
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		childpid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
+			(void *)child_fn1, NULL);
+
+		if (childpid < 0)
+			tst_brkm(TFAIL | TERRNO, NULL, "clone failed");
+
+		parentuid = geteuid();
+		parentgid = getegid();
+		sprintf(path, "/proc/%d/uid_map", childpid);
+		sprintf(content, "100 %d 1", parentuid);
+		fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
+		SAFE_WRITE(NULL, 1, fd, content, strlen(content));
+		sprintf(path, "/proc/%d/gid_map", childpid);
+		sprintf(content, "100 %d 1", parentgid);
+		fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
+		SAFE_WRITE(NULL, 1, fd, content, strlen(content));
+
+		TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
+
+		if (waitpid(childpid, &status, 0) < 0)
+			tst_resm(TBROK | TERRNO, "parent: waitpid failed.");
+
+		if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "child exited abnormally");
+		else if (WIFSIGNALED(status)) {
+			tst_resm(TFAIL, "child was killed with signal = %d",
+				WTERMSIG(status));
+		}
+
+	}
+	tst_resm(TPASS, "the uid and the gid are right inside the container");
+	tst_exit();
+}
+
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
