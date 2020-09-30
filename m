From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 18:02:13 +0200
Subject: [LTP] [PATCH v4 3/4] ima_tpm.sh: Fix calculating boot aggregate
In-Reply-To: <20200930160214.29358-1-pvorel@suse.cz>
References: <20200930160214.29358-1-pvorel@suse.cz>
Message-ID: <20200930160214.29358-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for TPM 2.0 or kernel >= v5.8-rc1:
6f1a1d103b48 ima: ("Switch to ima_hash_algo for boot aggregate")

Test still fails with newer TPM 2.0 on kernel < v5.8-rc1.

Test was failing, because it expect SHA1 (we ignore MD5) hash, but for TPM 2.0
is now used IMA default hash algorithm (by default default SHA256).
This is similar for entries in IMA measurement list so we can reuse
already existing code.

Reading other algorithms than SHA1 or support TPM 2.0 requires evmctl
>= 1.3.1 (1.3 would also work for test1, but will be required for test2).

Although recent evmctl is recommended, to support older kernels and TPMs
which supports only SHA1, get boot aggregate with old our legacy
ima_boot_aggregate.c.

Also fixed test without TPM device (when IMA TPM-bypass is tested)
as some TPM 2.0 devices does not export event log
(/sys/kernel/security/tpm0/binary_bios_measurements).
This does not require evmctl at all.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v3->v4:
* require 1.3.1 instead of 1.3 (simplification)

 .../security/integrity/ima/tests/ima_tpm.sh   | 153 +++++++++++++++---
 1 file changed, 131 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index dc958eb5c..ce35a8e27 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -7,41 +7,150 @@
 # Verify the boot and PCR aggregates.
 
 TST_CNT=2
-TST_NEEDS_CMDS="awk cut ima_boot_aggregate"
+TST_NEEDS_CMDS="awk cut"
+TST_SETUP="setup"
 
 . ima_setup.sh
 
-test1()
-{
-	tst_res TINFO "verify boot aggregate"
+EVMCTL_REQUIRED='1.3.1'
+ERRMSG_EVMCTL="install evmctl >= $EVMCTL_REQUIRED"
 
-	local zero="0000000000000000000000000000000000000000"
-	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
-	local ima_measurements="$ASCII_MEASUREMENTS"
-	local boot_aggregate boot_hash line
+setup()
+{
+	local line tmp
 
-	# IMA boot aggregate
-	read line < $ima_measurements
-	boot_hash=$(echo $line | awk '{print $(NF-1)}' | cut -d':' -f2)
+	read line < $ASCII_MEASUREMENTS
+	if tmp=$(get_algorithm_digest "$line"); then
+		ALGORITHM=$(echo "$tmp" | cut -d'|' -f1)
+		DIGEST=$(echo "$tmp" | cut -d'|' -f2)
+	else
+		tst_res TBROK "failed to get algorithm/digest: $tmp"
+	fi
+	tst_res TINFO "used algorithm: $ALGORITHM"
 
-	if [ ! -f "$tpm_bios" ]; then
-		tst_res TINFO "TPM Hardware Support not enabled in kernel or no TPM chip found"
+	TPM_VERSION="$(get_tpm_version)"
+	if [ "$TPM_VERSION" ]; then
+		tst_res TINFO "TMP major version: $TPM_VERSION"
+	fi
 
-		if [ "$boot_hash" = "$zero" ]; then
-			tst_res TPASS "bios boot aggregate is 0"
-		else
-			tst_res TFAIL "bios boot aggregate is not 0"
+	if ! check_evmctl $EVMCTL_REQUIRED; then
+		if [ "$ALGORITHM" != "sha1" ]; then
+			tst_brk TCONF "algorithm not sha1 ($ALGORITHM), $ERRMSG_EVMCTL"
 		fi
+		MISSING_EVMCTL=1
+	fi
+}
+
+# check_evmctl REQUIRED_TPM_VERSION
+# return: 0: evmctl is new enough, 1: too old version (or version > v0.9)
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
+# prints major version 1: TPM 1.2, 2: TPM 2.0
+# or nothing when version not detected (no TPM device)
+get_tpm_version()
+{
+	if [ -f /sys/class/tpm/tpm0/tpm_version_major ]; then
+		cat /sys/class/tpm/tpm0/tpm_version_major
+		return
+	fi
+
+	if [ -f /sys/class/tpm/tpm0/device/caps -o \
+		-f /sys/class/misc/tpm0/device/caps ]; then
+		echo 1
+		return
+	fi
+
+	if [ ! -d /sys/class/tpm/tpm0/ -a ! -d /sys/class/misc/tpm0/ ]; then
+		return
+	fi
+
+	tst_check_cmds dmesg || return
+	if dmesg | grep -q '1\.2 TPM (device-id'; then
+		echo 1
+	elif dmesg | grep -q '2\.0 TPM (device-id'; then
+		echo 2
+	fi
+}
+
+test1_virtual_tpm()
+{
+	local zero=$(echo $DIGEST | awk '{gsub(/./, "0")}; {print}')
+
+	tst_res TINFO "TPM hardware support not enabled in kernel or no TPM chip found, testing TPM-bypass"
+
+	if [ "$DIGEST" = "$zero" ]; then
+		tst_res TPASS "bios boot aggregate is $zero"
 	else
-		boot_aggregate=$(ima_boot_aggregate -f $tpm_bios | grep "sha1:" | cut -d':' -f2)
-		if [ "$boot_hash" = "$boot_aggregate" ]; then
-			tst_res TPASS "bios aggregate matches IMA boot aggregate"
-		else
-			tst_res TFAIL "bios aggregate does not match IMA boot aggregate"
+		tst_res TFAIL "bios boot aggregate is not $zero ($DIGEST)"
+	fi
+}
+
+test1_hw_tpm()
+{
+	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
+	local cmd="evmctl ima_boot_aggregate"
+	local boot_aggregate
+
+	if [ "$MISSING_EVMCTL" = 1 ]; then
+		if [ ! -f "$tpm_bios" ]; then
+			tst_res TCONF "missing $tpm_bios, $ERRMSG_EVMCTL"
+			return
 		fi
+		tst_check_cmds ima_boot_aggregate || return
+		cmd="ima_boot_aggregate -f $tpm_bios"
+	fi
+	tst_res TINFO "using command: $cmd"
+
+	boot_aggregate=$($cmd | grep "$ALGORITHM:" | cut -d':' -f2)
+	if [ -z "$boot_aggregate" ]; then
+		tst_res TBROK "failed to get boot aggregate"
+		return
+	fi
+	tst_res TINFO "IMA boot aggregate: '$boot_aggregate'"
+
+	if [ "$DIGEST" = "$boot_aggregate" ]; then
+		tst_res TPASS "bios boot aggregate matches IMA boot aggregate"
+	else
+		tst_res TFAIL "bios boot aggregate does not match IMA boot aggregate ($DIGEST)"
 	fi
 }
 
+test1()
+{
+	tst_res TINFO "verify boot aggregate"
+
+	[ -z "$TPM_VERSION" ] && test1_virtual_tpm || test1_hw_tpm
+}
+
 # Probably cleaner to programmatically read the PCR values directly
 # from the TPM, but that would require a TPM library. For now, use
 # the PCR values from /sys/devices.
-- 
2.28.0

