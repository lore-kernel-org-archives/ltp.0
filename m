From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 12:24:07 +0530
Subject: [LTP] [PATCH V2 1/6] tst_safe_clocks: Remove safe_clock_adjtime()
In-Reply-To: <cover.1590130423.git.viresh.kumar@linaro.org>
References: <cover.1590130423.git.viresh.kumar@linaro.org>
Message-ID: <d6f2460611242e1ae0a967483e4550d95c55ee95.1590130423.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

safe_clock_adjtime() isn't used anymore, remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_safe_clocks.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index 27e8bda45589..4cb5f41ed82f 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -55,21 +55,6 @@ static inline void safe_clock_settime(const char *file, const int lineno,
 	}
 }
 
-static inline int safe_clock_adjtime(const char *file, const int lineno,
-	clockid_t clk_id, struct timex *txc)
-{
-	int rval;
-
-	rval = tst_syscall(__NR_clock_adjtime, clk_id, txc);
-	if (rval < 0) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d clock_adjtime(%s) failed %i",
-			file, lineno, tst_clock_name(clk_id), rval);
-	}
-
-	return rval;
-}
-
 #define SAFE_CLOCK_GETRES(clk_id, res)\
 	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
 
@@ -79,7 +64,4 @@ static inline int safe_clock_adjtime(const char *file, const int lineno,
 #define SAFE_CLOCK_SETTIME(clk_id, tp)\
 	safe_clock_settime(__FILE__, __LINE__, (clk_id), (tp))
 
-#define SAFE_CLOCK_ADJTIME(clk_id, txc)\
-	safe_clock_adjtime(__FILE__, __LINE__, (clk_id), (txc))
-
 #endif /* SAFE_CLOCKS_H__ */
-- 
2.25.0.rc1.19.g042ed3e048af

