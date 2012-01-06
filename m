Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1Rj9Bk-0004ah-1z
	for ltp-list@lists.sourceforge.net; Fri, 06 Jan 2012 12:46:28 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rj9Bi-00022u-ST
	for ltp-list@lists.sourceforge.net; Fri, 06 Jan 2012 12:46:28 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q06CkKVK029132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Jan 2012 07:46:20 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Fri,  6 Jan 2012 20:46:12 +0800
Message-Id: <1325853972-13730-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1325853972-13730-1-git-send-email-eguan@redhat.com>
References: <1325853972-13730-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.5"
Subject: [LTP] [PATCH v3 2/2] syscalls/getxattr02: new testcase to test
	getxattr(2)
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


In the user.* namespace, only regular files and directories can
have extended attributes. Otherwise getxattr(2) will return -1
and set errno to ENODATA.

There are 4 test cases:
1. Get attribute from a FIFO, setxattr(2) should return -1 and
   set errno to ENODATA
2. Get attribute from a char special file, setxattr(2) should
   return -1 and set errno to ENODATA
3. Get attribute from a block special file, setxattr(2) should
   return -1 and set errno to ENODATA
4. Get attribute from a UNIX domain socket, setxattr(2) should
   return -1 and set errno to ENODATA

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2 -> v3:
	Use Macro instead of char array for test file names
v1 -> v2:
	Remove unnecessary variables

 runtest/syscalls                                |    1 +
 testcases/kernel/syscalls/getxattr/getxattr02.c |  152 +++++++++++++++++++++++
 2 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getxattr/getxattr02.c


--------------1.7.7.5
Content-Type: text/x-patch;
	name="0002-syscalls-getxattr02-new-testcase-to-test-getxattr-2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-syscalls-getxattr02-new-testcase-to-test-getxattr-2.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 8e36ec0..1442390 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -421,6 +421,7 @@ getuid03 getuid03
 getuid03_16 getuid03_16
 
 getxattr01 getxattr01
+getxattr02 getxattr02
 
 #Needs tty device.
 #ioctl01 ioctl01 -D /dev/tty0
diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
new file mode 100644
index 0000000..54d8949
--- /dev/null
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -0,0 +1,152 @@
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
+ * have extended attributes. Otherwise getxattr(2) will return -1
+ * and set errno to ENODATA.
+ *
+ * There are 4 test cases:
+ * 1. Get attribute from a FIFO, setxattr(2) should return -1 and
+ *    set errno to ENODATA
+ * 2. Get attribute from a char special file, setxattr(2) should
+ *    return -1 and set errno to ENODATA
+ * 3. Get attribute from a block special file, setxattr(2) should
+ *    return -1 and set errno to ENODATA
+ * 4. Get attribute from a UNIX domain socket, setxattr(2) should
+ *    return -1 and set errno to ENODATA
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
+
+#define FIFO "getxattr02fifo"
+#define CHR  "getxattr02chr"
+#define BLK  "getxattr02blk"
+#define SOCK "getxattr02sock"
+
+static void setup(void);
+static void cleanup(void);
+
+char *TCID = "getxattr02";
+
+static char *tc[] = {
+	FIFO,	/* case 00, get attr from fifo */
+	CHR,	/* case 01, get attr from char special */
+	BLK,	/* case 02, get attr from block special */
+	SOCK,	/* case 03, get attr from UNIX domain socket */
+};
+
+int TST_TOTAL = sizeof(tc) / sizeof(tc[0]);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	int i;
+	char *msg;
+	char buf[BUFSIZ];
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
+			TEST(getxattr(tc[0], XATTR_TEST_KEY, buf, BUFSIZ));
+
+			if (TEST_RETURN == -1 && TEST_ERRNO == ENODATA) {
+				tst_resm(TPASS | TTERRNO, "expected behavior");
+			} else {
+				tst_resm(TFAIL | TTERRNO, "unexpected behavior"
+				    " - expected errno %d - Got", ENODATA);
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
+	if (mknod(FIFO, S_IFIFO | 0777, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create FIFO(%s) failed",
+		    FIFO);
+
+	if (mknod(CHR, S_IFCHR | 0777, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create char special(%s)"
+		    " failed", CHR);
+
+	if (mknod(BLK, S_IFBLK | 0777, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create block special(%s)"
+		    " failed", BLK);
+
+	if (mknod(SOCK, S_IFSOCK | 0777, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create socket(%s) failed",
+		    SOCK);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+	tst_rmdir();
+}

--------------1.7.7.5
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



