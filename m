From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 17 Aug 2016 17:16:36 +0800
Subject: [LTP] [PATCH] tst_test.h: fix tst_test->tid for unsupported cases
Message-ID: <1471425396-26898-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If some cases aren't supported by system, they fail with
the following message:
  "tst_test.c:569: BROK: No tid set in test structure"
We should return TCONF instead of TBROK.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_test.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 7e4997f..03722ec 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -160,8 +160,8 @@ int main(int argc, char *argv[])
 
 #define TST_TEST_TCONF(message)                                           \
 	static void tst_do_test(void) { tst_brk(TCONF, "%s", message); }; \
-        static struct tst_test test = { .test_all = tst_do_test }         \
-
+	static struct tst_test test = { .test_all = tst_do_test,          \
+					.tid = "tst_test_conf" }          \
 /*
  * This is a hack to make the testcases link without defining TCID
  */
-- 
1.8.3.1



