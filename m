From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Mar 2019 14:54:32 +0100
Subject: [LTP] [PATCH v2 3/3] syscalls/clock_adjtime: create
 clock_adjtime syscall tests
In-Reply-To: <20190320214135.7029-3-rafael.tinoco@linaro.org>
References: <20190313163239.GC6171@rei>
 <20190320214135.7029-1-rafael.tinoco@linaro.org>
 <20190320214135.7029-3-rafael.tinoco@linaro.org>
Message-ID: <20190321135432.GD1252@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This test fails for me and clock_adjtime() returns 5 (TIME_ERROR) for me.

Looks like the SAFE_ADJTIME() should fail only on rval < 0 and return the rval
too so that we can possibly make use of the return value, the test passes for
me with:

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index a952be4bf..f7776a548 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -46,16 +46,18 @@ static inline void safe_clock_settime(const char *file, const int lineno,
                        "%s:%d clock_gettime() failed", file, lineno);
 }
 
-static inline void safe_clock_adjtime(const char *file, const int lineno,
+static inline int safe_clock_adjtime(const char *file, const int lineno,
        clockid_t clk_id, struct timex *txc)
 {
        int rval;
 
        rval = tst_syscall(__NR_clock_adjtime, clk_id, txc);
 
-       if (rval != 0)
+       if (rval < 0)
                tst_brk(TBROK | TERRNO,
-                       "%s:%d clock_adjtime() failed", file, lineno);
+                       "%s:%d clock_adjtime() failed %i", file, lineno, rval);
+
+       return rval;
 }


Also we should restore the adjtimex only if we actually managed to save it,
with something as:

diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
index 48cfbe6c5..6eb823387 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
@@ -58,6 +58,7 @@
 
 static long hz;
 static struct timex saved, ttxc;
+static int clock_saved;
 
 struct test_case {
        unsigned int modes;
@@ -165,10 +166,13 @@ static void verify_clock_adjtime(unsigned int i)
 static void setup(void)
 {
        size_t i;
+       int rval;
 
        /* save original clock flags */
 
-       SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
+       rval = SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
+       clock_saved = 1;
+       tst_res(TINFO, "clock_adjtime() = %i", rval);
 
        hz = SAFE_SYSCONF(_SC_CLK_TCK);
 
@@ -203,7 +207,8 @@ static void cleanup(void)
 
        /* restore original clock flags */
 
-       SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
+       if (clock_saved)
+               SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
 }
 
 static struct tst_test test = {


-- 
Cyril Hrubis
chrubis@suse.cz
