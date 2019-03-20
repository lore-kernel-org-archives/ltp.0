From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 20 Mar 2019 18:41:33 -0300
Subject: [LTP] [PATCH v2 1/3] lib: include SAFE_CLOCK_ADJTIME() macro
In-Reply-To: <20190313163239.GC6171@rei>
References: <20190313163239.GC6171@rei>
Message-ID: <20190320214135.7029-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adds SAFE_CLOCK_ADJTIME() macro to tst_safe_clocks.h.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_safe_clocks.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index d5cd83394..a952be4bf 100644
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
@@ -44,6 +46,18 @@ static inline void safe_clock_settime(const char *file, const int lineno,
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
+
 #define SAFE_CLOCK_GETRES(clk_id, res)\
 	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
 
@@ -52,3 +66,6 @@ static inline void safe_clock_settime(const char *file, const int lineno,
 
 #define SAFE_CLOCK_SETTIME(clk_id, tp)\
 	safe_clock_settime(__FILE__, __LINE__, (clk_id), (tp))
+
+#define SAFE_CLOCK_ADJTIME(clk_id, txc)\
+	safe_clock_adjtime(__FILE__, __LINE__, (clk_id), (txc))
-- 
2.20.1

