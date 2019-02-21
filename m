From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 21 Feb 2019 17:05:46 -0300
Subject: [LTP] [PATCH 1/2] lib: include SAFE_CLOCK_ADJTIME() macro
Message-ID: <20190221200547.7277-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adds SAFE_CLOCK_ADJTIME() macro to tst_safe_clocks.h.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_safe_clocks.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index 553f8464a..304207f6b 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -6,6 +6,8 @@
 
 #include <time.h>
 #include "tst_test.h"
+#include <sys/timex.h>
+#include "lapi/syscalls.h"
 
 static inline void safe_clock_getres(const char *file, const int lineno,
 	clockid_t clk_id, struct timespec *res)
@@ -42,6 +44,17 @@ static inline void safe_clock_settime(const char *file, const int lineno,
 			"%s:%d clock_gettime() failed", file, lineno);
 }
 
+static inline void safe_clock_adjtime(const char *file, const int lineno,
+	clockid_t clk_id, struct timex *txc)
+{
+	int rval;
+
+	rval = tst_syscall(__NR_clock_adjtime, clk_id, txc);
+
+	if (rval != 0)
+		tst_brk(TBROK | TERRNO,
+			"%s:%d clock_adjtime() failed", file, lineno);
+}
 #define SAFE_CLOCK_GETRES(clk_id, res)\
 	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
 
@@ -50,3 +63,6 @@ static inline void safe_clock_settime(const char *file, const int lineno,
 
 #define SAFE_CLOCK_SETTIME(clk_id, tp)\
 	safe_clock_settime(__FILE__, __LINE__, (clk_id), (tp))
+
+#define SAFE_CLOCK_ADJTIME(clk_id, txc)\
+	safe_clock_adjtime(__FILE__, __LINE__, (clk_id), (txc))
-- 
2.20.1

