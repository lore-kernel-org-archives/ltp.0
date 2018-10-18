From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 18 Oct 2018 15:52:10 +0300
Subject: [LTP] [PATCH] lib/tst_test.sh: setup timeout per test run for the
	shell tests
Message-ID: <1539867130-14299-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use LTP_TIMEOUT_MUL environment variable, similar to what we have
in the C library.

Basically, the patch puts the child process with kill command to
the background to signal the test process group processes after
the certain timeout, which is controlled by LTP_TIMEOUT_MUL.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_test.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 7a41309..a7aa608 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -42,6 +42,11 @@ _tst_do_exit()
 {
 	local ret=0
 
+	if [ -n "$_tst_setup_timer_pid" ]; then
+		kill $_tst_setup_timer_pid
+		wait $_tst_setup_timer_pid 2>/dev/null
+	fi
+
 	if [ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" -a \
 	     -z "$TST_NO_CLEANUP" ]; then
 		$TST_CLEANUP
@@ -347,6 +352,23 @@ _tst_rescmp()
 	fi
 }
 
+
+_tst_setup_timer()
+{
+	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
+
+	local sec=$((300 * LTP_TIMEOUT_MUL))
+	local h=$((sec / 3600))
+	local m=$((sec / 60 % 60))
+	local s=$((sec % 60))
+	local pid=$$
+
+	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
+
+	sleep $sec && kill -INT -$pid &
+	_tst_setup_timer_pid=$!
+}
+
 tst_run()
 {
 	local _tst_i
@@ -406,6 +428,8 @@ tst_run()
 			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
 	fi
 
+	_tst_setup_timer
+
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
 		if [ -z "$TMPDIR" ]; then
 			export TMPDIR="/tmp"
-- 
1.7.1

