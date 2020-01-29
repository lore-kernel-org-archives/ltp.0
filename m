From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Jan 2020 14:27:59 +0100
Subject: [LTP] [PATCH v2 1/1] ioctl,
 pty Add: fallback definition of struct termio
Message-ID: <20200129132759.5265-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

into ioctl0{1,2}.c, ptem01.c, pty01.c.

replace <termio.h> with <termios.h> and <sys/ioctl.h>

MUSL is not including <sys/ttydefaults.h> in <sys/ioctl.h>,
thus loaded in lapi/ioctl.h.

This fixes musl build, thus update travis.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
v1->v2:
* add a fallback defition of the structure into
lapi/termio.h instead of disabling the test
(suggested by Cyril, I've just added it into lapi/ioctl.h instead of
creating lapi/termio.h, as the struct is loadable via <sys/ioctl.h>)
* fix more tests: ioctl02.c ptem01.c, pty01.c
* add <sys/ttydefaults.h> fix for MUSL
* update Travis

CI: https://travis-ci.org/pevik/ltp/builds/643367472

Kind regards,
Petr

 configure.ac                              |  1 +
 include/lapi/ioctl.h                      | 25 +++++++++++++++++++++++
 m4/ltp-termio.m4                          |  6 ++++++
 testcases/kernel/pty/ptem01.c             |  6 +++---
 testcases/kernel/pty/pty01.c              |  4 ++--
 testcases/kernel/syscalls/ioctl/ioctl01.c | 15 +++++++-------
 testcases/kernel/syscalls/ioctl/ioctl02.c |  7 +++----
 travis/alpine.sh                          |  4 ----
 8 files changed, 47 insertions(+), 21 deletions(-)
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
diff --git a/include/lapi/ioctl.h b/include/lapi/ioctl.h
index a6ef811cd..ecd250290 100644
--- a/include/lapi/ioctl.h
+++ b/include/lapi/ioctl.h
@@ -1,15 +1,40 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
  */
 
 #ifndef IOCTL_H__
 #define IOCTL_H__
 
+#include "config.h"
 #include <sys/ioctl.h>
 
+/* musl not including it in <sys/ioctl.h> */
+#include <sys/ttydefaults.h>
+
 #ifndef TIOCVHANGUP
 # define TIOCVHANGUP 0x5437
 #endif
 
+#ifndef HAVE_STRUCT_TERMIO
+# ifndef NCC
+#  ifdef __powerpc__
+#   define NCC 10
+#  else
+#   define NCC 8
+#  endif
+# endif /* NCC */
+
+struct termio
+  {
+    unsigned short int c_iflag;		/* input mode flags */
+    unsigned short int c_oflag;		/* output mode flags */
+    unsigned short int c_cflag;		/* control mode flags */
+    unsigned short int c_lflag;		/* local mode flags */
+    unsigned char c_line;		/* line discipline */
+    unsigned char c_cc[NCC];		/* control characters */
+};
+#endif /* HAVE_STRUCT_TERMIO */
+
 #endif /* IOCTL_H__ */
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
diff --git a/testcases/kernel/pty/ptem01.c b/testcases/kernel/pty/ptem01.c
index ad9ac0e2b..9398b4389 100644
--- a/testcases/kernel/pty/ptem01.c
+++ b/testcases/kernel/pty/ptem01.c
@@ -1,6 +1,6 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -25,15 +25,15 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <termio.h>
+#include <termios.h>
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/poll.h>
 #include <sys/types.h>
 
-/** LTP Port **/
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/ioctl.h"
 
 char *TCID = "ptem01";		/* Test program identifier.    */
 int TST_TOTAL = 6;		/* Total number of test cases. */
diff --git a/testcases/kernel/pty/pty01.c b/testcases/kernel/pty/pty01.c
index 87fc6626a..fd4aa9f37 100644
--- a/testcases/kernel/pty/pty01.c
+++ b/testcases/kernel/pty/pty01.c
@@ -29,12 +29,12 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <termio.h>
+#include <termios.h>
 #include <unistd.h>
 
-/** LTP Port **/
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/ioctl.h"
 
 char *TCID = "pty01";		/* Test program identifier.    */
 int TST_TOTAL = 5;		/* Total number of test cases. */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 7fb8d417e..580083882 100644
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
@@ -14,15 +13,15 @@
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
 #include <termios.h>
 #include "tst_test.h"
+#include "lapi/ioctl.h"
 
 #define	INVAL_IOCTL	9999999
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index a4b468e43..b4d4a3594 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -1,6 +1,6 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -57,17 +57,16 @@
  */
 
 #include <stdio.h>
-#include <termio.h>
 #include <fcntl.h>
 #include <signal.h>
 #include <errno.h>
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/ioctl.h>
-#include <sys/termios.h>
+#include <termios.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/ioctl.h"
 
 #define	CNUL	0
 
diff --git a/travis/alpine.sh b/travis/alpine.sh
index 13fd5e1bf..95bceb2b9 100755
--- a/travis/alpine.sh
+++ b/travis/alpine.sh
@@ -30,8 +30,6 @@ cat /etc/os-release
 echo "WARNING: remove unsupported tests (until they're fixed)"
 cd ..
 rm -rfv \
-	testcases/kernel/pty/pty01.c \
-	testcases/kernel/pty/ptem01.c \
 	testcases/kernel/sched/process_stress/process.c \
 	testcases/kernel/syscalls/accept4/accept4_01.c \
 	testcases/kernel/syscalls/confstr/confstr01.c \
@@ -39,8 +37,6 @@ rm -rfv \
 	testcases/kernel/syscalls/getcontext/getcontext01.c \
 	testcases/kernel/syscalls/getdents/getdents01.c \
 	testcases/kernel/syscalls/getdents/getdents02.c \
-	testcases/kernel/syscalls/ioctl/ioctl01.c \
-	testcases/kernel/syscalls/ioctl/ioctl02.c \
 	testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c \
 	testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c \
 	testcases/kernel/syscalls/timer_create/timer_create01.c \
-- 
2.24.1

