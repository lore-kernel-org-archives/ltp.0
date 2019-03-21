From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 21 Mar 2019 17:27:30 -0300
Subject: [LTP] [PATCH v3 2/4] lib: Add include guard to tst_safe_clocks.h
In-Reply-To: <20190321202732.3331-1-rafael.tinoco@linaro.org>
References: <20190321141015.GG1252@rei>
 <20190321202732.3331-1-rafael.tinoco@linaro.org>
Message-ID: <20190321202732.3331-2-rafael.tinoco@linaro.org>
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
index 596db4099..34ed953b4 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -5,6 +5,9 @@
  * Email : code@zilogic.com
  */
 
+#ifndef TST_SAFE_CLOCKS_H__
+#define TST_SAFE_CLOCKS_H__
+
 #include <time.h>
 #include <sys/timex.h>
 #include "tst_test.h"
@@ -70,3 +73,5 @@ static inline int safe_clock_adjtime(const char *file, const int lineno,
 
 #define SAFE_CLOCK_ADJTIME(clk_id, txc)\
 	safe_clock_adjtime(__FILE__, __LINE__, (clk_id), (txc))
+
+#endif /* SAFE_CLOCKS_H__ */
-- 
2.20.1

