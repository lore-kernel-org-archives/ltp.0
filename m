From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Jan 2021 19:32:26 +0100
Subject: [LTP] [PATCH 1/1] zram: Check properly command dependencies
Message-ID: <20210114183226.794-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Instead of relying that there is mkfs.ext2 as a backup,
search for supported default.

Always check ext2 (in case there is enough space for btrfs but
no mkfs.btrfs).

This fixes error when even the default ext2 is not supported:

zram01 5 TINFO: make ext2 filesystem on /dev/zram0
/opt/ltp/testcases/bin/zram01.sh: line 188: mkfs.ext2: not found
zram01 5 TFAIL: failed to make ext2 on /dev/zram0

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

fix to be merged before release.

NOTE: Bug affecting BusyBox needs to be discussed:
http://lists.linux.it/pipermail/ltp/2021-January/020568.html

Kind regards,
Petr

 .../kernel/device-drivers/zram/zram_lib.sh    | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 3f4d1d55f..1a611b974 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -178,13 +178,30 @@ zram_swapoff()
 zram_makefs()
 {
 	tst_require_cmds mkfs
+
+	local default_fs fs
 	local i=0
 
+	for fs in $zram_filesystems ext2; do
+		if tst_supported_fs $fs 2> /dev/null; then
+			default_fs="$fs"
+			break
+		fi
+	done
+
+	if [ -z "$default_fs" ]; then
+		tst_res TINFO "supported filesystems"
+		tst_supported_fs > /dev/null
+		tst_brk TCONF "missing kernel support or mkfs for all of these filesystems: $zram_filesystems"
+	fi
+
 	for fs in $zram_filesystems; do
-		# if requested fs not supported default it to ext2
-		tst_supported_fs $fs 2> /dev/null || fs=ext2
+		# use default if requested fs not supported or missing mkfs
+		tst_supported_fs $fs 2> /dev/null && tst_cmd_available mkfs.$fs \
+			|| fs=$default_fs
 
 		tst_res TINFO "make $fs filesystem on /dev/zram$i"
+
 		mkfs.$fs /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
-- 
2.29.2

