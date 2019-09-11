From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Wed, 11 Sep 2019 18:52:25 +0200
Subject: [LTP] [PATCH v2 3/3] tst_common.h: Use tst_adjust_timeout in
 TST_RETRY_FN()
In-Reply-To: <20190911165225.2122-1-cfamullaconrad@suse.de>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
 <20190911165225.2122-1-cfamullaconrad@suse.de>
Message-ID: <20190911165225.2122-3-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Because of timeout problems when using TST_RETRY_FN() we want a LTP_TIMEOUT_MUL
adopted timeout value here as well.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 include/tst_common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index c21505450..ca8f06d01 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -50,12 +50,14 @@
 	TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, 1)
 
 #define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)	\
-({	int tst_delay_ = 1;						\
+({	unsigned int tst_delay_, tst_max_delay_;			\
+	tst_delay_ = 1;							\
+	tst_max_delay_ = tst_adjust_timeout(MAX_DELAY * 1000000);	\
 	for (;;) {							\
 		typeof(FUNC) tst_ret_ = FUNC;				\
 		if (tst_ret_ == ERET)					\
 			break;						\
-		if (tst_delay_ < MAX_DELAY * 1000000) {			\
+		if (tst_delay_ < tst_max_delay_) {			\
 			usleep(tst_delay_);				\
 			tst_delay_ *= 2;				\
 		} else {						\
-- 
2.16.4

