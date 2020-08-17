From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 17 Aug 2020 18:05:02 +0200
Subject: [LTP] [PATCH 1/2] Add SAFE_TIMER_*() functions to tst_safe_clocks.h
Message-ID: <20200817160503.11381-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_clocks.h | 90 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index 4cb5f41ed..5909f4083 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -55,6 +55,83 @@ static inline void safe_clock_settime(const char *file, const int lineno,
 	}
 }
 
+static inline int safe_timer_create(const char *file, const int lineno,
+	clockid_t clockid, struct sigevent *sevp, timer_t *timerid)
+{
+	int ret;
+
+	errno = 0;
+	ret = timer_create(clockid, sevp, timerid);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"timer_create(%s) failed", tst_clock_name(clockid));
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid timer_create(%s) return value %d",
+			tst_clock_name(clockid), ret);
+	}
+
+	return ret;
+}
+
+static inline int safe_timer_settime(const char *file, const int lineno,
+	timer_t timerid, int flags, const struct itimerspec *new_value,
+	struct itimerspec *old_value)
+{
+	int ret;
+
+	errno = 0;
+	ret = timer_settime(timerid, flags, new_value, old_value);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"timer_settime() failed");
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid timer_settime() return value %d", ret);
+	}
+
+	return ret;
+}
+
+static inline int safe_timer_gettime(const char *file, const int lineno,
+	timer_t timerid, struct itimerspec *curr_value)
+{
+	int ret;
+
+	errno = 0;
+	ret = timer_gettime(timerid, curr_value);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"timer_gettime() failed");
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid timer_gettime() return value %d", ret);
+	}
+
+	return ret;
+}
+
+static inline int safe_timer_delete(const char *file, const int lineno,
+	timer_t timerid)
+{
+	int ret;
+
+	errno = 0;
+	ret = timer_delete(timerid);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO, "timer_delete() failed");
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid timer_delete() return value %d", ret);
+	}
+
+	return ret;
+}
+
 #define SAFE_CLOCK_GETRES(clk_id, res)\
 	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
 
@@ -64,4 +141,17 @@ static inline void safe_clock_settime(const char *file, const int lineno,
 #define SAFE_CLOCK_SETTIME(clk_id, tp)\
 	safe_clock_settime(__FILE__, __LINE__, (clk_id), (tp))
 
+#define SAFE_TIMER_CREATE(clockid, sevp, timerid)\
+	safe_timer_create(__FILE__, __LINE__, (clockid), (sevp), (timerid))
+
+#define SAFE_TIMER_SETTIME(timerid, flags, new_value, old_value)\
+	safe_timer_settime(__FILE__, __LINE__, (timerid), (flags),\
+		(new_value), (old_value))
+
+#define SAFE_TIMER_GETTIME(timerid, curr_value)\
+	safe_timer_gettime(__FILE__, __LINE__, (timerid), (curr_value))
+
+#define SAFE_TIMER_DELETE(timerid)\
+	safe_timer_delete(__FILE__, __LINE__, timerid)
+
 #endif /* SAFE_CLOCKS_H__ */
-- 
2.27.0

