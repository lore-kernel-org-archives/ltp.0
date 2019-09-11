From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Wed, 11 Sep 2019 18:52:23 +0200
Subject: [LTP] [PATCH v2 1/3] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <20190911085536.25546-1-cfamullaconrad@suse.de>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
Message-ID: <20190911165225.2122-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Because of timeout problems when using TST_RETRY_FN() we do now use
LTP_TIMEOUT_MUL to adopt the timeout value.

Introduced tst_adjut_timeout function to have a generic place to
adopt timeout values.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 testcases/lib/tst_test.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e0b24c6b9..03692e503 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -164,7 +164,7 @@ TST_RETRY_FN_EXP_BACKOFF()
 {
 	local tst_fun="$1"
 	local tst_exp=$2
-	local tst_sec=$(expr $3 \* 1000000)
+	local tst_sec=$(tst_adjust_timeout $(expr $3 \* 1000000))
 	local tst_delay=1
 
 	if [ $# -ne 3 ]; then
@@ -371,12 +371,16 @@ _tst_rescmp()
 	fi
 }
 
-
-_tst_setup_timer()
+tst_adjust_timeout()
 {
 	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
+	local timeout=$1
+	echo $(( timeout * LTP_TIMEOUT_MUL))
+}
 
-	local sec=$((300 * LTP_TIMEOUT_MUL))
+_tst_setup_timer()
+{
+	local sec=$(tst_adjust_timeout 300)
 	local h=$((sec / 3600))
 	local m=$((sec / 60 % 60))
 	local s=$((sec % 60))
-- 
2.16.4

