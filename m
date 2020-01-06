From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 6 Jan 2020 16:30:18 +0800
Subject: [LTP] [PATCH v2] tst_dev_bytes_written: parsing /proc/diskstats
 instead of sys file
Message-ID: <1578299418-4961-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Now, tst_dev_bytes_written api can get the whole disk stat correctly(such as /dev/sda),
but can not get partition stat correctly(such as /dev/sda5).
fail as below:
export LTP_DEV=/dev/sda5
tst_device.c:388: CONF: Test device stat file: /sys/block/sda5/stat not found

To fix this, use /proc/diskstats to parse instead of /sys/block/<devices>/stat.
Data format as same as diskstats_show function in kernel genhd.c[1].

Also, add hint when loop driver doesn't support blk-mq[2]. So that, user can export
LTP_DEV to test.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/genhd.c
[2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5dd2f60

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 lib/tst_device.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 10f71901d..ad764a38d 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -375,24 +375,22 @@ int tst_umount(const char *path)
 
 unsigned long tst_dev_bytes_written(const char *dev)
 {
-	struct stat st;
-	unsigned long dev_sec_write = 0, dev_bytes_written, io_ticks = 0;
-	char dev_stat_path[1024];
-
-	snprintf(dev_stat_path, sizeof(dev_stat_path), "/sys/block/%s/stat",
-		 strrchr(dev, '/') + 1);
+	unsigned long dev_sec_write = 0, dev_bytes_written;
+	unsigned int io_ticks = 0;
+	char fmt[1024];
 
-	if (stat(dev_stat_path, &st) != 0)
-		tst_brkm(TCONF, NULL, "Test device stat file: %s not found",
-			 dev_stat_path);
+	sprintf(fmt, "%%*4d %%*7d %s %%*lu %%*lu %%*lu %%*u %%*lu %%*lu %%lu %%*u %%*u %%u",
+			strrchr(dev, '/') + 1);
 
-	SAFE_FILE_SCANF(NULL, dev_stat_path,
-			"%*s %*s %*s %*s %*s %*s %lu %*s %*s %lu",
-			&dev_sec_write, &io_ticks);
+	SAFE_FILE_LINES_SCANF(NULL, "/proc/diskstats", fmt, &dev_sec_write, &io_ticks);
 
+	/* If we create block device by attaching a free loop device, loop driver
+	 * needs to support blk-mq(commit b5dd2f6047c), so that kernel can get I/O
+	 * statistics about loop device.
+	 */
 	if (!io_ticks)
-		tst_brkm(TCONF, NULL, "Test device stat file: %s broken",
-			 dev_stat_path);
+		tst_brkm(TCONF, NULL, "io_ticks on test device %s is always 0, "
+				"export LTP_DEV to test", dev);
 
 	dev_bytes_written = (dev_sec_write - prev_dev_sec_write) * 512;
 
-- 
2.18.0



