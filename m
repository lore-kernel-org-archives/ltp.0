From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 9 Jun 2017 16:40:46 +0800
Subject: [LTP] [PATCH] syscalls/fcntl35.c: add new regression test
Message-ID: <1496997646-4825-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We add a regression test to check that pipe-max-size caps the
initial allocation for a new pipe for unprivileged users, but
not for privileged users.

This kernel bug has been fixed by:
'086e774a57fb(pipe: cap initial pipe capacity according to
pipe-max-size limit)'

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/.gitignore      |   2 +
 testcases/kernel/syscalls/fcntl/fcntl35.c | 134 ++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl35.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fe52272..32c65c6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -267,6 +267,8 @@ fcntl33 fcntl33
 fcntl33_64 fcntl33_64
 fcntl34 fcntl34
 fcntl34_64 fcntl34_64
+fcntl35 fcntl35
+fcntl35_64 fcntl35_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index c14c4e6..03178db 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -230,6 +230,8 @@
 /fcntl/fcntl33_64
 /fcntl/fcntl34
 /fcntl/fcntl34_64
+/fcntl/fcntl35
+/fcntl/fcntl35_64
 /fdatasync/fdatasync01
 /fdatasync/fdatasync02
 /flistxattr/flistxattr01
diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
new file mode 100644
index 0000000..087e779
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -0,0 +1,134 @@
+/*
+ * Copyright (c) 2017 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.*
+ */
+
+/*
+ * Description:
+ * fcntl(2) manpage states that an unprivileged user could not set the
+ * pipe capacity above the limit in /proc/sys/fs/pipe-max-size.  However,
+ * an unprivileged user could create a pipe whose initial capacity exceeds
+ * the limit.  We add a regression test to check that pipe-max-size caps
+ * the initial allocation for a new pipe for unprivileged users, but not
+ * for privileged users.
+ *
+ * This kernel bug has been fixed by:
+ *
+ * commit 086e774a57fba4695f14383c0818994c0b31da7c
+ * Author: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
+ * Date:   Tue Oct 11 13:53:43 2016 -0700
+ *
+ * pipe: cap initial pipe capacity according to pipe-max-size limit
+ */
+
+#include <errno.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdlib.h>
+
+#include "lapi/fcntl.h"
+#include "tst_test.h"
+
+static int pipe_max_unpriv;
+static int test_max_unpriv = 4096;
+struct passwd *pw;
+static struct tcase {
+	int exp_sz;
+	int exp_usr;
+	char *des;
+} tcases[] = {
+	{4096, 1, "an unprivileged user"},
+	{65536, 0, "a privileged user"}
+};
+
+static void setup(void)
+{
+	if (!access("/proc/sys/fs/pipe-max-size", F_OK)) {
+		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d",
+				&pipe_max_unpriv);
+		SAFE_FILE_PRINTF("/proc/sys/fs/pipe-max-size", "%d",
+				test_max_unpriv);
+	} else {
+		tst_brk(TCONF, "/proc/sys/fs/pipe-max-size doesn't exist");
+	}
+
+	pw = SAFE_GETPWNAM("nobody");
+}
+
+static void cleanup(void)
+{
+	SAFE_FILE_PRINTF("/proc/sys/fs/pipe-max-size", "%d", pipe_max_unpriv);
+}
+
+static int verify_pipe_size(int exp_pip_sz, char *desp)
+{
+	int get_size;
+	int fds[0];
+
+	SAFE_PIPE(fds);
+
+	get_size = fcntl(fds[1], F_GETPIPE_SZ);
+	if (get_size == -1) {
+		tst_res(TFAIL | TERRNO, "fcntl(2) with F_GETPIPE_SZ failed");
+		goto end;
+	}
+
+	if (get_size != exp_pip_sz) {
+		tst_res(TFAIL, "%s init the capacity of a pipe to %d "
+			"unexpectedly, expected %d", desp, get_size,
+			exp_pip_sz);
+	} else {
+		tst_res(TPASS, "%s init the capacity of a pipe to %d "
+			"successfully", desp, exp_pip_sz);
+	}
+
+end:
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
+
+	exit(0);
+}
+
+static void do_test(unsigned int n)
+{
+	pid_t pid;
+	struct tcase *tc = &tcases[n];
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		if (tc->exp_usr)
+			SAFE_SETUID(pw->pw_uid);
+
+		verify_pipe_size(tc->exp_sz, tc->des);
+	}
+
+	tst_reap_children();
+}
+
+static struct tst_test test = {
+	.min_kver = "2.6.35",
+	.needs_root = 1,
+	.forks_child = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = do_test
+};
-- 
1.8.3.1



