From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Aug 2018 16:40:05 +0200
Subject: [LTP] [PATCH RFC v3 1/3] lib: add tst_timer_find_clock()
Message-ID: <920f7a911d8b32c3c2e673a9c608ded2526a616d.1535466715.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adds function that returns first available clock usable for measuring
elapsed test time.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_timer.h |  5 +++++
 lib/tst_timer.c     | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 0fd7ed6cfc03..b92d975d8edc 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -245,6 +245,11 @@ static inline long long tst_timespec_abs_diff_ms(struct timespec t1,
 void tst_timer_check(clockid_t clk_id);
 
 /*
+ * Returns usable clock id for measuring elapsed test time.
+ */
+clockid_t tst_timer_find_clock(void);
+
+/*
  * Marks a start time for given clock type.
  *
  * @clk_id: Posix clock to use.
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index dffaba0cbd5c..bbd460364b70 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -39,6 +39,22 @@ static const char *clock_name(clockid_t clk_id)
 	}
 }
 
+clockid_t tst_timer_find_clock(void)
+{
+	unsigned int i;
+	static struct timespec tmp;
+	clockid_t clocks[] = { CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW, CLOCK_MONOTONIC_COARSE,
+		CLOCK_BOOTTIME, CLOCK_REALTIME, CLOCK_REALTIME_COARSE };
+
+	for (i = 0; i < ARRAY_SIZE(clocks); i++) {
+		if (tst_clock_gettime(clocks[i], &tmp) == 0)
+			return clocks[i];
+	}
+
+	tst_brk(TCONF, "Failed to find usable clock");
+	return -1;
+}
+
 void tst_timer_check(clockid_t clk_id)
 {
 	if (tst_clock_gettime(clk_id, &start_time)) {
-- 
1.8.3.1

