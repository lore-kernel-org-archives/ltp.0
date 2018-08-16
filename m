From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 16 Aug 2018 14:00:18 +0200
Subject: [LTP] [PATCH v3 2/4] tst_timer: Convert to new library
In-Reply-To: <20180816120020.11042-1-rpalethorpe@suse.com>
References: <20180816120020.11042-1-rpalethorpe@suse.com>
Message-ID: <20180816120020.11042-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So we can use functions from new lib.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_timer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index 53ff36777..d5e4c49d2 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -23,7 +23,9 @@
 
 #include <errno.h>
 
-#include "test.h"
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
 #include "tst_timer.h"
 #include "tst_clocks.h"
 #include "lapi/posix_clocks.h"
@@ -59,13 +61,13 @@ void tst_timer_check(clockid_t clk_id)
 {
 	if (tst_clock_gettime(clk_id, &start_time)) {
 		if (errno == EINVAL) {
-			tst_brkm(TCONF, NULL,
+			tst_brk(TCONF,
 			         "Clock id %s(%u) not supported by kernel",
 				 clock_name(clk_id), clk_id);
 			return;
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL, "tst_clock_gettime() failed");
+		tst_brk(TBROK | TERRNO, "tst_clock_gettime() failed");
 	}
 }
 
@@ -74,7 +76,7 @@ void tst_timer_start(clockid_t clk_id)
 	clock_id = clk_id;
 
 	if (tst_clock_gettime(clock_id, &start_time))
-		tst_resm(TWARN | TERRNO, "tst_clock_gettime() failed");
+		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 }
 
 int tst_timer_expired_ms(long long ms)
@@ -82,7 +84,7 @@ int tst_timer_expired_ms(long long ms)
 	struct timespec cur_time;
 
 	if (tst_clock_gettime(clock_id, &cur_time))
-		tst_resm(TWARN | TERRNO, "tst_clock_gettime() failed");
+		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 
 	return tst_timespec_diff_ms(cur_time, start_time) >= ms;
 }
@@ -90,7 +92,7 @@ int tst_timer_expired_ms(long long ms)
 void tst_timer_stop(void)
 {
 	if (tst_clock_gettime(clock_id, &stop_time))
-		tst_resm(TWARN | TERRNO, "tst_clock_gettime() failed");
+		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 }
 
 struct timespec tst_timer_elapsed(void)
-- 
2.18.0

