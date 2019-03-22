From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Fri, 22 Mar 2019 15:25:23 -0300
Subject: [LTP] [PATCH v4 1/4] lib: include SAFE_CLOCK_ADJTIME() macro
In-Reply-To: <20190322133425.GB20408@rei.lan>
References: <20190322133425.GB20408@rei.lan>
Message-ID: <20190322182526.10353-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adds SAFE_CLOCK_ADJTIME() macro to tst_safe_clocks.h.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_safe_clocks.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index d5cd83394..596db4099 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -6,7 +6,9 @@
  */
 
 #include <time.h>
+#include <sys/timex.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
 
 static inline void safe_clock_getres(const char *file, const int lineno,
@@ -44,6 +46,19 @@ static inline void safe_clock_settime(const char *file, const int lineno,
 			"%s:%d clock_gettime() failed", file, lineno);
 }
 
+static inline int safe_clock_adjtime(const char *file, const int lineno,
+	clockid_t clk_id, struct timex *txc)
+{
+	int rval;
+
+	rval = tst_syscall(__NR_clock_adjtime, clk_id, txc);
+	if (rval < 0)
+		tst_brk(TBROK | TERRNO,
+			"%s:%d clock_adjtime() failed %i", file, lineno, rval);
+
+	return rval;
+}
+
 #define SAFE_CLOCK_GETRES(clk_id, res)\
 	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
 
@@ -52,3 +67,6 @@ static inline void safe_clock_settime(const char *file, const int lineno,
 
 #define SAFE_CLOCK_SETTIME(clk_id, tp)\
 	safe_clock_settime(__FILE__, __LINE__, (clk_id), (tp))
+
+#define SAFE_CLOCK_ADJTIME(clk_id, txc)\
+	safe_clock_adjtime(__FILE__, __LINE__, (clk_id), (txc))
-- 
2.20.1

