From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Sun, 25 Apr 2021 11:04:40 +0800
Subject: [LTP] [PATCH] Ignore ntfs file system
Message-ID: <20210425030440.12762-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the fuse file system is ignored and the kernel enable CONFIG_NTFS_FS,
then the mount.ntfs of fuse is used when mounting ntfs,
which is equivalent to not ignoring the fuse file system.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
---
 testcases/kernel/syscalls/sync_file_range/sync_file_range02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index d9a8eec31..f9693089b 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -123,6 +123,7 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const []){
 		"fuse",
+		"ntfs",
 		"tmpfs",
 		NULL
 	},
--
2.20.1



