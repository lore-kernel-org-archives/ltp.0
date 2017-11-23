From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 23 Nov 2017 09:36:13 +0800
Subject: [LTP] [PATCH v2] lib/tst_device.c: Fix failure when using old
	mkfs.btrfs
In-Reply-To: <20171122145822.GF2389@rei.lan>
References: <20171122145822.GF2389@rei.lan>
Message-ID: <1511400973-23446-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We always got the following error when using mkfs.btrfs(v0.20-rc1)
on RHEL6.9GA.  For example:
---------------------------------------------------------------------------
./fallocate04
...
tst_mkfs.c:83: INFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
error checking /dev/loop0 mount status
tst_mkfs.c:94: BROK: mkfs.btrfs:1: tst_test.c failed with 693
---------------------------------------------------------------------------

After just calling LOOP_SET_FD to set up loopdev, newer mkfs.btrfs can
get associated filename by backing_file successfully.  However older
one cannot get associated filename by LOOP_GET_STATUS which is replaced
by backing_file since btrfs-progs v3.12.  So we call LOOP_SET_FD and
LOOP_SET_STATUS to set up loopdev when using all kinds of mkfs.btrfs.

The backing_file was produced in kernel(since v2.6.37):
'ee86273062cb("loop: add some basic read-only sysfs attributes")'

The backing_file began to be used by mkfs.btrfs on btrfs_progs(v3.12):
'abdb0ced0123("Btrfs-progs: fix resolving of loop devices")'

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_device.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 6ad6c47..4b73f0b 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -134,6 +134,7 @@ static int find_free_loopdev(void)
 static int attach_device(const char *dev, const char *file)
 {
 	int dev_fd, file_fd;
+	struct loop_info loopinfo;
 
 	dev_fd = open(dev, O_RDWR);
 	if (dev_fd < 0) {
@@ -156,6 +157,21 @@ static int attach_device(const char *dev, const char *file)
 		return 1;
 	}
 
+	/* Old mkfs.btrfs use LOOP_GET_STATUS instead of backing_file to get
+	 * associated filename, so we need to set up the device by calling
+	 * LOOP_SET_FD and LOOP_SET_STATUS.
+	 */
+	memset(&loopinfo, 0, sizeof(loopinfo));
+	strcpy(loopinfo.lo_name, file);
+
+	if (ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo)) {
+		close(dev_fd);
+		close(file_fd);
+		tst_resm(TWARN | TERRNO,
+			 "ioctl(%s, LOOP_SET_STATUS, %s) failed", dev, file);
+		return 1;
+	}
+
 	close(dev_fd);
 	close(file_fd);
 	return 0;
-- 
1.8.3.1



