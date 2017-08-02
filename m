From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  2 Aug 2017 10:16:36 +0200
Subject: [LTP] [PATCH] [COMMITTED] lib/tst_test: Ignore unknown options for
	TCONF tests
Message-ID: <20170802081636.32527-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The problem is that with TST_TEST_TCONF() the optional test options are
not propagated in the tst_test structure. As a matter of fact the test
library had no idea that the test was compiled out, which had to be
changed as well.

So this commit adds a string pointer to the tst_test structure, that if
set, causes the test library to ignore unknown options and exits the
test, as fast as possible, with a TCONF.

This fixes cases where a test was compiled out but the runtest file
passes some tests specific options which previously failed the test with
TBROK.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h | 8 +++++---
 lib/tst_test.c     | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 982cdfed5..e90312ae3 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -114,6 +114,9 @@ struct tst_test {
 
 	const char *min_kver;
 
+	/* If set the test is compiled out */
+	const char *tconf_msg;
+
 	int needs_tmpdir:1;
 	int needs_root:1;
 	int forks_child:1;
@@ -196,9 +199,8 @@ int main(int argc, char *argv[])
 
 #endif /* TST_NO_DEFAULT_MAIN */
 
-#define TST_TEST_TCONF(message)                                           \
-        static void tst_do_test(void) { tst_brk(TCONF, "%s", message); }; \
-        static struct tst_test test = { .test_all = tst_do_test }         \
+#define TST_TEST_TCONF(message)                                 \
+        static struct tst_test test = { .tconf_msg = message  } \
 /*
  * This is a hack to make the testcases link without defining TCID
  */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 82a607b48..4c30edab5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -669,6 +669,9 @@ static void do_setup(int argc, char *argv[])
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
 
+	if (tst_test->tconf_msg)
+		tst_brk(TCONF, "%s", tst_test->tconf_msg);
+
 	assert_test_fn();
 
 	if (tst_test->sample)
-- 
2.13.0

