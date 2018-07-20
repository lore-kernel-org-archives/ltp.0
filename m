From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 20 Jul 2018 18:40:13 +0800
Subject: [LTP] [PATCH v3 2/2] zram/zram_lib.sh: Apply tst_supported_fs for
	shell
In-Reply-To: <1532083213-4803-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180719122126.GA16703@rei>
 <1532083213-4803-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1532083213-4803-2-git-send-email-yangx.jy@cn.fujitsu.com>
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

We should check both kernel and mkfs command by tst_supported_fs binary, and use
ext2 fielsystem by default if either of them doesn't support a specified filesystem.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 224b407..36d1603 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -195,11 +195,11 @@ zram_swapoff()
 
 zram_makefs()
 {
-	tst_check_cmds mkfs which
+	tst_check_cmds mkfs
 	local i=0
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
-		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
+		tst_supported_fs $fs 2> /dev/null || fs=ext2
 
 		tst_resm TINFO "make $fs filesystem on /dev/zram$i"
 		mkfs.$fs /dev/zram$i > err.log 2>&1
-- 
1.8.3.1



