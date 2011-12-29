Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1RgDJ6-0005dN-Py
	for ltp-list@lists.sourceforge.net; Thu, 29 Dec 2011 10:33:56 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RgDJ5-00012T-M1
	for ltp-list@lists.sourceforge.net; Thu, 29 Dec 2011 10:33:56 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBTAXntE008455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Dec 2011 05:33:49 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Thu, 29 Dec 2011 18:33:36 +0800
Message-Id: <1325154816-31411-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.4"
Subject: [LTP] [PATCH] syscalls/setxattr02: New test case to test setxattr(2)
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
--------------1.7.7.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


In the user.* namespace, only regular files and directories can
have extended attributes. Otherwise setxattr(2) should return -1
and set errno to EPERM.

There are 7 test cases:
1. Set attribute to a regular file, setxattr(2) should succeed
2. Set attribute to a directory, setxattr(2) should succeed
3. Set attribute to a symlink which points to the regular file,
   setxattr(2) should return -1 and set errno to EEXIST
4. Set attribute to a FIFO, setxattr(2) should return -1 and set
   errno to EPERM
5. Set attribute to a char special file, setxattr(2) should
   return -1 and set errno to EPERM
6. Set attribute to a block special file, setxattr(2) should
   return -1 and set errno to EPERM
7. Set attribute to a UNIX domain socket, setxattr(2) should
   return -1 and set errno to EPERM

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 runtest/syscalls                                |    1 +
 testcases/kernel/syscalls/setxattr/setxattr02.c |  248 +++++++++++++++++++++++
 2 files changed, 249 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/setxattr/setxattr02.c


--------------1.7.7.4
Content-Type: text/x-patch;
	name="0001-syscalls-setxattr02-New-test-case-to-test-setxattr-2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-setxattr02-New-test-case-to-test-setxattr-2.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 48caaae..8e36ec0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1021,6 +1021,7 @@ setuid04 setuid04
 setuid04_16 setuid04_16
 
 setxattr01 setxattr01
