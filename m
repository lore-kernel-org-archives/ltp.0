From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Jan 2019 17:20:07 +0100
Subject: [LTP] [PATCH v3 2/6] shell: Add tst_security.sh helper
In-Reply-To: <20181218010220.2446-3-pvorel@suse.cz>
References: <20181218010220.2446-1-pvorel@suse.cz>
 <20181218010220.2446-3-pvorel@suse.cz>
Message-ID: <20190123162007.GA29183@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I decided to print warning on all TBROK/TCONF/TFAIL/TWARN (originally it was only on TFAIL).
This is needed for dnsmasq tests, which TBROK due AppArmor profile.

And split long messages into 2 (besides obvious fixes reported by Alexey).

Kind regards,
Petr

Diff of this commit with posted version:

diff --git testcases/lib/tst_security.sh testcases/lib/tst_security.sh
index 2c8c30f42..25e085d3c 100644
--- testcases/lib/tst_security.sh
+++ testcases/lib/tst_security.sh
@@ -16,7 +16,8 @@ _tst_check_security_modules()
 	local profiles
 
 	if tst_apparmor_enabled; then
-		tst_res TINFO "AppArmor enabled, this may affect test results. Disable it with TST_DISABLE_APPARMOR=1 (requires super/root)"
+		tst_res TINFO "AppArmor enabled, this may affect test results"
+		tst_res TINFO "You can try to disable it with TST_DISABLE_APPARMOR=1 (requires super/root)"
 		profiles=
 		for cmd in $TST_NEEDS_CMDS; do
 			tst_apparmor_used_profile $cmd && profiles="$cmd $profiles"
@@ -26,7 +27,8 @@ _tst_check_security_modules()
 	fi
 
 	if tst_selinux_enabled; then
-		tst_res TINFO "SELinux enabled in enforcing mode, this may affect test results. Disable it with TST_DISABLE_SELINUX=1 (requires super/root)"
+		tst_res TINFO "SELinux enabled in enforcing mode, this may affect test results"
+		tst_res TINFO "You can try to disable it with TST_DISABLE_SELINUX=1 (requires super/root)"
 		profiles=
 		for cmd in $TST_NEEDS_CMDS; do
 			tst_selinux_used_profile $cmd && profiles="$cmd $profiles"
diff --git testcases/lib/tst_test.sh testcases/lib/tst_test.sh
index 333061028..e69301e54 100644
--- testcases/lib/tst_test.sh
+++ testcases/lib/tst_test.sh
@@ -68,7 +68,6 @@ _tst_do_exit()
 
 	if [ $TST_FAIL -gt 0 ]; then
 		ret=$((ret|1))
-		_tst_check_security_modules
 	fi
 
 	if [ $TST_BROK -gt 0 ]; then
@@ -83,6 +82,10 @@ _tst_do_exit()
 		ret=$((ret|32))
 	fi
 
+	if [ $TST_BROK -gt 0 -o $TST_CONF -gt 0 -o $TST_FAIL -gt 0 -o $TST_WARN -gt 0 ]; then
+		_tst_check_security_modules
+	fi
+
 	echo
 	echo "Summary:"
 	echo "passed   $TST_PASS"
