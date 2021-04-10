From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sat, 10 Apr 2021 15:38:23 +0800
Subject: [LTP] [PATCH] lib/tst_test.sh: Add statistics info TST_BROK
Message-ID: <20210410073823.21753-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before test exit, we need print statistics info of TST_BROK.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2:Correct typos
---
 testcases/lib/tst_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index a6a8e9579..7f98e06bf 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -82,6 +82,7 @@ _tst_do_exit()
 	echo "Summary:"
 	echo "passed   $TST_PASS"
 	echo "failed   $TST_FAIL"
+	echo "broken   $TST_BROK"
 	echo "skipped  $TST_CONF"
 	echo "warnings $TST_WARN"

--
2.17.1

