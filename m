Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1YwixK-0007vW-Nu
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2015 03:21:34 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YwixG-0005eD-4r
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2015 03:21:34 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Mon, 25 May 2015 05:24:44 -0600
Message-ID: <1432553084-9391-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] containers: new testcase userns02 The user ID and
	group ID, which are inside a container,
	can be modified by its parent process.
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

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 runtest/containers                            |  1 +
 testcases/kernel/containers/.gitignore        |  1 +
 testcases/kernel/containers/userns/userns02.c | 94 +++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
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
index 0000000..078439e
--- /dev/null
+++ b/testcases/kernel/containers/userns/userns02.c
@@ -0,0 +1,94 @@
+/*
+* Copyright (c) Huawei Technologies Co., Ltd., 2015
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of the GNU General Public License as published by the Free
+* Software Foundation; either version 2 of the License, or (at your option)
+* any later version. This program is distributed in the hope that it will be
+* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
+* Public License for more details. You should have received a copy of the GNU
+* General Public License along with this program.
+*
+*
+* Verify that:
+*  The user ID and group ID, which are inside a container, can be modified by
+* its parent process.
+*/
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
+#include "libclone.h"
+#include "userns_helper.h"
+
+char *TCID = "user_namespace2";
+int TST_TOTAL = 1;
+
+char fullpath[BUFSIZ];
+pid_t childpid;
+int parentuid;
+int parentgid;
+char cmd[BUFSIZ];
+FILE *fp;
+/*
+ * child_fn1() - Inside a new user namespace
+ */
+static int child_fn1(void *arg)
+{
+	int exit_val;
+	int uid, gid;
+
+	sleep(1);
+	uid = geteuid();
+	gid = getegid();
+
+	tst_resm(TINFO, "USERNS test is running in a new user namespace.");
+	if (uid == 100 && gid == 100) {
+		tst_resm(TINFO,  "Got expected uid and gid.");
+		exit_val = 0;
+	} else {
+		tst_brkm(TFAIL | TTERRNO, NULL, "Got unexpected result of uid=%d gid=%d\n",
+			uid, gid);
+		exit_val = 1;
+	}
+
+	return exit_val;
+}
+
+static void setup(void)
+{
+	check_newuser();
+}
+
+int main(int argc, char *argv[])
+{
+	int status;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+	setup();
+
+	childpid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, child_fn1, NULL);
+
+	if (childpid < 0)
+		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
+
+	parentuid = geteuid();
+	sprintf(cmd, "echo 100 %d 1 > /proc/%d/uid_map", parentuid, childpid);
+	system(cmd);
+	parentgid = getegid();
+	sprintf(cmd, "echo 100 %d 1 > /proc/%d/gid_map", parentgid, childpid);
+	system(cmd);
+
+	if (waitpid(childpid, &status, 0) < 0)
+		tst_resm(TWARN, "parent: waitpid failed.");
+
+	tst_resm(TPASS, "the uid and the gid are right inside the container");
+	tst_exit();
+}
+
-- 
1.9.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
