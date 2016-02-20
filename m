From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Sat, 20 Feb 2016 16:34:10 +0300
Subject: [LTP] [RFC PATCH 1/2] tst_acquire_device: clear first sectors of
	LTP_DEV
Message-ID: <1455975251-30056-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mkfs.ext{2,3,4} on sparc64 does not clear the first two
sectors of a partition. Therefore, if one creates a vfat
file system on a block device and then creates an ext2 file
system, this new ext2 file system will not be mountable without
'-t specified':

~# dd if=/dev/zero of=/dev/vg/test
~# mkfs.vfat /dev/vg/test
~# mkfs.ext2 /dev/vg/test
~# mount /dev/vg/test /mnt
mount: you must specify the filesystem type

This situation may be reproduced with runtest/commands, where
df01_vfat may be followed (if there is no mkfs.exfat, mkfs.ntfs)
by mkfs01, mkfs01_ext2 and etc. If this is the case, then
mkfs01_ext{2,3,4} will fail.

As we see in [1] ZAP_BOOTBLOCK is defined on all archs except SPARC.
I could not find the exact reason why it's so, but tend to think
that it was implemented to let ext{2,3,4} be created on the first
partition of a Sun disk label. The thing is that with Sun disk labels
it's absolutely fine to have the first partition starting at sector 0,
which is used by the disk label itself:

~# fdisk -lu /dev/vdiska

Disk /dev/vdiska (Sun disk label): 255 heads, 63 sectors, 3916 cylinders
Units = sectors of 1 * 512 bytes

      Device Flag    Start       End    Blocks   Id  System
/dev/vdiska1             0   2104515   1052257+   1  Boot
/dev/vdiska2       2104515  62910540  30403012+  83  Linux native
/dev/vdiska3             0  62910540  31455270    5  Whole disk

If mkfs.ext{2,3,4} overwrote the first two sectors, then
'mkfs.ext{2,3,4} /dev/vdiska1' would destroy the disk label.

Clearing the first 512k of LTP_DEV solves this issue. I don't expect
it to make a noticeable impact on test execution time. 512k is fine
to cover superblocks of all file systems supported by libblkid [2].
Just in case.

[1] http://git.kernel.org/cgit/fs/ext2/e2fsprogs.git/tree/misc/mke2fs.c
[2] https://github.com/karelzak/util-linux/tree/master/libblkid/src/superblocks

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 lib/tst_device.c      |    5 +++++
 testcases/lib/test.sh |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 260ed7b..ed6b2a1 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -203,6 +203,11 @@ const char *tst_acquire_device(void (cleanup_fn)(void))
 			         "%s is not a block device", dev);
 		}
 
+		if (tst_fill_file(dev, 0, 1024, 512)) {
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				 "Failed to clear the first 512k of %s", dev);
+		}
+
 		return dev;
 	}
 
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index eeaf0b6..9b652c0 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -259,6 +259,9 @@ tst_acquire_device()
 		if [ ! -b ${LTP_DEV} ]; then
 			tst_brkm TBROK "${LTP_DEV} is not a block device"
 		fi
+
+		ROD_SILENT dd if=/dev/zero of="${LTP_DEV}" bs=1024 count=512
+
 		TST_DEVICE=${LTP_DEV}
 		TST_DEVICE_FLAG=0
 		return
-- 
1.7.1

