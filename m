From: Greg Hackmann <ghackmann@google.com>
Date: Mon,  3 Dec 2018 11:01:47 -0800
Subject: [LTP] [PATCH 1/2] getrlimit/getrlimit03: add configure-time check
 for struct ulimit64
Message-ID: <20181203190148.93108-1-ghackmann@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The kernel's UAPI headers export a definition of struct ulimit64 which
can conflict with the open-coded one in getrlimit03.  Fix this by moving
getrlimit03's definition behind a configure-time check.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 configure.ac                                      |  1 +
 m4/ltp-rlimit64.m4                                | 10 ++++++++++
 testcases/kernel/syscalls/getrlimit/getrlimit03.c |  2 ++
 3 files changed, 13 insertions(+)
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
index 000000000..f2e6c526a
--- /dev/null
+++ b/m4/ltp-rlimit64.m4
@@ -0,0 +1,10 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2018 Google, Inc.
+
+AC_DEFUN([LTP_CHECK_RLIMIT64],[
+AC_CHECK_TYPES([struct rlimit64],,,[
+#include <sys/time.h>
+#include <sys/resource.h>
+])
+])
+
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

