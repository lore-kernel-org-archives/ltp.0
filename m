From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 16 Mar 2016 15:28:34 +0800
Subject: [LTP] [PATCH v2 2/2] request_key/request_key02.c: add new testcase
In-Reply-To: <1458113314-29731-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160309145331.GG28171@rei.lan>
 <1458113314-29731-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1458113314-29731-2-git-send-email-yangx.jy@cn.fujitsu.com>
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
 .../kernel/syscalls/request_key/request_key02.c    | 150 +++++++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 testcases/kernel/syscalls/request_key/request_key02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index e3dd403..f0deac0 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -669,6 +669,7 @@ rename13 rename13
 rename14 rename14
 
 request_key01 request_key01
+request_key02 request_key02
 
 rmdir01 rmdir01
 rmdir02 rmdir02
diff --git a/runtest/syscalls b/runtest/syscalls
index e442297..b67d524 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -897,6 +897,7 @@ renameat201 renameat201
 renameat202 renameat202 -i 10
 
 request_key01 request_key01
+request_key02 request_key02
 
 rmdir01 rmdir01
 rmdir02 rmdir02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 92dbda4..2a4cb33 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -741,6 +741,7 @@
 /renameat2/renameat201
 /renameat2/renameat202
 /request_key/request_key01
+/request_key/request_key02
 /rmdir/rmdir01
 /rmdir/rmdir02
 /rmdir/rmdir03
diff --git a/testcases/kernel/syscalls/request_key/request_key02.c b/testcases/kernel/syscalls/request_key/request_key02.c
new file mode 100644
index 0000000..b40b934
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/request_key02.c
@@ -0,0 +1,150 @@
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
+#include <sys/types.h>
+#ifdef HAVE_KEYUTILS_H
+#include <keyutils.h>
+#endif
+#include "test.h"
+
+char *TCID = "request_key02";
+
+static struct test_case {
+	const char *des;
+	int exp_err;
+	int id;
+} tc[] = {
+	/* test1 */
+	{"ltp1", ENOKEY, 0},
+	/* test2 */
+	{"ltp2", EKEYREVOKED, 0},
+	/* test3 */
+	{"ltp3", EKEYEXPIRED, 0}
+};
+
+static void verify_request_key(struct test_case *);
+static void setup(void);
+static int init_key(char *, int);
+static void cleanup(void);
+
+int TST_TOTAL = ARRAY_SIZE(tc);
+
+#ifdef HAVE_KEYUTILS_H
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
+	TEST(request_key("keyring", tc->des, NULL, tc->id));
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "request_key() succeed unexpectly");
+		return;
+	}
+
+	if (TEST_ERRNO == tc->exp_err)
+		tst_resm(TPASS | TTERRNO, "request_key() failed expectly");
+	else
+		tst_resm(TFAIL | TTERRNO, "request_key() failed unexpectly");
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	tc[0].id = KEY_REQKEY_DEFL_DEFAULT;
+
+	tc[1].id = init_key("ltp2", KEYCTL_REVOKE);
+
+	tc[2].id = init_key("ltp3", KEYCTL_SET_TIMEOUT);
+}
+
+static int init_key(char *name, int cmd)
+{
+	int n;
+	int sec = 1;
+
+	n = add_key("keyring", name, NULL, 0, KEY_SPEC_THREAD_KEYRING);
+	if (n == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "add_key() failed");
+
+	if (cmd == KEYCTL_REVOKE) {
+		if (keyctl(cmd, n) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "failed to revoke a key");
+		}
+	}
+
+	if (cmd == KEYCTL_SET_TIMEOUT) {
+		if (keyctl(cmd, n, sec) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "failed to set timeout for a key");
+		}
+
+		sleep(sec + 1);
+	}
+
+	return n;
+}
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "compilation failed without keyutils.h");
+}
+#endif /* HAVE_LINUX_KEYCTL_H */
-- 
1.8.3.1



