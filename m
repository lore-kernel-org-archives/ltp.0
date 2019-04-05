From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  5 Apr 2019 18:52:25 +0200
Subject: [LTP] [PATCH v2 3/3] ima: Add overlay test
In-Reply-To: <20190405165225.27216-1-pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
Message-ID: <20190405165225.27216-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

test demonstrate a bug on overlayfs on current mainline kernel when
combining IMA with EVM.

Based on reproducer made by Ignaz Forster <iforster@suse.de>
used for not upstreamed patchset [1] and previous report [2].
IMA only behavior has already been fixed [3].

NOTE: backup variables are needed because ima_setup.sh calling
tst_mount as well when TMPDIR is on tmpfs device.

[1] https://www.spinics.net/lists/linux-integrity/msg05926.html
[2] https://www.spinics.net/lists/linux-integrity/msg03593.html
[3] https://patchwork.kernel.org/patch/10776231/

Tested-by: Ignaz Forster <iforster@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Added 2 more tests (suggested by Ignaz): append file and create a new
file. Tests has been further split to 4 tests (previously was only 1).
* Fixed testing on tmpfs (reported by Mimi) by adding TST_NEEDS_DEVICE=1.
* Renamed file to evm_overlay.sh (from ima_overlay.sh; suggested by Ignaz).
Obviously it's about IMA + EVM, but IMHO 'ima' can be left from filename.
* Changed pattern for kernel parameters check (suggested by Mimi).

TODO/questions:
Still not sure what is a proper setup.
Should I check EVM enabled?
/sys/kernel/security/evm should be 1?

I suppose different behaviour between ima_policy=appraise_tcb and
ima_appraise_tcb is just my wrong setup.

Thanks a lot for your comments.

Kind regards,
Petr
---
 runtest/ima                                   |  1 +
 .../integrity/ima/tests/evm_overlay.sh        | 86 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh |  4 +-
 3 files changed, 89 insertions(+), 2 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

diff --git a/runtest/ima b/runtest/ima
index bcae16bb7..f3ea88cf0 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -3,3 +3,4 @@ ima_measurements ima_measurements.sh
 ima_policy ima_policy.sh
 ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
+evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
new file mode 100755
index 000000000..08ec1ea37
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Based on reproducer and further discussion with Ignaz Forster <iforster@suse.de>
+
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
+TST_NEEDS_DEVICE=1
+TST_CNT=4
+. ima_setup.sh
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
+	grep -q -e ima_policy= -e ima_appraise_tcb /proc/cmdline || \
+		tst_brk TCONF "Test requires specify IMA policy as kernel parameter"
+
+	tst_mount
+	mounted=1
+}
+
+test1()
+{
+	local file="foo1.txt"
+
+	tst_res TINFO "overwrite file in overlay"
+	ROD echo lower \> $lower/$file
+	EXPECT_PASS echo overlay \> $merged/$file
+}
+
+test2()
+{
+	local file="foo2.txt"
+
+	tst_res TINFO "append file in overlay"
+	ROD echo lower \> $lower/$file
+	EXPECT_PASS echo overlay \>\> $merged/$file
+}
+
+test3()
+{
+	local file="foo3.txt"
+
+	tst_res TINFO "create a new file in overlay"
+	EXPECT_PASS echo overlay \> $merged/$file
+}
+
+test4()
+{
+	local f
+
+	tst_res TINFO "read all created files"
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

