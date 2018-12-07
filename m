From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Dec 2018 13:35:15 +0100
Subject: [LTP] [PATCH v2 5/6] shell: Add tst_security.sh helper
In-Reply-To: <20181207123516.30867-1-pvorel@suse.cz>
References: <20181207123516.30867-1-pvorel@suse.cz>
Message-ID: <20181207123516.30867-6-pvorel@suse.cz>
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
New in this version.
---
 testcases/lib/tst_security.sh | 64 +++++++++++++++++++++++++++++++++++
 testcases/lib/tst_test.sh     | 14 +++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_security.sh

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
new file mode 100644
index 000000000..a40a6d253
--- /dev/null
+++ b/testcases/lib/tst_security.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2016-2018 Petr Vorel <pvorel@suse.cz>
+
+if [ -z "$TST_LIB_LOADED" ]; then
+	echo "please load tst_test.sh first" >&2
+	exit 1
+fi
+
+[ -n "$TST_SECURITY_LOADED" ] && return 0
+TST_SECURITY_LOADED=1
+
+# Detect whether AppArmor profiles are loaded
+# Return 0: profiles loaded, 1: none profile loaded or AppArmor disabled
+tst_apparmor_enabled()
+{
+	local f="/sys/kernel/security/apparmor/profiles"
+	tst_test_cmds cut wc
+	[ -f "$f" ] && [ "$(wc -l $f | cut -d' ' -f1)" -gt 0 ]
+}
+
+# Detect whether SELinux is enabled in enforcing mode
+# Return 0: enabled in enforcing mode
+# Return 1: enabled in permissive mode or disabled
+tst_selinux_enabled()
+{
+	local f="$(_tst_get_enforce)"
+	[ -f "$f" ] && [ "$(cat $f)" = "1" ]
+}
+
+# Try disable AppArmor
+# Return 0: AppArmor disabled
+# Return > 0: failed to disable AppArmor
+tst_disable_apparmor()
+{
+	local f="aa-teardown"
+	local action
+
+	tst_cmd_available $f && { $f; return; }
+
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
+	local f="$(_tst_get_enforce)"
+	[ -f "$f" ] && cat 0 > $f
+}
+
+_tst_get_enforce()
+{
+	local dir="/sys/fs/selinux"
+	[ -d "$dir" ] || dir="/selinux"
+	local f="$dir/enforce"
+	[ -f "$f" ] && echo "$f"
+}
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 1a5d925f9..28d1e9c6d 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -34,6 +34,7 @@ export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
 
 . tst_ansi_color.sh
+. tst_security.sh
 
 # default trap function
 trap "tst_brk TBROK 'test interrupted'" INT
@@ -393,6 +394,7 @@ tst_run()
 			NEEDS_DRIVERS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
+			SECURITY_WARN|DISABLE_APPARMOR|DISABLE_SELINUX);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
@@ -421,12 +423,22 @@ tst_run()
 		tst_brk TBROK "Number of iterations (-i) must be > 0"
 	fi
 
-	if [ "$TST_NEEDS_ROOT" = 1 ]; then
+	if [ "$TST_NEEDS_ROOT" = 1 ] || [ "$TST_DISABLE_APPARMOR" = 1 ] || [ "$TST_DISABLE_SELINUX" = 1 ]; then
 		if [ "$(id -ru)" != 0 ]; then
 			tst_brk TCONF "Must be super/root for this test!"
 		fi
 	fi
 
+	[ "$TST_DISABLE_APPARMOR" = 1 ] && tst_disable_apparmor
+	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
+
+	if [ "$TST_SECURITY_WARN" = 1 ]; then
+		tst_apparmor_enabled && \
+			tst_res TINFO "AppArmor enabled, this may affect test results. Disable it with TST_DISABLE_APPARMOR=1 (requires super/root)"
+		tst_selinux_enabled && \
+			tst_res TINFO "SELinux enabled, this may affect test results. Disable it with TST_DISABLE_SELINUX=1 (requires super/root)"
+	fi
+
 	tst_test_cmds $TST_NEEDS_CMDS
 	tst_test_drivers $TST_NEEDS_DRIVERS
 
-- 
2.19.2

