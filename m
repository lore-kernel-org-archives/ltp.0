From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 11 Jul 2018 16:55:25 +0800
Subject: [LTP] [PATCH] zram/zram_lib.sh: Check fielsystem support more
	throughly
Message-ID: <1531299325-27779-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When mkfs command supports a specified filesystem and kernel doesn't support it,
mkfs can format zram device to the filesystem successfully, but mount will fail
with "unknown filesystem type".

For example, running zram01 got the following error when only mkfs supported btrfs
filesystem:
---------------------------------------------------------------------------------
mount: /tmp/ltp-aJSv2PMZGl/zram01.46mBiYaa3M/zram3: unknown filesystem type 'btrfs'.
---------------------------------------------------------------------------------

We should add a fielsystem support check for both kernel and mkfs command, and use
ext2 fielsystem by default if either of them doesn't support a specified filesystem.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 224b407..d6ce74a 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -193,13 +193,27 @@ zram_swapoff()
 	tst_resm TPASS "swapoff completed"
 }
 
+zram_check_fs_support()
+{
+	tst_check_cmds which modprobe
+	local filesystem=$1
+
+	# Check if mkfs command supports fs
+	which mkfs.$filesystem > /dev/null 2>&1 || return 1
+
+	# Check if kernel supports fs
+	if ! grep -qw $filesystem /proc/filesystems; then
+		modprobe $filesystem > /dev/null 2>&1 || return 1
+	fi
+}
+
 zram_makefs()
 {
-	tst_check_cmds mkfs which
+	tst_check_cmds mkfs
 	local i=0
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
-		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
+		zram_check_fs_support $fs || fs=ext2
 
 		tst_resm TINFO "make $fs filesystem on /dev/zram$i"
 		mkfs.$fs /dev/zram$i > err.log 2>&1
-- 
1.8.3.1



