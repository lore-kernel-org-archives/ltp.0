From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 1 Mar 2021 10:25:50 +0800
Subject: [LTP] [PATCH] De-duplication: Remove requirement of needs_tmpdir
Message-ID: <20210301022550.96228-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The flag is not needed to be set when use these flags: '.all_filesystems',
'.format_device', '.mntpoint', '.mount_device' '.needs_checkpoints',
'.needs_device', '.resource_file'. These flags imply creating temporary
directory.

For those:
	fanotify13.c
	setxattr01.c
	fanotify16.c
	close_range01.c
	clone301.c
	fanotify09.c

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/clone3/clone301.c           | 1 -
 testcases/kernel/syscalls/close_range/close_range01.c | 1 -
 testcases/kernel/syscalls/fanotify/fanotify09.c       | 1 -
 testcases/kernel/syscalls/fanotify/fanotify13.c       | 1 -
 testcases/kernel/syscalls/fanotify/fanotify16.c       | 1 -
 testcases/kernel/syscalls/setxattr/setxattr01.c       | 1 -
 6 files changed, 6 deletions(-)

diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
index bf009e940..11787fc7e 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -172,7 +172,6 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.needs_checkpoints = 1,
 	.bufs = (struct tst_buffers []) {
 		{&args, .size = sizeof(*args)},
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
index 56def2426..6ecd4576e 100644
--- a/testcases/kernel/syscalls/close_range/close_range01.c
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -190,7 +190,6 @@ static void run(unsigned int n)

 static struct tst_test test = {
 	.tcnt = 4,
-	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.mount_device = 1,
 	.mntpoint = "mnt",
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 918e40274..089655d29 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -365,7 +365,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "54a307ba8d3c"},
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
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index c4b8a5abc..801d05cc2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -562,7 +562,6 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.all_filesystems = 1,
-	.needs_tmpdir = 1,
 	.needs_root = 1
 };

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

