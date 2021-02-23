From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 Feb 2021 23:59:29 +0100
Subject: [LTP] [PATCH v3 1/2] IMA: Generalize key measurement tests
In-Reply-To: <20210223225930.27095-1-pvorel@suse.cz>
References: <20210223225930.27095-1-pvorel@suse.cz>
Message-ID: <20210223225930.27095-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Refactor check_keys_policy() and test1() implemented in ima_keys.sh to
make it generic, and move the functionality to ima_setup.sh,
to be used for measurements in other tests in the future.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
[ pvorel: move tst_res TPASS/TFAIL into test_policy_measurement(),
further cleanup ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_keys.sh  | 58 ++---------------
 .../security/integrity/ima/tests/ima_setup.sh | 62 +++++++++++++++++++
 2 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index c9eef4b68..1aeb1cd89 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -6,7 +6,7 @@
 #
 # Verify that keys are measured correctly based on policy.
 
-TST_NEEDS_CMDS="cmp cut grep sed xxd"
+TST_NEEDS_CMDS="cmp cut grep tail xxd"
 TST_CNT=2
 TST_NEEDS_DEVICE=1
 TST_SETUP=setup
@@ -28,64 +28,18 @@ cleanup()
 	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
 }
 
-check_keys_policy()
-{
-	local pattern="$1"
-
-	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
-		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
-		return 1
-	fi
-	return 0
-}
-
 # Based on https://lkml.org/lkml/2019/12/13/564.
 # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
 test1()
 {
 	local keycheck_lines i keyrings templates
 	local pattern='keyrings=[^[:space:]]+'
-	local test_file="file.txt" tmp_file="file2.txt"
+	local temp_file="test1.txt"
 
 	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
-	check_keys_policy "$pattern" > $tmp_file || return
-	keycheck_lines=$(cat $tmp_file)
-	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
-		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
-	if [ -z "$keyrings" ]; then
-		tst_res TCONF "IMA policy has a keyring key-value specifier, but no specified keyrings"
-		return
-	fi
-
-	templates=$(for i in $keycheck_lines; do echo "$i" | grep "template" | \
-		cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
-
-	tst_res TINFO "keyrings: '$keyrings'"
-	tst_res TINFO "templates: '$templates'"
-
-	grep -E "($templates).*($keyrings)" $ASCII_MEASUREMENTS | while read line
-	do
-		local digest expected_digest algorithm
-
-		digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
-		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
-		keyring=$(echo "$line" | cut -d' ' -f5)
-
-		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
-
-		if ! expected_digest="$(compute_digest $algorithm $test_file)"; then
-			tst_res TCONF "cannot compute digest for $algorithm"
-			return
-		fi
-
-		if [ "$digest" != "$expected_digest" ]; then
-			tst_res TFAIL "incorrect digest was found for $keyring keyring"
-			return
-		fi
-	done
-
-	tst_res TPASS "specified keyrings were measured correctly"
+	check_policy_pattern "$pattern" $FUNC_KEYCHECK $TEMPLATE_BUF > $temp_file || return
+	test_policy_measurement keyrings $temp_file
 }
 
 # Create a new keyring, import a certificate into it, and verify
@@ -97,11 +51,11 @@ test2()
 	local cert_file="$TST_DATAROOT/x509_ima.der"
 	local keyring_name="key_import_test"
 	local pattern="keyrings=[^[:space:]]*$keyring_name"
-	local temp_file="file.txt"
+	local temp_file="test2.txt"
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
-	check_keys_policy "$pattern" >/dev/null || return
+	check_policy_pattern "$pattern" $FUNC_KEYCHECK $TEMPLATE_BUF >/dev/null || return
 
 	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
 		tst_brk TBROK "unable to create a new keyring"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 59a7ffeac..605db0ff6 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -54,6 +54,19 @@ compute_digest()
 	return 1
 }
 
+check_policy_pattern()
+{
+	local pattern="$1"
+	local func="$2"
+	local template="$3"
+
+	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
+		tst_res TCONF "IMA policy must specify $pattern, $func, $template"
+		return 1
+	fi
+	return 0
+}
+
 check_policy_readable()
 {
 	if [ ! -f $IMA_POLICY ]; then
@@ -269,6 +282,55 @@ get_algorithm_digest()
 	echo "$algorithm|$digest"
 }
 
+test_policy_measurement()
+{
+	local policy_option="$1"
+	local lines=$(cat $2)
+	local input_digest="$3"
+	local test_file="$TST_TMPDIR/test.txt"
+	local grep_file="$TST_TMPDIR/grep.txt"
+	local i sources templates
+
+	tst_require_cmds cut sed xxd
+
+	sources=$(for i in $lines; do echo "$i" | grep "$policy_option" | \
+		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
+	if [ -z "$sources" ]; then
+		tst_res TCONF "IMA policy $policy_option is a key-value specifier, but no values specified"
+		return
+	fi
+
+	templates=$(for i in $lines; do echo "$i" | grep "template" | \
+		cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
+
+	tst_res TINFO "policy sources: '$sources'"
+	tst_res TINFO "templates: '$templates'"
+
+	grep -E "($templates).*($sources)" $ASCII_MEASUREMENTS > $grep_file
+
+	while read line; do
+		local algorithm digest expected_digest src_line
+
+		digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
+		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
+		src_line=$(echo "$line" | cut -d' ' -f5)
+
+		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
+
+		if ! expected_digest="$(compute_digest $algorithm $test_file)"; then
+			tst_res TCONF "cannot compute digest for $algorithm"
+			return
+		fi
+
+		if [ "$digest" != "$expected_digest" ]; then
+			tst_res TFAIL "incorrect digest was found for $src_line $policy_option"
+			return
+		fi
+	done < $grep_file
+
+	tst_res TPASS "$policy_option measured correctly"
+}
+
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
 if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
-- 
2.30.1

