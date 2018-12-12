From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 12 Dec 2018 18:37:19 -0200
Subject: [LTP] [PATCH v3 2/6] lib: add tst_clock_settime() to tst_clocks.h
In-Reply-To: <20181212203723.18810-1-rafael.tinoco@linaro.org>
References: <20181211142750.GA27159@rei>
 <20181212203723.18810-1-rafael.tinoco@linaro.org>
Message-ID: <20181212203723.18810-2-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adds tst_clock_settime() function to the lib.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_clocks.h | 2 ++
 lib/tst_clocks.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/tst_clocks.h b/include/tst_clocks.h
index ee2f645c7..90784a3fd 100644
--- a/include/tst_clocks.h
+++ b/include/tst_clocks.h
@@ -26,4 +26,6 @@ int tst_clock_getres(clockid_t clk_id, struct timespec *res);
 
 int tst_clock_gettime(clockid_t clk_id, struct timespec *ts);
 
+int tst_clock_settime(clockid_t clk_id, struct timespec *ts);
+
 #endif /* TST_CLOCKS__ */
diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 87413a339..35798a4aa 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -35,3 +35,8 @@ int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
 {
 	return syscall(SYS_clock_gettime, clk_id, ts);
 }
+
+int tst_clock_settime(clockid_t clk_id, struct timespec *ts)
+{
+	return syscall(SYS_clock_settime, clk_id, ts);
+}
-- 
2.20.0.rc1

