From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed,  4 Nov 2020 15:04:05 +0800
Subject: [LTP] [PATCHv2] syscalls/quotactl04: add mkfs.ext4 package version
 check
Message-ID: <20201104070405.24044-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The project quota feature was added in e2fsprogs 1.43 [1]:
  E2fsprogs 1.43 (May 17, 2016)
    Add support for the ext4 metadata checksum, checksum seed, inline
    data, encryption, project quota, and read-only features.

The test should be skipped when running with older package, otherwise
it will fail with:
  Invalid filesystem option set: quota,project

Use popen and fscanf to get mkfs.ext4 -V output for version
comparison. This version checking by adding digits together does not
work with alphabets in the number like rc1, but in that case the test
will still be tested.

It will now be skipped with (Tested with Ubuntu Xenial + 4.15 kernel):
  quotactl04.c:118: TCONF: Test needs mkfs.ext4 >= 1.43 for encrypt
  option, test skipped

[1] http://e2fsprogs.sourceforge.net/e2fsprogs-release.html#1.42.13

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 73980d7e9..3cc2b974f 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -19,6 +19,8 @@
  * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
  *    ID with Q_GETNEXTQUOTA flag for project.
  * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
+ *
+ * Minimum e2fsprogs version required is 1.43.
  */
 
 #include <errno.h>
@@ -28,6 +30,7 @@
 #include <sys/stat.h>
 #include "config.h"
 #include "lapi/quotactl.h"
+#include "tst_safe_stdio.h"
 #include "tst_test.h"
 
 #ifndef QFMT_VFS_V1
@@ -102,9 +105,18 @@ static struct tcase {
 
 static void setup(void)
 {
+	FILE *f;
 	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
+	int rc, major, minor, patch;
 
 	test_id = geteuid();
+	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
+	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
+	if (rc != 3)
+		tst_res(TWARN, "Unable parse version number");
+	else if (major * 10000 + minor * 100 + patch < 14300)
+		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for quota,project option, test skipped");
+	pclose(f);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
 	mount_flag = 1;
-- 
2.17.1

