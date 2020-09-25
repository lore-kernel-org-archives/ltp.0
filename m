From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 25 Sep 2020 12:27:24 +0200
Subject: [LTP] [PATCH] Fix search for device ID in tst_find_backing_dev()
Message-ID: <20200925102724.25815-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The current search using substrings can lead to false positives, e.g. search
for device 0:5 could return device 10:50 instead. Parse device IDs in
/proc/self/mountinfo properly using sscanf() and also check whether the device
was really found.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_device.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 0e98a7280..c096b418b 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -497,21 +497,26 @@ unsigned long tst_dev_bytes_written(const char *dev)
 
 void tst_find_backing_dev(const char *path, char *dev)
 {
-	char fmt[20];
 	struct stat buf;
 	FILE *file;
 	char line[PATH_MAX];
 	char *pre = NULL;
 	char *next = NULL;
+	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
 
 	if (stat(path, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
 
-	snprintf(fmt, sizeof(fmt), "%u:%u", major(buf.st_dev), minor(buf.st_dev));
+	dev_major = major(buf.st_dev);
+	dev_minor = minor(buf.st_dev);
 	file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
+	*dev = '\0';
 
 	while (fgets(line, sizeof(line), file)) {
-		if (strstr(line, fmt) != NULL) {
+		if (sscanf(line, "%*d %*d %d:%d", &line_mjr, &line_mnr) != 2)
+			continue;
+
+		if (line_mjr == dev_major && line_mnr == dev_minor) {
 			pre = strstr(line, " - ");
 			pre = strtok_r(pre, " ", &next);
 			pre = strtok_r(NULL, " ", &next);
@@ -523,8 +528,11 @@ void tst_find_backing_dev(const char *path, char *dev)
 
 	SAFE_FCLOSE(NULL, file);
 
+	if (!*dev)
+		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
+
 	if (stat(dev, &buf) < 0)
-		 tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
+		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
 
 	if (S_ISBLK(buf.st_mode) != 1)
 		tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
-- 
2.28.0

