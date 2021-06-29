From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 29 Jun 2021 17:25:58 +0800
Subject: [LTP] [PATCH 1/2] include/tst_test_macro.h: Fix zero-length
 gnu_printf format string warning
Message-ID: <1624958759-5562-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When build test_macro02.c, it reports the following warning.

CC lib/newlib_tests/test_macros01
In file included from ../../include/tst_test.h:21,
                 from test_macros02.c:10:
test_macros02.c: In function ?do_test?:
../../include/tst_test_macros.h:142:31: warning: zero-length gnu_printf format string [-Wformat-zero-length]
  142 |     TST_MSG_(TPASS | TTERRNO, "",                  \
      |                               ^~

Fix this by adding space string in format when using TST_MSG_ macro.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_test_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 78cee47de..41886fbbc 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -139,7 +139,7 @@ extern void *TST_RET_PTR;
 		                                                               \
 		if (ERRNO) {                                                   \
 			if (TST_ERR == ERRNO) {                                \
-				TST_MSG_(TPASS | TTERRNO, "",                  \
+				TST_MSG_(TPASS | TTERRNO, " ",                 \
 				         #SCALL, ##__VA_ARGS__);               \
 				TST_PASS = 1;                                  \
 			} else {                                               \
-- 
2.23.0

