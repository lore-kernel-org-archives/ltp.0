From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 Feb 2021 19:00:16 +0100
Subject: [LTP] [PATCH] IMA: Add test for selinux measurement
In-Reply-To: <20210222023805.12846-1-nramas@linux.microsoft.com>
References: <20210222023805.12846-1-nramas@linux.microsoft.com>
Message-ID: <YDVCsNAfn+Ot6QIB@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lakshmi,

> +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
...
> +validate_policy_capabilities()
> +{
> +	local measured_cap measured_value expected_value
> +	local result=1
> +	local inx=7
> +
> +	# Policy capabilities flags start from "network_peer_controls"
> +	# in the measured SELinux state at offset 7 for 'awk'
> +	while [ $inx -lt 20 ]; do
> +		measured_cap=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
> +		inx=$(( $inx + 1 ))
> +
> +		measured_value=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
> +		expected_value=$(cat "$SELINUX_DIR/policy_capabilities/$measured_cap")
> +		if [ "$measured_value" != "$expected_value" ];then
> +			tst_res TWARN "$measured_cap: expected: $expected_value, got: $digest"
We rarely use TWARN in the tests, only when the error is not related to the test result.
Otherwise we use TFAIL.

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

I did few formatting and style changes:
https://github.com/pevik/ltp/commits/ima/selinux.v2.fixes
(branch ima/selinux.v2.fixes), see diff below.

As we discuss, I'm going tom merge test when patchset is merged in maintainers tree,
please ping me. And ideally we should mention kernel commit hash as a comment in
the test.

Thanks a lot!

Kind regards,
Petr

diff --git testcases/kernel/security/integrity/ima/tests/ima_selinux.sh testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index e5060a5e3..ed758631b 100755
--- testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -13,16 +13,14 @@ TST_SETUP="setup"
 . ima_setup.sh
 
 FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
-REQUIRED_POLICY="^measure.*($FUNC_CRITICAL_DATA)"
+REQUIRED_POLICY="^measure.*$FUNC_CRITICAL_DATA"
 
 setup()
 {
-	SELINUX_DIR=$(tst_get_selinux_dir)
-	if [ -z "$SELINUX_DIR" ]; then
-		tst_brk TCONF "SELinux is not enabled"
-		return
-	fi
+	tst_require_selinux_enabled
 	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
+
+	SELINUX_DIR=$(tst_get_selinux_dir)
 }
 
 # Format of the measured SELinux state data.
@@ -41,16 +39,16 @@ validate_policy_capabilities()
 	# in the measured SELinux state at offset 7 for 'awk'
 	while [ $inx -lt 20 ]; do
 		measured_cap=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
-		inx=$(( $inx + 1 ))
+		inx=$(($inx + 1))
 
 		measured_value=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
 		expected_value=$(cat "$SELINUX_DIR/policy_capabilities/$measured_cap")
-		if [ "$measured_value" != "$expected_value" ];then
+		if [ "$measured_value" != "$expected_value" ]; then
 			tst_res TWARN "$measured_cap: expected: $expected_value, got: $digest"
 			result=0
 		fi
 
-		inx=$(( $inx + 1 ))
+		inx=$(($inx + 1))
 	done
 
 	return $result
@@ -109,7 +107,6 @@ test2()
 	local initialized_value
 	local enforced_value expected_enforced_value
 	local checkreqprot_value expected_checkreqprot_value
-	local result
 
 	tst_res TINFO "verifying SELinux state measurement"
 
@@ -149,27 +146,25 @@ test2()
 	measured_data=$(cat $state_file)
 	enforced_value=$(echo $measured_data | awk -F'[=;]' '{print $4}')
 	expected_enforced_value=$(cat $SELINUX_DIR/enforce)
-	if [ "$expected_enforced_value" != "$enforced_value" ];then
+	if [ "$expected_enforced_value" != "$enforced_value" ]; then
 		tst_res TFAIL "enforce: expected: $expected_enforced_value, got: $enforced_value"
 		return
 	fi
 
 	checkreqprot_value=$(echo $measured_data | awk -F'[=;]' '{print $6}')
 	expected_checkreqprot_value=$(cat $SELINUX_DIR/checkreqprot)
-	if [ "$expected_checkreqprot_value" != "$checkreqprot_value" ];then
+	if [ "$expected_checkreqprot_value" != "$checkreqprot_value" ]; then
 		tst_res TFAIL "checkreqprot: expected: $expected_checkreqprot_value, got: $checkreqprot_value"
 		return
 	fi
 
 	initialized_value=$(echo $measured_data | awk -F'[=;]' '{print $2}')
-	if [ "$initialized_value" != "1" ];then
+	if [ "$initialized_value" != "1" ]; then
 		tst_res TFAIL "initialized: expected 1, got: $initialized_value"
 		return
 	fi
 
-	validate_policy_capabilities $measured_data
-	result=$?
-	if [ $result = 0 ]; then
+	if validate_policy_capabilities $measured_data; then
 		tst_res TFAIL "policy capabilities did not match"
 		return
 	fi
