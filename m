From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 29 Jan 2019 15:36:57 -0200
Subject: [LTP] [PATCH v4 6/8] tst_timer: Turn clock_name() function public
In-Reply-To: <20190129173659.27901-1-rafael.tinoco@linaro.org>
References: <20190124161159.GC16804@rei.lan>
 <20190129173659.27901-1-rafael.tinoco@linaro.org>
Message-ID: <20190129173659.27901-6-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit exposes clock_name() function by removing its static
definition and creating a public function prototype. This function is
needed by clock/alarm tests and their error messages.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_timer.h | 5 +++++
 lib/tst_timer.c     | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 043b71460..c66f630c4 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -332,4 +332,9 @@ static inline long long tst_timer_elapsed_us(void)
 	return tst_timespec_to_us(tst_timer_elapsed());
 }
 
+/*
+ * Returns a string containing given clock type name
+ */
+const char *clock_name(clockid_t);
+
 #endif /* TST_TIMER */
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index dffaba0cb..e83da7ff6 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -15,7 +15,7 @@
 static struct timespec start_time, stop_time;
 static clockid_t clock_id;
 
-static const char *clock_name(clockid_t clk_id)
+const char *clock_name(clockid_t clk_id)
 {
 	switch (clk_id) {
 	case CLOCK_REALTIME:
-- 
2.20.1

