Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1YvGDt-0000ab-5e
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 02:28:37 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YvGDo-00061r-Dt
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 02:28:37 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Thu, 21 May 2015 04:31:58 -0600
Message-ID: <1432204318-18309-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH V2] Add userns01 testcase to verify user namespace.
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
 testcases/kernel/containers/userns01/Makefile      | 26 +++++++
 testcases/kernel/containers/userns01/userns01.c    | 90 ++++++++++++++++++++++
 .../kernel/containers/userns01/userns_helper.h     | 37 +++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 testcases/kernel/containers/userns01/Makefile
 create mode 100644 testcases/kernel/containers/userns01/userns01.c
 create mode 100644 testcases/kernel/containers/userns01/userns_helper.h

diff --git a/testcases/kernel/containers/userns01/Makefile b/testcases/kernel/containers/userns01/Makefile
new file mode 100644
index 0000000..9f67216
--- /dev/null
+++ b/testcases/kernel/containers/userns01/Makefile
@@ -0,0 +1,26 @@
+###############################################################################
+#                                                                            ##
+# Copyright (c) Huawei Technologies Co., Ltd., 2015                          ##
+#                                                                            ##
+# This program is free software;  you can redistribute it and#or modify      ##
+# it under the terms of the GNU General Public License as published by       ##
+# the Free Software Foundation; either version 2 of the License, or          ##
+# (at your option) any later version.                                        ##
+#                                                                            ##
+# This program is distributed in the hope that it will be useful, but        ##
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+# for more details.                                                          ##
+#                                                                            ##
+# You should have received a copy of the GNU General Public License          ##
+# along with this program.                                                   ##
+###############################################################################
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS			:= -lclone -lltp
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/userns01/userns01.c b/testcases/kernel/containers/userns01/userns01.c
new file mode 100644
index 0000000..c6022b5
--- /dev/null
+++ b/testcases/kernel/containers/userns01/userns01.c
@@ -0,0 +1,90 @@
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
+*  If a user ID has no mapping inside the namespace, user ID and group
+* ID will be the value defined in the file /proc/sys/kernel/overflowuid, 65534.
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
+#define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
+
+char *TCID = "user_namespace1";
+int TST_TOTAL = 1;
+
+char fullpath[BUFSIZ];
+long overflowuid;
+
+/*
+ * child_fn1() - Inside a new user namespace
+ */
+static int child_fn1(void *arg)
+{
+	int exit_val;
+	int uid, gid;
+
+	uid = geteuid();
+	gid = getegid();
+
+	tst_resm(TINFO, "USERNS test is running in a new user namespace.");
+	if (uid == overflowuid && gid == overflowuid) {
+		printf("Got expected uid and gid\n");
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
+	check_newuser();
+	SAFE_FILE_SCANF(NULL, OVERFLOWUIDPATH, "%ld", &overflowuid);
+}
+
+int main(int argc, char *argv[])
+{
+	int status;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+	setup();
+
+	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, child_fn1, NULL));
+
+	if (TEST_RETURN == -1)
+		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
+	else if ((wait(&status)) == -1)
+		tst_brkm(TWARN | TERRNO, NULL, "wait failed");
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+		tst_resm(TFAIL, "child exited abnormally");
+	else if (WIFSIGNALED(status)) {
+		tst_resm(TFAIL, "child was killed with signal = %d",
+			 WTERMSIG(status));
+	}
+
+	tst_resm(TPASS, "the uid and the gid are right inside the container");
+	tst_exit();
+}
+
diff --git a/testcases/kernel/containers/userns01/userns_helper.h b/testcases/kernel/containers/userns01/userns_helper.h
new file mode 100644
index 0000000..3fb7288
--- /dev/null
+++ b/testcases/kernel/containers/userns01/userns_helper.h
@@ -0,0 +1,37 @@
+/*
+* Copyright (c) Huawei Technologies Co., Ltd., 2015
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+* the GNU General Public License for more details.
+*/
+
+#include "../libclone/libclone.h"
+#include "test.h"
+#include "safe_macros.h"
+
+static int dummy_child(void *v)
+{
+	(void) v;
+	return 0;
+}
+
+static int check_newuser(void)
+{
+	int pid, status;
+
+	if (tst_kvercmp(3, 8, 0) < 0)
+		tst_brkm(TCONF, NULL, "CLONE_NEWUSER not supported");
+
+	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, dummy_child, NULL);
+	if (pid == -1)
+		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUSER not supported");
+	SAFE_WAIT(NULL, &status);
+
+	return 0;
+}
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
