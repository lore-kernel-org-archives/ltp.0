From: Li Wang <liwang@redhat.com>
Date: Thu,  3 May 2018 11:34:14 +0800
Subject: [LTP] [PATCH v2] tst_test.sh: achieve TST_RETRY_FUNC function in
	shell
Message-ID: <20180503033414.5601-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The commit c2ce4df67d(include: add an exponential backoff macro for
function retry) involves a new MACRO for function retry in C code,
here achieve it in shell lib and gives a introduction in LTP documents.

Signed-off-by: Li Wang <liwang@redhat.com>
Tested-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt | 26 ++++++++++++++++++++++++++
 testcases/lib/tst_test.sh       | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index cbbfe6c..b2dd091 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1640,6 +1640,32 @@ that can sleep for defined amount of seconds, milliseconds or microseconds.
 tst_sleep 100ms
 -------------------------------------------------------------------------------
 
+Retry a function in limited time
+++++++++++++++++++++++++++++++++
+
+Sometimes LTP test needs retrying a function for many times to get success.
+This achievement makes that possible via keeping it retrying if the return
+value of the function is NOT as we expected. After exceeding a limited time,
+test will break from the retries immediately.
+
+[source,c]
+-------------------------------------------------------------------------------
+# retry function in 1 second
+TST_RETRY_FUNC(FUNC, EXPECTED_RET)
+
+# retry function in N second
+TST_RETRY_FN_EXP_BACKOFF(FUNC, EXPECTED_RET, N)
+-------------------------------------------------------------------------------
+
+[source,sh]
+-------------------------------------------------------------------------------
+# retry function in 1 second
+TST_RETRY_FUNC "FUNC arg1 arg2 ..." "EXPECTED_RET"
+
+# retry function in N second
+TST_RETRY_FN_EXP_BACKOFF "FUNC arg1 arg2 ..." "EXPECTED_RET" "N"
+-------------------------------------------------------------------------------
+
 Checking for integers
 +++++++++++++++++++++
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d49d34..8b38dcd 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -154,6 +154,40 @@ EXPECT_FAIL()
 	fi
 }
 
+TST_RETRY_FN_EXP_BACKOFF()
+{
+	local tst_fun=$1
+	local tst_exp=$2
+	local tst_sec=$(expr $3 \* 1000000)
+	local tst_delay=1
+
+	if [ $# -ne 3 ]; then
+		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects three parameters"
+	fi
+
+	while true; do
+		$tst_fun
+		if [ "$?" = "$tst_exp" ]; then
+			break
+		fi
+
+		if [ $tst_delay -lt $tst_sec ]; then
+			tst_sleep ${tst_delay}us
+			tst_delay=$((tst_delay*2))
+		else
+			tst_brk TBROK "\"$tst_fun\" failed"
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

