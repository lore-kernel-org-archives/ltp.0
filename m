From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 May 2020 02:43:39 +0200
Subject: [LTP] [PATCH 1/1] ima_tpm.sh: Fix for calculating boot aggregate
Message-ID: <20200527004339.10433-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes test for kernel commit: 6f1a1d103b48 ima: ("Switch to
ima_hash_algo for boot aggregate") from current linux-integrity tree.

Tests was failing, because it expect SHA1 hash, but for TPM 2.0 is
now used IMA default hash algorithm (by default default SHA256).
This is similar for entries in IMA measurement list so we can reuse
already existing code.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

not proud on using global variables, any suggestions how to make code
cleaner?

@Mimi: could you please test this? 6f1a1d103b48 is for v5.8, right?

Kind regards,
Petr
 .../integrity/ima/tests/ima_measurements.sh   | 66 +++----------------
 .../security/integrity/ima/tests/ima_setup.sh | 63 ++++++++++++++++++
 .../security/integrity/ima/tests/ima_tpm.sh   | 22 ++++---
 3 files changed, 84 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 54237d688..55f7359d4 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -6,7 +6,7 @@
 #
 # Verify that measurements are added to the measurement list based on policy.
 
-TST_NEEDS_CMDS="awk cut"
+TST_NEEDS_CMDS="awk cut sed"
 TST_SETUP="setup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
@@ -20,30 +20,8 @@ setup()
 	TEST_FILE="$PWD/test.txt"
 	POLICY="$IMA_DIR/policy"
 	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
-	DIGEST_INDEX=
-
-	local template="$(tail -1 $ASCII_MEASUREMENTS | cut -d' ' -f 3)"
-	local i
-
-	# parse digest index
-	# https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
-	case "$template" in
-	ima|ima-ng|ima-sig) DIGEST_INDEX=4 ;;
-	*)
-		# using ima_template_fmt kernel parameter
-		local IFS="|"
-		i=4
-		for word in $template; do
-			if [ "$word" = 'd' -o "$word" = 'd-ng' ]; then
-				DIGEST_INDEX=$i
-				break
-			fi
-			i=$((i+1))
-		done
-	esac
 
-	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
-		"Cannot find digest index (template: '$template')"
+	set_digest_index
 }
 
 # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
@@ -82,8 +60,7 @@ compute_digest()
 
 ima_check()
 {
-	local delimiter=':'
-	local algorithm digest expected_digest line
+	local expected_digest line
 
 	# need to read file to get updated $ASCII_MEASUREMENTS
 	cat $TEST_FILE > /dev/null
@@ -93,40 +70,13 @@ ima_check()
 		tst_res TFAIL "cannot find measurement record for '$TEST_FILE'"
 		return
 	fi
-	tst_res TINFO "measurement record: '$line'"
-
-	digest=$(echo "$line" | cut -d' ' -f $DIGEST_INDEX)
-	if [ -z "$digest" ]; then
-		tst_res TFAIL "cannot find digest (index: $DIGEST_INDEX)"
-		return
-	fi
-
-	if [ "${digest#*$delimiter}" != "$digest" ]; then
-		algorithm=$(echo "$digest" | cut -d $delimiter -f 1)
-		digest=$(echo "$digest" | cut -d $delimiter -f 2)
-	else
-		case "${#digest}" in
-		32) algorithm="md5" ;;
-		40) algorithm="sha1" ;;
-		*)
-			tst_res TFAIL "algorithm must be either md5 or sha1 (digest: '$digest')"
-			return ;;
-		esac
-	fi
-	if [ -z "$algorithm" ]; then
-		tst_res TFAIL "cannot find algorithm"
-		return
-	fi
-	if [ -z "$digest" ]; then
-		tst_res TFAIL "cannot find digest"
-		return
-	fi
+	get_algorithm_digest "$line"
 
-	tst_res TINFO "computing digest for $algorithm algorithm"
-	expected_digest="$(compute_digest $algorithm $TEST_FILE)" || \
-		tst_brk TCONF "cannot compute digest for $algorithm algorithm"
+	tst_res TINFO "computing digest for $ALGORITHM algorithm"
+	expected_digest="$(compute_digest $ALGORITHM $TEST_FILE)" || \
+		tst_brk TCONF "cannot compute digest for $ALGORITHM algorithm"
 
-	if [ "$digest" = "$expected_digest" ]; then
+	if [ "$DIGEST" = "$expected_digest" ]; then
 		tst_res TPASS "correct digest found"
 	else
 		tst_res TFAIL "digest not found"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 58a12eda3..f23de8b96 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -112,6 +112,69 @@ ima_cleanup()
 	fi
 }
 
