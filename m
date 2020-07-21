From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Tue, 21 Jul 2020 14:24:40 -0400
Subject: [LTP] [PATCH] IMA: Add test for kexec cmdline measurement
Message-ID: <20200721182440.4169-1-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

IMA policy can be set to measure the command line passed in the kexec system call.
There needs to be a test to validate this kexec command line measurement.

Add a testcase that verifies that the IMA subsystem has correctly
measured the cmdline specified during a kexec.

Note that this test does not actually reboot.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 runtest/ima                                   |  1 +
 .../kernel/security/integrity/ima/README.md   | 11 +++
 .../security/integrity/ima/tests/ima_kexec.sh | 93 +++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh

diff --git a/runtest/ima b/runtest/ima
index 309d47420..5f4b4a7a1 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -4,4 +4,5 @@ ima_policy ima_policy.sh
 ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
 ima_keys ima_keys.sh
+ima_kexec ima_kexec.sh
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index db8819a99..926eb8478 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -30,6 +30,17 @@ measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
 
 The test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
 
+### IMA kexec test
+
+This test requires that the ima policy contains:
+```
+measure func=KEXEC_CMDLINE
+```
+
+Even though the test does not actually reboot, it does require a valid,
+signed kernel image. By default, the test will look in `/boot/vmlinuz-$(uname r)`,
+but if no image is accessible there, a valid image be must be placed at `/tmp/Image`.
+
 ## EVM tests
 
 `evm_overlay.sh` requires a builtin IMA appraise tcb policy (e.g. `ima_policy=appraise_tcb`
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
new file mode 100644
index 000000000..7d71557ee
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
+#
+# Verify that kexec cmdline is measured correctly.
+
+TST_NEEDS_CMDS="kexec sed xargs printf grep"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+
+. ima_setup.sh
+
+# Since the test is executed inside some sort of
+# separate shell, *most* environment variables are
+# not accessible, so there's no way to set it from
+# the outside.
+#
+# `/boot/vmlinuz-$(uname-r)` is where the image is
+# located on many systems, but not all. Therefore,
+# if the image is not located there, require the
+# user to copy it to `/tmp/Image`.
+#
+# Ideally, this test shouldn't even require an image,
+# since it doesn't actually reboot, but the IMA cmdline
+# measurement occurs after the image is parsed and verified,
+# so we must pass a valid kernel image. There is a possiblity of
+# putting together a "faux" kernel image that has the right headers
+# and appears to be signed correctly, but doesn't actually contain any
+# code, but, after investigating that possiblity, it appears to be
+# quite difficult (and would require a new faux kernel for each arch).
+IMAGE="/boot/vmlinuz-$(uname -r)"
+if [ ! -f $IMAGE ]; then
+    IMAGE="/tmp/Image"
+fi
+
+measure() {
+    local found temp_file="file.txt" temp_file2="file2.txt" algorithm \
+        digest expected_digest
+
+    echo -n "$1" > $temp_file
+    grep "kexec-cmdline" $ASCII_MEASUREMENTS > $temp_file2
+
+    while read found
+    do
+        algorithm=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f1)
+        digest=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f2)
+
+        expected_digest=$(compute_digest $algorithm $temp_file)
+
+        if [ "$digest" = "$expected_digest" ]; then
+            return 0
+        fi
+    done < $temp_file2
+
+    return 1
+}
+
+# Test that the kexec cmdline is measured correctly.
+# NOTE: This does *not* actually reboot.
+test1() {
+    # Strip the `BOOT_IMAGE=...` part from the cmdline.
+    local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
+    if ! kexec -sl $IMAGE --reuse-cmdline; then
+        tst_brk TCONF "kexec failed: $?"
+    fi
+
+    if ! measure "$cmdline"; then
+        tst_brk TFAIL "kexec cmdline was measured incorrectly"
+    fi
+
+    cmdline="foo"
+    if ! kexec -sl $IMAGE --append=$cmdline; then
+        tst_brk TCONF "kexec failed: $?"
+    fi
+
+    if ! measure "$cmdline"; then
+        tst_brk TFAIL "kexec cmdline was measured incorrectly"
+    fi
+
+    cmdline="bar"
+    if ! kexec -sl $IMAGE --command-line=$cmdline; then
+        tst_brk TCONF "kexec failed: $?"
+    fi
+
+    if ! measure "$cmdline"; then
+        tst_brk TFAIL "kexec cmdline was measured incorrectly"
+    fi
+
+    tst_res TPASS "kexec cmldine was measured correctly"
+}
+
+tst_run
-- 
2.25.1

