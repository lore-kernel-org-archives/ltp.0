From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed,  3 Mar 2021 12:32:54 -0800
Subject: [LTP] [PATCH] IMA: Allow only ima-buf template for key measurement
Message-ID: <20210303203254.12856-1-nramas@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ima-buf is the default IMA template used for all buffer measurements.
Therefore, IMA policy rule for measuring keys need not specify
an IMA template.  But if a template is specified for key measurement
rule then it must be only ima-buf.

Update keys tests to not require a template to be specified for
key measurement rule, but if a template is specified verify it is
only ima-buf.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 .../security/integrity/ima/tests/ima_keys.sh     | 10 +++++++---
 .../security/integrity/ima/tests/ima_setup.sh    | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index c9eef4b68..8b214b413 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -15,8 +15,7 @@ TST_CLEANUP=cleanup
 . ima_setup.sh
 
 FUNC_KEYCHECK='func=KEY_CHECK'
-TEMPLATE_BUF='template=ima-buf'
-REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_KEYCHECK)"
+REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
 
 setup()
 {
@@ -33,9 +32,10 @@ check_keys_policy()
 	local pattern="$1"
 
 	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
-		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
+		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
 		return 1
 	fi
+
 	return 0
 }
 
@@ -49,6 +49,8 @@ test1()
 
 	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
+	check_policy_template "template=ima-buf" $FUNC_KEYCHECK || return
+
 	check_keys_policy "$pattern" > $tmp_file || return
 	keycheck_lines=$(cat $tmp_file)
 	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
@@ -101,6 +103,8 @@ test2()
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
+	check_policy_template "template=ima-buf" $FUNC_KEYCHECK || return
+
 	check_keys_policy "$pattern" >/dev/null || return
 
 	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 59a7ffeac..01ebec2b6 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -107,6 +107,22 @@ check_ima_policy_cmdline()
 	return 1
 }
 
+check_policy_template()
+{
+	local template="$1"
+	local func="$2"
+	grep -E "template=" $TST_TMPDIR/policy.txt | while read line
+	do
+		ima_template=$(echo $line | grep $template)
+		if [ -z "$ima_template" ]; then
+			tst_res TCONF "Only $template can be specified for $func"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
 require_ima_policy_cmdline()
 {
 	local policy="$1"
-- 
2.30.0

