From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 5 Apr 2019 14:30:48 +0800
Subject: [LTP] [PATCH] lib/tst_wallclock.c: Add check for unsupported
	CLOCK_MONOTONIC_RAW
Message-ID: <1554445848-437-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

CLOCK_MONOTONIC_RAW was introduced since kernel v2.6.28, so we want
TCONF instead of TBROK if CLOCK_MONOTONIC_RAW wasn't supported on
older kernels.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_wallclock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/tst_wallclock.c b/lib/tst_wallclock.c
index f1c96c0..282d6ad 100644
--- a/lib/tst_wallclock.c
+++ b/lib/tst_wallclock.c
@@ -25,8 +25,14 @@ void tst_wallclock_save(void)
 	if (tst_clock_gettime(CLOCK_REALTIME, &real_begin))
 		tst_brk(TBROK | TERRNO, "tst_clock_gettime() realtime failed");
 
-	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_begin))
+	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_begin)) {
+		if (errno == EINVAL) {
+			tst_brk(TCONF | TERRNO,
+				"tst_clock_gettime() didn't support CLOCK_MONOTONIC_RAW");
+		}
+
 		tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
+	}
 
 	clock_saved = 1;
 }
-- 
1.7.11.rc0



