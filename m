From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sat, 27 Feb 2021 11:32:30 +0800
Subject: [LTP] [PATCH] fanotify13.c/setxattr01.c: Remove requirement of
 needs_tmpdir
Message-ID: <20210227033230.175881-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcases aim to run on all_filesystems, so we need remove the
requirement of needs_tmpdir.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/fanotify/fanotify13.c | 1 -
 testcases/kernel/syscalls/setxattr/setxattr01.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 6d812cdd1..1fb12ae68 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -289,7 +289,6 @@ static struct tst_test test = {
 	.setup = do_setup,
 	.cleanup = do_cleanup,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index 8b84dfe0d..8cd2821d0 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -210,7 +210,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 };

--
2.17.1

