From: Greg Hackmann <ghackmann@google.com>
Date: Wed,  5 Dec 2018 10:19:13 -0800
Subject: [LTP] [PATCH v2] getrlimit/getrlimit03: add configure-time check
	for struct ulimit64
Message-ID: <20181205181913.214565-1-ghackmann@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The kernel's UAPI headers export a definition of struct ulimit64 which
can conflict with the open-coded one in getrlimit03.  Depending on the
libc implementation, this may only be visible when _LARGEFILE64_SOURCE
is defined.  Fix this by moving getrlimit03's definition behind a
configure-time check.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
v2: define _LARGEFILE64_SOURCE, since it's needed to use the rlimit64
    definition included in glibc and uclibc-ng

 configure.ac                                      |  1 +
 m4/ltp-rlimit64.m4                                | 10 ++++++++++
 testcases/kernel/syscalls/getrlimit/Makefile      |  2 ++
 testcases/kernel/syscalls/getrlimit/getrlimit03.c |  2 ++
 4 files changed, 15 insertions(+)
 create mode 100644 m4/ltp-rlimit64.m4

diff --git a/configure.ac b/configure.ac
index e81d2add5..caea34462 100644
--- a/configure.ac
+++ b/configure.ac
@@ -228,6 +228,7 @@ LTP_CHECK_UNAME_DOMAINNAME
 LTP_CHECK_X_TABLES
 LTP_CHECK_ATOMIC_MEMORY_MODEL
 LTP_CHECK_TPACKET_V3
+LTP_CHECK_RLIMIT64
 LTP_DETECT_HOST_CPU
 LTP_CHECK_PERF_EVENT
 
diff --git a/m4/ltp-rlimit64.m4 b/m4/ltp-rlimit64.m4
new file mode 100644
index 000000000..93289fae6
--- /dev/null
+++ b/m4/ltp-rlimit64.m4
@@ -0,0 +1,10 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2018 Google, Inc.
+
+AC_DEFUN([LTP_CHECK_RLIMIT64],[
+AC_CHECK_TYPES([struct rlimit64],,,[
+#define _LARGEFILE64_SOURCE
+#include <sys/resource.h>
+])
+])
+
diff --git a/testcases/kernel/syscalls/getrlimit/Makefile b/testcases/kernel/syscalls/getrlimit/Makefile
index bd617d806..58c5a5478 100644
--- a/testcases/kernel/syscalls/getrlimit/Makefile
+++ b/testcases/kernel/syscalls/getrlimit/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+getrlimit03: CFLAGS += -D_LARGEFILE64_SOURCE
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
index 9ff28acb6..376ef7241 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -44,10 +44,12 @@
 #define __NR_getrlimit_ulong_str	"__NR_getrlimit"
 #endif
 
+#ifndef HAVE_STRUCT_RLIMIT64
 struct rlimit64 {
 	uint64_t rlim_cur;
 	uint64_t rlim_max;
 };
+#endif
 const uint64_t RLIM_INFINITY_U64 = UINT64_MAX;
 
 static int getrlimit_u64(int resource, struct rlimit64 *rlim)
-- 
2.20.0.rc1.387.gf8505762e3-goog

