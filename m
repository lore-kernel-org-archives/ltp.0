From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  9 Dec 2019 17:19:18 +0100
Subject: [LTP] [PATCH 1/1] tst_test.sh: Fix check for non-mounted device
Message-ID: <20191209161918.2411991-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) unset TST_DEVICE if acquiring failed
2) do not try to umount the device in this case

Maybe sometimes missing $device in tst_umount()
is error, but mostly at least in case of df01.sh
it's not, therefore return without warning.

This fixes error:

df01 1 TBROK: Failed to acquire device
grep: Unmatched [, [^, [:, [., or [=
grep: Unmatched [, [^, [:, [., or [=
df01 1 TINFO: The tst_device    0  TINFO  :  Found free device 0 '/dev/loop0'
Test device='/dev/loop0'
tst_device    0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts='' is not mounted, skipping umount

Fixes: 5c846a0f6 shell: Add $TST_DEVICE as default parameter to tst_umount

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 70c1ef2e3..f772857eb 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -273,6 +273,8 @@ tst_umount()
 	local device="${1:-$TST_DEVICE}"
 	local i=0
 
+	[ -z "$device" ] && return
+
 	if ! grep -q "$device" /proc/mounts; then
 		tst_res TINFO "The $device is not mounted, skipping umount"
 		return
@@ -546,6 +548,7 @@ tst_run()
 		TST_DEVICE=$(tst_device acquire)
 
 		if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then
+			unset TST_DEVICE
 			tst_brk TBROK "Failed to acquire device"
 		fi
 
-- 
2.24.0

