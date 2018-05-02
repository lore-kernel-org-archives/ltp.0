From: Li Wang <liwang@redhat.com>
Date: Wed,  2 May 2018 21:29:02 +0800
Subject: [LTP] [PATCH] tst_test.sh: achieve TST_RETRY_FUNC function in shell
Message-ID: <20180502132902.16065-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/test-writing-guidelines.txt | 20 ++++++++++++++++++++
 testcases/lib/tst_test.sh       | 30 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index cbbfe6c..318eca6 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1640,6 +1640,26 @@ that can sleep for defined amount of seconds, milliseconds or microseconds.
 tst_sleep 100ms
 -------------------------------------------------------------------------------
 
+Retry a function in limited time
+++++++++++++++++++++++++++++++++
+
+Sometimes LTP test needs retrying a function for many times to get success.
+This achievement makes that possible via keeping it retrying if the return
+value of the function is NOT as we expected. After exceeding one second, the
+test will break from the retries immediately.
+
+[source,c]
+-------------------------------------------------------------------------------
+# retry function in 1 second
+TST_RETRY_FUNC(FUNC, ERET)
+-------------------------------------------------------------------------------
+
+[source,sh]
+-------------------------------------------------------------------------------
+# retry function in 1 second
+TST_RETRY_FUNC "FUNC arg1 arg2" "ERET"
+-------------------------------------------------------------------------------
+
 Checking for integers
 +++++++++++++++++++++
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d49d34..d03ed04 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -154,6 +154,36 @@ EXPECT_FAIL()
 	fi
 }
 
+TST_RETRY_FN_EXP_BACKOFF()
+{
+	local tst_fun=$1
+	local tst_exp=$2
+	local tst_sec=$(expr $3 \* 1000000)
+	local tst_delay=1
+
+	while true; do
+		$tst_fun
+		if [ "$?" == "$tst_exp" ]; then
+			break
+		fi
+
+		if [ $tst_delay -lt $tst_sec ]; then
+			tst_sleep ${tst_delay}us
+			tst_delay=$((tst_delay*2))
+		else
+			tst_brk TBROK "$tst_fun failed"
+		fi
+	done
+
+	return $tst_exp
+}
+
+TST_RETRY_FUNC()
+{
+	TST_RETRY_FN_EXP_BACKOFF "$1" "$2" 1
+	return $2
+}
+
 tst_umount()
 {
 	local device="$1"
-- 
2.9.5

