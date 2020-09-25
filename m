From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Sep 2020 20:50:33 +0200
Subject: [LTP] [PATCH v2 3/4] ima_tpm.sh: Fix calculating boot aggregate
In-Reply-To: <20200925185034.24155-1-pvorel@suse.cz>
References: <20200925185034.24155-1-pvorel@suse.cz>
Message-ID: <20200925185034.24155-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for TPM 2.0 or kernel >= v5.8-rc1:
6f1a1d103b48 ima: ("Switch to ima_hash_algo for boot aggregate")

Test still fails with TPM 2.0 on kernel < v5.8-rc1.

Test was failing, because it expect SHA1 hash, but for TPM 2.0 is
now used IMA default hash algorithm (by default default SHA256).
This is similar for entries in IMA measurement list so we can reuse
already existing code.

Reading other algorithms than sha1 or TPM 2.0 requires evmctl >= 1.3.
Although evmctl is recommended, to support older distros, when
event log (/sys/kernel/security/tpm0/binary_bios_measurements) is not
exported and only sha1 used, get boot agregate with old our legacy
ima_boot_aggregate.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_tpm.sh   | 102 ++++++++++++++----
 1 file changed, 84 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index dc958eb5c..1fccc844b 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -7,38 +7,104 @@
 # Verify the boot and PCR aggregates.
 
 TST_CNT=2
-TST_NEEDS_CMDS="awk cut ima_boot_aggregate"
+TST_NEEDS_CMDS="awk cut"
+TST_SETUP="setup"
 
 . ima_setup.sh
 
+EVMCTL_REQUIRED='1.3'
+ERRMSG_EVMCTL="install evmctl >= $EVMCTL_REQUIRED"
+
+setup()
+{
+	local line tmp
+
+	read line < $ASCII_MEASUREMENTS
+	if tmp=$(get_algorithm_digest "$line"); then
+		ALGORITHM=$(echo "$tmp" | cut -d'|' -f1)
+		DIGEST=$(echo "$tmp" | cut -d'|' -f2)
+	else
+		tst_res TBROK "failed to get algorithm/digest: $tmp"
+	fi
+	tst_res TINFO "used algorithm: $ALGORITHM"
+
+	if ! check_evmctl $EVMCTL_REQUIRED; then
+		MISSING_EVMCTL=1
+		if [ "$ALGORITHM" != "sha1" ]; then
+			tst_brk TCONF "algorithm not sha1 ($ALGORITHM), $ERRMSG_EVMCTL"
+		fi
+	fi
+}
+
+# check_evmctl REQUIRED_TPM_VERSION
+# return: 0: evmctl is new enough, 1: too old version
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
+	tst_res TINFO "evmctl version: $v"
+
+	local v1="$(echo $v | cut -d. -f1)"
+	local v2="$(echo $v | cut -d. -f2)"
+	local v3="$(echo $v | cut -d. -f3)"
+	[ -z "$v3" ] && v3=0
+
+	if [ $v1 -lt $r1 -o $v2 -lt $r2 -o $v3 -lt $r3 ]; then
+		tst_res TCONF "evmctl >= $required required ($v)"
+		return 1
+	fi
+	return 0
+}
+
 test1()
 {
 	tst_res TINFO "verify boot aggregate"
 
-	local zero="0000000000000000000000000000000000000000"
 	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
-	local ima_measurements="$ASCII_MEASUREMENTS"
-	local boot_aggregate boot_hash line
+	local cmd="evmctl ima_boot_aggregate"
+	local boot_aggregate cmd zero
 
-	# IMA boot aggregate
-	read line < $ima_measurements
-	boot_hash=$(echo $line | awk '{print $(NF-1)}' | cut -d':' -f2)
+	if [ "$MISSING_EVMCTL" = 1 ]; then
+		if [ -f "$tpm_bios" ]; then
+			tst_res TCONF "missing $tpm_bios, $ERRMSG_EVMCTL"
+			return
+		fi
+		tst_check_cmds ima_boot_aggregate || return
+		cmd="ima_boot_aggregate -f $tpm_bios"
+	fi
+	tst_res TINFO "using command: $cmd"
 
-	if [ ! -f "$tpm_bios" ]; then
-		tst_res TINFO "TPM Hardware Support not enabled in kernel or no TPM chip found"
+	boot_aggregate=$($cmd | grep "$ALGORITHM:" | cut -d':' -f2)
+	if [ -z "$boot_aggregate" ]; then
+		tst_res TINFO "TPM hardware support not enabled in kernel or no TPM chip found"
 
-		if [ "$boot_hash" = "$zero" ]; then
-			tst_res TPASS "bios boot aggregate is 0"
+		zero=$(echo $DIGEST | awk '{gsub(/./, "0")}; {print}')
+		if [ "$DIGEST" = "$zero" ]; then
+			tst_res TPASS "bios boot aggregate is $zero"
 		else
-			tst_res TFAIL "bios boot aggregate is not 0"
+			tst_res TFAIL "bios boot aggregate is not $zero ($DIGEST)"
 		fi
+		return
+	fi
+
+	tst_res TINFO "IMA boot aggregate: '$boot_aggregate'"
+
+	if [ "$DIGEST" = "$boot_aggregate" ]; then
+		tst_res TPASS "bios boot aggregate matches IMA boot aggregate"
 	else
-		boot_aggregate=$(ima_boot_aggregate -f $tpm_bios | grep "sha1:" | cut -d':' -f2)
-		if [ "$boot_hash" = "$boot_aggregate" ]; then
-			tst_res TPASS "bios aggregate matches IMA boot aggregate"
-		else
-			tst_res TFAIL "bios aggregate does not match IMA boot aggregate"
-		fi
+		tst_res TFAIL "bios boot aggregate does not match IMA boot aggregate ($DIGEST)"
 	fi
 }
 
-- 
2.28.0

