From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 10 Jul 2019 15:18:22 +0800
Subject: [LTP] [PATCH v3 1/3] lib: alter find_free_loopdev()
In-Reply-To: <CAOQ4uxhjbaszcCL0=QAncBT3PzqJR_7oyR+_0-zNa-pt6JNQSA@mail.gmail.com>
References: <CAOQ4uxhjbaszcCL0=QAncBT3PzqJR_7oyR+_0-zNa-pt6JNQSA@mail.gmail.com>
Message-ID: <1562743104-2705-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Alter find_free_loopdev() to return the free loopdev minor
(and -1 for no free loopdev) and then WE can safely use the
minor number that find_free_loopdev() returned in test cases.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt |  9 +++++++++
 include/tst_device.h            |  6 ++++++
 lib/tst_device.c                | 12 ++++++------
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index c6d4e001d..887801e68 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1045,6 +1045,15 @@ IMPORTANT: All testcases should use 'tst_umount()' instead of 'umount(2)' to
 -------------------------------------------------------------------------------
 #include "tst_test.h"
 
+int find_free_loopdev();
+-------------------------------------------------------------------------------
+This function finds a free loopdev for use and returns the free loopdev minor(-1
+for no free loopdev).
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
 unsigned long tst_dev_bytes_written(const char *dev);
 -------------------------------------------------------------------------------
 
diff --git a/include/tst_device.h b/include/tst_device.h
index 61902b7e0..8953b0828 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -44,6 +44,12 @@ int tst_umount(const char *path);
  */
 int tst_clear_device(const char *dev);
 
+/*
+ * Finds a free loop device for use and returns the free loopdev minor(-1 for no
+ * free loopdev).
+ */
+int find_free_loopdev(void);
+
 /*
  * Reads test block device stat file and returns the bytes written since the
  * last call of this function.
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 65fcc1337..3b87dd1f1 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -68,7 +68,7 @@ static int set_dev_path(int dev)
 	return 0;
 }
 
-static int find_free_loopdev(void)
+int find_free_loopdev(void)
 {
 	int ctl_fd, dev_fd, rc, i;
 	struct loop_info loopinfo;
@@ -82,10 +82,10 @@ static int find_free_loopdev(void)
 		if (rc >= 0) {
 			set_dev_path(rc);
 			tst_resm(TINFO, "Found free device '%s'", dev_path);
-			return 0;
+			return rc;
 		}
 		tst_resm(TINFO, "Couldn't find free loop device");
-		return 1;
+		return -1;
 	}
 
 	switch (errno) {
@@ -121,7 +121,7 @@ static int find_free_loopdev(void)
 				continue;
 			tst_resm(TINFO, "Found free device '%s'", dev_path);
 			close(dev_fd);
-			return 0;
+			return i;
 		}
 
 		close(dev_fd);
@@ -129,7 +129,7 @@ static int find_free_loopdev(void)
 
 	tst_resm(TINFO, "No free devices found");
 
-	return 1;
+	return -1;
 }
 
 static int attach_device(const char *dev, const char *file)
@@ -274,7 +274,7 @@ const char *tst_acquire_device__(unsigned int size)
 		return NULL;
 	}
 
-	if (find_free_loopdev())
+	if (find_free_loopdev() == -1)
 		return NULL;
 
 	if (attach_device(dev_path, DEV_FILE))
-- 
2.18.1



