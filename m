From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  9 Mar 2021 18:11:04 +0100
Subject: [LTP] [PATCH 2/2] syscalls/quotactl: Skip tests if FS quota is not
 supported
In-Reply-To: <20210309171104.30821-1-mdoucha@suse.cz>
References: <20210309171104.30821-1-mdoucha@suse.cz>
Message-ID: <20210309171104.30821-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/quotactl/quotactl01.c     |  2 ++
 .../kernel/syscalls/quotactl/quotactl04.c     | 26 +++++++++++++++++--
 .../kernel/syscalls/quotactl/quotactl06.c     |  2 ++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 7b3649fa5..e5fa02acb 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -172,6 +172,8 @@ static void setup(void)
 	if (access(GRPPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "group quotafile didn't exist");
 
+	tst_require_quota_support(tst_device->dev, fmt_id, USRPATH);
+
 	TEST(quotactl(QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
 		test_id, (void *) &res_ndq));
 	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index c8fa916b2..fd3afc888 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
+#include <sys/mount.h>
 #include "config.h"
 #include "lapi/quotactl.h"
 #include "tst_safe_stdio.h"
@@ -103,6 +104,28 @@ static struct tcase {
 
 };
 
+static void do_mount(const char *source, const char *target,
+	const char *filesystemtype, unsigned long mountflags,
+	const void *data)
+{
+	TEST(mount(source, target, filesystemtype, mountflags, data));
+
+	if (TST_RET == -1 && TST_ERR == ESRCH)
+		tst_brk(TCONF, "Kernel or device does not support FS quotas");
+
+	if (TST_RET == -1) {
+		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
+			source, target, filesystemtype, mountflags, data);
+	}
+
+	if (TST_RET) {
+		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
+			source, target, filesystemtype, mountflags, data);
+	}
+
+	mount_flag = 1;
+}
+
 static void setup(void)
 {
 	FILE *f;
@@ -118,8 +141,7 @@ static void setup(void)
 		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for quota,project option, test skipped");
 	pclose(f);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
-	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
-	mount_flag = 1;
+	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 2818a4dc4..6288f5fa2 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -153,6 +153,8 @@ static void setup(void)
 	if (access(USRPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
 
+	tst_require_quota_support(tst_device->dev, fmt_id, USRPATH);
+
 	SAFE_MKDIR(TESTDIR1, 0666);
 	test_id = geteuid();
 	test_invalid = test_id + 1;
-- 
2.30.0

