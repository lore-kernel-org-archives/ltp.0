From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 22 Jul 2019 17:52:46 +0800
Subject: [LTP] [PATCH v2 1/2] m4: remove some useless m4
In-Reply-To: <1b8b7f73-fd31-58d2-5162-3648fa9729a5@163.com>
References: <1b8b7f73-fd31-58d2-5162-3648fa9729a5@163.com>
Message-ID: <1563789167-2328-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit fe9d9218c, we have detected linux/securebits.h in
confiure.ac. one place used the HAVE_SECUREBITS defined), it only
controls compile. kernel/security/securebits/check_keepcaps.c has
HAVE_LINUX_SECUREBITS_H check in internal, so removing it is safe.

No testcase used these macros defined in ltp/time.m4, and these
(CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE)
have been defined in lapi/posix_clocks.h. Removing it is safe.

FS_IOC_GETFLAGS and FS_IOC_SETFLAGS have been defined in lapi/fs.h.
setxattr03.c checked this ioctl return value, so removing it is safe.

Since commit ef772539, LTP_CHECK_CGROUPSTATS has been removed. But
testcase still used it. It looks like a mistakenly deletion. Removing
ltp-cgroupstats.m4, check linux/cgroupstats.h in configure.ac.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac                                  |  6 ++--
 include/mk/features.mk.default                |  3 --
 include/mk/features.mk.in                     |  3 --
 m4/ltp-cgroupstats.m4                         |  8 -----
 m4/ltp-fs_ioc_flags.m4                        | 11 -------
 m4/ltp-securebits.m4                          | 10 ------
 m4/ltp-time.m4                                | 12 -------
 testcases/kernel/security/Makefile            |  4 ---
 .../kernel/syscalls/setxattr/setxattr03.c     | 33 +++----------------
 9 files changed, 7 insertions(+), 83 deletions(-)
 delete mode 100644 m4/ltp-cgroupstats.m4
 delete mode 100644 m4/ltp-fs_ioc_flags.m4
 delete mode 100644 m4/ltp-securebits.m4
 delete mode 100644 m4/ltp-time.m4

