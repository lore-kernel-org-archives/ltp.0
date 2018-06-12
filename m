From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jun 2018 16:11:37 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] tst_test.sh: Quote function parameter
Message-ID: <20180612141137.11690-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As following patches shows the need to use function with parameter [1],
quotes are needed.

[1] http://lists.linux.it/pipermail/ltp/2018-May/008147.html

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Sorry, I overlooked it in your patch.
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 0c98d5a75..d27b4afd6 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -156,7 +156,7 @@ EXPECT_FAIL()
 
 TST_RETRY_FN_EXP_BACKOFF()
 {
-	local tst_fun=$1
+	local tst_fun="$1"
 	local tst_exp=$2
 	local tst_sec=$(expr $3 \* 1000000)
 	local tst_delay=1
-- 
2.16.3

