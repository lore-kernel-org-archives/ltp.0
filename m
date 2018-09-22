From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sat, 22 Sep 2018 17:30:44 +0800
Subject: [LTP] [PATCH 2/2] syscalls/getxattr05: Add new regression testcase
In-Reply-To: <1537608644-14994-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1537608644-14994-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1537608644-14994-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test POSIX Access Control Lists by getxattr(2) with/without a
user namespace.  The following issue is included by the new
testcase and has been fixed in kernel:
'82c9a927bc5d ("getxattr: use correct xattr length")'

Fix #396

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/getxattr/.gitignore   |   1 +
 testcases/kernel/syscalls/getxattr/Makefile     |   2 +
 testcases/kernel/syscalls/getxattr/getxattr05.c | 171 ++++++++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 testcases/kernel/syscalls/getxattr/getxattr05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be77..bfdd450 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -461,6 +461,7 @@ getxattr01 getxattr01
 getxattr02 getxattr02
 getxattr03 getxattr03
 getxattr04 getxattr04
+getxattr05 getxattr05
 
 #Needs tty device.
 #ioctl01 ioctl01 -D /dev/tty0
diff --git a/testcases/kernel/syscalls/getxattr/.gitignore b/testcases/kernel/syscalls/getxattr/.gitignore
index 3918a30..cded941 100644
--- a/testcases/kernel/syscalls/getxattr/.gitignore
+++ b/testcases/kernel/syscalls/getxattr/.gitignore
@@ -2,3 +2,4 @@
 /getxattr02
 /getxattr03
 /getxattr04
+/getxattr05
diff --git a/testcases/kernel/syscalls/getxattr/Makefile b/testcases/kernel/syscalls/getxattr/Makefile
index 72544c1..3f78745 100644
--- a/testcases/kernel/syscalls/getxattr/Makefile
+++ b/testcases/kernel/syscalls/getxattr/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+getxattr05: LDLIBS	+= $(ACL_LIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
new file mode 100644
index 0000000..8656205
--- /dev/null
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+/*
+ * Description:
+ * 1) Witout a user namespace, getxattr(2) should get same data when
+ *    acquiring the value of system.posix_acl_access twice.
+ * 2) With/Without mapped root UID in a user namespaces, getxattr(2) should
+ *    get same data when acquiring the value of system.posix_acl_access twice.
+ *
+ * This issue included by getxattr05 has been fixed in kernel:
+ * '82c9a927bc5d ("getxattr: use correct xattr length")'
+ */
+
+#define _GNU_SOURCE
+#include "config.h"
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sched.h>
+#include <stdlib.h>
+
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
+#endif
+
+#ifdef HAVE_LIBACL
+# include <sys/acl.h>
+#endif
+
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
+
+#if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
+
+#define TEST_FILE	"testfile"
+#define MAX_USERNS	"/proc/sys/user/max_user_namespaces"
+#define UID_MAP	"/proc/self/uid_map"
+
+static acl_t acl;
+static int orig_max_userns = -1;
+
+static struct tcase {
+	/* 0: without userns, 1: with userns */
+	int set_userns;
+	/* 0: don't map root UID in userns, 1: map root UID in userns */
+	int map_root;
+} tcases[] = {
+	{0, 0},
+	{1, 0},
+	{1, 1},
+};
+
+static void verify_getxattr(void)
+{
+	ssize_t i, res1, res2;
+	char buf1[128], buf2[132];
+
+	res1 = SAFE_GETXATTR(TEST_FILE, "system.posix_acl_access",
+			     buf1, sizeof(buf1));
+	res2 = SAFE_GETXATTR(TEST_FILE, "system.posix_acl_access",
+			     buf2, sizeof(buf2));
+
+	if (res1 != res2) {
+		tst_res(TFAIL, "Return different sizes when acquiring "
+			"the value of system.posix_acl_access twice");
+		return;
+	}
+
+	for (i = 0; i < res1; i++) {
+		if (buf1[i] != buf2[i])
+			break;
+	}
+
+	if (i < res1) {
+		tst_res(TFAIL, "Got different data(%02x != %02x)@%ld",
+			buf1[i], buf2[i], i);
+		return;
+	}
+
+	tst_res(TPASS, "Got same data when acquiring the value of "
+		"system.posix_acl_access twice");
+}
+
+static void do_unshare(int map_root)
+{
+	int res;
+
+	/* unshare() should support CLONE_NEWUSER flag since Linux 3.8 */
+	res = unshare(CLONE_NEWUSER);
+	if (res == -1)
+		tst_brk(TFAIL | TERRNO, "unshare(CLONE_NEWUSER) failed");
+
+	if (map_root) {
+		/* uid_map file should exist since Linux 3.8 because
+		 * it is available on Linux 3.5
+		 */
+		if (access(UID_MAP, F_OK))
+			tst_brk(TBROK, "file %s didn't exist", UID_MAP);
+
+		SAFE_FILE_PRINTF(UID_MAP, "%d %d %d", 0, 0, 1);
+	}
+}
+
+static void do_getxattr(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		if (tc->set_userns)
+			do_unshare(tc->map_root);
+
+		verify_getxattr();
+		exit(0);
+	}
+
+	tst_reap_children();
+}
+
+static void setup(void)
+{
+	const char *acl_text = "u::rw-,u:root:rwx,g::r--,o::r--,m::rwx";
+	int res;
+
+	SAFE_TOUCH(TEST_FILE, 0644, NULL);
+
+	acl = acl_from_text(acl_text);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_from_text() failed");
+
+	res = acl_set_file(TEST_FILE, ACL_TYPE_ACCESS, acl);
+	if (res == -1)
+		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
+
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call unshare().
+	 */
+	if (!access(MAX_USERNS, F_OK)) {
+		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
+		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
+	}
+}
+
+static void cleanup(void)
+{
+	if (orig_max_userns != -1)
+		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns);
+
+	if (acl)
+		acl_free(acl);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = do_getxattr,
+	.min_kver = "3.8",
+};
+
+#else /* HAVE_SYS_XATTR_H && HAVE_LIBACL*/
+	TST_TEST_TCONF("<sys/xattr.h> or <sys/acl.h> does not exist.");
+#endif
-- 
1.8.3.1



