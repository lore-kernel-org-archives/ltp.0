From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 16 Feb 2021 07:47:48 +0000
Subject: [LTP] [PATCH v2 2/2] close_range02: Add simpler test and Check
 invalid params
In-Reply-To: <20210216074748.6873-1-rpalethorpe@suse.com>
References: <20210216074748.6873-1-rpalethorpe@suse.com>
Message-ID: <20210216074748.6873-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds some coverage for invalid parameters and a min fd above or
on the limits. There is also some overlap with close_range01, but this
test is simpler and has less requirements.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---

V2: Try Closing the path file descriptor at the end if it was opened
    to prevent hitting the FD limit with -i

This does not include a check for EMFILE during unsharing because it
only happens if the _system's_ maximum file count is reduced after
clone and before unshare. This should probably go into a separate
test. Also it seems like a corner case which is not likely to happen
in practice and can not be done without CAP_SYS_ADMIN AFAICT.

More tests could be added, but I think we can leave it to the fuzzers
to find where coverage is lacking now that we have the basics. Also
Cyrils and I discussed creating generic data copying tests which copy
data between various types of FD (file system files, pipes, sockets,
etc.)  using various system calls (e.g (vm)splice, send/recvmsg,
write) and these could also use close_range() in addtion to close(). I
think that would be more productive than adding just to
close_range.

 runtest/syscalls                              |   1 +
 .../kernel/syscalls/close_range/.gitignore    |   1 +
 .../syscalls/close_range/close_range02.c      | 116 ++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 testcases/kernel/syscalls/close_range/close_range02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c71f2b371..ae47a6d5e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -121,6 +121,7 @@ close02 close02
 close08 close08
 
 close_range01 close_range01
+close_range02 close_range02
 
 confstr01 confstr01
 
diff --git a/testcases/kernel/syscalls/close_range/.gitignore b/testcases/kernel/syscalls/close_range/.gitignore
index dddc1b7f8..4b8bab442 100644
--- a/testcases/kernel/syscalls/close_range/.gitignore
+++ b/testcases/kernel/syscalls/close_range/.gitignore
@@ -1 +1,2 @@
 close_range01
+close_range02
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testcases/kernel/syscalls/close_range/close_range02.c
new file mode 100644
index 000000000..780da68ff
--- /dev/null
+++ b/testcases/kernel/syscalls/close_range/close_range02.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 SUSE LLC
+ */
+/*\
+ * [DESCRIPTION]
+ *
+ * - First check close_range works on a valid range.
+ * - Then check close_range does not accept invalid paramters.
+ * - Then check it accepts a large lower fd.
+ * - Finally check CLOEXEC works
+ *
+\*/
+
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "tst_clone.h"
+#include "lapi/fcntl.h"
+#include "lapi/close_range.h"
+#include "lapi/clone.h"
+
+static int try_close_range(int fd, int flags)
+{
+	int res;
+
+	TEST(close_range(fd, fd, flags));
+
+	if (TST_RET == -1 && TST_ERR == EINVAL)
+		res = TCONF;
+	else if (TST_RET == -1)
+		res = TFAIL;
+	else
+		res = TPASS;
+
+	return res;
+}
+
+static void run(unsigned int n)
+{
+	const struct tst_clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+	int fd = -1, res;
+
+	switch (n) {
+	case 0:
+		fd = SAFE_OPEN("/", O_PATH);
+		SAFE_DUP2(fd, 100);
+
+		TST_EXP_PASS(close_range(fd, 100, 0),
+			     "close_range(%d, 100, 0)", fd);
+		TST_EXP_FAIL(fcntl(fd, F_GETFD), EBADF,
+			     "fcntl(%d, F_GETFD)", fd);
+		TST_EXP_FAIL(fcntl(100, F_GETFD), EBADF);
+		break;
+	case 1:
+		TST_EXP_FAIL(close_range(4, 3, 0), EINVAL);
+		break;
+	case 2:
+		TST_EXP_FAIL(close_range(3, ~0U, ~0U), EINVAL);
+		break;
+	case 3:
+		TST_EXP_PASS(close_range(~0U, ~0U, 0));
+		break;
+	case 4:
+		fd = SAFE_OPEN("/", O_PATH);
+
+		res = try_close_range(fd, CLOSE_RANGE_CLOEXEC);
+		tst_res(res | TTERRNO,
+			"close_range(%d, %d, CLOSE_RANGE_CLOEXEC)", fd, fd);
+
+		if (res != TPASS)
+			break;
+
+		TST_EXP_FD_SILENT(fcntl(fd, F_GETFD), "fcntl(%d, F_GETFD)", fd);
+		if (TST_RET & FD_CLOEXEC)
+			tst_res(TPASS, "FD_CLOEXEC was set on %d", fd);
+		else
+			tst_res(TFAIL, "FD_CLOEXEC not set on %d", fd);
+		break;
+	case 5:
+		fd = SAFE_OPEN("/", O_PATH);
+
+		if (!SAFE_CLONE(&args)) {
+			res = try_close_range(fd, CLOSE_RANGE_UNSHARE);
+			tst_res(res | TTERRNO,
+				"close_range(%d, %d, CLOSE_RANGE_UNSHARE)",
+				fd, fd);
+
+			if (res != TPASS)
+				exit(0);
+
+			TST_EXP_FAIL(fcntl(fd, F_GETFD), EBADF,
+				     "fcntl(%d, F_GETFD)", fd);
+			exit(0);
+		}
+
+		tst_reap_children();
+
+		TST_EXP_PASS(fcntl(fd, F_GETFD), "%d is open", fd);
+	}
+
+	if (fd > -1) {
+		TST_EXP_PASS_SILENT(close_range(fd, fd, 0),
+				    "close_range(%d, %d, 0)", fd, fd);
+		fd = -1;
+	}
+}
+
+static struct tst_test test = {
+	.tcnt = 6,
+	.forks_child = 1,
+	.test = run,
+};
-- 
2.30.0

