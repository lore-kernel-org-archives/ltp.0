From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 29 Jan 2019 15:36:52 -0200
Subject: [LTP] [PATCH v4 1/8] lib: add tst_clock_settime() to tst_clocks.h
In-Reply-To: <20190124161159.GC16804@rei.lan>
References: <20190124161159.GC16804@rei.lan>
Message-ID: <20190129173659.27901-1-rafael.tinoco@linaro.org>
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
2.20.1

