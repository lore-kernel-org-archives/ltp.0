From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 18:02:14 +0200
Subject: [LTP] [PATCH v4 4/4] ima_tpm.sh: Fix calculating PCR aggregate
In-Reply-To: <20200930160214.29358-1-pvorel@suse.cz>
References: <20200930160214.29358-1-pvorel@suse.cz>
Message-ID: <20200930160214.29358-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for TPM 2.0 and support more evmctl versions.

Because exporting PCR registers for TPM 2.0 has not been upstreamed [1],
we use user space code, which requires evmctl >= 1.3.1 and tsspcrread.
Using evmctl allows to test for TPM devices which does not export event
log (/sys/kernel/security/tpm0/binary_bios_measurements).

For TPM 1.2 read tpm0 device pcrs file from kernel. (tss1pcrread could
be also used, but it's not yet packaged by distros.)

For old kernels which use SHA1/MD5, any evmctl version is required (evmctl
ima_measurement was introduced in very old v0.7), but
* newer sysctl path /sys/class/tpm/tpm0/device/pcrs requires evmctl 1.1
* using ima_policy=tcb requires 1.3.1 due --ignore-violations

We now support output format of ima_measurement command for various
evmctl versions:
* 1.3: "sha256: TPM PCR-10:" (or other algorithm, e.g. "sha1:")
* 1.1-1.2.1: "HW PCR-10:" (the only previously supported format)
* 0.7-1.0: "PCR-10:"

NOTE: we ignore evmctl failure for evmctl < 1.3.1 (missing --ignore-violations,
also evmctl < 1.1 fails with "PCRAgg does not match PCR-10")

[1] https://patchwork.kernel.org/patch/11759729/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v3->v4:
* use --ignore-violations if evmctl >= 1.3.1 available
* check error only for 1.3.1, for others check only the result
* check for ima_policy=tcb (or ima_tcb) and require 1.3.1 if used
(to get --ignore-violations)
 .../security/integrity/ima/tests/ima_setup.sh |  14 +-
 .../security/integrity/ima/tests/ima_tpm.sh   | 151 +++++++++++++-----
 2 files changed, 118 insertions(+), 47 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 83ea62d4f..b801c4371 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -93,7 +93,7 @@ require_ima_policy_content()
 	fi
 }
 
-require_ima_policy_cmdline()
+check_ima_policy_cmdline()
 {
 	local policy="$1"
 	local i
@@ -101,10 +101,18 @@ require_ima_policy_cmdline()
 	grep -q "ima_$policy" /proc/cmdline && return
 	for i in $(cat /proc/cmdline); do
 		if echo "$i" | grep -q '^ima_policy='; then
-			echo "$i" | grep -q -e "|[ ]*$policy" -e "$policy[ ]*|" -e "=$policy" && return
+			echo "$i" | grep -q -e "|[ ]*$policy" -e "$policy[ ]*|" -e "=$policy" && return 0
 		fi
 	done
-	tst_brk TCONF "IMA measurement tests require builtin IMA $policy policy (e.g. ima_policy=$policy kernel parameter)"
+	return 1
+}
+
+require_ima_policy_cmdline()
+{
+	local policy="$1"
+
+	check_ima_policy_cmdline $policy || \
+		tst_brk TCONF "IMA measurement tests require builtin IMA $policy policy (e.g. ima_policy=$policy kernel parameter)"
 }
 
 mount_helper()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index ce35a8e27..43d330802 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -13,7 +13,8 @@ TST_SETUP="setup"
 . ima_setup.sh
 
 EVMCTL_REQUIRED='1.3.1'
-ERRMSG_EVMCTL="install evmctl >= $EVMCTL_REQUIRED"
+ERRMSG_EVMCTL="=> install evmctl >= $EVMCTL_REQUIRED"
+ERRMSG_TPM="TPM hardware support not enabled in kernel or no TPM chip found"
 
 setup()
 {
@@ -101,11 +102,91 @@ get_tpm_version()
 	fi
 }
 
