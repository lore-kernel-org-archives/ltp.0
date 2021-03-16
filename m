From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Mar 2021 16:05:59 +0100
Subject: [LTP] [PATCH 1/2] IMA: Move check_evmctl to setup,
 add require_evmctl()
Message-ID: <20210316150600.16461-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Helper functions can be reused in other tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_setup.sh | 43 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_tpm.sh   | 33 --------------
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 59a7ffeac..565f0bc3e 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -269,6 +269,49 @@ get_algorithm_digest()
 	echo "$algorithm|$digest"
 }
 
+# check_evmctl REQUIRED_TPM_VERSION
+# return: 0: evmctl is new enough, 1: version older than required (or version < v0.9)
+check_evmctl()
+{
+	local required="$1"
+
+	local r1="$(echo $required | cut -d. -f1)"
+	local r2="$(echo $required | cut -d. -f2)"
+	local r3="$(echo $required | cut -d. -f3)"
+	[ -z "$r3" ] && r3=0
+
+	tst_is_int "$r1" || tst_brk TBROK "required major version not int ($v1)"
+	tst_is_int "$r2" || tst_brk TBROK "required minor version not int ($v2)"
+	tst_is_int "$r3" || tst_brk TBROK "required patch version not int ($v3)"
+
+	tst_check_cmds evmctl || return 1
+
+	local v="$(evmctl --version | cut -d' ' -f2)"
+	[ -z "$v" ] && return 1
+	tst_res TINFO "evmctl version: $v"
+
+	local v1="$(echo $v | cut -d. -f1)"
+	local v2="$(echo $v | cut -d. -f2)"
+	local v3="$(echo $v | cut -d. -f3)"
+	[ -z "$v3" ] && v3=0
+
+	if [ $v1 -lt $r1 ] || [ $v1 -eq $r1 -a $v2 -lt $r2 ] || \
+		[ $v1 -eq $r1 -a $v2 -eq $r2 -a $v3 -lt $r3 ]; then
+		return 1
+	fi
+	return 0
+}
+
+# require_evmctl REQUIRED_TPM_VERSION
+require_evmctl()
+{
+	local required="$1"
+
+	if ! check_evmctl $required; then
+		tst_brk TCONF "evmctl >= $required required"
+	fi
+}
+
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
 if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 1cc34ddda..71083efd8 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -52,39 +52,6 @@ setup()
 	fi
 }
 
-# check_evmctl REQUIRED_TPM_VERSION
-# return: 0: evmctl is new enough, 1: version older than required (or version < v0.9)
-check_evmctl()
-{
-	local required="$1"
-
-	local r1="$(echo $required | cut -d. -f1)"
-	local r2="$(echo $required | cut -d. -f2)"
-	local r3="$(echo $required | cut -d. -f3)"
-	[ -z "$r3" ] && r3=0
-
-	tst_is_int "$r1" || tst_brk TBROK "required major version not int ($v1)"
-	tst_is_int "$r2" || tst_brk TBROK "required minor version not int ($v2)"
-	tst_is_int "$r3" || tst_brk TBROK "required patch version not int ($v3)"
-
-	tst_check_cmds evmctl || return 1
-
-	local v="$(evmctl --version | cut -d' ' -f2)"
-	[ -z "$v" ] && return 1
-	tst_res TINFO "evmctl version: $v"
-
-	local v1="$(echo $v | cut -d. -f1)"
-	local v2="$(echo $v | cut -d. -f2)"
-	local v3="$(echo $v | cut -d. -f3)"
-	[ -z "$v3" ] && v3=0
-
-	if [ $v1 -lt $r1 ] || [ $v1 -eq $r1 -a $v2 -lt $r2 ] || \
-		[ $v1 -eq $r1 -a $v2 -eq $r2 -a $v3 -lt $r3 ]; then
-		return 1
-	fi
-	return 0
-}
-
 # prints major version: 1: TPM 1.2, 2: TPM 2.0
 # or nothing on TPM-bypass (no TPM device)
 # WARNING: Detecting TPM 2.0 can fail due kernel not exporting TPM 2.0 files.
-- 
2.30.1

