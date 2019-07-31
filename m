From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 31 Jul 2019 18:40:27 +0800
Subject: [LTP] [PATCH v7 1/3] lib: alter find_free_loopdev()
In-Reply-To: <20190730110555.GB7528@rei.lan>
References: <20190730110555.GB7528@rei.lan>
Message-ID: <1564569629-2358-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Alter find_free_loopdev() to tst_find_free_loopdev(path, path_len),
tst_acquire_device() passes the dev_path and path_len inside of
the tst_device.c. It returns the free loopdev minor (and -1 for no
free loopdev). If path is non-NULL, it will be filled with free
loopdev path. We also can call tst_find_free_loopdev(NULL, 0) to
make a customized loopdev by using mkdnod.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
-------
v6->v7:
     correct logic when use old detection way
---
---
 doc/test-writing-guidelines.txt | 12 +++++++++++
 include/tst_device.h            |  6 ++++++
 lib/tst_device.c                | 35 +++++++++++++++++++--------------
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index e59d72065..d21fbf76a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1053,6 +1053,18 @@ IMPORTANT: All testcases should use 'tst_umount()' instead of 'umount(2)' to
 -------------------------------------------------------------------------------
 #include "tst_test.h"
 
+int tst_find_free_loopdev(const char *path, size_t path_len);
+-------------------------------------------------------------------------------
+
+This function finds a free loopdev and returns the free loopdev minor (-1 for no
+free loopdev). If path is non-NULL, it will be filled with free loopdev path.
+If you want to use a customized loop device, we can call tst_find_free_loopdev
+(NULL, 0) in tests to get a free minor number. Then mknod.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
 unsigned long tst_dev_bytes_written(const char *dev);
 -------------------------------------------------------------------------------
 
diff --git a/include/tst_device.h b/include/tst_device.h
index 61902b7e0..f0ddc3e93 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -44,6 +44,12 @@ int tst_umount(const char *path);
  */
 int tst_clear_device(const char *dev);
 
+/*
+ * Finds a free loop device for use and returns the free loopdev minor(-1 for no
+ * free loopdev). If path is non-NULL, it will be filled with free loopdev path.
+ *
+ */
+int tst_find_free_loopdev(const char *path, size_t path_len);
 /*
  * Reads test block device stat file and returns the bytes written since the
  * last call of this function.
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 65fcc1337..3eb51bee1 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -53,25 +53,26 @@ static const char *dev_variants[] = {
 	"/dev/block/loop%i"
 };
 
-static int set_dev_path(int dev)
+static int set_dev_path(int dev, char *path, size_t path_len)
 {
 	unsigned int i;
 	struct stat st;
 
 	for (i = 0; i < ARRAY_SIZE(dev_variants); i++) {
-		snprintf(dev_path, sizeof(dev_path), dev_variants[i], dev);
+		snprintf(path, path_len, dev_variants[i], dev);
 
-		if (stat(dev_path, &st) == 0 && S_ISBLK(st.st_mode))
+		if (stat(path, &st) == 0 && S_ISBLK(st.st_mode))
 			return 1;
 	}
 
 	return 0;
 }
 
-static int find_free_loopdev(void)
+int tst_find_free_loopdev(char *path, size_t path_len)
 {
 	int ctl_fd, dev_fd, rc, i;
 	struct loop_info loopinfo;
+	char buf[1024];
 
 	/* since Linux 3.1 */
 	ctl_fd = open(LOOP_CONTROL_FILE, O_RDWR);
@@ -80,12 +81,14 @@ static int find_free_loopdev(void)
 		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
 		close(ctl_fd);
 		if (rc >= 0) {
-			set_dev_path(rc);
-			tst_resm(TINFO, "Found free device '%s'", dev_path);
-			return 0;
+			if (path)
+				set_dev_path(rc, path, path_len);
+			tst_resm(TINFO, "Found free device %d '%s'",
+				rc, path ?: "");
+			return rc;
 		}
 		tst_resm(TINFO, "Couldn't find free loop device");
-		return 1;
+		return -1;
 	}
 
 	switch (errno) {
@@ -106,22 +109,24 @@ static int find_free_loopdev(void)
 	 */
 	for (i = 0; i < 256; i++) {
 
-		if (!set_dev_path(i))
+		if (!set_dev_path(i, buf, sizeof(buf)))
 			continue;
 
-		dev_fd = open(dev_path, O_RDONLY);
+		dev_fd = open(buf, O_RDONLY);
 
 		if (dev_fd < 0)
 			continue;
 
 		if (ioctl(dev_fd, LOOP_GET_STATUS, &loopinfo) == 0) {
-			tst_resm(TINFO, "Device '%s' in use", dev_path);
+			tst_resm(TINFO, "Device '%s' in use", buf);
 		} else {
 			if (errno != ENXIO)
 				continue;
-			tst_resm(TINFO, "Found free device '%s'", dev_path);
+			tst_resm(TINFO, "Found free device '%s'", buf);
 			close(dev_fd);
-			return 0;
+			if (path != NULL)
+				strncpy(path, buf, path_len);
+			return i;
 		}
 
 		close(dev_fd);
@@ -129,7 +134,7 @@ static int find_free_loopdev(void)
 
 	tst_resm(TINFO, "No free devices found");
 
-	return 1;
+	return -1;
 }
 
 static int attach_device(const char *dev, const char *file)
@@ -274,7 +279,7 @@ const char *tst_acquire_device__(unsigned int size)
 		return NULL;
 	}
 
-	if (find_free_loopdev())
+	if (tst_find_free_loopdev(dev_path, sizeof(dev_path)) == -1)
 		return NULL;
 
 	if (attach_device(dev_path, DEV_FILE))
-- 
2.18.1



