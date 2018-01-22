From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Jan 2018 15:19:31 +0100
Subject: [LTP] [RFC] [PATCH] lib/tst_test: Use CLOCK_MONOTONIC for -I option.
Message-ID: <20180122141931.12464-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

CLOCK_MONOTONIC has been added to linux in the 2.5 development branch so
this syscall is available in all 2.6 kernels hence it's reasonable to be
used it in the test library at this point it has been 15 years after
all.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 1df4b72df..2cf35ed66 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -24,7 +24,6 @@
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <sys/time.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
@@ -34,6 +33,8 @@
 #include "tst_ansi_color.h"
 #include "tst_safe_stdio.h"
 #include "tst_timer_test.h"
+#include "tst_clocks.h"
+#include "tst_timer.h"
 
 #include "old_resource.h"
 #include "old_device.h"
@@ -853,11 +854,12 @@ static void run_tests(void)
 
 static unsigned long long get_time_ms(void)
 {
-	struct timeval tv;
+	struct timespec ts;
 
-	gettimeofday(&tv, NULL);
+	if (tst_clock_gettime(CLOCK_MONOTONIC, &ts))
+		tst_brk(TBROK | TERRNO, "tst_clock_gettime()");
 
-	return tv.tv_sec * 1000 + tv.tv_usec / 1000;
+	return tst_timespec_to_ms(ts);
 }
 
 static void add_paths(void)
-- 
2.13.6

