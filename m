From: Murphy Zhou <xzhou@redhat.com>
Date: Fri, 31 May 2019 17:56:59 +0800
Subject: [LTP] [PATCH] syscalls: testing on all fs for copy_file_range02 and
	getxattr04
Message-ID: <20190531095659.22796-1-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To increase test coverage. If the testing fs is not supporting
this syscall, tcase handles it well.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/copy_file_range/copy_file_range02.c | 2 +-
 testcases/kernel/syscalls/getxattr/getxattr04.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index 07c0207c2..d3fb737be 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -113,6 +113,6 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
-	.dev_fs_type = "ext4",
+	.all_filesystems = 1,
 	.test_variants = TEST_VARIANTS,
 };
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index 1dcb14da3..905abd587 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -121,7 +121,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.mount_device = 1,
-	.dev_fs_type = "xfs",
+	.all_filesystems = 1,
 	.mntpoint = MNTPOINT,
 	.forks_child = 1,
 	.test_all = verify_getxattr,
-- 
2.21.0