+set_digest_index()
+{
+	DIGEST_INDEX=
+
+	local template="$(tail -1 $ASCII_MEASUREMENTS | cut -d' ' -f 3)"
+	local i word
+
+	# parse digest index
+	# https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
+	case "$template" in
+	ima|ima-ng|ima-sig) DIGEST_INDEX=4 ;;
+	*)
+		# using ima_template_fmt kernel parameter
+		local IFS="|"
+		i=4
+		for word in $template; do
+			if [ "$word" = 'd' -o "$word" = 'd-ng' ]; then
+				DIGEST_INDEX=$i
+				break
+			fi
+			i=$((i+1))
+		done
+	esac
+
+	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
+		"Cannot find digest index (template: '$template')"
+}
+
+get_algorithm_digest()
+{
+	local line="$1"
+	local delimiter=':'
+
+	tst_res TINFO "measurement record: '$line'"
+
+	DIGEST=$(echo "$line" | cut -d' ' -f $DIGEST_INDEX)
+	if [ -z "$DIGEST" ]; then
+		tst_res TFAIL "cannot find digest (index: $DIGEST_INDEX)"
+		return
+	fi
+
+	if [ "${DIGEST#*$delimiter}" != "$DIGEST" ]; then
+		ALGORITHM=$(echo "$DIGEST" | cut -d $delimiter -f 1)
+		DIGEST=$(echo "$DIGEST" | cut -d $delimiter -f 2)
+	else
+		case "${#DIGEST}" in
+		32) ALGORITHM="md5" ;;
+		40) ALGORITHM="sha1" ;;
+		*)
+			tst_res TFAIL "algorithm must be either md5 or sha1 (digest: '$DIGEST')"
+			return ;;
+		esac
+	fi
+	if [ -z "$ALGORITHM" ]; then
+		tst_res TFAIL "cannot find algorithm"
+		return
+	fi
+	if [ -z "$DIGEST" ]; then
+		tst_res TFAIL "cannot find digest"
+		return
+	fi
+}
+
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
 if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index c69f891f1..5679fe964 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -7,6 +7,7 @@
 # Verify the boot and PCR aggregates.
 
 TST_CNT=2
+TST_SETUP="set_digest_index"
 TST_NEEDS_CMDS="awk cut ima_boot_aggregate"
 
 . ima_setup.sh
@@ -15,29 +16,32 @@ test1()
 {
 	tst_res TINFO "verify boot aggregate"
 
-	local zero="0000000000000000000000000000000000000000"
 	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
 	local ima_measurements="$ASCII_MEASUREMENTS"
-	local boot_aggregate boot_hash line
+	local boot_aggregate line zero
 
 	# IMA boot aggregate
 	read line < $ima_measurements
-	boot_hash=$(echo $line | awk '{print $(NF-1)}' | cut -d':' -f2)
+
+	get_algorithm_digest "$line"
 
 	if [ ! -f "$tpm_bios" ]; then
 		tst_res TINFO "TPM Hardware Support not enabled in kernel or no TPM chip found"
 
-		if [ "$boot_hash" = "$zero" ]; then
-			tst_res TPASS "bios boot aggregate is 0"
+		zero=$(echo $DIGEST | awk '{gsub(/./, "0")}; {print}')
+		if [ "$DIGEST" = "$zero" ]; then
+			tst_res TPASS "bios boot aggregate is $zero"
 		else
-			tst_res TFAIL "bios boot aggregate is not 0"
+			tst_res TFAIL "bios boot aggregate is not $zero ($DIGEST)"
 		fi
 	else
 		boot_aggregate=$(ima_boot_aggregate $tpm_bios | grep "boot_aggregate:" | cut -d':' -f2)
-		if [ "$boot_hash" = "$boot_aggregate" ]; then
-			tst_res TPASS "bios aggregate matches IMA boot aggregate"
+		tst_res TINFO "IMA boot aggregate: '$boot_aggregate'"
+
+		if [ "$DIGEST" = "$boot_aggregate" ]; then
+			tst_res TPASS "bios boot aggregate matches IMA boot aggregate"
 		else
-			tst_res TFAIL "bios aggregate does not match IMA boot aggregate"
+			tst_res TFAIL "bios boot aggregate does not match IMA boot aggregate ($DIGEST)"
 		fi
 	fi
 }
-- 
2.26.2

