From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Wed, 16 Oct 2019 18:15:16 +0200
Subject: [LTP] [PATCH v3 1/4] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <1571225126.8494.1.camel@suse.de>
References: <1571225126.8494.1.camel@suse.de>
Message-ID: <20191016161519.11256-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Because of timeout problems when using TST_RETRY_FN() we do now use
LTP_TIMEOUT_MUL to adopt the timeout value.

Introduced tst_multiply_timeout function to have a generic place to
adopt timeout values.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 testcases/lib/tst_test.sh | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index d8071cb10..ee220ac19 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -164,9 +164,11 @@ TST_RETRY_FN_EXP_BACKOFF()
 {
 	local tst_fun="$1"
 	local tst_exp=$2
-	local tst_sec=$(expr $3 \* 1000000)
+	local tst_sec=$(( $3 * 1000000 ))
 	local tst_delay=1
 
+	tst_multiply_timeout tst_sec
+
 	if [ $# -ne 3 ]; then
 		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects 3 parameters"
 	fi
@@ -376,16 +378,13 @@ _tst_rescmp()
 	fi
 }
 
-
-_tst_setup_timer()
+tst_multiply_timeout()
 {
-	TST_TIMEOUT=${TST_TIMEOUT:-300}
-	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
+	# first parameter is used as return value
+	local timeout="${!1}"
+	[ $# -gt 1 ] && timeout="$2"
 
-	if [ "$TST_TIMEOUT" = -1 ]; then
-		tst_res TINFO "Timeout per run is disabled"
-		return
-	fi
+	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
 
 	local err="LTP_TIMEOUT_MUL must be number >= 1!"
 
@@ -396,13 +395,29 @@ _tst_setup_timer()
 		LTP_TIMEOUT_MUL=$((LTP_TIMEOUT_MUL+1))
 		tst_res TINFO "ceiling LTP_TIMEOUT_MUL to $LTP_TIMEOUT_MUL"
 	fi
+
 	[ "$LTP_TIMEOUT_MUL" -ge 1 ] || tst_brk TBROK "$err ($LTP_TIMEOUT_MUL)"
+	[ "$timeout" -ge 1 ] || tst_brk TBROK "timeout need to be >= 1 ($timeout)"
+
+	eval "$1='$(( timeout * LTP_TIMEOUT_MUL))'"
+	return 0
+}
+
+_tst_setup_timer()
+{
+	TST_TIMEOUT=${TST_TIMEOUT:-300}
+
+	if [ "$TST_TIMEOUT" = -1 ]; then
+		tst_res TINFO "Timeout per run is disabled"
+		return
+	fi
 
 	if ! tst_is_int "$TST_TIMEOUT" || [ "$TST_TIMEOUT" -lt 1 ]; then
 		tst_brk TBROK "TST_TIMEOUT must be int >= 1! ($TST_TIMEOUT)"
 	fi
 
-	local sec=$((TST_TIMEOUT * LTP_TIMEOUT_MUL))
+	local sec=$TST_TIMEOUT
+	tst_multiply_timeout sec
 	local h=$((sec / 3600))
 	local m=$((sec / 60 % 60))
 	local s=$((sec % 60))
-- 
2.16.4

