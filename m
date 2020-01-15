From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 15 Jan 2020 17:09:54 +0800
Subject: [LTP] [PATCH 2/2] syscalls/fcntl37: add error test for fcntl with
 F_SETPIPE_SZ
In-Reply-To: <1579079394-18233-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1579079394-18233-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1579079394-18233-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                           |   2 +
 testcases/kernel/syscalls/fcntl/.gitignore |   2 +
 testcases/kernel/syscalls/fcntl/fcntl37.c  | 100 +++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl37.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 92a9ae636..3f33b8661 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -299,6 +299,8 @@ fcntl35 fcntl35
 fcntl35_64 fcntl35_64
 fcntl36 fcntl36
 fcntl36_64 fcntl36_64
+fcntl37 fcntl37
+fcntl37_64 fcntl37_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
index 8d5738f97..be8d9739e 100644
--- a/testcases/kernel/syscalls/fcntl/.gitignore
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -70,3 +70,5 @@
 /fcntl35_64
 /fcntl36
 /fcntl36_64
+/fcntl37
+/fcntl37_64
diff --git a/testcases/kernel/syscalls/fcntl/fcntl37.c b/testcases/kernel/syscalls/fcntl/fcntl37.c
new file mode 100644
index 000000000..c9f5f15a7
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl37.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * Test basic error handling for fcntl(2) using F_SETPIPE_SZ, F_GETPIPE_SZ
+ * argument.
+ * 1)fcntl fails with EINVAL when cmd is F_SETPIPE_SZ and the arg is
+ * beyond UINT_MAX
+ * 2)fcntl fails with EBUSY when cmd is F_SETPIPE_SZ and the arg is smaller
+ * than the amount of the current used buffer space.
+ * 3)fcntl fails with EPERM when cmd is F_SETPIPE_SZ and the arg is over
+ * /proc/sys/fs/pipe-max-size limit under unprivileged users.
+ */
+
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <limits.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/capability.h"
+
+static int fds[2];
+static unsigned int orig_value, invalid_value, half_value, sys_value;
+static char *wrbuf;
+
+static struct tcase {
+	unsigned int *setvalue;
+	int exp_err;
+	char *message;
+} tcases[] = {
+	{&invalid_value, EINVAL,
+	"cmd is F_SETPIPE_SZ and the arg is beyond UINT_MAX"},
+
+	{&half_value, EBUSY,
+	"cmd is F_SETPIPE_SZ and the arg is smaller than the amount of the current used buffer space"},
+	{&sys_value, EPERM,
+	"cmd is F_SETPIPE_SZ and the arg is over /proc/sys/fs/pipe-max-size limit under unprivileged users"},
+};
+
+static void verify_fcntl(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	tst_res(TINFO, "%s", tc->message);
+
+	TEST(fcntl(fds[1], F_SETPIPE_SZ, *(tc->setvalue)));
+	if (TST_RET != -1)
+		tst_res(TFAIL, "F_SETPIPE_SZ succeed");
+	if (TST_ERR == tc->exp_err)
+		tst_res(TPASS | TTERRNO, "F_SETPIPE_SZ failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "F_SETPIPE_SZ failed expected %s bu got",
+				tst_strerrno(tc->exp_err));
+}
+
+static void setup(void)
+{
+	SAFE_PIPE(fds);
+
+	TEST(fcntl(fds[1], F_GETPIPE_SZ));
+	if (TST_ERR == EINVAL)
+		tst_brk(TCONF, "kernel doesn't support F_GET/SETPIPE_SZ");
+
+	orig_value = TST_RET;
+
+	wrbuf = SAFE_MALLOC(orig_value);
+	memset(wrbuf, 'x', orig_value);
+	SAFE_WRITE(1, fds[1], wrbuf, orig_value);
+
+	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &sys_value);
+	sys_value++;
+
+	half_value = orig_value / 2;
+	invalid_value = (1U << 31) + 1;
+}
+
+static void cleanup(void)
+{
+	SAFE_FCNTL(fds[1], F_SETPIPE_SZ, orig_value);
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
+	if (wrbuf)
+		free(wrbuf);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_fcntl,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_SYS_RESOURCE),
+		{}
+	},
+};
-- 
2.18.0



