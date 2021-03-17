From: ice_yangxiao@163.com <ice_yangxiao@163.com>
Date: Wed, 17 Mar 2021 21:26:24 +0800
Subject: [LTP] [PATCH] include/tst_test_macros.h: Use TTERRNO for
 TST_EXP_FAIL() properly
Message-ID: <20210317132624.13507-1-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

1) Remove TTERRNO if TST_RET == 0
2) Use TTERRNO if TST_RET == -1

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_test_macros.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 92cb5c66b..189891507 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -114,8 +114,7 @@ extern void *TST_RET_PTR;
 		TST_PASS = 0;                                                  \
 		                                                               \
 		if (TST_RET == 0) {                                            \
-			TST_MSG_(TFAIL | TTERRNO, " succeeded",                \
-			         #SCALL, ##__VA_ARGS__);                       \
+			TST_MSG_(TFAIL, " succeeded", #SCALL, ##__VA_ARGS__);  \
 		        break;                                                 \
 		}                                                              \
 		                                                               \
@@ -127,11 +126,11 @@ extern void *TST_RET_PTR;
 		                                                               \
 		if (ERRNO) {                                                   \
 			if (TST_ERR == ERRNO) {                                \
-				TST_MSG_(TPASS | TERRNO, "",                   \
+				TST_MSG_(TPASS | TTERRNO, "",                  \
 				         #SCALL, ##__VA_ARGS__);               \
 				TST_PASS = 1;                                  \
 			} else {                                               \
-				TST_MSGP_(TFAIL | TERRNO, " expected %s",      \
+				TST_MSGP_(TFAIL | TTERRNO, " expected %s",     \
 				          tst_strerrno(ERRNO),                 \
 				          #SCALL, ##__VA_ARGS__);              \
 			}                                                      \
-- 
2.26.2


