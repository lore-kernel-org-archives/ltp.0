From: Matthias Maennich <maennich@google.com>
Date: Tue, 12 Feb 2019 16:12:36 +0000
Subject: [LTP] [PATCH v2 2/2] rt_sigpending: add rt_sigpending02 test case
In-Reply-To: <20190212161236.74385-1-maennich@google.com>
References: <20190207155153.41816-1-maennich@google.com>
 <20190212161236.74385-1-maennich@google.com>
Message-ID: <20190212161236.74385-3-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is effectively a copy of the sigpending/sigpending02 test case.
Both of them are now bypassing any syscall wrapper.

Signed-off-by: Matthias Maennich <maennich@google.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/rt_sigpending/.gitignore  |  1 +
 .../kernel/syscalls/rt_sigpending/Makefile    | 23 +++++++++
 .../syscalls/rt_sigpending/rt_sigpending02.c  | 48 +++++++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 testcases/kernel/syscalls/rt_sigpending/.gitignore
 create mode 100644 testcases/kernel/syscalls/rt_sigpending/Makefile
 create mode 100644 testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 668c87cd1..6280034d0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -990,6 +990,7 @@ rmdir03A symlink01 -T rmdir03
 rt_sigaction01 rt_sigaction01
 rt_sigaction02 rt_sigaction02
 rt_sigaction03 rt_sigaction03
+rt_sigpending02 rt_sigpending02
 rt_sigprocmask01 rt_sigprocmask01
 rt_sigprocmask02 rt_sigprocmask02
 rt_sigqueueinfo01 rt_sigqueueinfo01
diff --git a/testcases/kernel/syscalls/rt_sigpending/.gitignore b/testcases/kernel/syscalls/rt_sigpending/.gitignore
new file mode 100644
index 000000000..85905fc83
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigpending/.gitignore
@@ -0,0 +1 @@
+/rt_sigpending02
diff --git a/testcases/kernel/syscalls/rt_sigpending/Makefile b/testcases/kernel/syscalls/rt_sigpending/Makefile
new file mode 100644
index 000000000..bd617d806
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigpending/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2001
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
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c b/testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c
new file mode 100644
index 000000000..06d1c1578
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (c) International Business Machines  Corp., 2002
+ *
+ * AUTHORS
+ *	Paul Larson
+ *
+ * DESCRIPTION
+ *	Test to see that the proper errors are returned by rt_sigpending
+ *
+ *	Test 1:
+ *		Call rt_sigpending(sigset_t*=-1, SIGSETSIZE),
+ *		it should return -1 with errno EFAULT
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+#include "ltp_signal.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	/* set sigset to point to an invalid location */
+	sigset_t *sigset = (sigset_t *) - 1;
+
+	TEST(tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE));
+
+	/* check return code */
+	if (TST_RET == -1) {
+		if (TST_ERR != EFAULT) {
+			tst_res(TFAIL | TTERRNO,
+				"rt_sigpending() Failed with wrong errno, "
+				"expected errno=%d, got ", EFAULT);
+		} else {
+			tst_res(TPASS | TTERRNO, "expected failure");
+		}
+	} else {
+		tst_res(TFAIL,
+			"rt_sigpending() Failed, expected return value=-1, got %ld", TST_RET);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run
+};
-- 
2.20.1.791.gb4d0f1c61a-goog

