From: Khem Raj <raj.khem@gmail.com>
Date: Sun, 15 Nov 2020 16:33:45 -0800
Subject: [LTP] [PATCH] Define SYS_futex on 32bit arches using 64-bit time_t
Message-ID: <20201116003345.3261577-1-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Newer 32bit arches like RISCV32 and ARC are using 64bit time_t
from get go unlike other 32bit architecture therefore aliasing __NR_futex to
__NR_futex_time64 helps avoid the below errors

tst_checkpoint.c:99:17: error: use of undeclared identifier 'SYS_futex'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/tst_checkpoint.c                        | 4 ++++
 testcases/kernel/syscalls/clone/clone08.c   | 4 ++++
 testcases/kernel/syscalls/futex/futextest.h | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 5e5b11496c..80e82c13f4 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -31,6 +31,10 @@
 #include "safe_macros.h"
 #include "lapi/futex.h"
 
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
 #define DEFAULT_MSEC_TIMEOUT 10000
 
 futex_t *tst_futexes;
diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index 8e115b0421..aaaff94aa0 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -17,6 +17,10 @@
 #include "clone_platform.h"
 #include "lapi/syscalls.h"
 
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
 static pid_t ptid, ctid, tgid;
 static void *child_stack;
 
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index c50876fa67..06e2275d55 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -20,6 +20,10 @@
 #include "lapi/futex.h"
 #include "tst_timer.h"
 
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
 #define FUTEX_INITIALIZER 0
 
 #ifndef FUTEX_CMP_REQUEUE
-- 
2.29.2

