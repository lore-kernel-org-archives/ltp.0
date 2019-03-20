From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 20 Mar 2019 16:37:18 -0300
Subject: [LTP] [PATCH] lib: Add include guard to tst_safe_clocks.h
Message-ID: <20190320193718.2320-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When adding a common header to my tests I missed this include guard when
accidentally including tst_safe_clocks.h from .c and .h files. Since
other tst_safe_*.h files have guards I thought it would be good to add
to this one as well.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_safe_clocks.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index a952be4bf..0f642148e 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -5,6 +5,9 @@
  * Email : code@zilogic.com
  */
 
+#ifndef TST_SAFE_CLOCK_H__
+#define TST_SAFE_CLOCK_H__
+
 #include <time.h>
 #include <sys/timex.h>
 #include "tst_test.h"
@@ -69,3 +72,5 @@ static inline void safe_clock_adjtime(const char *file, const int lineno,
 
 #define SAFE_CLOCK_ADJTIME(clk_id, txc)\
 	safe_clock_adjtime(__FILE__, __LINE__, (clk_id), (txc))
+
+#endif /* SAFE_CLOCK_H__ */
-- 
2.20.1

