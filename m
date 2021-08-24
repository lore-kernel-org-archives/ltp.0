From: Leo Liang <ycliang@andestech.com>
Date: Tue, 24 Aug 2021 20:16:59 +0800
Subject: [LTP] [PATCH v7,
 1/4] lib: tst_umount: umount a mount point instead of a device
Message-ID: <YSTjO2rjk9sWRSWD@ubuntu02>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current check inside tst_umount for whehter a device is mounted is ambiguous.
Fix it by checking for the existance of the exact mount point the fs is mounted upon,
and use the mount point instead of the device to do the umount process.
This patch make tst_umount umount TST_MNTPOINT by default,
and reject any argument that does not start with '/'.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 78e2760e7..33015616d 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -279,31 +279,35 @@ tst_mount()
 
 tst_umount()
 {
-	local device="${1:-$TST_DEVICE}"
+	local mntpoint="${1:-$TST_MNTPOINT}"
 	local i=0
 
-	[ -z "$device" ] && return
+	[ -z "$mntpoint" ] && return
 
-	if ! grep -q "$device" /proc/mounts; then
-		tst_res TINFO "The $device is not mounted, skipping umount"
+	if ! echo "$mntpoint" | grep -q ^/; then
+		tst_brk TCONF "The '$mntpoint' is not an absolute path"
+	fi
+
+	if ! grep -q "${mntpoint%/}" /proc/mounts; then
+		tst_res TINFO "The '$mntpoint' is not mounted upon, skipping umount"
 		return
 	fi
 
 	while [ "$i" -lt 50 ]; do
-		if umount "$device" > /dev/null; then
+		if umount "$mntpoint" > /dev/null; then
 			return
 		fi
 
 		i=$((i+1))
 
-		tst_res TINFO "umount($device) failed, try $i ..."
+		tst_res TINFO "umount($mntpoint) failed, try $i ..."
 		tst_res TINFO "Likely gvfsd-trash is probing newly mounted "\
 		              "fs, kill it to speed up tests."
 
 		tst_sleep 100ms
 	done
 
-	tst_res TWARN "Failed to umount($device) after 50 retries"
+	tst_res TWARN "Failed to umount($mntpoint) after 50 retries"
 }
 
 tst_mkfs()
-- 
2.17.0
