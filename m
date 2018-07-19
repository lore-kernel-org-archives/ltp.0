From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 19 Jul 2018 15:31:10 +0800
Subject: [LTP] [PATCH v2 2/2] zram/zram_lib.sh: Apply tst_supported_fs for
	shell
In-Reply-To: <1531985470-25203-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180718124638.GD7117@rei>
 <1531985470-25203-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1531985470-25203-2-git-send-email-yangx.jy@cn.fujitsu.com>
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

We should check for both kernel and mkfs command by tst_supported_fs, and use ext2
fielsystem by default if either of them doesn't support a specified filesystem.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 224b407..0203c4d 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -195,11 +195,12 @@ zram_swapoff()
 
 zram_makefs()
 {
-	tst_check_cmds mkfs which
+	tst_check_cmds mkfs
 	local i=0
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
-		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
+		tst_supported_fs $fs > /dev/null 2>&1
+		[ $? -eq 0 ] && fs=ext2
 
 		tst_resm TINFO "make $fs filesystem on /dev/zram$i"
 		mkfs.$fs /dev/zram$i > err.log 2>&1
-- 
1.8.3.1



