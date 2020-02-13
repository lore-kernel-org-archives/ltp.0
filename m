From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 12 Feb 2020 22:25:24 -0800
Subject: [LTP] [PATCH] syscalls: Check for time64 unsafe syscalls before
 using them
Message-ID: <20200213062524.2027846-1-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

musl is using 64bit time_t now on 32bit architectures and these syscalls
no longer exist, therefore its better to check for them being available
before using them

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/tst_clocks.c                                        | 9 +++++++++
 testcases/kernel/syscalls/gettimeofday/gettimeofday01.c | 4 ++++
 testcases/kernel/syscalls/gettimeofday/gettimeofday02.c | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 35798a4aaf..6a5b05c4ea 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -28,15 +28,24 @@
 
 int tst_clock_getres(clockid_t clk_id, struct timespec *res)
 {
+#if defined(__NR_clock_getres)
 	return syscall(SYS_clock_getres, clk_id, res);
+#endif
+	return -1;
 }
 
 int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
 {
+#if defined(__NR_clock_gettime)
 	return syscall(SYS_clock_gettime, clk_id, ts);
+#endif
+	return -1;
 }
 
 int tst_clock_settime(clockid_t clk_id, struct timespec *ts)
 {
+#if defined(__NR_clock_settime)
 	return syscall(SYS_clock_settime, clk_id, ts);
+#endif
+	return -1;
 }
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
index 583d8f7b9b..b498de5b68 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
@@ -41,7 +41,11 @@
 #include <sys/syscall.h>
 #include <unistd.h>
 
+#ifdef __NR_gettimeofday
 #define gettimeofday(a,b)  syscall(__NR_gettimeofday,a,b)
+#else
+#define gettimeofday(a,b) (-1)
+#endif
 
 char *TCID = "gettimeofday01";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index 1d60f448e8..218e017df8 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -23,7 +23,11 @@
 
 #include "tst_test.h"
 
+#ifdef __NR_gettimeofday
 #define gettimeofday(a,b)  syscall(__NR_gettimeofday,a,b)
+#else
+#define gettimeofday(a,b) (-1)
+#endif
 
 static volatile sig_atomic_t done;
 static char *str_rtime;
-- 
2.25.0

