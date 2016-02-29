From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 29 Feb 2016 15:53:38 +0800
Subject: [LTP] [PATCH 2/2] request_key/request_key02.c: add new testcase
In-Reply-To: <1456732418-10557-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1456732418-10557-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1456732418-10557-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) request_key(2) fails if no matching key was found and
   set errno to ENOKEY.
2) request_key(2) fails if a revoked key was found and
   set errno to EKEYREVOKED.
3) request_key(2) fails if an expired key was found and
   set errno to EKEYEXPIRED.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                    |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/request_key/request_key02.c    | 143 +++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 testcases/kernel/syscalls/request_key/request_key02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 8ecafa1..8767a9d 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -664,6 +664,7 @@ rename13 rename13
 rename14 rename14
 
 request_key01 request_key01
+request_key02 request_key02
 
 rmdir01 rmdir01
 rmdir02 rmdir02
diff --git a/runtest/syscalls b/runtest/syscalls
index 68ba417..394c37d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -892,6 +892,7 @@ renameat201 renameat201
 renameat202 renameat202 -i 10
 
 request_key01 request_key01
+request_key02 request_key02
 
 rmdir01 rmdir01
 rmdir02 rmdir02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5d01d2..23b31b9 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -737,6 +737,7 @@
 /renameat2/renameat201
 /renameat2/renameat202
 /request_key/request_key01
+/request_key/request_key02
 /rmdir/rmdir01
 /rmdir/rmdir02
 /rmdir/rmdir03
diff --git a/testcases/kernel/syscalls/request_key/request_key02.c b/testcases/kernel/syscalls/request_key/request_key02.c
new file mode 100644
index 0000000..8fbc6f5
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/request_key02.c
@@ -0,0 +1,143 @@
+/*
+* Copyright (c) 2016 Fujitsu Ltd.
+* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it would be useful, but
+* WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+*
+* You should have received a copy of the GNU General Public License
+* alone with this program.
+*/
+
+/*
+* Test Name: request_key02
+*
+* Description:
+* 1) request_key(2) fails if no matching key was found.
+* 2) request_key(2) fails if A revoked key was found.
+* 3) request_key(2) fails if An expired key was found.
+*
+* Expected Result:
+* 1) request_key(2) should return -1 and set errno to ENOKEY.
+* 2) request_key(2) should return -1 and set errno to EKEYREVOKED.
+* 3) request_key(2) should return -1 and set errno to EKEYEXPIRED.
+*
+*/
+
+#include "config.h"
+#include <errno.h>
+
+#ifdef HAVE_LINUX_KEYCTL_H
+#include <linux/keyctl.h>
+#endif
+
+#include "test.h"
+#include "linux_syscall_numbers.h"
+
+char *TCID = "request_key02";
+
+#ifdef HAVE_LINUX_KEYCTL_H
+
+static struct test_case {
+	const char *des;
+	int exp_err;
+} tc[] = {
+	/* test1 */
+	{"ltp1", ENOKEY},
+	/* test2 */
+	{"ltp", EKEYREVOKED},
+	/* test3 */
+	{"ltp", EKEYEXPIRED}
+};
+
+static void verify_request_key(struct test_case *);
+static void setup(void);
+static void cleanup(void);
+
+int TST_TOTAL = ARRAY_SIZE(tc);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			verify_request_key(&tc[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void verify_request_key(struct test_case *tc)
+{
+	int sec = 1;
+	int res;
+	int n;
+
+	res = ltp_syscall(__NR_add_key, "keyring", "ltp", NULL, 0, KEY_SPEC_THREAD_KEYRING);
+	if (res == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "add_key() failed");
+
+	if (tc->exp_err == EKEYREVOKED) {
+		n = ltp_syscall(__NR_keyctl, KEYCTL_REVOKE, res);
+		if (n == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "fail to revoke a key");
+		}
+	}
+
+	if (tc->exp_err == EKEYEXPIRED) {
+		n = ltp_syscall(__NR_keyctl, KEYCTL_SET_TIMEOUT, res, sec);
+		if (n == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "fail to set timeout for a key");
+		}
+		sleep(sec + 1);
+	}
+
+	TEST(ltp_syscall(__NR_request_key, "keyring", tc->des, NULL, res));
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "request_key() succeed unexpectly");
+		return;
+	}
+	if (TEST_ERRNO == tc->exp_err)
+		tst_resm(TPASS | TTERRNO, "request_key() failed expectly");
+	else
+		tst_resm(TFAIL | TTERRNO, "request_key() failed unexpectly");
+}
+
+static void setup(void)
+{
+	tst_require_root();
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+}
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+#else
+int main(int ac, char **av)
+{
+	tst_brkm(TCONF, NULL, "linux/keyctl.h was missing upon compilation.");
+}
+#endif
-- 
1.8.3.1



