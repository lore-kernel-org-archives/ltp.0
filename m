From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 19 Feb 2020 14:57:57 +0530
Subject: [LTP] [PATCH V2 01/10] tst_device: Add tst_ismount() helper
In-Reply-To: <cover.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <199f58740e42bbdbcba0c847c194f62d2b3bb37b.1582104018.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch moves the ismount() helper added to the fsmount syscall tests
to the standard library and renames it to tst_ismount(). The helper can
be used across different files now.

Minor modifications are also done to the helper.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_device.h                          |  6 +++++
 lib/tst_device.c                              | 25 +++++++++++++++++++
 testcases/kernel/syscalls/fsmount/fsmount01.c | 25 +------------------
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 3ad33bd48e10..3f4aaf6f75ab 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -36,6 +36,12 @@ extern struct tst_device *tst_device;
  */
 int tst_umount(const char *path);
 
+/*
+ * Verifies if an earlier mount is successful or not.
+ * @path: Mount path to verify
+ */
+int tst_ismount(const char *path);
+
 /*
  * Clears a first few blocks of the device. This is needed when device has
  * already been formatted with a filesystems, subset of mkfs.foo utils aborts
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8b5459def1cb..4d66b5d45996 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -386,6 +386,31 @@ int tst_umount(const char *path)
 	return -1;
 }
 
+int tst_ismount(const char *path)
+{
+	char line[256];
+	FILE *file;
+	int ret = -1;
+
+	file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, path) != NULL) {
+			ret = 0;
+			break;
+		}
+	}
+
+	SAFE_FCLOSE(NULL, file);
+
+	if (ret) {
+		errno = ENOENT;
+		tst_resm(TWARN, "No device is mounted at %s", path);
+	}
+
+	return ret;
+}
+
 int find_stat_file(const char *dev, char *path, size_t path_len)
 {
 	const char *devname = strrchr(dev, '/') + 1;
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 83185b48aedd..5b8e95176728 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -12,30 +12,10 @@
 #include "tst_test.h"
 #include "lapi/fcntl.h"
 #include "lapi/fsmount.h"
-#include "tst_safe_stdio.h"
 
-#define LINELENGTH 256
 #define MNTPOINT "newmount_point"
 static int sfd, mfd, is_mounted;
 
-static int ismount(char *mntpoint)
-{
-	int ret = 0;
-	FILE *file;
-	char line[LINELENGTH];
-
-	file = SAFE_FOPEN("/proc/mounts", "r");
-
-	while (fgets(line, sizeof(line), file)) {
-		if (strstr(line, mntpoint) != NULL) {
-			ret = 1;
-			break;
-		}
-	}
-	SAFE_FCLOSE(file);
-	return ret;
-}
-
 static void cleanup(void)
 {
 	if (is_mounted)
@@ -76,12 +56,9 @@ static void test_fsmount(void)
 	tst_res(TPASS, "move_mount() attached to the mount point");
 	SAFE_CLOSE(mfd);
 
-	if (ismount(MNTPOINT)) {
-		tst_res(TPASS, "device mounted");
+	if (!tst_ismount(MNTPOINT)) {
 		SAFE_UMOUNT(MNTPOINT);
 		is_mounted = 0;
-	} else {
-		tst_res(TFAIL, "device not mounted");
 	}
 }
 
-- 
2.21.0.rc0.269.g1a574e7a288b

