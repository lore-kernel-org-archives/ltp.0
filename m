From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Oct 2017 15:40:39 +0300
Subject: [LTP] [PATCH 1/3] lib: setup rhost TST_TMPDIR if net test sets
	TST_NEEDS_TMPDIR
Message-ID: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_tmpdir() in test_net.sh should be removed when network tests
converted to newer lib.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test.sh     |    2 ++
 testcases/lib/test_net.sh |   12 ++++++++++++
 testcases/lib/tst_test.sh |    2 ++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index d16444e..341c1f0 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -24,6 +24,7 @@
 export LTP_RET_VAL=0
 export TST_COUNT=1
 export TST_LIB_LOADED=1
+export TST_TMPDIR_RHOST=0
 
 . tst_ansi_color.sh
 
@@ -135,6 +136,7 @@ tst_rmdir()
 	if [ -n "$TST_TMPDIR" ]; then
 		cd "$LTPROOT"
 		rm -r "$TST_TMPDIR"
+		[ "$TST_TMPDIR_RHOST" = 1 ] && tst_cleanup_rhost
 	fi
 }
 
diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index a1d68ce..8025582 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -577,6 +577,11 @@ tst_set_sysctl()
 	tst_rhost_run $safe -c "sysctl -qw $add_opt $name=$value"
 }
 
+tst_cleanup_rhost()
+{
+	tst_rhost_run -c "rm -rf $TST_TMPDIR"
+}
+
 # Management Link
 [ -z "$RHOST" ] && TST_USE_NETNS="yes"
 export RHOST="$RHOST"
@@ -669,3 +674,10 @@ export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
 
 # More information about network parameters can be found
 # in the following document: testcases/network/stress/README
+
+if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
+	tst_tmpdir
+	tst_rhost_run -c "mkdir -p $TST_TMPDIR"
+	tst_rhost_run -c "chmod 777 $TST_TMPDIR"
+	export TST_TMPDIR_RHOST=1
+fi
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 9453759..249b054 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -28,6 +28,7 @@ export TST_WARN=0
 export TST_CONF=0
 export TST_COUNT=1
 export TST_ITERATIONS=1
+export TST_TMPDIR_RHOST=0
 
 . tst_ansi_color.sh
 
@@ -49,6 +50,7 @@ tst_do_exit()
 	if [ "$TST_NEEDS_TMPDIR" = 1 -a -n "$TST_TMPDIR" ]; then
 		cd "$LTPROOT"
 		rm -r "$TST_TMPDIR"
+		[ "$TST_TMPDIR_RHOST" = 1 ] && tst_cleanup_rhost
 	fi
 
 	if [ $TST_FAIL -gt 0 ]; then
-- 
1.7.1

