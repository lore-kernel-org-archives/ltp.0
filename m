From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 12 Mar 2020 17:31:01 +0530
Subject: [LTP] [PATCH V6 01/10] tst_device: Add tst_is_mounted() and
 tst_is_mounted_at_tmpdir() helpers
In-Reply-To: <cover.1584014172.git.viresh.kumar@linaro.org>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
Message-ID: <4ee56e50f8b239ce74ec295bdd1caa8395da509e.1584014172.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch moves the ismount() helper added to the fsmount syscall tests
to the standard library and renames it to tst_is_mounted() and also adds
a new helper tst_is_mounted_at_tmpdir(). These helpers can be used
across different files now.

Minor modifications are also done to the helper.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_device.h                          |  7 +++
 lib/tst_device.c                              | 44 +++++++++++++++++++
 testcases/kernel/syscalls/fsmount/fsmount01.c | 25 +----------
 3 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 04577eb1ac55..950cfe1edcba 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -24,6 +24,13 @@ extern struct tst_device *tst_device;
  */
 int tst_umount(const char *path);
 
+/*
+ * Verifies if an earlier mount is successful or not.
+ * @path: Mount path to verify
+ */
+int tst_is_mounted(const char *path);
+int tst_is_mounted_at_tmpdir(const char *path);
+
 /*
  * Clears a first few blocks of the device. This is needed when device has
  * already been formatted with a filesystems, subset of mkfs.foo utils aborts
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8b5459def1cb..a703512d2aeb 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -386,6 +386,50 @@ int tst_umount(const char *path)
 	return -1;
 }
 
+int tst_is_mounted(const char *path)
+{
+	char line[PATH_MAX];
+	FILE *file;
+	int ret = 0;
+
+	file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, path) != NULL) {
+			ret = 1;
+			break;
+		}
+	}
+
+	SAFE_FCLOSE(NULL, file);
+
+	if (!ret)
+		tst_resm(TINFO, "No device is mounted at %s", path);
+
+	return ret;
+}
+
+int tst_is_mounted_at_tmpdir(const char *path)
+{
+	char cdir[PATH_MAX], mpath[PATH_MAX];
+	int ret;
+
+	if (!getcwd(cdir, PATH_MAX)) {
+		tst_resm(TWARN | TERRNO, "Failed to find current directory");
+		return 0;
+	}
+
+	ret = snprintf(mpath, PATH_MAX, "%s/%s", cdir, path);
+	if (ret < 0 || ret >= PATH_MAX) {
+		tst_resm(TWARN | TERRNO,
+			 "snprintf() should have returned %d instead of %d",
+			 PATH_MAX, ret);
+		return 0;
+	}
+
+	return tst_is_mounted(mpath);
+}
+
 int find_stat_file(const char *dev, char *path, size_t path_len)
 {
 	const char *devname = strrchr(dev, '/') + 1;
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 83185b48aedd..530a794647c1 100644
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
+	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
 		SAFE_UMOUNT(MNTPOINT);
 		is_mounted = 0;
-	} else {
-		tst_res(TFAIL, "device not mounted");
 	}
 }
 
-- 
2.21.0.rc0.269.g1a574e7a288b

