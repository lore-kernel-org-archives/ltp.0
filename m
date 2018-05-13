From: Eric Biggers <ebiggers3@gmail.com>
Date: Sat, 12 May 2018 17:01:01 -0700
Subject: [LTP] [PATCH] pty/pty02: new test for hang involving EXTPROC|ICANON
	terminal mode
Message-ID: <20180513000101.13027-1-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Test for a bug in the kernel's tty layer where an infinite loop could
occur if the EXTPROC and ICANON terminal modes were combined.  This bug
was found by the syzkaller fuzzer and was fixed in v4.15.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/pty02.c    | 58 +++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 testcases/kernel/pty/pty02.c

diff --git a/runtest/pty b/runtest/pty
index 92c89ab31..52e2c07f1 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -1,5 +1,6 @@
 #DESCRIPTION:Terminal type stress
 pty01 pty01
+pty02 pty02
 ptem01 ptem01
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index db16401dc..131b8a077 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -1,3 +1,4 @@
 /hangup01
 /ptem01
 /pty01
+/pty02
diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
new file mode 100644
index 000000000..d96eec211
--- /dev/null
+++ b/testcases/kernel/pty/pty02.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2018 Google, Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Regression test for commit 966031f340185 ("n_tty: fix EXTPROC vs ICANON
+ * interaction with TIOCINQ (aka FIONREAD)").  The test reproduces a hang
+ * (infinite loop in the kernel) after a pseudoterminal is put in both canonical
+ * (ICANON) and external processing (EXTPROC) mode, some data is written to the
+ * master and read from the slave, and the FIONREAD ioctl is called on the
+ * slave.  This is simplified from a syzkaller-generated reproducer.
+ */
+
+#include <stdlib.h>
+#include <termio.h>
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	struct termios io = { .c_lflag = EXTPROC | ICANON };
+	int ptmx, pts;
+	char c = 'A';
+	int nbytes;
+
+	ptmx = SAFE_OPEN("/dev/ptmx", O_WRONLY);
+
+	if (tcsetattr(ptmx, TCSANOW, &io) != 0)
+		tst_brk(TBROK | TERRNO, "tcsetattr() failed");
+
+	if (unlockpt(ptmx) != 0)
+		tst_brk(TBROK | TERRNO, "unlockpt() failed");
+
+	pts = SAFE_OPEN(ptsname(ptmx), O_RDONLY);
+	SAFE_WRITE(1, ptmx, &c, 1);
+	SAFE_READ(1, pts, &c, 1);
+
+	tst_res(TINFO, "Calling FIONREAD, this will hang in n_tty_ioctl() if the bug is present...");
+	SAFE_IOCTL(pts, FIONREAD, &nbytes);
+	tst_res(TPASS, "Got to the end without hanging");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.17.0

