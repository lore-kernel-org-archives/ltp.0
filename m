Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1RoBCX-0008SG-CV
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 09:56:05 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RoBCR-0003P6-I3
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 09:56:05 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0K9trvi006247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Jan 2012 04:55:53 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Fri, 20 Jan 2012 17:54:07 +0800
Message-Id: <1327053248-18415-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.5"
Subject: [LTP] [PATCH v2 1/2] syscalls/getxattr03: new testcase to test
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


An empty buffer of size zero can be passed into getxattr(2) to return
the current size of the named extended attribute.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v1->v2:
	1. Use sizeof() instead of strlen to compute length of string at compile time
	2. Use better described log message

 runtest/syscalls                                |    1 +
 testcases/kernel/syscalls/getxattr/getxattr03.c |  123 +++++++++++++++++++++++
 2 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getxattr/getxattr03.c


--------------1.7.7.5
Content-Type: text/x-patch;
	name="0001-syscalls-getxattr03-new-testcase-to-test-getxattr-2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-getxattr03-new-testcase-to-test-getxattr-2.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 4aac38c..d786746 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -423,6 +423,7 @@ getuid03_16 getuid03_16
 
 getxattr01 getxattr01
 getxattr02 getxattr02
+getxattr03 getxattr03
 
 #Needs tty device.
 #ioctl01 ioctl01 -D /dev/tty0
diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
new file mode 100644
index 0000000..0595e53
--- /dev/null
+++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) 2012 Red Hat, Inc.
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
+ * An empty buffer of size zero can be passed into getxattr(2) to return
+ * the current size of the named extended attribute.
+ */
+
+#include "config.h"
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
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "getxattr03";
+
+#ifdef HAVE_ATTR_XATTR_H
+#define XATTR_TEST_KEY "user.testkey"
+#define XATTR_TEST_VALUE "test value"
+#define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
+#define TESTFILE "getxattr03testfile"
+
+static void setup(void);
+static void cleanup(void);
+
+int TST_TOTAL = 1;
+
+int main(int argc, char *argv[])
+{
+	int lc;
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
+		TEST(getxattr(TESTFILE, XATTR_TEST_KEY, NULL, 0));
+
+		if (TEST_RETURN == XATTR_TEST_VALUE_SIZE)
+			tst_resm(TPASS, "getxattr(2) returned correct value");
+		else
+			tst_resm(TFAIL | TTERRNO, "getxattr(2) failed");
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
+	/* Test for xattr support and set attr value */
+	fd = creat(TESTFILE, 0644);
+	if (fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create %s failed", TESTFILE);
+	close(fd);
+
+	if (setxattr(TESTFILE, XATTR_TEST_KEY, XATTR_TEST_VALUE,
+	    XATTR_TEST_VALUE_SIZE, XATTR_CREATE) == -1) {
+		if (errno == ENOTSUP)
+			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
+			    "fs mounted without user_xattr option");
+		else
+			tst_brkm(TBROK | TERRNO, cleanup, "setxattr %s failed",
+			    TESTFILE);
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
+#else /* HAVE_ATTR_XATTR_H */
+int main(int argc, char *argv[])
+{
+	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+}
+#endif

--------------1.7.7.5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
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



