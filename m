From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:49 +0100
Subject: [LTP] [PATCH 12/19] Unify error handling in
 include/tst_safe_clocks.h
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-13-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location
- Pedantically check invalid syscall return values
- Always return success/failure value so that all SAFE_*() functions can be
  called in test cleanup

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_clocks.h | 48 +++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index 5909f4083..5661ce57b 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -15,44 +15,62 @@
 #include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
 
-static inline void safe_clock_getres(const char *file, const int lineno,
+static inline int safe_clock_getres(const char *file, const int lineno,
 	clockid_t clk_id, struct timespec *res)
 {
 	int rval;
 
 	rval = clock_getres(clk_id, res);
-	if (rval != 0) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d clock_getres(%s) failed",
-			file, lineno, tst_clock_name(clk_id));
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"clock_getres(%s) failed", tst_clock_name(clk_id));
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid clock_getres(%s) return value %d",
+			tst_clock_name(clk_id), rval);
 	}
+
+	return rval;
 }
 
-static inline void safe_clock_gettime(const char *file, const int lineno,
+static inline int safe_clock_gettime(const char *file, const int lineno,
 	clockid_t clk_id, struct timespec *tp)
 {
 	int rval;
 
 	rval = clock_gettime(clk_id, tp);
-	if (rval != 0) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d clock_gettime(%s) failed",
-			file, lineno, tst_clock_name(clk_id));
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"clock_gettime(%s) failed", tst_clock_name(clk_id));
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid clock_gettime(%s) return value %d",
+			tst_clock_name(clk_id), rval);
 	}
+
+	return rval;
 }
 
 
-static inline void safe_clock_settime(const char *file, const int lineno,
+static inline int safe_clock_settime(const char *file, const int lineno,
 	clockid_t clk_id, struct timespec *tp)
 {
 	int rval;
 
 	rval = clock_settime(clk_id, tp);
-	if (rval != 0) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d clock_gettime(%s) failed",
-			file, lineno, tst_clock_name(clk_id));
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"clock_gettime(%s) failed", tst_clock_name(clk_id));
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid clock_gettime(%s) return value %d",
+			tst_clock_name(clk_id), rval);
 	}
+
+	return rval;
 }
 
 static inline int safe_timer_create(const char *file, const int lineno,
-- 
2.28.0

