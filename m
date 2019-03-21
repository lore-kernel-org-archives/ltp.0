From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 21 Mar 2019 23:36:56 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] cpuset: Detect missing fts.h
Message-ID: <20190321223656.9615-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes build on uClibc with disabled fts.h support and MUSL, which
does not have fts.h at all.

Reported-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 configure.ac                          | 1 +
 include/mk/config.mk.in               | 1 +
 m4/ltp-fts.m4                         | 7 +++++++
 testcases/kernel/controllers/Makefile | 4 ++++
 4 files changed, 13 insertions(+)
 create mode 100644 m4/ltp-fts.m4

diff --git a/configure.ac b/configure.ac
index e002c248e..f05db9d2e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -235,6 +235,7 @@ LTP_DETECT_HOST_CPU
 LTP_CHECK_PERF_EVENT
 LTP_CHECK_SYNCFS
 LTP_CHECK_SYNC_FILE_RANGE
+LTP_CHECK_FTS_H
 
 if test "x$with_numa" = xyes; then
 	LTP_CHECK_SYSCALL_NUMA
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 01f178bff..d55fe9602 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -46,6 +46,7 @@ SELINUX_LIBS		:= @SELINUX_LIBS@
 TIRPC_CPPFLAGS		:= @TIRPC_CPPFLAGS@
 TIRPC_LIBS		:= @TIRPC_LIBS@
 KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
+HAVE_FTS_H		:= @HAVE_FTS_H@
 
 prefix			:= @prefix@
 
diff --git a/m4/ltp-fts.m4 b/m4/ltp-fts.m4
new file mode 100644
index 000000000..0da692f23
--- /dev/null
+++ b/m4/ltp-fts.m4
@@ -0,0 +1,7 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
+
+AC_DEFUN([LTP_CHECK_FTS_H],[
+	AC_CHECK_HEADERS(fts.h, [have_fts=1])
+	AC_SUBST(HAVE_FTS_H, $have_fts)
+])
diff --git a/testcases/kernel/controllers/Makefile b/testcases/kernel/controllers/Makefile
index 404073947..548692cb8 100644
--- a/testcases/kernel/controllers/Makefile
+++ b/testcases/kernel/controllers/Makefile
@@ -29,6 +29,10 @@ LIBDIR			:= libcontrollers
 LIB			:= $(LIBDIR)/libcontrollers.a
 FILTER_OUT_DIRS		:= $(LIBDIR)
 
+ifneq ($(HAVE_FTS_H),1)
+	FILTER_OUT_DIRS += cpuset
+endif
+
 $(LIBDIR):
 	mkdir -p "$@"
 
-- 
2.21.0

