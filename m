From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  9 Oct 2019 08:16:19 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Add public tst_test_root command
In-Reply-To: <20191009061619.48677-1-lkml@jv-coder.de>
References: <20191009061619.48677-1-lkml@jv-coder.de>
Message-ID: <20191009061619.48677-3-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

If a test requires root only under certan circumstances, TST_NEEDS_ROOT
is not sufficient, because it always requires root.
---
 testcases/lib/tst_test.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c70a5abbe..07712670d 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -326,6 +326,13 @@ tst_check_cmds()
 	return 0
 }
 
+tst_test_root()
+{
+	if [ "$(id -ru)" != 0 ]; then
+		tst_brk TCONF "Must be super/root for this test!"
+	fi
+}
+
 tst_test_drivers()
 {
 	[ $# -eq 0 ] && return 0
@@ -389,13 +396,6 @@ _tst_setup_timer()
 	_tst_setup_timer_pid=$!
 }
 
-_tst_require_root()
-{
-	if [ "$(id -ru)" != 0 ]; then
-		tst_brk TCONF "Must be super/root for this test!"
-	fi
-}
-
 _tst_find_module()
 {
 	local _tst_module=$1
@@ -469,7 +469,7 @@ tst_run()
 		tst_brk TBROK "Number of iterations (-i) must be > 0"
 	fi
 
-	[ "$TST_NEEDS_ROOT" = 1 ] && _tst_require_root
+	[ "$TST_NEEDS_ROOT" = 1 ] && tst_test_root
 
 	[ "$TST_DISABLE_APPARMOR" = 1 ] && tst_disable_apparmor
 	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
-- 
2.20.1

