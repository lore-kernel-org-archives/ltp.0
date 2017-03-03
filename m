From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 3 Mar 2017 10:18:33 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/getxattr04.c: add new regression test
In-Reply-To: <20170302162310.GB8152@rei.lan>
References: <20170302162310.GB8152@rei.lan>
Message-ID: <1488507513-30941-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a regression test for the race between getting an existing
xattr and setting/removing a large xattr.  This bug leads to that
getxattr() fails to get an existing xattr and returns ENOATTR in xfs
filesystem.  Thie bug has been fixed in:

commit 5a93790d4e2df73e30c965ec6e49be82fc3ccfce
Author: Brian Foster <bfoster@redhat.com>
Date:   Wed Jan 25 07:53:43 2017 -0800

	xfs: remove racy hasattr check from attr ops

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/.gitignore            |   1 +
 testcases/kernel/syscalls/getxattr/getxattr04.c | 131 ++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 testcases/kernel/syscalls/getxattr/getxattr04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c3ea212..edf0674 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -444,6 +444,7 @@ getuid03_16 getuid03_16
 getxattr01 getxattr01
 getxattr02 getxattr02
 getxattr03 getxattr03
+getxattr04 getxattr04
 
 #Needs tty device.
 #ioctl01 ioctl01 -D /dev/tty0
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 9d7b947..2728509 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -368,6 +368,7 @@
 /getxattr/getxattr01
 /getxattr/getxattr02
 /getxattr/getxattr03
+/getxattr/getxattr04
 /inotify/inotify01
 /inotify/inotify02
 /inotify/inotify03
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
new file mode 100644
index 0000000..1a793b9
--- /dev/null
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright (c) 2017 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
+ *
+ */
+
+/*
+ * This is a regression test for the race between getting an existing
+ * xattr and setting/removing a large xattr.  This bug leads to that
+ * getxattr() fails to get an existing xattr and returns ENOATTR in xfs
+ * filesystem.
+ *
+ * Thie bug has been fixed in:
+ *
+ * commit 5a93790d4e2df73e30c965ec6e49be82fc3ccfce
+ * Author: Brian Foster <bfoster@redhat.com>
+ * Date:   Wed Jan 25 07:53:43 2017 -0800
+ *
+ * xfs: remove racy hasattr check from attr ops
+ */
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+#include <string.h>
+#include <stdlib.h>
+#include <signal.h>
+
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
+#endif
+
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
+#define MNTPOINT	"mntpoint"
+#define TEST_FILE	MNTPOINT "/file"
+#define TRUSTED_BIG	"trusted.big"
+#define TRUSTED_SMALL	"trusted.small"
+
+static volatile int end;
+static char big_value[512];
+static char small_value[32];
+
+static void sigproc(int sig)
+{
+	end = sig;
+}
+
+static void loop_getxattr(void)
+{
+	int res;
+
+	while (!end) {
+		res = getxattr(TEST_FILE, TRUSTED_SMALL, NULL, 0);
+		if (res == -1) {
+			if (errno == ENODATA) {
+				tst_res(TFAIL, "getxattr() failed to get an "
+					"existing attribute");
+			} else {
+				tst_res(TFAIL | TERRNO,
+					"getxattr() failed without ENOATTR");
+			}
+
+			exit(0);
+		}
+	}
+
+	tst_res(TPASS, "getxattr() succeeded to get an existing attribute");
+	exit(0);
+}
+
+static void verify_getxattr(void)
+{
+	pid_t pid;
+	int n;
+
+	pid = SAFE_FORK();
+	if (!pid)
+		loop_getxattr();
+
+	for (n = 0; n < 99; n++) {
+		SAFE_SETXATTR(TEST_FILE, TRUSTED_BIG, big_value,
+				sizeof(big_value), XATTR_CREATE);
+		SAFE_REMOVEXATTR(TEST_FILE, TRUSTED_BIG);
+	}
+
+	kill(pid, SIGUSR1);
+	tst_reap_children();
+}
+
+static void setup(void)
+{
+	SAFE_SIGNAL(SIGUSR1, sigproc);
+
+	SAFE_TOUCH(TEST_FILE, 0644, NULL);
+
+	memset(big_value, 'a', sizeof(big_value));
+	memset(small_value, 'a', sizeof(small_value));
+
+	SAFE_SETXATTR(TEST_FILE, TRUSTED_SMALL, small_value,
+			sizeof(small_value), XATTR_CREATE);
+}
+
+static struct tst_test test = {
+	.tid = "getxattr04",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.mount_device = 1,
+	.dev_fs_type = "xfs",
+	.mntpoint = MNTPOINT,
+	.forks_child = 1,
+	.test_all = verify_getxattr,
+	.setup = setup
+};
+
+#else /* HAVE_SYS_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
+#endif
-- 
1.8.3.1



