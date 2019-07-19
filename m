From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 19 Jul 2019 18:48:54 +0800
Subject: [LTP] [PATCH] m4: remove useless ltp-securebits.m4
Message-ID: <1563533334-2232-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit fe9d9218c, we have detected linux/securebits.h in
confiure.ac. one place used the HAVE_SECUREBITS(ltp-securebits.m4 
defined), it only controls compile. kernel/security/securebits/
check_keepcaps.c has HAVE_LINUX_SECUREBITS_H check in internal, 
so removing it is safe.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac                       |  1 -
 include/mk/features.mk.default     |  3 ---
 include/mk/features.mk.in          |  3 ---
 m4/ltp-securebits.m4               | 10 ----------
 testcases/kernel/security/Makefile |  4 ----
 5 files changed, 21 deletions(-)
 delete mode 100644 m4/ltp-securebits.m4

diff --git a/configure.ac b/configure.ac
index 3dcf282e8..f899d8ebc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -226,7 +226,6 @@ LTP_CHECK_NOMMU_LINUX
 LTP_CHECK_PERF_EVENT
 LTP_CHECK_PRCTL_SUPPORT
 LTP_CHECK_RLIMIT64
-LTP_CHECK_SECUREBITS
 LTP_CHECK_SELINUX
 LTP_CHECK_SIGNAL
 LTP_CHECK_STATX
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
 
-- 
2.18.1



