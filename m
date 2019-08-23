From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 23 Aug 2019 16:07:59 +0800
Subject: [LTP] [PATCH v2] syscalls/copy_file_range02: use .needs_tmpdir and
 MAX_LEN
Message-ID: <1566547679-2771-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit bc514b22, we have removed EXDEV test. all_filesystem
,mount_device and mntpoint make no sense. Remove it and use tmpdir.

As man-page said, when we plan to write at a position past the maximum
allowed offset, it will return EFBIG. We should USE tst_max_lfs_filesize 
as dst instead of (tst_max_lfs_fileszie - MIN_OFF). Also, it doesn't affect 
EOVERFLOW.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 .../kernel/syscalls/copy_file_range/copy_file_range02.c     | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index a08df9bdb..d6e843ee4 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -115,7 +115,7 @@ static void verify_copy_file_range(unsigned int n)
 	}
 
 	if (tc->copy_to_fd == &fd_copy)
-		dst = tst_max_lfs_filesize() - MIN_OFF;
+		dst = tst_max_lfs_filesize();
 
 	TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
 				&dst, tc->len, tc->flags));
@@ -224,8 +224,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.mount_device = 1,
-	.mntpoint = MNTPOINT,
-	.all_filesystems = 1,
+	.needs_tmpdir = 1,
 	.test_variants = TEST_VARIANTS,
 };
-- 
2.18.1