+read_pcr_tpm1()
+{
+	local pcr_path="/sys/class/tpm/tpm0/device/pcrs"
+	local evmctl_required="1.1"
+	local pcr hash
+
+	if [ ! -f "$pcrs_path" ]; then
+		pcrs_path="/sys/class/misc/tpm0/device/pcrs"
+	elif ! check_evmctl $evmctl_required; then
+		tst_res TCONF "evmctl >= $evmctl_required required"
+		return 1
+	fi
+
+	if [ ! -f "$pcr_path" ]; then
+		tst_res TCONF "missing PCR file $pcrs_path ($ERRMSG_TPM)"
+		return
+	fi
+
+	while read line; do
+		pcr="$(echo $line | cut -d':' -f1)"
+		hash="$(echo $line | cut -d':' -f2 | awk '{ gsub (" ", "", $0); print tolower($0) }')"
+		echo "$pcr: $hash"
+	done < $pcr_path
+}
+
+# NOTE: TPM 1.2 would require to use tss1pcrread which is not fully adopted
+# by distros yet.
+read_pcr_tpm2()
+{
+	local pcrmax=23
+	local pcrread="tsspcrread -halg $ALGORITHM"
+	local i pcr
+
+	tst_check_cmds tsspcrread || return 1
+
+	for i in $(seq 0 $pcrmax); do
+		pcr=$($pcrread -ha "$i" -ns)
+		if [ $? -ne 0 ]; then
+			tst_brk TBROK "tsspcrread failed: $pcr"
+		fi
+		printf "PCR-%02d: %s\n" $i "$pcr"
+	done
+}
+
+get_pcr10_aggregate()
+{
+	local params pcr
+	local msg="$ERRMSG_EVMCTL"
+	local res=TCONF
+
+	if [ -z "$MISSING_EVMCTL" ]; then
+		params="--ignore-violations"
+		msg=
+		res=TFAIL
+	elif check_ima_policy_cmdline "tcb"; then
+		tst_res TCONF "using builtin IMA TCB policy $ERRMSG_EVMCTL"
+		return
+	fi
+
+	evmctl -v ima_measurement $params $BINARY_MEASUREMENTS > hash.txt 2>&1
+	if [ $? -ne 0 -a -z "$MISSING_EVMCTL" ]; then
+		tst_res TFAIL "evmctl failed $ERRMSG_EVMCTL"
+		tst_res TINFO "hash file:"
+		cat hash.txt >&2
+		return
+	fi
+
+	pcr=$(grep -E "^($ALGORITHM: )*PCRAgg.*:" hash.txt \
+		| awk '{print $NF}')
+
+	if [ -z "$pcr" ]; then
+		tst_res $res "failed to find aggregate PCR-10 $msg"
+		tst_res TINFO "hash file:"
+		cat hash.txt >&2
+		return
+	fi
+
+	echo "$pcr"
+}
+
 test1_virtual_tpm()
 {
 	local zero=$(echo $DIGEST | awk '{gsub(/./, "0")}; {print}')
 
-	tst_res TINFO "TPM hardware support not enabled in kernel or no TPM chip found, testing TPM-bypass"
+	tst_res TINFO "$ERRMSG_TPM, testing TPM-bypass"
 
 	if [ "$DIGEST" = "$zero" ]; then
 		tst_res TPASS "bios boot aggregate is $zero"
@@ -122,7 +203,7 @@ test1_hw_tpm()
 
 	if [ "$MISSING_EVMCTL" = 1 ]; then
 		if [ ! -f "$tpm_bios" ]; then
-			tst_res TCONF "missing $tpm_bios, $ERRMSG_EVMCTL"
+			tst_res TCONF "missing $tpm_bios $ERRMSG_EVMCTL"
 			return
 		fi
 		tst_check_cmds ima_boot_aggregate || return
@@ -151,57 +232,39 @@ test1()
 	[ -z "$TPM_VERSION" ] && test1_virtual_tpm || test1_hw_tpm
 }
 
-# Probably cleaner to programmatically read the PCR values directly
-# from the TPM, but that would require a TPM library. For now, use
-# the PCR values from /sys/devices.
-validate_pcr()
+test2()
 {
-	tst_res TINFO "verify PCR (Process Control Register)"
+	local hash pcr_aggregate
 
-	local dev_pcrs="$1"
-	local pcr hash aggregate_pcr
+	tst_res TINFO "verify PCR values"
 
-	aggregate_pcr="$(evmctl -v ima_measurement $BINARY_MEASUREMENTS 2>&1 | \
-		grep 'HW PCR-10:' | awk '{print $3}')"
-	if [ -z "$aggregate_pcr" ]; then
-		tst_res TFAIL "failed to get PCR-10"
-		return 1
+	if [ -z "$TPM_VERSION" ]; then
+		tst_brk TCONF "TMP version not detected ($ERRMSG_TPM)"
 	fi
 
-	while read line; do
-		pcr="$(echo $line | cut -d':' -f1)"
-		if [ "$pcr" = "PCR-10" ]; then
-			hash="$(echo $line | cut -d':' -f2 | awk '{ gsub (" ", "", $0); print tolower($0) }')"
-			[ "$hash" = "$aggregate_pcr" ]
-			return $?
-		fi
-	done < $dev_pcrs
-	return 1
-}
-
-test2()
-{
-	tst_res TINFO "verify PCR values"
-	tst_check_cmds evmctl || return
+	if [ "$ALGORITHM" = "sha1" -a "$MISSING_EVMCTL" = 1 ]; then
+		tst_check_cmds evmctl || return 1
+	fi
 
-	tst_res TINFO "evmctl version: $(evmctl --version)"
+	read_pcr_tpm$TPM_VERSION > pcr.txt || return
+	hash=$(grep "^PCR-10" pcr.txt | cut -d' ' -f2)
+	if [ -z "$hash" ]; then
+		tst_res TFAIL "PCR-10 hash not found"
+		cat pcr.txt
+		return
+	fi
+	tst_res TINFO "real PCR-10: '$hash'"
 
-	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"
-	if [ -f "$pcrs_path" ]; then
-		tst_res TINFO "new PCRS path, evmctl >= 1.1 required"
-	else
-		pcrs_path="/sys/class/misc/tpm0/device/pcrs"
+	pcr_aggregate="$(get_pcr10_aggregate)"
+	if [ -z "$pcr_aggregate" ]; then
+		return
 	fi
+	tst_res TINFO "aggregate PCR-10: '$hash'"
 
-	if [ -f "$pcrs_path" ]; then
-		validate_pcr $pcrs_path
-		if [ $? -eq 0 ]; then
-			tst_res TPASS "aggregate PCR value matches real PCR value"
-		else
-			tst_res TFAIL "aggregate PCR value does not match real PCR value"
-		fi
+	if [ "$hash" = "$pcr_aggregate" ]; then
+		tst_res TPASS "aggregate PCR value matches real PCR value"
 	else
-		tst_res TCONF "TPM Hardware Support not enabled in kernel or no TPM chip found"
+		tst_res TFAIL "aggregate PCR value does not match real PCR value"
 	fi
 }
 
-- 
2.28.0

