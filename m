From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 26 Feb 2019 19:23:32 +0300
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: don't treat TWARN/TCONF as
	failure in tst_netload()
Message-ID: <1551198213-10024-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Report TWARN and don't stop the test in that case.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 3148643..7625c51 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -573,7 +573,7 @@ tst_netload()
 	[ "$setup_srchost" = 1 ] && s_opts="${s_opts}-S $hostopt "
 
 	local expect_ret=0
-	[ "$expect_res" != "pass" ] && expect_ret=1
+	[ "$expect_res" != "pass" ] && expect_ret=3
 
 	tst_rhost_run -c "pkill -9 netstress\$"
 	s_opts="${cs_opts}${s_opts}-R $s_replies -B $TST_TMPDIR"
@@ -590,26 +590,37 @@ tst_netload()
 	c_opts="${cs_opts}${c_opts}-a $c_num -r $c_requests -d $rfile -g $port"
 
 	tst_res_ TINFO "run client 'netstress -l $c_opts'"
-	netstress -l $c_opts > tst_netload.log 2>&1 || ret=1
+	netstress -l $c_opts > tst_netload.log 2>&1 || ret=$?
 	tst_rhost_run -c "pkill -9 netstress\$"
 
-	if [ "$expect_ret" -ne "$ret" ]; then
+	if [ "$expect_ret" -ne 0 ]; then
+		if [ $((ret & expect_ret)) -ne 0 ]; then
+			tst_res_ TPASS "netstress failed as expected"
+		else
+			tst_res_ TFAIL "unexpected pass, ret is $ret"
+		fi
+		return $ret
+	fi
+
+	if [ "$ret" -ne 0 ]; then
 		tst_dump_rhost_cmd
 		cat tst_netload.log
-		tst_brk_ TFAIL "expected '$expect_res' but ret: '$ret'"
+		[ $((ret & 3)) -ne 0 ] && \
+			tst_brk_ TFAIL "expected '$expect_res' but ret: '$ret'"
+		[ $((ret & 32)) -ne 0 ] && \
+			tst_brk_ TCONF "not supported configuration"
+		[ $((ret & 4)) -ne 0 ] && \
+			tst_res_ TWARN "netstress has warnings"
 	fi
 
-	if [ "$ret" -eq 0 ]; then
-		if [ ! -f $rfile ]; then
-			tst_dump_rhost_cmd
-			cat tst_netload.log
-			tst_brk_ TFAIL "can't read $rfile"
-		fi
-		tst_res_ TPASS "netstress passed, time spent '$(cat $rfile)' ms"
-	else
-		tst_res_ TPASS "netstress failed as expected"
+	if [ ! -f $rfile ]; then
+		tst_dump_rhost_cmd
+		cat tst_netload.log
+		tst_brk_ TFAIL "can't read $rfile"
 	fi
 
+	tst_res_ TPASS "netstress passed, time spent '$(cat $rfile)' ms"
+
 	return $ret
 }
 
-- 
1.7.1

