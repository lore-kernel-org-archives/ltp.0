From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Fri, 22 Mar 2019 15:25:25 -0300
Subject: [LTP] [PATCH v4 3/4] lapi/posix_clocks.h: add MAX_CLOCKS definition
In-Reply-To: <20190322182526.10353-1-rafael.tinoco@linaro.org>
References: <20190322133425.GB20408@rei.lan>
 <20190322182526.10353-1-rafael.tinoco@linaro.org>
Message-ID: <20190322182526.10353-3-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Used by clock_XXXtime() tests, defining MAX_CLOCKS in common header.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/lapi/posix_clocks.h                               | 2 ++
 testcases/kernel/syscalls/clock_gettime/clock_gettime02.c | 2 --
 testcases/kernel/syscalls/clock_settime/clock_settime02.c | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/lapi/posix_clocks.h b/include/lapi/posix_clocks.h
index 0d1f0e99c..4914479ac 100644
--- a/include/lapi/posix_clocks.h
+++ b/include/lapi/posix_clocks.h
@@ -9,6 +9,8 @@
 #ifndef POSIX_CLOCKS_H__
 #define POSIX_CLOCKS_H__
 
+#define MAX_CLOCKS 16
+
 #ifndef CLOCK_MONOTONIC_RAW
 # define CLOCK_MONOTONIC_RAW 4
 #endif
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
index 2a29a71e6..b4bc6e2d5 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -24,8 +24,6 @@
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
-#define MAX_CLOCKS 16
-
 struct test_case {
 	clockid_t clktype;
 	int exp_err;
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
index 8db417b6b..e16e9061a 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime02.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
@@ -16,7 +16,6 @@
 
 #define DELTA_SEC 10
 #define NSEC_PER_SEC (1000000000L)
-#define MAX_CLOCKS 16
 
 struct test_case {
 	clockid_t type;
-- 
2.20.1

