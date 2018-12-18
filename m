From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Dec 2018 02:02:16 +0100
Subject: [LTP] [PATCH v3 2/6] shell: Add tst_security.sh helper
In-Reply-To: <20181218010220.2446-1-pvorel@suse.cz>
References: <20181218010220.2446-1-pvorel@suse.cz>
Message-ID: <20181218010220.2446-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It prints info about AppArmor and SELinux and allows to disable it.
This is due some false positives because improper usage or bugs
in AppArmor profiles (e.g. traceroute, dnsmasq).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: some of functions in tst_security.sh are meant to be used
also in tests (when AppArmor and SELinux has different paths).
---
 testcases/lib/tst_security.sh | 124 ++++++++++++++++++++++++++++++++++
 testcases/lib/tst_test.sh     |  17 +++--
 2 files changed, 136 insertions(+), 5 deletions(-)
 create mode 100644 testcases/lib/tst_security.sh

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
new file mode 100644
index 000000000..68b47347f
--- /dev/null
+++ b/testcases/lib/tst_security.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+
+if [ -z "$TST_LIB_LOADED" ]; then
+	echo "please load tst_test.sh first" >&2
+	exit 1
+fi
+
+[ -n "$TST_SECURITY_LOADED" ] && return 0
+TST_SECURITY_LOADED=1
+
+_tst_check_security_modules()
+{
+	local cmd
+	local profiles
+
+	if tst_apparmor_enabled; then
+		tst_res TINFO "AppArmor enabled, this may affect test results. Disable it with TST_DISABLE_APPARMOR=1 (requires super/root)"
+		profiles=
+		for cmd in $TST_NEEDS_CMDS; do
+			tst_apparmor_used_profile $cmd && profiles="$cmd $profiles"
+		done
+		[ -z "$profiles" ] && profiles="none"
+		tst_res TINFO "loaded AppArmor profiles: $profiles"
+	fi
+
+	if tst_selinux_enabled; then
+		tst_res TINFO "SELinux enabled in enforcing mode, this may affect test results. Disable it with TST_DISABLE_SELINUX=1 (requires super/root)"
+		profiles=
+		for cmd in $TST_NEEDS_CMDS; do
+			tst_selinux_used_profile $cmd && profiles="$cmd $profiles"
+		done
+		[ -z "$profiles" ] && profiles="none"
+		tst_res TINFO "loaded SELinux profiles: $profiles"
+	fi
+}
+
+# Detect whether AppArmor profiles are loaded
+# Return 0: profiles loaded, 1: none profile loaded or AppArmor disabled
+tst_apparmor_enabled()
+{
+	local f="/sys/module/apparmor/parameters/enabled"
+	[ -f "$f" ] && [ "$(cat $f)" = "Y" ]
+}
+
+# Detect whether AppArmor profile for command is enforced
+# tst_apparmor_used_profile CMD
+# Return 0: loaded profile for CMD
+# Return 1: no profile CMD
+tst_apparmor_used_profile()
+{
+	[ $# -eq 1 ] && tst_brk TCONF "usage tst_apparmor_used_profile CMD"
+	local cmd="$1"
+	grep -q "$cmd .*(enforce)" /sys/kernel/security/apparmor/profiles 2>/dev/null
+}
+
+# Detect whether SELinux is enabled in enforcing mode
+# Return 0: enabled in enforcing mode
+# Return 1: enabled in permissive mode or disabled
+tst_selinux_enabled()
+{
+	local f="$(_tst_get_enforce)"
+
+	[ -f "$f" ] && [ "$(cat $f)" = "1" ]
+}
+
+# Detect whether SELinux profile for command is enforced
+# tst_selinux_used_profile CMD
+# Return 0: loaded profile for CMD
+# Return 1: profile for CMD not loaded or seinfo not available
+tst_selinux_used_profile()
+{
+	[ $# -eq 1 ] && tst_brk TCONF "usage tst_selinux_used_profile CMD"
+	local cmd="$1"
+
+	if ! tst_cmd_available seinfo; then
+		if [ -z "$seinfo_warn_printed" ]; then
+			tst_res "install seinfo to find used SELinux profiles"
+			export seinfo_warn_printed=1
+		fi
+		return
+	fi
+	seinfo -t 2>/dev/null | grep -q $cmd
+}
+
+# Try disable AppArmor
+# Return 0: AppArmor disabled
+# Return > 0: failed to disable AppArmor
+tst_disable_apparmor()
+{
+	_tst_require_root
+	local f="aa-teardown"
+	local action
+
+	tst_cmd_available $f && { $f; return; }
+	f="/etc/init.d/apparmor"
+	if [ -f "$f" ]; then
+		for action in teardown kill stop; do
+			$f $action >/dev/null 2>&1 && return
+		done
+	fi
+}
+
+# Try disable SELinux
+# Return 0: SELinux disabled
+# Return > 0: failed to disable SELinux
+tst_disable_selinux()
+{
+	_tst_require_root
+	local f="$(_tst_get_enforce)"
+
+	[ -f "$f" ] && cat 0 > $f
+}
+
+# Get SELinux enforce file path
+_tst_get_enforce()
+{
+	local dir="/sys/fs/selinux"
+
+	[ -d "$dir" ] || dir="/selinux"
+	local f="$dir/enforce"
+	[ -f "$f" ] && echo "$f"
+}
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e3770d005..333061028 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -34,6 +34,7 @@ export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
 
 . tst_ansi_color.sh
+. tst_security.sh
 
 # default trap function
 trap "tst_brk TBROK 'test interrupted'" INT
@@ -67,6 +68,7 @@ _tst_do_exit()
 
 	if [ $TST_FAIL -gt 0 ]; then
 		ret=$((ret|1))
+		_tst_check_security_modules
 	fi
 
 	if [ $TST_BROK -gt 0 ]; then
@@ -376,6 +378,11 @@ _tst_setup_timer()
 	_tst_setup_timer_pid=$!
 }
 
+_tst_require_root()
+{
+	[ "$(id -ru)" != 0 ] && tst_brk TCONF "Must be super/root for this test!"
+}
+
 tst_run()
 {
 	local _tst_i
@@ -386,6 +393,7 @@ tst_run()
 	if [ -n "$TST_TEST_PATH" ]; then
 		for _tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
 			case "$_tst_i" in
+			DISABLE_APPARMOR|DISABLE_SELINUX);;
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
@@ -421,11 +429,10 @@ tst_run()
 		tst_brk TBROK "Number of iterations (-i) must be > 0"
 	fi
 
-	if [ "$TST_NEEDS_ROOT" = 1 ]; then
-		if [ "$(id -ru)" != 0 ]; then
-			tst_brk TCONF "Must be super/root for this test!"
-		fi
-	fi
+	[ "$TST_NEEDS_ROOT" = 1 ] && _tst_require_root
+
+	[ "$TST_DISABLE_APPARMOR" = 1 ] && tst_disable_apparmor
+	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
 
 	tst_test_cmds $TST_NEEDS_CMDS
 	tst_test_drivers $TST_NEEDS_DRIVERS
-- 
2.19.2

