Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1RdhGF-0007wQ-3t
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 11:56:35 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RdhG8-0002q1-Mr
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 11:56:35 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBMBuMFT027364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Dec 2011 06:56:22 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Thu, 22 Dec 2011 19:56:17 +0800
Message-Id: <1324554978-26997-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.4"
Subject: [LTP] [PATCH 1/2] syscalls/setxattr01: new testcase to test
	setxattr(2) basic function
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


Basic tests for setxattr(2) and make sure setxattr(2) handles error
conditions correctly.

There are 7 test cases:
1. Any other flags being set except XATTR_CREATE and XATTR_REPLACE,
   setxattr(2) should return -1 and set errno to EINVAL
2. With XATTR_REPLACE flag set but the attribute does not exist,
   setxattr(2) should return -1 and set errno to ENOATTR
3. Create new attr with name length greater than XATTR_NAME_MAX(255)
   setxattr(2) should return -1 and set errno to ERANGE
4. Create new attr whose value length is greater than XATTR_SIZE_MAX(65536)
   setxattr(2) should return -1 and set errno to E2BIG
5. Create new attr whose value length is zero,
   setxattr(2) should succeed
6. Replace the attr value without XATTR_REPLACE flag being set,
   setxattr(2) should return -1 and set errno to EEXIST
7. Replace attr value with XATTR_REPLACE flag being set,
   setxattr(2) should succeed

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 runtest/syscalls                                |    2 +
 testcases/kernel/syscalls/setxattr/Makefile     |   23 +++
 testcases/kernel/syscalls/setxattr/setxattr01.c |  207 +++++++++++++++++++++++
 3 files changed, 232 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/setxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/setxattr/setxattr01.c


--------------1.7.7.4
Content-Type: text/x-patch;
	name="0001-syscalls-setxattr01-new-testcase-to-test-setxattr-2-.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-setxattr01-new-testcase-to-test-setxattr-2-.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 3755789..3056659 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1018,6 +1018,8 @@ setuid03_16 setuid03_16
 setuid04 setuid04
 setuid04_16 setuid04_16
 
+setxattr01 setxattr01
+
 shmat01 shmat01
 shmat02 shmat02
 shmat03 shmat03
diff --git a/testcases/kernel/syscalls/setxattr/Makefile b/testcases/kernel/syscalls/setxattr/Makefile
new file mode 100644
index 0000000..72544c1
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattr/Makefile
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
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
new file mode 100644
index 0000000..cfe5e52
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -0,0 +1,207 @@
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
+ * Basic tests for setxattr(2) and make sure setxattr(2) handles error
+ * conditions correctly.
+ *
+ * There are 7 test cases:
+ * 1. Any other flags being set except XATTR_CREATE and XATTR_REPLACE,
+ *    setxattr(2) should return -1 and set errno to EINVAL
+ * 2. With XATTR_REPLACE flag set but the attribute does not exist,
+ *    setxattr(2) should return -1 and set errno to ENOATTR
+ * 3. Create new attr with name length greater than XATTR_NAME_MAX(255)
+ *    setxattr(2) should return -1 and set errno to ERANGE
+ * 4. Create new attr whose value length is greater than XATTR_SIZE_MAX(65536)
+ *    setxattr(2) should return -1 and set errno to E2BIG
+ * 5. Create new attr whose value length is zero,
+ *    setxattr(2) should succeed
+ * 6. Replace the attr value without XATTR_REPLACE flag being set,
+ *    setxattr(2) should return -1 and set errno to EEXIST
+ * 7. Replace attr value with XATTR_REPLACE flag being set,
+ *    setxattr(2) should succeed
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
+#define XATTR_NAME_MAX 255
+#define XATTR_NAME_LEN (XATTR_NAME_MAX + 2)
+#define XATTR_SIZE_MAX 65536
+#define XATTR_TEST_KEY "user.testkey"
+#define XATTR_TEST_VALUE "this is a test value"
+#define NR_TEST 7
+
+static void setup(void);
+static void cleanup(void);
+
+char *TCID = "setxattr01";
+char filename[BUFSIZ];
+char long_key[XATTR_NAME_LEN];
+char *long_value;
+int TST_TOTAL = NR_TEST;
+
+struct test_case {
+	char *fname;
+	char *key;
+	char *value;
+	size_t size;
+	int flags;
+	int exp_err;
+};
+struct test_case tc[NR_TEST];
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
+		for (i = 0; i < NR_TEST; i++)	{
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
+				tst_resm(TPASS, "expected behavior - errno = %d"
+				    " : %s", TEST_ERRNO, strerror(TEST_ERRNO));
+			} else {
+				tst_resm(TFAIL, "unexpected behavior - %d : %s "
+				    "- expected %d", TEST_ERRNO,
+				    strerror(TEST_ERRNO), texp_err);
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
+	int i;
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
+
+	/* Create test file */
+	snprintf(filename, BUFSIZ, "setxattr01testfile");
+	fd = creat(filename, 0644);
+	if (fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
+		    filename);
+	close(fd);
+
+	/* Prepare test cases */
+	memset(tc, 0, NR_TEST * sizeof(tc[0]));
+	for (i = 0; i < NR_TEST; i++) {
+		tc[i].fname = filename;
+		tc[i].key = XATTR_TEST_KEY;
+		tc[i].value = XATTR_TEST_VALUE;
+		tc[i].size = strlen(XATTR_TEST_VALUE);
+		tc[i].flags = XATTR_CREATE;
+	}
+
+	tc[0].flags = ~0;
+	tc[0].exp_err = EINVAL;
+
+	tc[1].flags = XATTR_REPLACE;
+	tc[1].exp_err = ENOATTR;
+
+	snprintf(long_key, 6, "%s", "user.");
+	memset(long_key + 5, 'k', XATTR_NAME_LEN - 5);
+	long_key[XATTR_NAME_LEN - 1] = '\0';
+	tc[2].key = long_key;
+	tc[2].exp_err = ERANGE;
+
+	long_value = malloc(XATTR_SIZE_MAX + 2);
+	if (!long_value)
+		tst_brkm(TBROK | TERRNO, cleanup, "malloc failed");
+	memset(long_value, 'v', XATTR_SIZE_MAX + 2);
+	long_value[XATTR_SIZE_MAX + 1] = '\0';
+	tc[3].value = long_value;
+	tc[3].size = XATTR_SIZE_MAX + 1;
+	tc[3].exp_err = E2BIG;
+
+	tc[4].size = 0;
+	tc[4].exp_err = 0;
+
+	tc[5].exp_err = EEXIST;
+
+	tc[6].flags = XATTR_REPLACE;
+	tc[6].exp_err = 0;
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



