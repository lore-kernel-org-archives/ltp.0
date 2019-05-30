From: Murphy Zhou <xzhou@redhat.com>
Date: Thu, 30 May 2019 18:23:36 +0800
Subject: [LTP] [PATCH 2/2] syscalls: update tcases using dev_fs_type to use
	some_filesystems
In-Reply-To: <20190530102336.10898-1-xzhou@redhat.com>
References: <20190530102336.10898-1-xzhou@redhat.com>
Message-ID: <20190530102336.10898-2-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Not all of them. Some tests need to run specific filesystem.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 .../kernel/syscalls/copy_file_range/copy_file_range02.c   | 8 ++++++--
 testcases/kernel/syscalls/getxattr/getxattr04.c           | 7 +++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index 07c0207c2..de200febe 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -47,6 +47,8 @@ static struct tcase {
 	{&fd_dest,	-1,	EINVAL},
 };
 
+static char *some_filesystems[] = {"ext4", "xfs"};
+
 static void verify_copy_file_range(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
@@ -111,8 +113,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.mount_device = 1,
+	.mount_device = 0,
+	.needs_device = 1,
+	.format_device = 1,
 	.mntpoint = MNTPOINT,
-	.dev_fs_type = "ext4",
+	.some_filesystems = some_filesystems,
 	.test_variants = TEST_VARIANTS,
 };
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index 1dcb14da3..c5ae03f46 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -54,6 +54,7 @@
 static volatile int end;
 static char big_value[512];
 static char small_value[32];
+static char *some_filesystems[] = {"ext4", "xfs"};
 
 static void sigproc(int sig)
 {
@@ -120,9 +121,11 @@ static void setup(void)
 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
-	.mount_device = 1,
-	.dev_fs_type = "xfs",
+	.mount_device = 0,
+	.needs_device = 1,
+	.format_device = 1,
 	.mntpoint = MNTPOINT,
+	.some_filesystems = some_filesystems,
 	.forks_child = 1,
 	.test_all = verify_getxattr,
 	.setup = setup
-- 
2.21.0

