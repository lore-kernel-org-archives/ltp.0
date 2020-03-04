From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  4 Mar 2020 16:24:01 +0100
Subject: [LTP] [PATCH 02/12] include/tst_safe_clocks.h: Make use of
 tst_clock_name()
In-Reply-To: <20200304152401.7432-1-chrubis@suse.cz>
References: <20200304152401.7432-1-chrubis@suse.cz>
Message-ID: <20200304152401.7432-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_clocks.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index 34ed953b4..27e8bda45 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -11,6 +11,7 @@
 #include <time.h>
 #include <sys/timex.h>
 #include "tst_test.h"
+#include "tst_clocks.h"
 #include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
 
@@ -20,10 +21,11 @@ static inline void safe_clock_getres(const char *file, const int lineno,
 	int rval;
 
 	rval = clock_getres(clk_id, res);
-	if (rval != 0)
+	if (rval != 0) {
 		tst_brk(TBROK | TERRNO,
-			"%s:%d clock_getres() failed", file, lineno);
-
+			"%s:%d clock_getres(%s) failed",
+			file, lineno, tst_clock_name(clk_id));
+	}
 }
 
 static inline void safe_clock_gettime(const char *file, const int lineno,
@@ -32,9 +34,11 @@ static inline void safe_clock_gettime(const char *file, const int lineno,
 	int rval;
 
 	rval = clock_gettime(clk_id, tp);
-	if (rval != 0)
+	if (rval != 0) {
 		tst_brk(TBROK | TERRNO,
-			"%s:%d clock_gettime() failed", file, lineno);
+			"%s:%d clock_gettime(%s) failed",
+			file, lineno, tst_clock_name(clk_id));
+	}
 }
 
 
@@ -44,9 +48,11 @@ static inline void safe_clock_settime(const char *file, const int lineno,
 	int rval;
 
 	rval = clock_settime(clk_id, tp);
-	if (rval != 0)
+	if (rval != 0) {
 		tst_brk(TBROK | TERRNO,
-			"%s:%d clock_gettime() failed", file, lineno);
+			"%s:%d clock_gettime(%s) failed",
+			file, lineno, tst_clock_name(clk_id));
+	}
 }
 
 static inline int safe_clock_adjtime(const char *file, const int lineno,
@@ -55,9 +61,11 @@ static inline int safe_clock_adjtime(const char *file, const int lineno,
 	int rval;
 
 	rval = tst_syscall(__NR_clock_adjtime, clk_id, txc);
-	if (rval < 0)
+	if (rval < 0) {
 		tst_brk(TBROK | TERRNO,
-			"%s:%d clock_adjtime() failed %i", file, lineno, rval);
+			"%s:%d clock_adjtime(%s) failed %i",
+			file, lineno, tst_clock_name(clk_id), rval);
+	}
 
 	return rval;
 }
-- 
2.24.1

