From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Tue, 14 Jul 2020 14:17:02 -0400
Subject: [LTP] [PATCH v5 1/2] IMA: Add a test to verify measurment of keys
In-Reply-To: <20200714181703.6374-1-t-josne@linux.microsoft.com>
References: <20200714181703.6374-1-t-josne@linux.microsoft.com>
Message-ID: <20200714181703.6374-2-t-josne@linux.microsoft.com>
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
 .../integrity/ima/datafiles/keycheck.policy   |  1 +
 .../security/integrity/ima/tests/ima_keys.sh  | 71 +++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   | 36 +---------
 .../integrity/ima/tests/ima_policy.sh         |  1 -
 .../security/integrity/ima/tests/ima_setup.sh | 35 +++++++++
 6 files changed, 109 insertions(+), 36 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_keys.sh

diff --git a/runtest/ima b/runtest/ima
index f3ea88cf0..309d47420 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -3,4 +3,5 @@ ima_measurements ima_measurements.sh
 ima_policy ima_policy.sh
 ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
+ima_keys ima_keys.sh
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/datafiles/keycheck.policy b/testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
new file mode 100644
index 000000000..3f1934a3d
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
@@ -0,0 +1 @@
+measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist template=ima-buf
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
new file mode 100755
index 000000000..4d53cd04f
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
+#
+# Verify that keys are measured correctly based on policy.
+
+TST_NEEDS_CMDS="grep mktemp cut sed tr"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+
+. ima_setup.sh
+
+# Based on https://lkml.org/lkml/2019/12/13/564.
+# (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
+test1()
+{
+	local keyrings keycheck_lines keycheck_line templates test_file="file.txt" fail
+
+	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
+
+	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
+
+	[ -r $IMA_POLICY ] || tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
+
+	keycheck_lines=$(grep "func=KEY_CHECK" $IMA_POLICY)
+	if [ -z "$keycheck_lines" ]; then
+		tst_brk TCONF "ima policy does not specify \"func=KEY_CHECK\""
+	fi
+
+	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
+
+	if [ -z "$keycheck_line" ]; then
+		tst_brk TCONF "ima policy does not specify a keyrings to check"
+	fi
+
+	keyrings=$(echo "$keycheck_line" | tr " " "\n" | grep "keyrings" | \
+		sed "s/\./\\\./g" | cut -d'=' -f2)
+	if [ -z "$keyrings" ]; then
+		tst_brk TCONF "ima policy has a keyring key-value specifier, but no specified keyrings"
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
+		keyring=$(echo "$line" | cut -d' ' -f5)
+
+		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
+
+		expected_digest="$(compute_digest $algorithm $test_file)" || \
+			tst_brk TCONF "cannot compute digest for $algorithm"
+
+		if [ "$digest" != "$expected_digest" ]; then
+			fail=1
+			tst_res TFAIL "incorrect digest was found for the ($keyring) keyring"
+			break
+		fi
+	done
+
+	if [ "$fail" ]; then
+		tst_res TPASS "specified keyrings were measured correctly"
+	fi
+}
+
+tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 54237d688..04d8e6353 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -28,7 +28,7 @@ setup()
 	# parse digest index
 	# https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
 	case "$template" in
-	ima|ima-ng|ima-sig) DIGEST_INDEX=4 ;;
+	ima|ima-ng|ima-sig|ima-buf) DIGEST_INDEX=4 ;;
 	*)
 		# using ima_template_fmt kernel parameter
 		local IFS="|"
@@ -46,40 +46,6 @@ setup()
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
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 6286277b4..244cf081d 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -23,7 +23,6 @@ check_policy_writable()
 
 setup()
 {
-	IMA_POLICY="$IMA_DIR/policy"
 	check_policy_writable
 
 	VALID_POLICY="$TST_DATAROOT/measure.policy"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 58a12eda3..8ae477c1c 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -20,6 +20,40 @@ SYSFS="/sys"
 UMOUNT=
 TST_FS_TYPE="ext3"
 
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
+
 check_ima_policy()
 {
 	local policy="$1"
@@ -85,6 +119,7 @@ ima_setup()
 	[ -d "$IMA_DIR" ] || tst_brk TCONF "IMA not enabled in kernel"
 	ASCII_MEASUREMENTS="$IMA_DIR/ascii_runtime_measurements"
 	BINARY_MEASUREMENTS="$IMA_DIR/binary_runtime_measurements"
+	IMA_POLICY="$IMA_DIR/policy"
 
 	print_ima_config
 
-- 
2.25.1

