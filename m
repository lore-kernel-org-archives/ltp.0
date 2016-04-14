From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 Apr 2016 17:22:06 +0800
Subject: [LTP] [PATCH v3 2/2] request_key/request_key02.c: add new testcase
In-Reply-To: <1460625726-3659-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160413160302.GG11529@rei.lan>
 <1460625726-3659-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1460625726-3659-2-git-send-email-yangx.jy@cn.fujitsu.com>
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
 .../kernel/syscalls/request_key/request_key02.c    | 146 +++++++++++++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 testcases/kernel/syscalls/request_key/request_key02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index ebd5e77..8b8121d 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -665,6 +665,7 @@ rename13 rename13
 rename14 rename14
 
 request_key01 request_key01
+request_key02 request_key02
 
 rmdir01 rmdir01
 rmdir02 rmdir02
diff --git a/runtest/syscalls b/runtest/syscalls
index 8c87161..edf70eb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -896,6 +896,7 @@ renameat201 renameat201
 renameat202 renameat202 -i 10
 
 request_key01 request_key01
+request_key02 request_key02
 
 rmdir01 rmdir01
 rmdir02 rmdir02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 21130d2..63fc261 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -743,6 +743,7 @@
 /renameat2/renameat201
 /renameat2/renameat202
 /request_key/request_key01
+/request_key/request_key02
 /rmdir/rmdir01
 /rmdir/rmdir02
 /rmdir/rmdir03
diff --git a/testcases/kernel/syscalls/request_key/request_key02.c b/testcases/kernel/syscalls/request_key/request_key02.c
new file mode 100644
index 0000000..94cad28
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/request_key02.c
@@ -0,0 +1,146 @@
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
+#ifdef HAVE_KEYUTILS_H
+
+static int res1;
+static int res2;
+static int res3;
+
+static struct test_case {
+	const char *des;
+	int exp_err;
+	int *id;
+} tc[] = {
+	{"ltp1", ENOKEY, &res1},
+	{"ltp2", EKEYREVOKED, &res2},
+	{"ltp3", EKEYEXPIRED, &res3}
+};
+
+static void verify_request_key(struct test_case *);
+static void setup(void);
+static int init_key(char *, int);
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
+	tst_exit();
+}
+
+static void verify_request_key(struct test_case *tc)
+{
+	TEST(request_key("keyring", tc->des, NULL, *tc->id));
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "request_key() succeed unexpectly");
+		return;
+	}
+
+	if (TEST_ERRNO == tc->exp_err) {
+		tst_resm(TPASS | TTERRNO, "request_key() failed expectly");
+		return;
+	}
+
+	tst_resm(TFAIL | TTERRNO, "request_key() failed unexpectly, "
+		 "expected %s", tst_strerrno(tc->exp_err));
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, NULL);
+
+	TEST_PAUSE;
+
+	res1 = KEY_REQKEY_DEFL_DEFAULT;
+
+	res2 = init_key("ltp2", KEYCTL_REVOKE);
+
+	res3 = init_key("ltp3", KEYCTL_SET_TIMEOUT);
+}
+
+static int init_key(char *name, int cmd)
+{
+	int n;
+	int sec = 1;
+
+	n = add_key("keyring", name, NULL, 0, KEY_SPEC_THREAD_KEYRING);
+	if (n == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "add_key() failed");
+
+	if (cmd == KEYCTL_REVOKE) {
+		if (keyctl(cmd, n) == -1) {
+			tst_brkm(TBROK | TERRNO, NULL,
+				 "failed to revoke a key");
+		}
+	}
+
+	if (cmd == KEYCTL_SET_TIMEOUT) {
+		if (keyctl(cmd, n, sec) == -1) {
+			tst_brkm(TBROK | TERRNO, NULL,
+				 "failed to set timeout for a key");
+		}
+
+		sleep(sec + 1);
+	}
+
+	return n;
+}
+
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "keyutils.h was missing at compilation");
+}
+#endif /* HAVE_LINUX_KEYCTL_H */
-- 
1.8.3.1



