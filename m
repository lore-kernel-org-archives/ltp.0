From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Fri, 29 Jan 2016 23:56:25 +0800
Subject: [LTP] [PATCH] commands/mkswap01: Update wait_for_file function
Message-ID: <1454082985-3549-1-git-send-email-shuang.qiu@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shuang Qiu <shuang.qiu@oracle.com>

In commit a76b72ad31fa7bb22a09f323dadd5db7c00c7f56,it depends on the files 
under /dev/disk/by-* in wait_for_file function.But sometimes udev does not 
refresh automatically during runtime and the symbolic links will not appear.
Update the function to use blkid instead.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/commands/mkswap/mkswap01.sh |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
index ae4c98a..fdfc712 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -46,25 +46,26 @@ cleanup()
 	tst_rmdir
 }
 
-wait_for_file()
+wait_for_device()
 {
-	local path="$1"
+	local token="$1"
 	local retries=10
 
-	if [ -z "$path" ]; then
+	if [ -z "$token" ]; then
 		return
 	fi
 
 	while [ $retries -gt 0 ]; do
-		if [ -e "$path" ]; then
+		blkid -t "$token" $TST_DEVICE >/dev/null
+		if [ $? -eq 0 ]; then
 			return
 		fi
-		tst_resm TINFO "Waiting for $path to appear"
+		tst_resm TINFO "Waiting for device $token prepared"
 		retries=$((retries - 1))
 		tst_sleep 10ms
 	done
 
-	tst_resm TWARN "The file $path haven't appeared"
+	tst_resm TWARN "The device $token haven't prepared"
 }
 
 mkswap_verify()
@@ -72,7 +73,7 @@ mkswap_verify()
 	local mkswap_op="$1"
 	local op_arg="$2"
 	local swapfile="$3"
-	local dev_file="$5"
+	local token="$5"
 
 	local before=`awk '/SwapTotal/ {print $2}' /proc/meminfo`
 
@@ -84,7 +85,7 @@ mkswap_verify()
 		local pagesize=$PAGE_SIZE
 	fi
 
-	wait_for_file "$dev_file"
+	wait_for_device "$token"
 
 	swapon $swapfile 2>/dev/null
 
@@ -138,7 +139,7 @@ mkswap_test()
 	local op_arg="$2"
 	local device="$3"
 	local size="$4"
-	local dev_file="$5"
+	local token="$5"
 
 	local mkswap_cmd="mkswap $mkswap_op $op_arg $TST_DEVICE $size"
 
@@ -156,7 +157,7 @@ mkswap_test()
 	fi
 
 	if [ -n "$device" ]; then
-		mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size" "$dev_file"
+		mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size" "$token"
 		if [ $? -ne 0 ]; then
 			tst_resm TFAIL "'${mkswap_cmd}' failed, not expected."
 			return
@@ -173,9 +174,9 @@ mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-10000))"
 mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+10000))"
 mkswap_test "-c" "" "$TST_DEVICE"
 mkswap_test "-p" "2048" "$TST_DEVICE"
-mkswap_test "-L" "ltp_testswap" "-L ltp_testswap" "" "/dev/disk/by-label/ltp_testswap"
+mkswap_test "-L" "ltp_testswap" "-L ltp_testswap" "" "LABEL=ltp_testswap"
 mkswap_test "-v1" "" "$TST_DEVICE"
-mkswap_test "-U" "$UUID" "-U $UUID" "" "/dev/disk/by-uuid/$UUID"
+mkswap_test "-U" "$UUID" "-U $UUID" "" "UUID=$UUID"
 mkswap_test "-V"
 mkswap_test "-h"
 
-- 
1.7.9.5

