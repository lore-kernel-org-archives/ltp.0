From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 12 Apr 2019 15:03:05 +0800
Subject: [LTP] [PATCH] syscalls/getcpu: Add libc sched_getcpu() detection &&
	fix compiler errors
Message-ID: <1555052585-2293-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)sched_getcpu() isn't defined on some old distros, so we can add dection and
fix compiler error.

2)If CPU_ALLOC isn't defined on some old distros, it will used "include/lapi/cpuset"
CPU_ALLOC macro. But getcpu01.c has converted into new library, so it will report
"cleanup" undefine error. We should ensure CPU_ALLOC can be used both new cases and
old cases.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac                                |  1 +
 include/lapi/cpuset.h                       | 10 +++++++++-
 testcases/kernel/syscalls/getcpu/getcpu01.c |  6 +++---
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index de12499..3ac0f28 100644
--- a/configure.ac
+++ b/configure.ac
@@ -77,6 +77,7 @@ AC_CHECK_FUNCS([ \
     readlinkat \
     renameat \
     renameat2 \
+    sched_getcpu \
     sigpending \
     splice \
     stime \
diff --git a/include/lapi/cpuset.h b/include/lapi/cpuset.h
index b946650..959462b 100644
--- a/include/lapi/cpuset.h
+++ b/include/lapi/cpuset.h
@@ -33,11 +33,19 @@
 #define LTP_CPUSET_H
 
 #ifndef CPU_ALLOC
+#ifndef TST_TEST_H__
 #define CPU_ALLOC(ncpus) malloc(sizeof(cpu_set_t)); \
 if (ncpus > CPU_SETSIZE) { \
 	tst_brkm(TCONF, cleanup, \
-		"Your libc does not support masks with %ld cpus", ncpus); \
+		"Your libc does not support masks with %d cpus", ncpus); \
 }
+#else
+#define CPU_ALLOC(ncpus) malloc(sizeof(cpu_set_t)); \
+if (ncpus > CPU_SETSIZE) { \
+	tst_brk(TCONF, \
+		"Your libc does not support masks with %d cpus", ncpus); \
+}
+#endif
 #endif
 
 #ifndef CPU_FREE
diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index eb6ded8..d033119 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -16,15 +16,15 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include "lapi/syscalls.h"
-#include "lapi/cpuset.h"
 #include "tst_test.h"
+#include "lapi/cpuset.h"
 
 static inline int get_cpu(unsigned *cpu_id,
 			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
 			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
 {
-#if defined(__i386__)
-	return syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
+#ifndef HAVE_SCHED_GETCPU
+	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
 #else
 	*cpu_id = sched_getcpu();
 #endif
-- 
1.7.11.rc0



