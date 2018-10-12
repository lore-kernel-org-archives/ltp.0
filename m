From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 12 Oct 2018 16:10:56 +0300
Subject: [LTP] [PATCH V2 4/5] runtest/commands: add _sh to all testcases
In-Reply-To: <1539349857-10633-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1539349857-10633-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1539349857-10633-4-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To avoid existing and possible name collisions in

http://lists.linux.it/pipermail/ltp/2018-October/009490.html

it was proposed to add '_sh' to all testcases in runtest/commands

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 - changed the naming scheme
 - changed names of all test cases in commands

 runtest/commands |   82 +++++++++++++++++++++++++++---------------------------
 1 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/runtest/commands b/runtest/commands
index 4626330..ac15e8b 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -1,42 +1,42 @@
 #DESCRIPTION:General Linux commands
-ar export TCdat=$LTPROOT/testcases/bin; ar01
-ld01 ld01
-ldd01 ldd01
-nm01 nm01
-file01 file01.sh
-tar01  tar_tests.sh
-logrotate export TCdat=$LTPROOT/testcases/bin; logrotate_tests.sh
-cpio01 cpio_tests.sh
-unzip01 unzip01.sh
-gzip01 gzip_tests.sh
-cp01 cp_tests.sh
-ln01 ln_tests.sh
-mkdir01 mkdir_tests.sh
-mv01 mv_tests.sh
-du01 du01.sh
-df01_ext2 df01.sh -f ext2
-df01_ext3 df01.sh -f ext3
-df01_ext4 df01.sh -f ext4
-df01_xfs df01.sh -f xfs
-df01_vfat df01.sh -f vfat
-df01_exfat df01.sh -f exfat
-df01_ntfs df01.sh -f ntfs
-mkfs01 mkfs01.sh
-mkfs01_ext2 mkfs01.sh -f ext2
-mkfs01_ext3 mkfs01.sh -f ext3
-mkfs01_ext4 mkfs01.sh -f ext4
-mkfs01_xfs mkfs01.sh -f xfs
-mkfs01_btrfs mkfs01.sh -f btrfs
-mkfs01_minix mkfs01.sh -f minix
-mkfs01_msdos mkfs01.sh -f msdos
-mkfs01_vfat mkfs01.sh -f vfat
-mkfs01_ntfs mkfs01.sh -f ntfs
-mkswap01 mkswap01.sh
-which01 which01.sh
-lsmod01 lsmod01.sh
-insmod01 insmod01.sh
-wc01 wc01.sh
-keyctl01 keyctl01.sh
-gdb01 gdb01.sh
-unshare01 unshare01.sh
-sysctl01 sysctl01.sh
+ar_sh export TCdat=$LTPROOT/testcases/bin; ar01
+ld01_sh ld01
+ldd01_sh ldd01
+nm01_sh nm01
+file01_sh file01.sh
+tar01_sh  tar_tests.sh
+logrotate_sh export TCdat=$LTPROOT/testcases/bin; logrotate_tests.sh
+cpio01_sh cpio_tests.sh
+unzip01_sh unzip01.sh
+gzip01_sh gzip_tests.sh
+cp01_sh cp_tests.sh
+ln01_sh ln_tests.sh
+mkdir01_sh mkdir_tests.sh
+mv01_sh mv_tests.sh
+du01_sh du01.sh
+df01_ext2_sh df01.sh -f ext2
+df01_ext3_sh df01.sh -f ext3
+df01_ext4_sh df01.sh -f ext4
+df01_xfs_sh df01.sh -f xfs
+df01_vfat_sh df01.sh -f vfat
+df01_exfat_sh df01.sh -f exfat
+df01_ntfs_sh df01.sh -f ntfs
+mkfs01_sh mkfs01.sh
+mkfs01_ext2_sh mkfs01.sh -f ext2
+mkfs01_ext3_sh mkfs01.sh -f ext3
+mkfs01_ext4_sh mkfs01.sh -f ext4
+mkfs01_xfs_sh mkfs01.sh -f xfs
+mkfs01_btrfs_sh mkfs01.sh -f btrfs
+mkfs01_minix_sh mkfs01.sh -f minix
+mkfs01_msdos_sh mkfs01.sh -f msdos
+mkfs01_vfat_sh mkfs01.sh -f vfat
+mkfs01_ntfs_sh mkfs01.sh -f ntfs
+mkswap01_sh mkswap01.sh
+which01_sh which01.sh
+lsmod01_sh lsmod01.sh
+insmod01_sh insmod01.sh
+wc01_sh wc01.sh
+keyctl01_sh keyctl01.sh
+gdb01_sh gdb01.sh
+unshare01_sh unshare01.sh
+sysctl01_sh sysctl01.sh
-- 
1.7.1

