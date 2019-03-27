From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Mar 2019 17:16:38 +0100
Subject: [LTP] [PATCH 3/3] ima: Add overlay test
In-Reply-To: <20190327161638.7407-1-pvorel@suse.cz>
References: <20190327161638.7407-1-pvorel@suse.cz>
Message-ID: <20190327161638.7407-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Based on reproducer made by Ignaz Forster <iforster@suse.de>
used for his not upstreamed patchset [1] and previous report [2].

NOTE: backup variables are needed because ima_setup.sh calling
tst_mount as well when TMPDIR is on tmpfs device.

[1] https://www.spinics.net/lists/linux-integrity/msg05926.html
[2] https://www.spinics.net/lists/linux-integrity/msg03593.html

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Ignaz Forster <iforster@suse.de>
Cc: Fabian Vogt <FVogt@suse.com>
Cc: Weihua Du <WHDu@suse.com>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ima                                   |  1 +
 .../integrity/ima/tests/ima_overlay.sh        | 65 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh |  4 +-
 3 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_overlay.sh

diff --git a/runtest/ima b/runtest/ima
index bcae16bb7..f96711a7d 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -3,3 +3,4 @@ ima_measurements ima_measurements.sh
 ima_policy ima_policy.sh
 ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
+ima_overlay ima_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_overlay.sh b/testcases/kernel/security/integrity/ima/tests/ima_overlay.sh
new file mode 100755
index 000000000..eedcd3753
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_overlay.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Based on reproducer made by Ignaz Forster <iforster@suse.de>
+
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
+. ima_setup.sh
+TST_TESTFUNC="do_test"
+
+setup()
+{
+	lower="$TST_MNTPOINT/lower"
+	upper="$TST_MNTPOINT/upper"
+	work="$TST_MNTPOINT/work"
+	merged="$TST_MNTPOINT/merged"
+	mkdir -p $lower $upper $work $merged
+
+	device_backup="$TST_DEVICE"
+	TST_DEVICE="overlay"
+
+	fs_type_backup="$TST_FS_TYPE"
+	TST_FS_TYPE="overlay"
+
+	mntpoint_backup="$TST_MNTPOINT"
+	TST_MNTPOINT="$merged"
+
+	params_backup="$TST_MNT_PARAMS"
+	TST_MNT_PARAMS="-o lowerdir=$lower,upperdir=$upper,workdir=$work"
+
+	grep -q ima_appraise_tcb /proc/cmdline || \
+		tst_brk TCONF "Test requires ima_appraise_tcb kernel parameter"
+}
+
+do_test()
+{
+	local file="foo.txt"
+	local f
+
+	tst_mount
+	mounted=1
+
+	ROD echo lower \> $lower/$file
+	if ! echo overlay > $merged/$file 2>/dev/null; then
+		tst_res TFAIL "Cannot write to merged layer"
+		return
+	fi
+
+	for f in $(find $TST_MNTPOINT -type f); do
+		EXPECT_PASS cat $f \> /dev/null 2\> /dev/null
+	done
+}
+
+cleanup()
+{
+	[ -n "$mounted" ] || return 0
+
+	tst_umount $TST_DEVICE
+
+	TST_DEVICE="$device_backup"
+	TST_FS_TYPE="$fs_type_backup"
+	TST_MNTPOINT="$mntpoint_backup"
+	TST_MNT_PARAMS="$params_backup"
+}
+
+tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index da49eb1b2..08aa5300a 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -64,14 +64,14 @@ print_ima_config()
 	local config="/boot/config-$(uname -r)"
 	local i
 
-	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
-
 	if [ -r "$config" ]; then
 		tst_res TINFO "IMA kernel config:"
 		for i in $(grep ^CONFIG_IMA $config); do
 			tst_res TINFO "$i"
 		done
 	fi
+
+	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
 }
 
 ima_setup()
-- 
2.21.0

