From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Jul 2019 15:43:28 +0200
Subject: [LTP] [PATCH] tst_test.sh: Use $LTP_TIMEOUT_MUL also in
 TST_RETRY_FN_EXP_BACKOFF()
Message-ID: <20190712134328.20528-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This function should also address possibility of slow machine.

Because using on 2 places moved the default definition to the beginning
of the script.
+ use $((...)) instead of expr.
+ move expression using $3 after check whether we have enough parameters

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 31b3a3951..55a642267 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -17,6 +17,8 @@ export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
 
+export LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
+
 . tst_ansi_color.sh
 . tst_security.sh
 
@@ -164,12 +166,13 @@ TST_RETRY_FN_EXP_BACKOFF()
 {
 	local tst_fun="$1"
 	local tst_exp=$2
-	local tst_sec=$(expr $3 \* 1000000)
 	local tst_delay=1
+	local tst_sec
 
 	if [ $# -ne 3 ]; then
 		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects 3 parameters"
 	fi
+	tst_sec=$(($3 * LTP_TIMEOUT_MUL * 1000000))
 
 	if ! tst_is_int "$tst_sec"; then
 		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF: tst_sec must be integer ('$tst_sec')"
@@ -185,7 +188,7 @@ TST_RETRY_FN_EXP_BACKOFF()
 			tst_sleep ${tst_delay}us
 			tst_delay=$((tst_delay*2))
 		else
-			tst_brk TBROK "\"$tst_fun\" timed out"
+			tst_brk TBROK "\"$tst_fun\" timed out! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL"
 		fi
 	done
 
@@ -374,8 +377,6 @@ _tst_rescmp()
 
 _tst_setup_timer()
 {
-	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
-
 	local sec=$((300 * LTP_TIMEOUT_MUL))
 	local h=$((sec / 3600))
 	local m=$((sec / 60 % 60))
-- 
2.22.0

