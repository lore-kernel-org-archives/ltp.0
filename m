From: Xiong Zhou <xzhou@redhat.com>
Date: Fri,  2 Jun 2017 17:24:15 +0800
Subject: [LTP] [PATCH] syscalls/fanotify08: add sanity check for FAN_CLOEXEC
Message-ID: <1496395455-6778-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fanotify/fanotify08.c | 144 ++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify08.c

diff --git a/testcases/kernel/syscalls/fanotify/fanotify08.c b/testcases/kernel/syscalls/fanotify/fanotify08.c
new file mode 100644
index 0000000..1bcef7d
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify08.c
@@ -0,0 +1,144 @@
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
+#include "test.h"
+#include "linux_syscall_numbers.h"
+#include "fanotify.h"
+#include "safe_macros.h"
+
+char *TCID = "fanotify01";
+int TST_TOTAL = 12;
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define EVENT_MAX 1024
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+/* reasonable guess as to size of 1024 events */
+#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
+
+static void setup(void);
+static void cleanup(void);
+
+#define BUF_SIZE 256
+static int fd_notify;
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
+		int coe;
+
+		tst_count = 0;
+
+		if ((fd_notify = fanotify_init(FAN_CLASS_NOTIF,
+						O_RDONLY)) < 0) {
+			if (errno == ENOSYS) {
+				tst_brkm(TCONF, cleanup,
+				"fanotify is not configured in this kernel.");
+			} else {
+				tst_brkm(TBROK | TERRNO, cleanup,
+					 "fanotify_init failed");
+			}
+		}
+
+		coe = fcntl(fd_notify, F_GETFD);
+		if (coe == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "fcntl failed");
+		}
+		if (coe & FD_CLOEXEC) {
+			tst_brkm(TFAIL, cleanup,
+				 "fanotify_init set close-on-exit");
+		}
+		close(fd_notify);
+
+		if ((fd_notify = fanotify_init(FAN_CLASS_NOTIF|FAN_CLOEXEC,
+							O_RDONLY)) < 0) {
+			if (errno == ENOSYS) {
+				tst_brkm(TCONF, cleanup,
+				"fanotify is not configured in this kernel.");
+			} else {
+				tst_brkm(TBROK | TERRNO, cleanup,
+				"fanotify_init(FAN_CLOEXEC) failed");
+			}
+		}
+
+		coe = fcntl(fd_notify, F_GETFD);
+		if (coe == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup, "fcntl failed");
+		} else if ((coe & FD_CLOEXEC) == 0) {
+			tst_brkm(TFAIL, cleanup,
+				 "fanotify_init set close-on-exit");
+		} else {
+			tst_resm(TPASS, "fanotify_init(FAN_CLOEXEC) PASSED");
+		}
+		close(fd_notify);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
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
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
+}
+
+#endif
-- 
1.8.3.1

