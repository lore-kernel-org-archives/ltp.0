From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 28 Aug 2019 13:30:01 +0200
Subject: [LTP] [COMMITTED][PATCH] tst_security.sh: Adjust AppArmor/SELinux
 messages
Message-ID: <20190828113001.15105-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* print info before an attempt to disable AppArmor/SELinux
* print setup tips only if needed (when TST_DISABLE_{APPARMOR,SELINUX} are
set, it does not make sense to print tips how to disable it)
* adjust setup tips messages

+ quiet output of aa-teardown
This suppress "Unloading AppArmor profiles" message
(output of /etc/init.d/apparmor was also suppressed)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_security.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 25e085d3c..7d033bbc5 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -17,7 +17,8 @@ _tst_check_security_modules()
 
 	if tst_apparmor_enabled; then
 		tst_res TINFO "AppArmor enabled, this may affect test results"
-		tst_res TINFO "You can try to disable it with TST_DISABLE_APPARMOR=1 (requires super/root)"
+		[ "$TST_DISABLE_APPARMOR" = 1 ] || \
+			tst_res TINFO "it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)"
 		profiles=
 		for cmd in $TST_NEEDS_CMDS; do
 			tst_apparmor_used_profile $cmd && profiles="$cmd $profiles"
@@ -28,7 +29,9 @@ _tst_check_security_modules()
 
 	if tst_selinux_enabled; then
 		tst_res TINFO "SELinux enabled in enforcing mode, this may affect test results"
-		tst_res TINFO "You can try to disable it with TST_DISABLE_SELINUX=1 (requires super/root)"
+
+		[ "$TST_DISABLE_SELINUX" = 1 ] || \
+			tst_res TINFO "it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)"
 		profiles=
 		for cmd in $TST_NEEDS_CMDS; do
 			tst_selinux_used_profile $cmd && profiles="$cmd $profiles"
@@ -91,11 +94,13 @@ tst_selinux_used_profile()
 # Return > 0: failed to disable AppArmor
 tst_disable_apparmor()
 {
+	tst_res TINFO "trying to disable AppArmor (requires super/root)"
 	_tst_require_root
+
 	local f="aa-teardown"
 	local action
 
-	tst_cmd_available $f && { $f; return; }
+	tst_cmd_available $f && { $f >/dev/null; return; }
 	f="/etc/init.d/apparmor"
 	if [ -f "$f" ]; then
 		for action in teardown kill stop; do
@@ -109,7 +114,9 @@ tst_disable_apparmor()
 # Return > 0: failed to disable SELinux
 tst_disable_selinux()
 {
+	tst_res TINFO "trying to disable SELinux (requires super/root)"
 	_tst_require_root
+
 	local f="$(_tst_get_enforce)"
 
 	[ -f "$f" ] && cat 0 > $f
-- 
2.22.0

