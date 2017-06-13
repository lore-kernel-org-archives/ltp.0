From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jun 2017 18:00:33 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/2] tst_timer.h: Add timeval helpers
Message-ID: <20170613160034.10042-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_timer.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index f0a10bd45..f294b0eb7 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -51,6 +51,22 @@ static inline long long tst_timespec_to_ms(struct timespec t)
 }
 
 /*
+ * Converts timeval to microseconds.
+ */
+static inline long long tst_timeval_to_us(struct timeval t)
+{
+	return t.tv_sec * 1000000 + t.tv_usec;
+}
+
+/*
+ * Converts timeval to miliseconds.
+ */
+static inline long long tst_timeval_to_ms(struct timeval t)
+{
+	return t.tv_sec * 1000 + (t.tv_usec + 500) / 1000;
+}
+
+/*
  * Converts ms to struct timeval
  */
 static inline struct timeval tst_ms_to_timeval(long long ms)
@@ -137,6 +153,38 @@ static inline long long tst_timespec_diff_ms(struct timespec t1,
 }
 
 /*
+ * Returns difference between two timeval structures.
+ */
+static inline struct timeval tst_timeval_diff(struct timeval t1,
+                                              struct timeval t2)
+{
+	struct timeval res;
+
+	res.tv_sec = t1.tv_sec - t2.tv_sec;
+
+	if (t1.tv_usec < t2.tv_usec) {
+		res.tv_sec--;
+		res.tv_usec = 1000000 - (t2.tv_usec - t1.tv_usec);
+	} else {
+		res.tv_usec = t1.tv_usec - t2.tv_usec;
+	}
+
+	return res;
+}
+
+static inline long long tst_timeval_diff_us(struct timeval t1,
+                                            struct timeval t2)
+{
+	return tst_timeval_to_us(tst_timeval_diff(t1, t2));
+}
+
+static inline long long tst_timeval_diff_ms(struct timeval t1,
+                                            struct timeval t2)
+{
+	return tst_timeval_to_ms(tst_timeval_diff(t1, t2));
+}
+
+/*
  * Returns absolute value of difference between two timespec structures.
  */
 static inline struct timespec tst_timespec_abs_diff(struct timespec t1,
-- 
2.13.0

