Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WkpUV-0008Ds-Lp
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 06:50:07 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WkpUT-0004mX-Ok
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 06:50:07 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4F6msoV024636
	for <ltp-list@lists.sourceforge.net>; Thu, 15 May 2014 14:48:54 +0800
Message-ID: <1400136477.2768.16.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 15 May 2014 14:47:57 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] setresuid/setresuid04.c: Add new test
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
To: ltp-list <ltp-list@lists.sourceforge.net>

1. Set new euid.
2. Create a new file.
3. Verify the file's st_uid is equal to the new euid.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                                   |   1 +
 runtest/stress.part3                              |   1 +
 runtest/syscalls                                  |   2 +
 testcases/kernel/syscalls/.gitignore              |   2 +
 testcases/kernel/syscalls/setresuid/setresuid05.c | 107 ++++++++++++++++++++++
 5 files changed, 113 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setresuid/setresuid05.c

diff --git a/runtest/ltplite b/runtest/ltplite
index f09c386..4b22444 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -774,6 +774,7 @@ setresuid01 setresuid01
 setresuid02 setresuid02
 setresuid03 setresuid03
 setresuid04 setresuid04
+setresuid05 setresuid05
 
 setreuid01 setreuid01
 setreuid02 setreuid02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 4fe4626..38aaa1d 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -678,6 +678,7 @@ setresuid01 setresuid01
 setresuid02 setresuid02
 setresuid03 setresuid03
 setresuid04 setresuid04
+setresuid05 setresuid05
 
 setreuid01 setreuid01
 setreuid02 setreuid02
diff --git a/runtest/syscalls b/runtest/syscalls
index 7a067cd..c294032 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1036,6 +1036,8 @@ setresuid03 setresuid03
 setresuid03_16 setresuid03_16
 setresuid04 setresuid04
 setresuid04_16 setresuid04_16
+setresuid05 setresuid05
+setresuid05_16 setresuid05_16
 
 setreuid01 setreuid01
 setreuid01_16 setreuid01_16
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0a16f74..31d5c1f 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -827,6 +827,8 @@
 /setresuid/setresuid03_16
 /setresuid/setresuid04
 /setresuid/setresuid04_16
+/setresuid/setresuid05
+/setresuid/setresuid05_16
 /setreuid/setreuid01
 /setreuid/setreuid01_16
 /setreuid/setreuid02
diff --git a/testcases/kernel/syscalls/setresuid/setresuid05.c b/testcases/kernel/syscalls/setresuid/setresuid05.c
new file mode 100644
index 0000000..c3c2da4
--- /dev/null
+++ b/testcases/kernel/syscalls/setresuid/setresuid05.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+/*
+ * Test Description:
+ *  Verify that,
+ *	File system UID is always set to the same value as the (possibly new)
+ *	effective UID.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <unistd.h>
+#include <pwd.h>
+#include <sys/stat.h>
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "setresuid05";
+int TST_TOTAL = 1;
+static struct passwd *ltpuser;
+static void setup(void);
+static void setresuid_verify(void);
+static void cleanup(void);
+
+int main(int argc, char **argv)
+{
+	int i, lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			setresuid_verify();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+}
+
+static void setresuid_verify(void)
+{
+	struct stat buf;
+
+	TEST(setresuid(-1, ltpuser->pw_uid, -1));
+
+	if (TEST_RETURN != 0) {
+		tst_resm(TFAIL | TTERRNO, "setresuid failed unexpectedly");
+		return;
+	}
+
+	SAFE_TOUCH(cleanup, "test_file", 0644, NULL);
+
+	SAFE_STAT(cleanup, "test_file", &buf);
+
+	if (ltpuser->pw_uid == buf.st_uid) {
+		tst_resm(TPASS, "setresuid succeeded as expected");
+	} else {
+		tst_resm(TFAIL,
+			 "setresuid failed unexpectedly; euid(%d) - st_uid(%d)",
+			 ltpuser->pw_uid, buf.st_uid);
+	}
+}
+
+static void cleanup(void)
+{
+	if (seteuid(0) < 0)
+		tst_resm(TWARN | TERRNO, "seteuid failed");
+
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
-- 
1.8.4.2




------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
