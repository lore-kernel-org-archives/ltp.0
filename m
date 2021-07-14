From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 14 Jul 2021 08:11:57 +0100
Subject: [LTP] [PATCH v2 7/8] API: Move libtsc.h from realtime tests include
 to tst_tsc.h
In-Reply-To: <20210714071158.15868-1-rpalethorpe@suse.com>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
Message-ID: <20210714071158.15868-8-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allow the meltdown test to use this file without modifying the
CFLAGS. This avoids having to add the include also to the CHECK_FLAGS.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/realtime/include/libtsc.h => include/tst_tsc.h  | 0
 testcases/cve/Makefile                                    | 2 --
 testcases/cve/meltdown.c                                  | 2 +-
 testcases/realtime/func/async_handler/async_handler_tsc.c | 3 ++-
 testcases/realtime/func/measurement/preempt_timing.c      | 3 ++-
 testcases/realtime/func/measurement/rdtsc-latency.c       | 3 ++-
 6 files changed, 7 insertions(+), 6 deletions(-)
 rename testcases/realtime/include/libtsc.h => include/tst_tsc.h (100%)

diff --git a/testcases/realtime/include/libtsc.h b/include/tst_tsc.h
similarity index 100%
rename from testcases/realtime/include/libtsc.h
rename to include/tst_tsc.h
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index ddf8b6fe1..c5308794d 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -18,8 +18,6 @@ ifneq ($(ANDROID),1)
 cve-2014-0196:  LDLIBS += -lutil
 endif
 
-meltdown: CFLAGS += -I$(abs_srcdir)/../realtime/include
-
 ifneq (,$(filter $(HOST_CPU),x86 x86_64))
 meltdown: CFLAGS += -msse2
 endif
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index a387b3205..5a984aba3 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -19,7 +19,7 @@
 
 #include <emmintrin.h>
 
-#include "libtsc.h"
+#include "tst_tsc.h"
 
 #define TARGET_OFFSET	9
 #define TARGET_SIZE	(1 << TARGET_OFFSET)
diff --git a/testcases/realtime/func/async_handler/async_handler_tsc.c b/testcases/realtime/func/async_handler/async_handler_tsc.c
index 7da4324a5..73d4ee5c6 100644
--- a/testcases/realtime/func/async_handler/async_handler_tsc.c
+++ b/testcases/realtime/func/async_handler/async_handler_tsc.c
@@ -46,7 +46,8 @@
 #include <pthread.h>
 #include <librttest.h>
 #include <libstats.h>
-#include <libtsc.h>
+
+#include "tst_tsc.h"
 
 #define HANDLER_PRIO 98
 #define SIGNAL_PRIO 99
diff --git a/testcases/realtime/func/measurement/preempt_timing.c b/testcases/realtime/func/measurement/preempt_timing.c
index 8b5333480..b84d54692 100644
--- a/testcases/realtime/func/measurement/preempt_timing.c
+++ b/testcases/realtime/func/measurement/preempt_timing.c
@@ -52,7 +52,8 @@
 #include <sys/mman.h>
 #include <stdint.h>
 #include <librttest.h>
-#include <libtsc.h>
+
+#include "tst_tsc.h"
 
 #define ITERATIONS 1000000ULL
 #define INTERVALS 10
diff --git a/testcases/realtime/func/measurement/rdtsc-latency.c b/testcases/realtime/func/measurement/rdtsc-latency.c
index d6ab89ff0..3829947bc 100644
--- a/testcases/realtime/func/measurement/rdtsc-latency.c
+++ b/testcases/realtime/func/measurement/rdtsc-latency.c
@@ -44,7 +44,8 @@
 #include <errno.h>
 #include <stdint.h>
 #include <librttest.h>
-#include <libtsc.h>
+
+#include "tst_tsc.h"
 
 #define ITERATIONS 1000000
 
-- 
2.31.1

