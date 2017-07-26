From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 11:29:53 +0800
Subject: [LTP] [PATCH] tst_timer.h: Cosmetic fix
Message-ID: <20170726032953.23646-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_timer.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 48d7c7b..1b00e3c 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -95,12 +95,12 @@ static inline struct timeval tst_us_to_timeval(long long us)
 /*
  * Converts ms to struct timespec
  */
-static inline struct timespec tst_ms_to_timespec(long long us)
+static inline struct timespec tst_ms_to_timespec(long long ms)
 {
 	struct timespec ret;
 
-	ret.tv_sec = us / 1000;
-	ret.tv_nsec = (us % 1000) * 1000000;
+	ret.tv_sec = ms / 1000;
+	ret.tv_nsec = (ms % 1000) * 1000000;
 
 	return ret;
 }
-- 
2.9.4



