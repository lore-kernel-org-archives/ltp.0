Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1RkyjG-0004mG-1Y
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 14:00:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RkyjA-0001ws-95
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 14:00:38 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0BE0QOn029369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Jan 2012 09:00:26 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Wed, 11 Jan 2012 21:59:26 +0800
Message-Id: <1326290366-7464-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1326135670-18584-1-git-send-email-eguan@redhat.com>
References: <1326135670-18584-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.5"
Subject: [LTP] [PATCH v2] syscalls/sendfile08: new test case for sendfile(2)
	syscall
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


A bug in the splice code had caused the file position on the write side
of the sendfile system call to be incorrectly set to the read side file
position. This can result in the data being written to an incorrect offset.

This is a regression test for kernel commit
2cb4b05e7647891b46b91c07c9a60304803d1688

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
	Remove unnecessary comments

 runtest/syscalls                                |    2 +
 testcases/kernel/syscalls/sendfile/sendfile08.c |  131 +++++++++++++++++++++++
 2 files changed, 133 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/sendfile/sendfile08.c


--------------1.7.7.5
Content-Type: text/x-patch;
	name="0001-syscalls-sendfile08-new-test-case-for-sendfile-2-sys.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-sendfile08-new-test-case-for-sendfile-2-sys.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 5a201e1..4aac38c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -891,6 +891,8 @@ sendfile06 sendfile06
 sendfile06_64 sendfile06_64
 sendfile07 sendfile07
 sendfile07_64 sendfile07_64
+sendfile08 sendfile08
+sendfile08_64 sendfile08_64
 
 
 sendmsg01 sendmsg01
diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
new file mode 100644
index 0000000..f044d39
--- /dev/null
+++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright (C) 2012 Red Hat, Inc.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+/*
+ * Bug in the splice code has caused the file position on the write side
+ * of the sendfile system call to be incorrectly set to the read side file
+ * position. This can result in the data being written to an incorrect offset.
+ *
+ * This is a regression test for kernel commit
+ * 2cb4b05e7647891b46b91c07c9a60304803d1688
+ */
+
+#include <sys/sendfile.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "usctest.h"
+#include "test.h"
+
+#define TEST_MSG_IN "world"
+#define TEST_MSG_OUT "hello"
+
+TCID_DEFINE(sendfile08);
+int TST_TOTAL = 1;
+
+static int in_fd;
+static int out_fd;
+static char *in_file = "sendfile08.in";
+static char *out_file = "sendfile08.out";
+
+static void cleanup(void);
+static void setup(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	int ret;
+	char *msg;
+	char buf[BUFSIZ];
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		TEST(sendfile(out_fd, in_fd, NULL, strlen(TEST_MSG_IN)));
+
+		if (TEST_RETURN == -1)
+			tst_brkm(TBROK | TTERRNO, cleanup, "sendfile() failed");
+
+		ret = lseek(out_fd, 0, SEEK_SET);
+		if (ret == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "lseek %s failed",
+			    out_file);
+		ret = read(out_fd, buf, BUFSIZ);
+		if (ret == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "read %s failed",
+			    out_file);
+
+		if (!strcmp(buf, TEST_MSG_OUT TEST_MSG_IN))
+			tst_resm(TPASS, "sendfile(2) copies data correctly");
+		else
+			tst_resm(TFAIL, "sendfile(2) copies data incorrectly."
+			    " Expect \"%s%s\", got \"%s\"", TEST_MSG_OUT,
+			    TEST_MSG_IN, buf);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int ret;
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	in_fd = creat(in_file, 0700);
+	if (in_fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Create %s failed", in_file);
+
+	ret = write(in_fd, TEST_MSG_IN, strlen(TEST_MSG_IN));
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", in_file);
+	close(in_fd);
+
+	in_fd = open(in_file, O_RDONLY);
+	if (in_fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Open %s failed", in_file);
+
+	out_fd = open(out_file, O_TRUNC | O_CREAT | O_RDWR, 0777);
+	if (out_fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Open %s failed", out_file);
+	ret = write(out_fd, TEST_MSG_OUT, strlen(TEST_MSG_OUT));
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", out_file);
+}
+
+static void cleanup(void)
+{
+	close(out_fd);
+	close(in_fd);
+
+	TEST_CLEANUP;
+
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



