From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri,  4 May 2018 14:53:49 +0200
Subject: [LTP] [PATCH] lib: Remove retry message from TST_RETRY_FUNC
Message-ID: <20180504125349.22734-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This message creates a lot of noise and uses extra resources on slower
machines. It also does not seem very useful.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

This may help debug test failures on ARM machines by reducing the amount of
noise.

 include/tst_common.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index d3d50eb19..27924766e 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -56,13 +56,10 @@
 		if (tst_ret_ == ERET)					\
 			break;						\
 		if (tst_delay_ < MAX_DELAY * 1000000) {			\
-			tst_res(TINFO,					\
-				#FUNC" returned %i, retrying"		\
-				" in %ius", tst_ret_, tst_delay_);	\
 			usleep(tst_delay_);				\
 			tst_delay_ *= 2;				\
 		} else {						\
-			tst_brk(TBROK, #FUNC" failed");			\
+			tst_brk(TBROK, #FUNC" timed out");		\
 		}							\
 	}								\
 	ERET;								\
-- 
2.16.3