+setxattr02 setxattr02
 
 shmat01 shmat01
 shmat02 shmat02
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
new file mode 100644
index 0000000..a48c562
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -0,0 +1,248 @@
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
+ * In the user.* namespace, only regular files and directories can
+ * have extended attributes. Otherwise setxattr(2) will return -1
+ * and set errno to EPERM.
+ *
+ * There are 7 test cases:
+ * 1. Set attribute to a regular file, setxattr(2) should succeed
+ * 2. Set attribute to a directory, setxattr(2) should succeed
+ * 3. Set attribute to a symlink which points to the regular file,
+ *    setxattr(2) should return -1 and set errno to EEXIST
+ * 4. Set attribute to a FIFO, setxattr(2) should return -1 and set
+ *    errno to EPERM
+ * 5. Set attribute to a char special file, setxattr(2) should
+ *    return -1 and set errno to EPERM
+ * 6. Set attribute to a block special file, setxattr(2) should
+ *    return -1 and set errno to EPERM
+ * 7. Set attribute to a UNIX domain socket, setxattr(2) should
+ *    return -1 and set errno to EPERM
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <attr/xattr.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test.h"
+#include "usctest.h"
+
+#define XATTR_TEST_KEY "user.testkey"
+#define XATTR_TEST_VALUE "this is a test value"
+#define XATTR_TEST_VALUE_SIZE 20
+
+static void setup(void);
+static void cleanup(void);
+
+char *TCID = "setxattr02";
+
+char file[] = "setxattr02testfile";
+char dir[] = "setxattr02testdir";
+char sym[] = "setxattr02symlink";
+char fifo[] = "setxattr02fifo";
+char chr[] = "setxattr02chr";
+char blk[] = "setxattr02blk";
+char sock[] = "setxattr02sock";
+
+struct test_case {
+	char *fname;
+	char *key;
+	char *value;
+	size_t size;
+	int flags;
+	int exp_err;
+};
+struct test_case tc[] = {
+	{	/* case 00, set attr to reg */
+		.fname = file,
+		.key = XATTR_TEST_KEY,
+		.value = XATTR_TEST_VALUE,
+		.size = XATTR_TEST_VALUE_SIZE,
+		.flags = XATTR_CREATE,
+		.exp_err = 0,
+	},
+	{	/* case 01, set attr to dir */
+		.fname = dir,
+		.key = XATTR_TEST_KEY,
+		.value = XATTR_TEST_VALUE,
+		.size = XATTR_TEST_VALUE_SIZE,
+		.flags = XATTR_CREATE,
+		.exp_err = 0,
+	},
+	{	/* case 02, set attr to symlink */
+		.fname = sym,
+		.key = XATTR_TEST_KEY,
+		.value = XATTR_TEST_VALUE,
+		.size = XATTR_TEST_VALUE_SIZE,
+		.flags = XATTR_CREATE,
+		.exp_err = EEXIST,
+	},
+	{	/* case 03, set attr to fifo */
+		.fname = fifo,
+		.key = XATTR_TEST_KEY,
+		.value = XATTR_TEST_VALUE,
+		.size = XATTR_TEST_VALUE_SIZE,
+		.flags = XATTR_CREATE,
+		.exp_err = EPERM,
+	},
+	{	/* case 04, set attr to character special */
+		.fname = chr,
+		.key = XATTR_TEST_KEY,
+		.value = XATTR_TEST_VALUE,
+		.size = XATTR_TEST_VALUE_SIZE,
+		.flags = XATTR_CREATE,
+		.exp_err = EPERM,
+	},
+	{	/* case 05, set attr to block special */
+		.fname = blk,
+		.key = XATTR_TEST_KEY,
+		.value = XATTR_TEST_VALUE,
+		.size = XATTR_TEST_VALUE_SIZE,
+		.flags = XATTR_CREATE,
+		.exp_err = EPERM,
+	},
+	{	/* case 06, set attr to socket */
+		.fname = sock,
+		.key = XATTR_TEST_KEY,
+		.value = XATTR_TEST_VALUE,
+		.size = XATTR_TEST_VALUE_SIZE,
+		.flags = XATTR_CREATE,
+		.exp_err = EPERM,
+	},
+};
+
+int TST_TOTAL = sizeof(tc) / sizeof(tc[0]);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	int i;
+	char *msg;
+	char *tname;
+	char *tkey;
+	char *tvalue;
+	size_t tsize;
+	int tflags;
+	int texp_err;
+
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
+			tname = tc[i].fname;
+			tkey = tc[i].key;
+			tvalue = tc[i].value;
+			tsize = tc[i].size;
+			tflags = tc[i].flags;
+			texp_err = tc[i].exp_err;
+
+			TEST(setxattr(tname, tkey, tvalue, tsize, tflags));
+
+			if (TEST_ERRNO == texp_err) {
+				tst_resm(TPASS | TTERRNO, "expected behavior");
+			} else {
+				tst_resm(TFAIL | TTERRNO, "unexpected behavior"
+				    " - expected errno %d - Got", texp_err);
+			}
+		}
+	}
+
+	cleanup();
+	tst_exit();
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
+	/* Create test files */
+	fd = creat(file, 0644);
+	if (fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
+		    file);
+	close(fd);
+
+	if (mkdir(dir, 0644) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create test dir(%s) failed",
+		    dir);
+
+	if (symlink(file, sym) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create symlink(%s->%s)"
+		    " failed", sym, file);
+
+	if (mknod(fifo, S_IFIFO | 0777, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create fifo(%s) failed",
+		    fifo);
+
+	if (mknod(chr, S_IFCHR | 0777, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create char special(%s)"
+		    " failed", chr);
+
+	if (mknod(blk, S_IFBLK | 0777, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create block special(%s)"
+		    " failed", blk);
+
+	if (mknod(sock, S_IFSOCK | 0777, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create socket(%s) failed",
+		    sock);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+	tst_rmdir();
+}

--------------1.7.7.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--------------1.7.7.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.7.4--



