From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 1 Nov 2018 14:56:53 +0800
Subject: [LTP] [PATCH] tracing/pt_test.c: Fix compiler errors on old distros
Message-ID: <1541055413-29268-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation fails on old distros which don't have linux/perf_event.h
and LTP_CHECK_PERF_EVENT can check the existence of linux/perf_event.h
as well, so we just include perf_event.h header file when
HAVE_STRUCT_PERF_EVENT_MMAP_PAGE_AUX_HEAD is defined.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/tracing/pt_test/pt_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
index fe5b1e9..5feb1aa 100644
--- a/testcases/kernel/tracing/pt_test/pt_test.c
+++ b/testcases/kernel/tracing/pt_test/pt_test.c
@@ -14,7 +14,6 @@
  * kconfig requirement: CONFIG_PERF_EVENTS
  */
 
-#include <linux/perf_event.h>
 #include <sched.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -24,6 +23,7 @@
 #include "config.h"
 
 #ifdef HAVE_STRUCT_PERF_EVENT_MMAP_PAGE_AUX_HEAD
+# include <linux/perf_event.h>
 
 #define PAGESIZE 4096
 #define INTEL_PT_MEMSIZE (17*PAGESIZE)
-- 
1.8.3.1



