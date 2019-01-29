From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 29 Jan 2019 15:36:53 -0200
Subject: [LTP] [PATCH v4 2/8] lib: include SAFE_CLOCK_SETTIME() macro
In-Reply-To: <20190129173659.27901-1-rafael.tinoco@linaro.org>
References: <20190124161159.GC16804@rei.lan>
 <20190129173659.27901-1-rafael.tinoco@linaro.org>
Message-ID: <20190129173659.27901-2-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adds SAFE_CLOCK_SETTIME() macro to tst_safe_clocks.h.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_safe_clocks.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index 1b4d48543..553f8464a 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -30,9 +30,23 @@ static inline void safe_clock_gettime(const char *file, const int lineno,
 			"%s:%d clock_gettime() failed", file, lineno);
 }
 
+
+static inline void safe_clock_settime(const char *file, const int lineno,
+	clockid_t clk_id, struct timespec *tp)
+{
+	int rval;
+
+	rval = clock_settime(clk_id, tp);
+	if (rval != 0)
+		tst_brk(TBROK | TERRNO,
+			"%s:%d clock_gettime() failed", file, lineno);
+}
+
 #define SAFE_CLOCK_GETRES(clk_id, res)\
 	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
 
 #define SAFE_CLOCK_GETTIME(clk_id, tp)\
 	safe_clock_gettime(__FILE__, __LINE__, (clk_id), (tp))
 
+#define SAFE_CLOCK_SETTIME(clk_id, tp)\
+	safe_clock_settime(__FILE__, __LINE__, (clk_id), (tp))
-- 
2.20.1

