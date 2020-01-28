From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 28 Jan 2020 22:27:25 +0100
Subject: [LTP] [PATCH 1/1] ioctl02.c: check for struct termio
Message-ID: <20200128212725.22781-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test is meant to use legacy struct termio, so we need to check for it.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Tested: https://travis-ci.org/pevik/ltp/builds/643099597

NOTE: also rewriting other tests to new API which will use LTP_CHECK_TERMIO
(ioctl02.c and ptem01.c).

Kind regards,
Petr

 configure.ac                              |  1 +
 m4/ltp-termio.m4                          |  6 ++++++
 testcases/kernel/syscalls/ioctl/ioctl01.c | 20 ++++++++++++--------
 3 files changed, 19 insertions(+), 8 deletions(-)
 create mode 100644 m4/ltp-termio.m4

diff --git a/configure.ac b/configure.ac
index c7cdff1c4..b860bdacc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -257,6 +257,7 @@ LTP_CHECK_SYSCALL_QUOTACTL
 LTP_CHECK_SYSCALL_SIGNALFD
 LTP_CHECK_SYSCALL_UTIMENSAT
 LTP_CHECK_TASKSTATS
+LTP_CHECK_TERMIO
 LTP_CHECK_TIMERFD
 test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
 LTP_CHECK_TPACKET_V3
diff --git a/m4/ltp-termio.m4 b/m4/ltp-termio.m4
new file mode 100644
index 000000000..e745df1d9
--- /dev/null
+++ b/m4/ltp-termio.m4
@@ -0,0 +1,6 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2020 Petr Vorel <petr.vorel@gmail.com>
+
+AC_DEFUN([LTP_CHECK_TERMIO],[
+AC_CHECK_TYPES([struct termio],,,[#include <sys/ioctl.h>])
+])
diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 7fb8d417e..88c0b9ffb 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
- *  04/2002 Fixes by wjhuie
- */
-/*
- * DESCRIPTION
+ * Copyright (c) International Business Machines Corp., 2001
+ * Copyright (c) 2020 Petr Vorel <petr.vorel@gmail.com>
+ * 07/2001 Ported by Wayne Boyer
+ * 04/2002 Fixes by wjhuie
+ *
  *	Testcase to check the errnos set by the ioctl(2) system call.
  *
  * ALGORITHM
@@ -14,13 +13,13 @@
  *	3. EINVAL: Pass invalid cmd in ioctl(fd, cmd, arg)
  *	4. ENOTTY: Pass an non-streams fd in ioctl(fd, cmd, arg)
  *	5. EFAULT: Pass a NULL address for termio
- *
  */
 
+#include "config.h"
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
-#include <termio.h>
+#include <sys/ioctl.h>
 #include <termios.h>
 #include "tst_test.h"
 
@@ -29,6 +28,7 @@
 static int fd, fd_file;
 static int bfd = -1;
 
+#ifdef HAVE_STRUCT_TERMIO
 static struct termio termio;
 
 static struct tcase {
@@ -113,3 +113,7 @@ static struct tst_test test = {
 		{}
 	}
 };
+
+#else
+	TST_TEST_TCONF("libc doesn't provide legacy struct termio");
+#endif /* HAVE_STRUCT_TERMIO */
-- 
2.24.1

