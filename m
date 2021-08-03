From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  3 Aug 2021 13:52:50 +0100
Subject: [LTP] [PATCH v3 1/3] API: TST_EXP_FAIL: Allow passing when errno is
 not checked
In-Reply-To: <87czquna4l.fsf@suse.de>
References: <87czquna4l.fsf@suse.de>
Message-ID: <20210803125252.16214-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Judging by the existing usage of TST_EXP_FAIL(..., 0, ...) in
finit_module02. We want to pass if errno == 0 otherwise the test will
not return a result.

This is also less surprising than giving errno == 0 a dual
meaning.

This also changes the trailing '\' indentation to tabs. However this
is correct and the rest of the file is wrong.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V3:
* Add fix for TST_EXP_FAIL which prevented the test from
  passing on a non buggy system.
* TCONF but continue on non 32-bit compat mode
* Add Fixes trailer

V2:
* Add mising lapi header

 include/tst_test_macros.h | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 41886fbbc..4c1df58ff 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -137,17 +137,15 @@ extern void *TST_RET_PTR;
 			break;                                                 \
 		}                                                              \
 		                                                               \
-		if (ERRNO) {                                                   \
-			if (TST_ERR == ERRNO) {                                \
-				TST_MSG_(TPASS | TTERRNO, " ",                 \
-				         #SCALL, ##__VA_ARGS__);               \
-				TST_PASS = 1;                                  \
-			} else {                                               \
-				TST_MSGP_(TFAIL | TTERRNO, " expected %s",     \
-				          tst_strerrno(ERRNO),                 \
-				          #SCALL, ##__VA_ARGS__);              \
-			}                                                      \
-		}                                                              \
+		if (!ERRNO || TST_ERR == ERRNO) {			\
+			TST_MSG_(TPASS | TTERRNO, " ",			\
+				 #SCALL, ##__VA_ARGS__);		\
+			TST_PASS = 1;					\
+		} else {						\
+			TST_MSGP_(TFAIL | TTERRNO, " expected %s",	\
+				  tst_strerrno(ERRNO),			\
+				  #SCALL, ##__VA_ARGS__);		\
+		}							\
 	} while (0)
 
 #define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET == 0, SCALL, ERRNO, __VA_ARGS__)
-- 
2.31.1

