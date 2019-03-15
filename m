From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 15 Mar 2019 09:42:15 -0700
Subject: [LTP] [PATCH] lib/tst_test.c: fix error message for zero tcnt
Message-ID: <20190315164215.96129-1-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Remove the word "not".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/tst_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 7dd890b8d..ba5eab011 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -698,7 +698,7 @@ static void assert_test_fn(void)
 		tst_brk(TBROK, "You can define only one test function");
 
 	if (tst_test->test && !tst_test->tcnt)
-		tst_brk(TBROK, "Number of tests (tcnt) must not be > 0");
+		tst_brk(TBROK, "Number of tests (tcnt) must be > 0");
 
 	if (!tst_test->test && tst_test->tcnt)
 		tst_brk(TBROK, "You can define tcnt only for test()");
-- 
2.21.0.360.g471c308f928-goog

