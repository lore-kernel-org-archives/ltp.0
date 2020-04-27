From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Apr 2020 07:38:12 +0200
Subject: [LTP] [PATCH v2 1/2] tst_test.sh: eval TST_RETRY_FN_EXP_BACKOFF
 function
Message-ID: <20200427053813.23112-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It helps to have more advanced commands without having to declare
function.

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 1d8a71d9f..8d24b4abf 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -207,7 +207,7 @@ TST_RETRY_FN_EXP_BACKOFF()
 	fi
 
 	while true; do
-		$tst_fun
+		eval "$tst_fun"
 		if [ "$?" = "$tst_exp" ]; then
 			break
 		fi
-- 
2.26.1

