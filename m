From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 May 2017 14:05:54 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/2] tst_test: TST_TEST_TCONF() do no set
	tid
Message-ID: <20170524120555.26571-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's not needed since we set tid based on argv[0] now.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index eec8e1257..666109550 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -192,9 +192,9 @@ int main(int argc, char *argv[])
 
 #endif /* TST_NO_DEFAULT_MAIN */
 
-#define TST_TEST_TCONF(message)                                              \
-        static void tst_do_test(void) { tst_brk(TCONF, "%s", message); };    \
-        static struct tst_test test = { .test_all = tst_do_test, .tid = "" } \
+#define TST_TEST_TCONF(message)                                           \
+        static void tst_do_test(void) { tst_brk(TCONF, "%s", message); }; \
+        static struct tst_test test = { .test_all = tst_do_test }         \
 /*
  * This is a hack to make the testcases link without defining TCID
  */
-- 
2.13.0

