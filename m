From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed,  7 Jul 2021 08:18:38 +0100
Subject: [LTP] [PATCH] kill13, CVE-2018-10124: Reproduce INT_MIN negation
Message-ID: <20210707071838.27834-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/cve                               |  1 +
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/kill/.gitignore |  1 +
 testcases/kernel/syscalls/kill/kill13.c   | 35 +++++++++++++++++++++++
 4 files changed, 38 insertions(+)
 create mode 100644 testcases/kernel/syscalls/kill/kill13.c

diff --git a/runtest/cve b/runtest/cve
index 5a6ef966d..226b5ea44 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -49,6 +49,7 @@ cve-2018-5803 sctp_big_chunk
 cve-2018-7566 snd_seq01
 cve-2018-8897 ptrace09
 cve-2018-9568 connect02
+cve-2018-10124 kill13
 cve-2018-1000001 realpath01
 cve-2018-1000199 ptrace08
 cve-2018-1000204 ioctl_sg01
diff --git a/runtest/syscalls b/runtest/syscalls
index 98fe3c02e..0c1e16f9e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -644,6 +644,7 @@ kill09 kill09
 kill10 kill10
 kill11 kill11
 kill12 kill12
+kill13 kill13
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/kill/.gitignore b/testcases/kernel/syscalls/kill/.gitignore
index 75fdaa561..810ed0200 100644
--- a/testcases/kernel/syscalls/kill/.gitignore
+++ b/testcases/kernel/syscalls/kill/.gitignore
@@ -8,3 +8,4 @@
 /kill10
 /kill11
 /kill12
+/kill13
diff --git a/testcases/kernel/syscalls/kill/kill13.c b/testcases/kernel/syscalls/kill/kill13.c
new file mode 100644
index 000000000..b5afb653f
--- /dev/null
+++ b/testcases/kernel/syscalls/kill/kill13.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Reproducer of CVE-2018-10124; INT_MIN negation.
+ *
+ * Most likely this test will always pass without UBSAN
+ * enabled. Perhaps unless negating INT_MIN results in -1 or
+ * 0. However on my computer it just results in INT_MIN.
+ *
+ */
+
+#include <limits.h>
+#include <signal.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	TST_EXP_FAIL2(kill(INT_MIN, 1000), ESRCH,
+		      "kill(INT_MIN, ...) fails with ESRCH");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "4ea77014af0d"},
+		{"CVE", "CVE-2018-10124"},
+		{}
+	}
+};
-- 
2.31.1

