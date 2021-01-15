From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Jan 2021 16:19:36 +0100
Subject: [LTP] [PATCH] include/tst_timer.h: Fix overflows
Message-ID: <20210115151936.18809-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes overflows in tst_timeval_to_us() and tst_timeval_to_ns() on
32bit hardware. We have to cast the tv_sec (ulong) to (long long)
explicitly otherwise the tv_sec will overflow the multiplication.

This fixes clock_gettime04 where the overflow corrupted the result from
gettimeofday() when it was converted from timeval to timespec.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 include/tst_timer.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 657c0824f..4a79ae208 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -26,7 +26,7 @@
  */
 static inline long long tst_timeval_to_us(struct timeval t)
 {
-	return t.tv_sec * 1000000 + t.tv_usec;
+	return ((long long)t.tv_sec) * 1000000 + t.tv_usec;
 }
 
 /*
@@ -34,7 +34,7 @@ static inline long long tst_timeval_to_us(struct timeval t)
  */
 static inline long long tst_timeval_to_ms(struct timeval t)
 {
-	return t.tv_sec * 1000 + (t.tv_usec + 500) / 1000;
+	return ((long long)t.tv_sec) * 1000 + (t.tv_usec + 500) / 1000;
 }
 
 /*
-- 
2.26.2

