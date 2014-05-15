Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WkpUY-0005AE-6K
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 06:50:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WkpUW-0004mX-8i
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 06:50:10 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4F6ntRs024704
	for <ltp-list@lists.sourceforge.net>; Thu, 15 May 2014 14:49:55 +0800
Message-ID: <1400136537.2768.17.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 15 May 2014 14:48:57 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] setresgid/setresgid04.c: Add new test
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

1. Set new egid.
2. Create a new file.
3. Verify the file's st_gid is equal to the new egid.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                                   |   1 +
 runtest/stress.part3                              |   1 +
 runtest/syscalls                                  |   2 +
 testcases/kernel/syscalls/.gitignore              |   2 +
 testcases/kernel/syscalls/setresgid/setresgid04.c | 104 ++++++++++++++++++++++
 5 files changed, 110 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setresgid/setresgid04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 4b22444..59e1c8a 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -769,6 +769,7 @@ setregid04 setregid04
 setresgid01 setresgid01
 setresgid02 setresgid02
 setresgid03 setresgid03
+setresgid04 setresgid04
 
 setresuid01 setresuid01
 setresuid02 setresuid02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 38aaa1d..3b3a45c 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -673,6 +673,7 @@ setregid04 setregid04
 setresgid01 setresgid01
 setresgid02 setresgid02
 setresgid03 setresgid03
+setresgid04 setresgid04
 
 setresuid01 setresuid01
 setresuid02 setresuid02
diff --git a/runtest/syscalls b/runtest/syscalls
index c294032..3cd249a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1027,6 +1027,8 @@ setresgid02 setresgid02
 setresgid02_16 setresgid02_16
 setresgid03 setresgid03
 setresgid03_16 setresgid03_16
+setresgid04 setresgid04
+setresgid04_16 setresgid04_16
 
 setresuid01 setresuid01
 setresuid01_16 setresuid01_16
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 31d5c1f..184c1c1 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -819,6 +819,8 @@
 /setresgid/setresgid02_16
 /setresgid/setresgid03
 /setresgid/setresgid03_16
+/setresgid/setresgid04
+/setresgid/setresgid04_16
 /setresuid/setresuid01
 /setresuid/setresuid01_16
 /setresuid/setresuid02
diff --git a/testcases/kernel/syscalls/setresgid/setresgid04.c b/testcases/kernel/syscalls/setresgid/setresgid04.c
new file mode 100644
index 0000000..0cd09bb
--- /dev/null
+++ b/testcases/kernel/syscalls/setresgid/setresgid04.c
@@ -0,0 +1,104 @@
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
+ *	File system GID is always set to the same value as the (possibly new)
+ *	effective GID.
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
+char *TCID = "setresgid04";
+int TST_TOTAL = 1;
+static struct passwd *ltpuser;
+static void setup(void);
+static void setresgid_verify(void);
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
+			setresgid_verify();
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
+static void setresgid_verify(void)
+{
+	struct stat buf;
+
+	TEST(setresgid(-1, ltpuser->pw_gid, -1));
+
+	if (TEST_RETURN != 0) {
+		tst_resm(TFAIL | TTERRNO, "setresgid failed unexpectedly");
+		return;
+	}
+
+	SAFE_TOUCH(cleanup, "test_file", 0644, NULL);
+
+	SAFE_STAT(cleanup, "test_file", &buf);
+
+	if (ltpuser->pw_gid == buf.st_gid) {
+		tst_resm(TPASS, "setresgid succeeded as expected");
+	} else {
+		tst_resm(TFAIL,
+			 "setresgid failed unexpectedly; egid(%d) - st_gid(%d)",
+			 ltpuser->pw_gid, buf.st_gid);
+	}
+}
+
+static void cleanup(void)
+{
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
