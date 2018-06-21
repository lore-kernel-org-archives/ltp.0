From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 21 Jun 2018 11:27:05 +0800
Subject: [LTP] [PATCH] commands/mkswap01.sh: Revert the original retry loops
Message-ID: <1529551625-366-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before kernel commit c3473c6(e.g. RHEL6), mkswap -L or mkswap -U for loop
devices can not generate corresponding "/dev/disk/by-*" files and gets TBROK.
It is just a way to check the success of mkswap rather than a bug, so the test
should not get TBROK when "/dev/disk/by-*" files are not generated but swapon
enable loop devices for swapping sucessfully.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/commands/mkswap/mkswap01.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
index 5ead4cd..1c01c86 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -37,14 +37,25 @@ setup()
 	DEVICE_SIZE=$((($real_size/$PAGE_SIZE * $PAGE_SIZE)/1024))
 }
 
-check_for_file()
+wait_for_file()
 {
 	local path="$1"
+	local retries=10
 
-	if [ -z "$path" -o -e "$path" ]; then
+	if [ -z "$path" ]; then
 		return
 	fi
-	return 1
+
+	while [ $retries -gt 0 ]; do
+		if [ -e "$path" ]; then
+			return
+		fi
+		tst_res TINFO "Waiting for $path to appear"
+		retries=$((retries - 1))
+		tst_sleep 10ms
+	done
+
+	tst_res TINFO "The file $path haven't appeared"
 }
 
 mkswap_verify()
@@ -64,7 +75,7 @@ mkswap_verify()
 		local pagesize=$PAGE_SIZE
 	fi
 
-	TST_RETRY_FUNC "check_for_file $dev_file" 0
+	wait_for_file "$dev_file"
 
 	swapon $swapfile 2>/dev/null
 
-- 
1.8.3.1



