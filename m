From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 22 Mar 2021 10:37:09 -0700
Subject: [LTP] [PATCH v4] IMA: Allow only ima-buf template for key
 measurement
Message-ID: <20210322173709.22150-1-nramas@linux.microsoft.com>
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
 .../kernel/security/integrity/ima/README.md   |  9 +++++++++
 .../security/integrity/ima/tests/ima_keys.sh  | 20 ++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 8f2249767..1aaa734a3 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -28,6 +28,15 @@ policy allowed in the kernel configuration:
 ```
 CONFIG_IMA_READ_POLICY=y
 ```
+If the IMA key tests are executed on Linux kernel v5.6 through v5.10,
+`ima-buf` template should be specified in the IMA policy rule for
+key measurement. For example,
+`measure func=KEY_CHECK keyrings=key_import_test template=ima-buf`
+
+If the IMA key tests are executed on Linux kernel v5.11 or later,
+`template=ima-buf` is optional in the IMA policy rule for key measurement.
+For example,
+`measure func=KEY_CHECK keyrings=key_import_test`
 
 ### IMA kexec test
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index c9eef4b68..b9bef4feb 100755
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
@@ -28,12 +27,23 @@ cleanup()
 	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
 }
 
+check_policy_template()
+{
+	while read line; do
+	if ( echo $line | grep -q 'template=') && ( ! echo $line | grep -q 'template=ima-buf' ); then
+		tst_res TCONF "only template=ima-buf can be specified for KEY_CHECK"
+		return 1
+	fi
+	done < $TST_TMPDIR/policy.txt
+	return 0
+}
+
 check_keys_policy()
 {
 	local pattern="$1"
 
 	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
-		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
+		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
 		return 1
 	fi
 	return 0
@@ -49,6 +59,8 @@ test1()
 
 	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
+	check_policy_template || return
+
 	check_keys_policy "$pattern" > $tmp_file || return
 	keycheck_lines=$(cat $tmp_file)
 	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
@@ -101,6 +113,8 @@ test2()
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
+	check_policy_template || return
+
 	check_keys_policy "$pattern" >/dev/null || return
 
 	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
-- 
2.30.2

