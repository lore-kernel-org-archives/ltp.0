From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 29 Feb 2016 15:53:37 +0800
Subject: [LTP] [PATCH 1/2] request_key/request_key01.c: add new testcase
Message-ID: <1456732418-10557-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase checks the basic functionality of the request_key(2).
request_key(2) asks the kernel to find a key which matches the
specified description. If successful, it attaches it to the nominated
keyring and returns its serial number.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                    |   2 +
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/request_key/Makefile     |  22 +++++
 .../kernel/syscalls/request_key/request_key01.c    | 107 +++++++++++++++++++++
 5 files changed, 134 insertions(+)
 create mode 100644 testcases/kernel/syscalls/request_key/Makefile
 create mode 100644 testcases/kernel/syscalls/request_key/request_key01.c

diff --git a/runtest/ltplite b/runtest/ltplite
index f1795ed..8ecafa1 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -663,6 +663,8 @@ rename12 rename12
 rename13 rename13
 rename14 rename14
 
+request_key01 request_key01
+
 rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
diff --git a/runtest/syscalls b/runtest/syscalls
index e912ecc..68ba417 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -891,6 +891,8 @@ renameat01 renameat01
 renameat201 renameat201
 renameat202 renameat202 -i 10
 
+request_key01 request_key01
+
 rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index fd8b7a1..d5d01d2 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -736,6 +736,7 @@
 /renameat/renameat01
 /renameat2/renameat201
 /renameat2/renameat202
+/request_key/request_key01
 /rmdir/rmdir01
 /rmdir/rmdir02
 /rmdir/rmdir03
diff --git a/testcases/kernel/syscalls/request_key/Makefile b/testcases/kernel/syscalls/request_key/Makefile
new file mode 100644
index 0000000..7f2d92b
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/Makefile
@@ -0,0 +1,22 @@
+#  Copyright (c) 2016 Fujitsu Ltd.
+#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+#  along with this program.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
new file mode 100644
index 0000000..ed90e98
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/request_key01.c
@@ -0,0 +1,107 @@
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
+* Test Name: request_key01
+*
+* Description:
+* The testcase checks the basic functionality of the request_key(2).
+* request_key(2) asks the kernel to find a key which matches the
+* specified description. If successful, it attaches it to the nominated
+* keyring and returns its serial number.
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
+char *TCID = "request_key01";
+
+#ifdef HAVE_LINUX_KEYCTL_H
+
+static void verify_request_key(void);
+static void setup(void);
+static void cleanup(void);
+
+int TST_TOTAL = 1;
+
+int main(int ac, char **av)
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		verify_request_key();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void verify_request_key(void)
+{
+	int res;
+
+	res = ltp_syscall(__NR_add_key, "keyring", "ltp", NULL, 0, KEY_SPEC_THREAD_KEYRING);
+	if (res == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "add_key() failed");
+
+	TEST(ltp_syscall(__NR_request_key, "keyring", "ltp", NULL, KEY_SPEC_PROCESS_KEYRING));
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TERRNO, "request_key() failed");
+		return;
+	}
+
+	if (TEST_RETURN != res)
+		tst_resm(TFAIL, "serial number mismatched");
+	else
+		tst_resm(TPASS, "request_key() succeed");
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



