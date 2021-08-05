From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  5 Aug 2021 09:35:37 +0100
Subject: [LTP] [PATCH v4 1/3] API: TST_EXP_FAIL: Allow passing when errno is
 not set
In-Reply-To: <87a6lwmm6c.fsf@suse.de>
References: <87a6lwmm6c.fsf@suse.de>
Message-ID: <20210805083539.20634-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

TEST() sets errno to zero. So if something does not set errno on
failure it will be zero. It is normal for functions not to use errno,
some standard libraries are the exception.

The original code will not allow for a pass result if errno is not
set. So we can just remove the branch to allow that. It's not clear
what the original intention was.

This also changes the trailing '\' indentation to tabs. However this
is correct and the rest of the file is wrong.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V4:
* Check for EINVAL.
* Unconditionally check TST_ERR == ERRNO.
  (redundant/irrelevant due to the above change, but we still should do it IMO)

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
index 41886fbbc..cd65d8d0d 100644
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
+		if (TST_ERR == ERRNO) {					\
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