diff --git a/configure.ac b/configure.ac
index 3dcf282e8..699d7907d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -36,8 +36,9 @@ AC_CHECK_HEADERS([ \
     ifaddrs.h \
     keyutils.h \
     linux/can.h \
-    linux/dccp.h \
+    linux/cgroupstats.h \
     linux/cryptouser.h \
+    linux/dccp.h \
     linux/genetlink.h \
     linux/keyctl.h \
     linux/if_alg.h \
@@ -209,7 +210,6 @@ LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_CRYPTO
 LTP_CHECK_FIDEDUPE
 LTP_CHECK_FORTIFY_SOURCE
-LTP_CHECK_FS_IOC_FLAGS
 LTP_CHECK_FTS_H
 LTP_CHECK_IF_LINK
 LTP_CHECK_IOVEC
@@ -226,7 +226,6 @@ LTP_CHECK_NOMMU_LINUX
 LTP_CHECK_PERF_EVENT
 LTP_CHECK_PRCTL_SUPPORT
 LTP_CHECK_RLIMIT64
-LTP_CHECK_SECUREBITS
 LTP_CHECK_SELINUX
 LTP_CHECK_SIGNAL
 LTP_CHECK_STATX
@@ -249,7 +248,6 @@ LTP_CHECK_SYSCALL_QUOTACTL
 LTP_CHECK_SYSCALL_SIGNALFD
 LTP_CHECK_SYSCALL_UTIMENSAT
 LTP_CHECK_TASKSTATS
-LTP_CHECK_TIME
 LTP_CHECK_TIMERFD
 test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
 LTP_CHECK_TPACKET_V3
diff --git a/include/mk/features.mk.default b/include/mk/features.mk.default
index 94b8b0c54..3a6cc5176 100644
--- a/include/mk/features.mk.default
+++ b/include/mk/features.mk.default
@@ -29,9 +29,6 @@ WITH_PYTHON			:= no
 
 # Features knobs
 
-# Is securebits[.h], et all support available?
-HAVE_SECUREBITS			:= no
-
 # Test suite knobs
 
 # Enable testcases/kernel/power_management's compile and install?
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index 7536b6f20..8e561b738 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -29,9 +29,6 @@ WITH_PYTHON			:= @WITH_PYTHON@
 
 # Features knobs
 
-# Is securebits[.h], et all support available?
-HAVE_SECUREBITS			:= @HAVE_SECUREBITS@
-
 # Test suite knobs
 
 # Enable testcases/kernel/power_management's compile and install?
diff --git a/m4/ltp-cgroupstats.m4 b/m4/ltp-cgroupstats.m4
deleted file mode 100644
index 527f719ac..000000000
--- a/m4/ltp-cgroupstats.m4
+++ /dev/null
@@ -1,8 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Linux Test Project, 2009
-
-AC_DEFUN([LTP_CHECK_CGROUPSTATS],
-[
-AC_CHECK_HEADERS(linux/cgroupstats.h,[LTP_CHECK_CGROUPSTATS_HEADER=yes])
-AC_SUBST(LTP_CHECK_CGROUPSTATS_HEADER)
-])
diff --git a/m4/ltp-fs_ioc_flags.m4 b/m4/ltp-fs_ioc_flags.m4
deleted file mode 100644
index 79fffd27b..000000000
--- a/m4/ltp-fs_ioc_flags.m4
+++ /dev/null
@@ -1,11 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Linux Test Project, 2012
-dnl Author: Cyril Hrubis <chrubis@suse.cz>
-
-AC_DEFUN([LTP_CHECK_FS_IOC_FLAGS],[
-AH_TEMPLATE(HAVE_FS_IOC_FLAGS,
-[Define to 1 if you have FS_IOC_GETFLAGS and FS_IOC_SETFLAGS in <linux/fs.h>.])
-AC_MSG_CHECKING([for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS in <linux/fs.h>])
-AC_TRY_COMPILE([#include <linux/fs.h>], [int flags = FS_IOC_GETFLAGS;],
-               AC_DEFINE(HAVE_FS_IOC_FLAGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
-])
diff --git a/m4/ltp-securebits.m4 b/m4/ltp-securebits.m4
deleted file mode 100644
index 7888e6335..000000000
--- a/m4/ltp-securebits.m4
+++ /dev/null
@@ -1,10 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Serge Hallyn (2010)
-
-AC_DEFUN([LTP_CHECK_SECUREBITS],[
-	AC_CHECK_HEADERS(linux/securebits.h,[have_securebits=yes])
-if test "x$have_securebits" != xyes; then
-	have_securebits=no
-fi
-AC_SUBST(HAVE_SECUREBITS,$have_securebits)
-])
diff --git a/m4/ltp-time.m4 b/m4/ltp-time.m4
deleted file mode 100644
index 205ba6d5a..000000000
--- a/m4/ltp-time.m4
+++ /dev/null
@@ -1,12 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Author: Ngie Cooper <yaneurabeya@gmail.com>
-
-dnl For all directly related time syscalls
-AC_DEFUN([LTP_CHECK_TIME],[
-	AC_CHECK_DECLS([CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE],,,[
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <time.h>
-])
-])
diff --git a/testcases/kernel/security/Makefile b/testcases/kernel/security/Makefile
index 0b4b98b83..eea794aa9 100644
--- a/testcases/kernel/security/Makefile
+++ b/testcases/kernel/security/Makefile
@@ -24,10 +24,6 @@ top_srcdir		?= ../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-ifneq ($(HAVE_SECUREBITS),yes)
-FILTER_OUT_DIRS		+= securebits
-endif
-
 OPT_CFLAGS		+= -O
 DEBUG_LDFLAGS		+= -s
 
diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index a2f6cbf36..53fca2073 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -1,30 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Red Hat, Inc.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-/*
  * setxattr(2) to immutable and append-only files should get EPERM
- *
  * There are 2 test cases:
  * 1. Set attribute to a immutable file, setxattr(2) should return -1
  *    and set errno to EPERM
@@ -47,14 +25,14 @@
 #ifdef HAVE_SYS_XATTR_H
 # include <sys/xattr.h>
 #endif
-#include <linux/fs.h>
+#include "lapi/fs.h"
 
 #include "test.h"
 #include "safe_macros.h"
 
 char *TCID = "setxattr03";
 
-#if defined HAVE_SYS_XATTR_H && defined HAVE_FS_IOC_FLAGS
+#if defined HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
@@ -206,7 +184,6 @@ static void cleanup(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "<sys/xattr.h> not present or FS_IOC_FLAGS "
-		 "missing in <linux/fs.h>");
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> not present");
 }
-#endif /* defined HAVE_SYS_XATTR_H && defined HAVE_FS_IOC_FLAGS */
+#endif /* defined HAVE_SYS_XATTR_H */
-- 
2.18.1



