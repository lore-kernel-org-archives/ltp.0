From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Apr 2018 20:35:56 +0200
Subject: [LTP] [RFC PATCH v3 10/10] ima: Print /proc/cmdline and IMA kernel
	config
Message-ID: <20180424183556.2368-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Useful for debugging

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Adding one more commit as it's useful to see config (due problems with
test order).

Petr
---
 .../kernel/security/integrity/ima/tests/ima_setup.sh    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 56c4d5245..fa2b5337d 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -64,6 +64,21 @@ mount_loop_device()
 	cd mntpoint
 }
 
+print_ima_config()
+{
+	local config="/boot/config-$(uname -r)"
+	local i
+
+	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
+
+	if [ -r "$config" ]; then
+		tst_res TINFO "IMA kernel config"
+		for i in $(grep ^CONFIG_IMA $config); do
+			tst_res TINFO "$i"
+		done
+	fi
+}
+
 ima_setup()
 {
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
@@ -73,6 +88,8 @@ ima_setup()
 	ASCII_MEASUREMENTS="$IMA_DIR/ascii_runtime_measurements"
 	BINARY_MEASUREMENTS="$IMA_DIR/binary_runtime_measurements"
 
+	print_ima_config
+
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
 		mount_loop_device
-- 
2.16.3

