From: Xiong Zhou <xzhou@redhat.com>
Date: Mon, 14 Aug 2017 22:01:51 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/fanotify0[89]: add sanity check for
	FAN_CLOEXEC
In-Reply-To: <1502719311-18774-1-git-send-email-xzhou@redhat.com>
References: <20170811084138.GA3341@rei.lan>
 <1502719311-18774-1-git-send-email-xzhou@redhat.com>
Message-ID: <1502719311-18774-4-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 runtest/syscalls                                |  2 +
 testcases/kernel/syscalls/fanotify/fanotify08.c | 77 +++++++++++++++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify09.c | 77 +++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify08.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index be617e3..4033a8f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -479,6 +479,8 @@ fanotify04 fanotify04
 fanotify05 fanotify05
 fanotify06 fanotify06
 fanotify07 fanotify07
+fanotify08 fanotify08
+fanotify09 fanotify09
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/fanotify08.c b/testcases/kernel/syscalls/fanotify/fanotify08.c
new file mode 100644
index 0000000..82f3ff9
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify08.c
@@ -0,0 +1,77 @@
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
+static int fd_notify;
+
+static void test01(void)
+{
+	int coe;
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_CLOEXEC, O_RDONLY);
+
+	coe = SAFE_FCNTL(fd_notify, F_GETFD);
+
+	if (coe & FD_CLOEXEC) {
+		tst_res(TPASS, "set close-on-exit");
+	} else {
+		tst_res(TFAIL, "not set close-on-exit");
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
+	.test_all = test01,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
new file mode 100644
index 0000000..26c0b00
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -0,0 +1,77 @@
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
+static int fd_notify;
+
+static void test01(void)
+{
+	int coe;
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
+
+	coe = SAFE_FCNTL(fd_notify, F_GETFD);
+
+	if (coe & FD_CLOEXEC) {
+		tst_res(TFAIL, "set close-on-exit");
+	} else {
+		tst_res(TPASS, "not set close-on-exit");
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
+	.test_all = test01,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
1.8.3.1

