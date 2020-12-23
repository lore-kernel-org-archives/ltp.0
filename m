From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Wed, 23 Dec 2020 11:35:16 +0800
Subject: [LTP] [PATCH 2/3] lib: implement rtctime_save and rtctime_restore
 function
In-Reply-To: <20201223033517.1464263-1-gengcixi@gmail.com>
References: <20201223033517.1464263-1-gengcixi@gmail.com>
Message-ID: <20201223033517.1464263-3-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

* Reading the RTC in the setup as well as timestamping with monotonic
  timer
* Getting a second monotonic timestamp in the cleanup
* Setting the RTC to the value taken in setup plus the difference in
  the monotonic timer timestamps

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 include/tst_wallclock.h |  4 ++++
 lib/tst_wallclock.c     | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/tst_wallclock.h b/include/tst_wallclock.h
index 7d6723a7a..5103c8321 100644
--- a/include/tst_wallclock.h
+++ b/include/tst_wallclock.h
@@ -12,4 +12,8 @@ void tst_wallclock_save(void);
 
 void tst_wallclock_restore(void);
 
+void tst_rtctime_save(void);
+
+void tst_rtctime_restore(void);
+
 #endif	/* TST_WALLCLK_H__ */
diff --git a/lib/tst_wallclock.c b/lib/tst_wallclock.c
index 282d6ada3..5be1f46d8 100644
--- a/lib/tst_wallclock.c
+++ b/lib/tst_wallclock.c
@@ -11,11 +11,14 @@
 #include "tst_test.h"
 #include "tst_timer.h"
 #include "tst_clocks.h"
+#include "tst_rtctime.h"
 #include "tst_wallclock.h"
 #include "lapi/posix_clocks.h"
 
 static struct timespec real_begin, mono_begin;
 
+static struct rtc_time rtc_begin;
+
 static int clock_saved;
 
 void tst_wallclock_save(void)
@@ -58,3 +61,42 @@ void tst_wallclock_restore(void)
 	if (tst_clock_settime(CLOCK_REALTIME, &adjust))
 		tst_brk(TBROK | TERRNO, "tst_clock_settime() realtime failed");
 }
+
+void tst_rtctime_save(void)
+{
+	/* save initial monotonic time to restore it when needed */
+	if (tst_rtc_gettime(&rtc_begin))
+		tst_brk(TBROK | TERRNO, "tst_rtc_gettime() realtime failed");
+
+	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_begin))
+		tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
+
+	clock_saved = 1;
+}
+
+void tst_rtctime_restore(void)
+{
+	static struct timespec mono_end, elapsed;
+	static struct timespec rtc_begin_tm, rtc_adjust;
+	static struct rtc_time rtc_restore;
+
+	if (!clock_saved)
+		return;
+
+	clock_saved = 0;
+
+	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_end))
+		tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
+
+	elapsed = tst_timespec_diff(mono_end, mono_begin);
+
+	rtc_begin_tm.tv_sec = tst_rtc_tm_to_time(&rtc_begin);
+
+	rtc_adjust = tst_timespec_add(rtc_begin_tm, elapsed);
+
+	tst_rtc_time_to_tm(rtc_adjust.tv_sec, &rtc_restore);
+
+	/* restore realtime clock based on monotonic delta */
+	if (tst_rtc_settime(&rtc_restore))
+		tst_brk(TBROK | TERRNO, "tst_rtc_settime() realtime failed");
+}
-- 
2.25.1

