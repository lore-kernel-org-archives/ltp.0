From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 16:26:38 +0100
Subject: [LTP] [PATCH 2/3] syscalls: Make use of format_device/mount_device
	flags
In-Reply-To: <20170214152639.11603-1-chrubis@suse.cz>
References: <20170214152639.11603-1-chrubis@suse.cz>
Message-ID: <20170214152639.11603-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/access/access04.c     | 18 +++---------------
 testcases/kernel/syscalls/creat/creat06.c       | 20 +++-----------------
 testcases/kernel/syscalls/quotactl/quotactl01.c | 19 ++++---------------
 testcases/kernel/syscalls/quotactl/quotactl02.c | 20 ++++----------------
 testcases/kernel/syscalls/umount/umount01.c     |  4 +---
 testcases/kernel/syscalls/umount/umount02.c     |  3 +--
 testcases/kernel/syscalls/umount/umount03.c     |  3 +--
 7 files changed, 17 insertions(+), 70 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index f43c38c..820aab6 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -54,7 +54,6 @@
 
 static uid_t uid;
 static char longpathname[PATH_MAX + 2];
-int mount_flag;
 
 static struct tcase {
 	const char *pathname;
@@ -119,18 +118,6 @@ static void setup(void)
 
 	SAFE_SYMLINK(SNAME1, SNAME2);
 	SAFE_SYMLINK(SNAME2, SNAME1);
-
-	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
-	SAFE_MKDIR(MNT_POINT, 0755);
-	SAFE_MOUNT(tst_device->dev, MNT_POINT, tst_device->fs_type,
-		MS_RDONLY, NULL);
-	mount_flag = 1;
-}
-
-static void cleanup(void)
-{
-	if (mount_flag)
-		tst_umount(MNT_POINT);
 }
 
 static struct tst_test test = {
@@ -138,9 +125,10 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
 	.needs_root = 1,
-	.needs_device = 1,
 	.forks_child = 1,
+	.mount_device = 1,
+	.mntpoint = MNT_POINT,
+	.mnt_flags = MS_RDONLY,
 	.setup = setup,
-	.cleanup = cleanup,
 	.test = verify_access,
 };
diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 73913cd..db0850a 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -71,7 +71,6 @@
 #define	MODE2		0666
 
 static void setup(void);
-static void cleanup(void);
 static void test6_setup(void);
 static void test6_cleanup(void);
 #if !defined(UCLINUX)
@@ -80,7 +79,6 @@ static void bad_addr_setup(int);
 
 static struct passwd *ltpuser;
 static char long_name[PATH_MAX+2];
-static int mount_flag;
 
 static struct test_case_t {
 	char *fname;
@@ -140,13 +138,6 @@ static void setup(void)
 
 	SAFE_SYMLINK(TEST7_FILE, "test_file_eloop2");
 	SAFE_SYMLINK("test_file_eloop2", TEST7_FILE);
-
-	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
-
-	SAFE_MKDIR("mntpoint", 0777);
-	SAFE_MOUNT(tst_device->dev, "mntpoint", tst_device->fs_type,
-	           MS_RDONLY, NULL);
-	mount_flag = 1;
 }
 
 #if !defined(UCLINUX)
@@ -170,19 +161,14 @@ static void test6_cleanup(void)
 	SAFE_SETEUID(0);
 }
 
-static void cleanup(void)
-{
-	if (mount_flag)
-		tst_umount("mntpoint");
-}
-
 static struct tst_test test = {
 	.tid = "creat06",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_creat,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-	.needs_device = 1,
-	.cleanup = cleanup,
+	.mount_device = 1,
+	.mntpoint = "mntpoint",
+	.mnt_flags = MS_RDONLY,
 	.setup = setup,
 };
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index e6baa2e..a994e95 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -78,7 +78,6 @@
 
 # define MNTPOINT	"mntpoint"
 
