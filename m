From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 30 Jul 2020 18:53:57 +0800
Subject: [LTP] [PATCH v1] tst_find_backing_dev: modify find bdev logic
Message-ID: <1596106437-28781-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On proc(5) man-pages,  it says:
36 35 98:0 /mnt1 /mnt2 rw,noatime master:1 - ext3 /dev/root rw,errors=continue
(1)(2)(3)   (4)   (5)      (6)      (7)   (8) (9)   (10)         (11)

(7)  optional fields: zero or more fields of the form
     "tag[:value]"; see below.

So we cannot really parse the information with a static scanf() string,
since the number of elements in the line is not constant.

As cyril suggested, use " - " to delim string and get the bdev value after two fileds.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt |  2 +-
 lib/tst_device.c                | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 10e0cdd75..67aed1ac9 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1098,7 +1098,7 @@ voud tst_find_backing_dev(const char *path, char *dev);
 
 This function finds the block dev that this path belongs to, it uses stat function
 to get the major/minor number of the path. Then scan them in "/proc/self/mountinfo"
-and list 10th column value as its block dev if match succeeds.
+and list 2th column value after ' - ' string as its block dev if match succeeds.
 
 2.2.16 Formatting a device with a filesystem
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8d8bc5b40..0e98a7280 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -497,16 +497,31 @@ unsigned long tst_dev_bytes_written(const char *dev)
 
 void tst_find_backing_dev(const char *path, char *dev)
 {
-	char fmt[1024];
+	char fmt[20];
 	struct stat buf;
+	FILE *file;
+	char line[PATH_MAX];
+	char *pre = NULL;
+	char *next = NULL;
 
 	if (stat(path, &buf) < 0)
-		 tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
+		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
 
-	snprintf(fmt, sizeof(fmt), "%%*i %%*i %u:%u %%*s %%*s %%*s %%*s %%*s %%*s %%s %%*s",
-			major(buf.st_dev), minor(buf.st_dev));
+	snprintf(fmt, sizeof(fmt), "%u:%u", major(buf.st_dev), minor(buf.st_dev));
+	file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, fmt) != NULL) {
+			pre = strstr(line, " - ");
+			pre = strtok_r(pre, " ", &next);
+			pre = strtok_r(NULL, " ", &next);
+			pre = strtok_r(NULL, " ", &next);
+			strcpy(dev, pre);
+			break;
+		}
+	}
 
-	SAFE_FILE_LINES_SCANF(NULL, "/proc/self/mountinfo", fmt, dev);
+	SAFE_FCLOSE(NULL, file);
 
 	if (stat(dev, &buf) < 0)
 		 tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
-- 
2.23.0



