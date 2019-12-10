From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 10 Dec 2019 09:04:18 +0100
Subject: [LTP] [PATCH v4 2/3] tst_test.sh: Make public tst_require_root
 command public
In-Reply-To: <20191210080419.128773-1-lkml@jv-coder.de>
References: <20191210080419.128773-1-lkml@jv-coder.de>
Message-ID: <20191210080419.128773-3-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

If a test requires root only under certain circumstances, TST_NEEDS_ROOT
is not sufficient, because it always requires root.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 doc/test-writing-guidelines.txt |  3 ++-
 testcases/lib/tst_net.sh        | 12 ++----------
 testcases/lib/tst_security.sh   |  4 ++--
 testcases/lib/tst_test.sh       |  4 ++--
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 3360f0920..d0c49dc9c 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2118,7 +2118,8 @@ simply by setting right '$TST_NEEDS_FOO'.
 [options="header"]
 |=============================================================================
 | Variable name      | Action done
-| 'TST_NEEDS_ROOT'   | Exit the test with 'TCONF' unless executed under root
+| 'TST_NEEDS_ROOT'   | Exit the test with 'TCONF' unless executed under root.
+|                    | Alternatively the tst_require_root command can be used
 | 'TST_NEEDS_TMPDIR' | Create test temporary directory and cd into it.
 | 'TST_NEEDS_DEVICE' | Prepare test temporary device, the path to testing
                        device is stored in '$TST_DEVICE' variable.
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 59ceb3352..dd0c712c3 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -97,14 +97,6 @@ tst_brk_()
 {
 	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
 }
-tst_require_root_()
-{
-	if [ -z "$TST_USE_LEGACY_API" ]; then
-		_tst_require_root
-	else
-		tst_require_root
-	fi
-}
 
 init_ltp_netspace()
 {
@@ -112,7 +104,7 @@ init_ltp_netspace()
 
 	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
 		tst_require_cmds ip
-		tst_require_root_
+		tst_require_root
 
 		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
 		pid="$(ROD ns_create net,mnt)"
@@ -577,7 +569,7 @@ tst_del_ipaddr()
 tst_restore_ipaddr()
 {
 	tst_require_cmds ip
-	tst_require_root_
+	tst_require_root
 
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 7d033bbc5..af7c81bb5 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -95,7 +95,7 @@ tst_selinux_used_profile()
 tst_disable_apparmor()
 {
 	tst_res TINFO "trying to disable AppArmor (requires super/root)"
-	_tst_require_root
+	tst_require_root
 
 	local f="aa-teardown"
 	local action
@@ -115,7 +115,7 @@ tst_disable_apparmor()
 tst_disable_selinux()
 {
 	tst_res TINFO "trying to disable SELinux (requires super/root)"
-	_tst_require_root
+	tst_require_root
 
 	local f="$(_tst_get_enforce)"
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index afee6aac5..c93ab7dbe 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -454,7 +454,7 @@ _tst_setup_timer()
 	_tst_setup_timer_pid=$!
 }
 
-_tst_require_root()
+tst_require_root()
 {
 	if [ "$(id -ru)" != 0 ]; then
 		tst_brk TCONF "Must be super/root for this test!"
@@ -529,7 +529,7 @@ tst_run()
 		tst_brk TBROK "Number of iterations (-i) must be > 0"
 	fi
 
-	[ "$TST_NEEDS_ROOT" = 1 ] && _tst_require_root
+	[ "$TST_NEEDS_ROOT" = 1 ] && tst_require_root
 
 	[ "$TST_DISABLE_APPARMOR" = 1 ] && tst_disable_apparmor
 	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
-- 
2.20.1