-static int mount_flag;
 static int32_t fmt_id = FMTID;
 static int test_id;
 static struct dqblk set_dq = {
@@ -163,12 +162,6 @@ static void setup(void)
 	const char *const cmd[] = {"quotacheck", "-ug", MNTPOINT, NULL};
 	int ret;
 
-	SAFE_MKDIR(MNTPOINT, 0755);
-
-	SAFE_MKFS(tst_device->dev, "ext4", NULL, NULL);
-
-	SAFE_MOUNT(tst_device->dev, MNTPOINT, "ext4", 0, "usrquota,grpquota");
-	mount_flag = 1;
 
 	ret = tst_run_cmd(cmd, NULL, NULL, 1);
 	switch (ret) {
@@ -189,12 +182,6 @@ static void setup(void)
 		tst_brk(TFAIL | TERRNO, "group quotafile didn't exist");
 }
 
-static void cleanup(void)
-{
-	if (mount_flag && tst_umount(MNTPOINT) < 0)
-		tst_res(TWARN | TERRNO, "umount(2) failed");
-}
-
 static void verify_quota(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
@@ -225,9 +212,11 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
-	.needs_device = 1,
+	.mount_device = 1,
+	.dev_fs_type = "ext4",
+	.mntpoint = MNTPOINT,
+	.mnt_data = "usrquota,grpquota",
 	.setup = setup,
-	.cleanup = cleanup
 };
 
 #else
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index d3bd946..f7ae78b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -47,7 +47,6 @@ static void check_qon(char *);
 static void check_qlim(char *);
 
 static int test_id;
-static int mount_flag;
 static struct fs_disk_quota set_dquota = {
 	.d_rtb_softlimit = 1000,
 	.d_fieldmask = FS_DQ_RTBSOFT
@@ -138,22 +137,9 @@ static void check_qlim(char *desp)
 
 static void setup(void)
 {
-	SAFE_MKDIR(mntpoint, 0755);
-
-	SAFE_MKFS(tst_device->dev, "xfs", NULL, NULL);
-
-	SAFE_MOUNT(tst_device->dev, mntpoint, "xfs", 0, "usrquota");
-	mount_flag = 1;
-
 	test_id = geteuid();
 }
 
-static void cleanup(void)
-{
-	if (mount_flag && tst_umount(mntpoint) < 0)
-		tst_res(TWARN | TERRNO, "umount() failed");
-}
-
 static void verify_quota(unsigned int n)
 {
 	struct t_case *tc = &tcases[n];
@@ -173,9 +159,11 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
-	.needs_device = 1,
+	.mount_device = 1,
+	.dev_fs_type = "xfs",
+	.mntpoint = mntpoint,
+	.mnt_data = "usrquota",
 	.setup = setup,
-	.cleanup = cleanup
 };
 #else
 	TST_TEST_TCONF("This system didn't support quota or xfs quota");
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index a8da4f4..3b5aeb9 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -55,8 +55,6 @@ static void verify_umount(void)
 
 static void setup(void)
 {
-	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
-
 	SAFE_MKDIR(MNTPOINT, 0775);
 }
 
@@ -70,7 +68,7 @@ static struct tst_test test = {
 	.tid = "umount01",
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-	.needs_device = 1,
+	.format_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_umount,
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index ecfad1b..690ba5f 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -76,7 +76,6 @@ static void setup(void)
 {
 	memset(long_path, 'a', PATH_MAX + 1);
 
-	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
 	SAFE_MKDIR(MNTPOINT, 0775);
 	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 	mount_flag = 1;
@@ -98,7 +97,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-	.needs_device = 1,
+	.format_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_umount,
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index 4b13240..c1bcb05 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -52,7 +52,6 @@ static void setup(void)
 {
 	struct passwd *pw;
 
-	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
 	SAFE_MKDIR(MNTPOINT, 0775);
 	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 	mount_flag = 1;
@@ -74,7 +73,7 @@ static struct tst_test test = {
 	.tid = "umount03",
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-	.needs_device = 1,
+	.format_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_umount,
-- 
2.10.2

