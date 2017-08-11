From: Xiong Zhou <xzhou@redhat.com>
Date: Fri, 11 Aug 2017 11:13:19 +0800
Subject: [LTP] [PATCH v2] syscalls/fanotify08: add sanity check for
	FAN_CLOEXEC
In-Reply-To: <20170605140332.GB24454@rei.lan>
References: <20170605140332.GB24454@rei.lan>
Message-ID: <1502421199-6364-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fanotify/fanotify08.c | 101 ++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify08.c

diff --git a/testcases/kernel/syscalls/fanotify/fanotify08.c b/testcases/kernel/syscalls/fanotify/fanotify08.c
new file mode 100644
index 0000000..aa3a7c0
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify08.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright (c) 2017 RedHat.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Started by Xiong Zhou <xzhou@redhat.com>
+ *
+ * DESCRIPTION
+ *     Check fanotify_init flag O_CLOEXEC.
+ */
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include "tst_test.h"
+#include "fanotify.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+static void cleanup(void);
+static void test01(int flag);
+static int fd_notify;
+
+void test_coe(void)
+{
+	test01(FAN_CLOEXEC);
+	test01(0);
+}
+
+static void test01(int flag)
+{
+	int coe;
+
+	fd_notify = fanotify_init(FAN_CLASS_NOTIF|flag, O_RDONLY);
+
+	if (fd_notify < 0) {
+
+		if (errno == ENOSYS) {
+			tst_brk(TCONF,
+				"fanotify is not configured in this kernel.");
+		} else {
+			tst_brk(TBROK | TERRNO, "fanotify_init failed");
+		}
+	}
+
+	coe = SAFE_FCNTL(fd_notify, F_GETFD);
+
+	if (coe & FD_CLOEXEC) {
+		if (flag == 0)
+			tst_res(TFAIL, "set close-on-exit");
+		else
+			tst_res(TPASS, "set close-on-exit");
+	} else {
+		if (flag == 0)
+			tst_res(TPASS, "not set close-on-exit");
+		else
+			tst_res(TFAIL, "not set close-on-exit");
+	}
+
+	SAFE_CLOSE(fd_notify);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+}
+
+static struct tst_test test = {
+	.test_all = test_coe,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
1.8.3.1

