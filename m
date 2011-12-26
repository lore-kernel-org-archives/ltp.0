Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1Rf1p5-0004uD-Ut
	for ltp-list@lists.sourceforge.net; Mon, 26 Dec 2011 04:06:03 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rf1p5-0006ti-38
	for ltp-list@lists.sourceforge.net; Mon, 26 Dec 2011 04:06:03 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBQ45v9e011610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sun, 25 Dec 2011 23:05:57 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Mon, 26 Dec 2011 12:04:43 +0800
Message-Id: <1324872283-6292-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1324872283-6292-1-git-send-email-eguan@redhat.com>
References: <1324872283-6292-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.4"
Subject: [LTP] [PATCH 2/2 V2] syscalls/getxattr01: new testcase to test
	getxattr(2) basic function
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


Basic tests for getxattr(2) and make sure getxattr(2) handles error
conditions correctly.

There are 4 test cases:
1. Get an non-existing attribute,
   getxattr(2) should return -1 and set errno to ENOATTR
2. Buffer size is smaller than attribute value size,
   getxattr(2) should return -1 and set errno to ERANGE
3. Get attribute, getxattr(2) should succeed
4. Verify the attribute got by getxattr(2) is same as the value we set

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 V2:
	1. Statically initialize test case array
	2. Use TTERRNO with TPASS and TFAIL to print TEST_ERRNO message

 runtest/syscalls                                |    2 +
 testcases/kernel/syscalls/getxattr/Makefile     |   23 +++
 testcases/kernel/syscalls/getxattr/getxattr01.c |  184 +++++++++++++++++++++++
 3 files changed, 209 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/getxattr/getxattr01.c


--------------1.7.7.4
Content-Type: text/x-patch;
	name="0002-syscalls-getxattr01-new-testcase-to-test-getxattr-2-.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-syscalls-getxattr01-new-testcase-to-test-getxattr-2-.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 3056659..48caaae 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -420,6 +420,8 @@ getuid02_16 getuid02_16
 getuid03 getuid03
 getuid03_16 getuid03_16
 
+getxattr01 getxattr01
+
 #Needs tty device.
 #ioctl01 ioctl01 -D /dev/tty0
 #ioctl02 ioctl02 -D /dev/tty0
diff --git a/testcases/kernel/syscalls/getxattr/Makefile b/testcases/kernel/syscalls/getxattr/Makefile
new file mode 100644
index 0000000..72544c1
--- /dev/null
+++ b/testcases/kernel/syscalls/getxattr/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) Red Hat Inc., 2011
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
new file mode 100644
index 0000000..5e6209e
--- /dev/null
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -0,0 +1,184 @@
+/*
+ * Copyright (C) 2011  Red Hat, Inc.
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
+ * Basic tests for getxattr(2) and make sure getxattr(2) handles error
+ * conditions correctly.
+ *
+ * There are 4 test cases:
+ * 1. Get an non-existing attribute,
+ *    getxattr(2) should return -1 and set errno to ENOATTR
+ * 2. Buffer size is smaller than attribute value size,
+ *    getxattr(2) should return -1 and set errno to ERANGE
+ * 3. Get attribute, getxattr(2) should succeed
+ * 4. Verify the attribute got by getxattr(2) is same as the value we set
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <attr/xattr.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
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
+#define BUFFSIZE 64
+
+static void setup(void);
+static void cleanup(void);
+
+char *TCID = "getxattr01";
+char filename[BUFSIZ];
+
+struct test_case {
+	char *fname;
+	char *key;
+	char *value;
+	size_t size;
+	int exp_err;
+};
+struct test_case tc[] = {
+	{	/* case 00, get non-existing attribute */
+		.fname = filename,
+		.key = "user.nosuchkey",
+		.value = NULL,
+		.size = BUFFSIZE - 1,
+		.exp_err = ENOATTR,
+	},
+	{	/* case 01, small value buffer */
+		.fname = filename,
+		.key = XATTR_TEST_KEY,
+		.value = NULL,
+		.size = 1,
+		.exp_err = ERANGE,
+	},
+	{	/* case 02, get existing attribute */
+		.fname = filename,
+		.key = XATTR_TEST_KEY,
+		.value = NULL,
+		.size = BUFFSIZE - 1,
+		.exp_err = 0,
+	},
+};
+
+int TST_TOTAL = sizeof(tc) / sizeof(tc[0]) + 1;
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
+		for (i = 0; i < (sizeof(tc) / sizeof(tc[0])); i++) {
+			tname = tc[i].fname;
+			tkey = tc[i].key;
+			tvalue = tc[i].value;
+			tsize = tc[i].size;
+			texp_err = tc[i].exp_err;
+
+			TEST(getxattr(tname, tkey, tvalue, tsize));
+
+			if (TEST_ERRNO == texp_err) {
+				tst_resm(TPASS | TTERRNO, "expected behavior");
+			} else {
+				tst_resm(TFAIL | TTERRNO, "unexpected behavior"
+				    "- expected errno %d - Got", texp_err);
+			}
+		}
+
+		if (strcmp(tvalue, XATTR_TEST_VALUE))
+			tst_resm(TFAIL, "Wrong value, expect \"%s\" got \"%s\"",
+			    XATTR_TEST_VALUE, tvalue);
+		else
+			tst_resm(TPASS, "Got the right value");
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int fd;
+	int i;
+
+	tst_require_root(NULL);
+
+	tst_tmpdir();
+
+	/* Create test file and setup initial xattr */
+	snprintf(filename, BUFSIZ, "getxattr01testfile");
+	fd = creat(filename, 0644);
+	if (fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
+		    filename);
+	close(fd);
+	if (setxattr(filename, XATTR_TEST_KEY, XATTR_TEST_VALUE,
+	    strlen(XATTR_TEST_VALUE), XATTR_CREATE) == -1) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
+			    "mount without user_xattr option");
+		}
+	}
+
+	/* Prepare test cases */
+	for (i = 0; i < (sizeof(tc) / sizeof(tc[0])); i++) {
+		tc[i].value = malloc(BUFFSIZE);
+		if (tc[i].value == NULL) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			    "Cannot allocate memory");
+		}
+	}
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
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
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



