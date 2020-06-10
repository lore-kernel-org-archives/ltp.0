From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Wed, 10 Jun 2020 10:01:22 -0700
Subject: [LTP] [PATCH 1/2] IMA: Add a test to verify measurment of keys
Message-ID: <1591808483-22040-1-git-send-email-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a testcase that verifies that the IMA subsystem has correctly
measured keys added to keyrings specified in the IMA policy file.

Additionally, add support for handling a new IMA template descriptor,
namely ima-buf[1], in the IMA measurement tests.

[1]: https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 runtest/ima                                   |  1 +
 .../integrity/ima/tests/compute_digest.sh     | 38 ++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  | 72 +++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   | 37 +---------
 4 files changed, 113 insertions(+), 35 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/tests/compute_digest.sh
 create mode 100644 testcases/kernel/security/integrity/ima/tests/ima_keys.sh

diff --git a/runtest/ima b/runtest/ima
index f3ea88cf0..939fb40f0 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -4,3 +4,4 @@ ima_policy ima_policy.sh
 ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
 evm_overlay evm_overlay.sh
+ima_keys ima_keys.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/compute_digest.sh b/testcases/kernel/security/integrity/ima/tests/compute_digest.sh
new file mode 100644
index 000000000..85f6bf3da
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/compute_digest.sh
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 IBM Corporation
+# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+# Author: Mimi Zohar <zohar@linux.ibm.com>
+
+# TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
+compute_digest()
+{
+	local algorithm="$1"
+	local file="$2"
+	local digest
+
+	digest="$(${algorithm}sum $file 2>/dev/null | cut -f1 -d ' ')"
+	if [ -n "$digest" ]; then
+		echo "$digest"
+		return 0
+	fi
+
+	digest="$(openssl $algorithm $file 2>/dev/null | cut -f2 -d ' ')"
+	if [ -n "$digest" ]; then
+		echo "$digest"
+		return 0
+	fi
+
+	# uncommon ciphers
+	local arg="$algorithm"
+	case "$algorithm" in
+	tgr192) arg="tiger" ;;
+	wp512) arg="whirlpool" ;;
+	esac
+
+	digest="$(rdigest --$arg $file 2>/dev/null | cut -f1 -d ' ')"
+	if [ -n "$digest" ]; then
+		echo "$digest"
+		return 0
+	fi
+	return 1
+}
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
new file mode 100644
index 000000000..1b0dd0aed
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
+#
+# Verify that keys are measured correctly based on policy.
+
+TST_NEEDS_CMDS="awk cut"
+TST_SETUP="setup"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+
+. ima_setup.sh
+. compute_digest.sh
+
+setup()
+{
+    TEST_FILE="$PWD/test.txt"
+}
+
+# Based on https://lkml.org/lkml/2019/12/13/564.
+test1()
+{
+	local keyrings keycheck_line templates
+
+	tst_res TINFO "verifying key measurement for keyrings and \
+templates specified in ima policy file"
+
+	IMA_POLICY="$IMA_DIR/policy"
+	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
+
+	keycheck_line=$(grep "func=KEY_CHECK" $IMA_POLICY)
+	if [ -z "$keycheck_line" ]; then
+		tst_brk TCONF "ima policy does not specify \"func=KEY_CHECK\""
+	fi
+
+	if echo "$keycheck_line" | grep -q "*keyrings*"; then
+		tst_brk TCONF "ima policy does not specify a keyrings to check"
+	fi
+
+	keyrings=$(echo "$keycheck_line" | tr " " "\n" | grep "keyrings" | \
+		sed "s/\./\\\./g" | cut -d'=' -f2)
+	if [ -z "$keyrings" ]; then
+		tst_brk TCONF "ima policy has a keyring key-value specifier, \
+but no specified keyrings"
+	fi
+
+	templates=$(echo "$keycheck_line" | tr " " "\n" | grep "template" | \
+		cut -d'=' -f2)
+
+	grep -E "($templates)*($keyrings)" $ASCII_MEASUREMENTS | while read line
+	do
+		local digest expected_digest algorithm
+
+		digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
+		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
+
+		echo "$line" | cut -d' ' -f6 | xxd -r -p > $TEST_FILE
+
+		expected_digest="$(compute_digest $algorithm $TEST_FILE)" || \
+			tst_brk TCONF "cannot compute digest for $algorithm"
+
+		if [ "$digest" != "$expected_digest" ]; then
+			tst_res TFAIL "incorrect digest was found for the \
+$(echo "$line" | cut -d' ' -f5) keyring"
+		fi
+	done
+
+	tst_res TPASS "specified keyrings were measured correctly"
+}
+
+tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 54237d688..0a58d021d 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -12,6 +12,7 @@ TST_CNT=3
 TST_NEEDS_DEVICE=1
 
 . ima_setup.sh
+. compute_digest.sh
 
 setup()
 {
@@ -28,7 +29,7 @@ setup()
 	# parse digest index
 	# https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
 	case "$template" in
-	ima|ima-ng|ima-sig) DIGEST_INDEX=4 ;;
+	ima|ima-ng|ima-sig|ima-buf) DIGEST_INDEX=4 ;;
 	*)
 		# using ima_template_fmt kernel parameter
 		local IFS="|"
@@ -46,40 +47,6 @@ setup()
 		"Cannot find digest index (template: '$template')"
 }
 
-# TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
-compute_digest()
-{
-	local algorithm="$1"
-	local file="$2"
-	local digest
-
-	digest="$(${algorithm}sum $file 2>/dev/null | cut -f1 -d ' ')"
-	if [ -n "$digest" ]; then
-		echo "$digest"
-		return 0
-	fi
-
-	digest="$(openssl $algorithm $file 2>/dev/null | cut -f2 -d ' ')"
-	if [ -n "$digest" ]; then
-		echo "$digest"
-		return 0
-	fi
-
-	# uncommon ciphers
-	local arg="$algorithm"
-	case "$algorithm" in
-	tgr192) arg="tiger" ;;
-	wp512) arg="whirlpool" ;;
-	esac
-
-	digest="$(rdigest --$arg $file 2>/dev/null | cut -f1 -d ' ')"
-	if [ -n "$digest" ]; then
-		echo "$digest"
-		return 0
-	fi
-	return 1
-}
-
 ima_check()
 {
 	local delimiter=':'
-- 
2.25.1

