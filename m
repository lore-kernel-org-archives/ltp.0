Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1RlGR9-0004RZ-St
	for ltp-list@lists.sourceforge.net; Thu, 12 Jan 2012 08:55:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RlGR6-0005BB-1B
	for ltp-list@lists.sourceforge.net; Thu, 12 Jan 2012 08:55:07 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0C8sws0015324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Jan 2012 03:54:58 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Thu, 12 Jan 2012 16:54:48 +0800
Message-Id: <1326358488-15419-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1326358488-15419-1-git-send-email-eguan@redhat.com>
References: <1326358488-15419-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.5"
Subject: [LTP] [PATCH 2/2] syscalls/setxattr03: net testcase to test
	setxattr(2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.7.5
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


setxattr(2) to immutable and append-only files should get EPERM

There are 2 test cases:
1. Set attribute to a immutable file, setxattr(2) should return -1
   and set errno to EPERM
2. Set attribute to a append-only file, setxattr(2) should return
   -1 and set errno to EPERM

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 runtest/syscalls                                |    1 +
 testcases/kernel/syscalls/setxattr/setxattr03.c |  222 +++++++++++++++++++++++
 2 files changed, 223 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/setxattr/setxattr03.c


--------------1.7.7.5
Content-Type: text/x-patch;
	name="0002-syscalls-setxattr03-net-testcase-to-test-setxattr-2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-syscalls-setxattr03-net-testcase-to-test-setxattr-2.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index d786746..37dfc7e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1027,6 +1027,7 @@ setuid04_16 setuid04_16
 
 setxattr01 setxattr01
 setxattr02 setxattr02
+setxattr03 setxattr03
 
 shmat01 shmat01
 shmat02 shmat02
diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
new file mode 100644
index 0000000..223bff7
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -0,0 +1,222 @@
+/*
+ * Copyright (C) 2011 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+/*
+ * setxattr(2) to immutable and append-only files should get EPERM
+ *
+ * There are 2 test cases:
+ * 1. Set attribute to a immutable file, setxattr(2) should return -1
+ *    and set errno to EPERM
+ * 2. Set attribute to a append-only file, setxattr(2) should return
+ *    -1 and set errno to EPERM
+ */
+
+#include "config.h"
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#ifdef HAVE_ATTR_XATTR_H
+#include <attr/xattr.h>
+#endif
+#include <linux/fs.h>
+
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "setxattr03";
+
+#ifdef HAVE_ATTR_XATTR_H
+#define XATTR_TEST_KEY "user.testkey"
+#define XATTR_TEST_VALUE "this is a test value"
+#define XATTR_TEST_VALUE_SIZE 20
+
+#define IMMU_FILE "setxattr03immutable"
+#define APPEND_FILE  "setxattr03appendonly"
+
+#define set_immutable_on(fd) fsetflag(fd, 1, 1)
+#define set_immutable_off(fd) fsetflag(fd, 0, 1)
+#define set_append_on(fd) fsetflag(fd, 1, 0)
+#define set_append_off(fd) fsetflag(fd, 0, 0)
+
+struct test_case {
+	char *desc;
+	char *fname;
+	char *key;
+	char *value;
+	size_t size;
+	int flags;
+	int exp_err;
+};
+static struct test_case tc[] = {
+	{	/* case 00, set attr to immutable file */
+		.desc = "Set attr to immutable file",
+		.fname = IMMU_FILE,
+		.key = XATTR_TEST_KEY,
+		.value = XATTR_TEST_VALUE,
+		.size = XATTR_TEST_VALUE_SIZE,
+		.flags = XATTR_CREATE,
+		.exp_err = EPERM,
+	},
+	{	/* case 01, set attr to append-only file */
+		.desc = "Set attr to append-only file",
+		.fname = APPEND_FILE,
+		.key = XATTR_TEST_KEY,
+		.value = XATTR_TEST_VALUE,
+		.size = XATTR_TEST_VALUE_SIZE,
+		.flags = XATTR_CREATE,
+		.exp_err = EPERM,
+	},
+};
+
+static void setup(void);
+static void cleanup(void);
+
+static int immu_fd;
+static int append_fd;
+
+int TST_TOTAL = sizeof(tc) / sizeof(tc[0]);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	int i;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)	{
+			TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value,
+			    tc[i].size, tc[i].flags));
+
+			if (TEST_ERRNO == tc[i].exp_err) {
+				tst_resm(TPASS | TTERRNO, tc[i].desc);
+			} else {
+				tst_resm(TFAIL | TTERRNO, "%s - expected errno"
+				    " %d - Got", tc[i].desc, tc[i].exp_err);
+			}
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static int fsetflag(int fd, int on, int immutable)
+{
+	int fsflags = 0;
+	int fsfl;
+
+	if (ioctl(fd, FS_IOC_GETFLAGS, &fsflags) < 0)
+		return 1;
+
+	if (immutable)
+		fsfl = FS_IMMUTABLE_FL;
+	else
+		fsfl = FS_APPEND_FL;
+
+	if (on)
+		fsflags |= fsfl;
+	else
+		fsflags &= ~fsfl;
+
+	if (ioctl(fd, FS_IOC_SETFLAGS, &fsflags) < 0)
+		return 1;
+
+	return 0;
+}
+
+static void setup(void)
+{
+	int fd;
+
+	tst_require_root(NULL);
+
+	tst_tmpdir();
+
+	/* Test for xattr support */
+	fd = creat("testfile", 0644);
+	if (fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create testfile failed");
+	close(fd);
+	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
+		if (errno == ENOTSUP)
+			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
+			    "mount without user_xattr option");
+	unlink("testfile");
+
+	/* Create test files and set file immutable or append-only */
+	immu_fd = creat(IMMU_FILE, 0644);
+	if (immu_fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
+		    IMMU_FILE);
+	if (set_immutable_on(immu_fd))
+		tst_brkm(TBROK | TERRNO, cleanup, "Set %s immutable failed",
+		    IMMU_FILE);
+
+	append_fd = creat(APPEND_FILE, 0644);
+	if (append_fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
+		    APPEND_FILE);
+	if (set_append_on(append_fd))
+		tst_brkm(TBROK | TERRNO, cleanup, "Set %s append-only failed",
+		    APPEND_FILE);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	if (set_immutable_off(immu_fd))
+		tst_resm(TWARN | TERRNO, "Unset %s immutable failed",
+		    IMMU_FILE);
+	if (set_append_off(append_fd))
+		tst_resm(TWARN | TERRNO, "Unset %s append-only failed",
+		    APPEND_FILE);
+	close(immu_fd);
+	close(append_fd);
+
+	TEST_CLEANUP;
+	tst_rmdir();
+}
+#else /* HAVE_ATTR_XATTR_H */
+int main(int argc, char *argv[])
+{
+	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+}
+#endif /* HAVE_ATTR_XATTR_H */

--------------1.7.7.5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
--------------1.7.7.5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.7.5--



