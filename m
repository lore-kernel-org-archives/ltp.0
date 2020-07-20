From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 13:27:55 +0800
Subject: [LTP] [PATCH v4] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
Message-ID: <20200720052755.21105-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

pidfd_open(2) will set close-on-exec flag on the file descriptor as
it manpage states, so check close-on-exec flag by fcntl(2).

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---

1) We don't care if the test uses the TEST() macro so just keep it.
2) Use bare fcntl() instead of SAFE_FCNTL() so that file descriptor
   can be closed when fcntl(F_GETFD) fails.

 .../kernel/syscalls/pidfd_open/pidfd_open01.c  | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
index 93bb86687..f40e9b624 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -3,21 +3,35 @@
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
  *
  * Description:
- * Basic pidfd_open() test, fetches the PID of the current process and tries to
- * get its file descriptor.
+ * Basic pidfd_open() test:
+ * 1) Fetch the PID of the current process and try to get its file descriptor.
+ * 2) Check that the close-on-exec flag is set on the file descriptor.
  */
+
+#include <unistd.h>
+#include <fcntl.h>
 #include "tst_test.h"
 #include "lapi/pidfd_open.h"
 
 static void run(void)
 {
+	int flag;
+
 	TEST(pidfd_open(getpid(), 0));
 
 	if (TST_RET == -1)
 		tst_brk(TFAIL | TTERRNO, "pidfd_open(getpid(), 0) failed");
 
+	flag = fcntl(TST_RET, F_GETFD);
+
 	SAFE_CLOSE(TST_RET);
 
+	if (flag == -1)
+		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFD) failed");
+
+	if (!(flag & FD_CLOEXEC))
+		tst_brk(TFAIL, "pidfd_open(getpid(), 0) didn't set close-on-exec flag");
+
 	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
 }
 
-- 
2.21.0



