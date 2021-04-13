From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Apr 2021 19:29:15 +0200
Subject: [LTP] [PATCH 1/2] [COMMITTED] syscalls/*sync: Skip test on tmpfs
Message-ID: <20210413172916.24434-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As sync() is no-op for tmpfs no bytes are transfered.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fdatasync/fdatasync03.c           | 4 ++++
 testcases/kernel/syscalls/fsync/fsync04.c                   | 4 ++++
 testcases/kernel/syscalls/msync/msync04.c                   | 4 ++++
 testcases/kernel/syscalls/sync/sync01.c                     | 4 ++++
 .../kernel/syscalls/sync_file_range/sync_file_range02.c     | 6 +++++-
 testcases/kernel/syscalls/syncfs/syncfs01.c                 | 4 ++++
 6 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync03.c b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
index 263175b85..5f3e0c96f 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync03.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
@@ -58,4 +58,8 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.mntpoint = MNTPOINT,
 	.test_all = verify_fdatasync,
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	}
 };
diff --git a/testcases/kernel/syscalls/fsync/fsync04.c b/testcases/kernel/syscalls/fsync/fsync04.c
index 1e4b8754c..9aa1584c1 100644
--- a/testcases/kernel/syscalls/fsync/fsync04.c
+++ b/testcases/kernel/syscalls/fsync/fsync04.c
@@ -58,4 +58,8 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.mntpoint = MNTPOINT,
 	.test_all = verify_fsync,
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	}
 };
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 7c295d961..4a564a3d1 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -98,5 +98,9 @@ static struct tst_test test = {
 	.mntpoint = "msync04",
 	.mount_device = 1,
 	.all_filesystems = 1,
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	},
 	.min_kver = "2.6.25",
 };
diff --git a/testcases/kernel/syscalls/sync/sync01.c b/testcases/kernel/syscalls/sync/sync01.c
index dc093d863..423662678 100644
--- a/testcases/kernel/syscalls/sync/sync01.c
+++ b/testcases/kernel/syscalls/sync/sync01.c
@@ -53,6 +53,10 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.all_filesystems = 1,
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	},
 	.mntpoint = MNTPOINT,
 	.test_all = verify_sync,
 };
diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index f68f46233..d9a8eec31 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -121,7 +121,11 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.skip_filesystems = (const char *const []){"fuse", NULL},
+	.skip_filesystems = (const char *const []){
+		"fuse",
+		"tmpfs",
+		NULL
+	},
 	.mntpoint = MNTPOINT,
 	.setup = setup,
 	.test = run,
diff --git a/testcases/kernel/syscalls/syncfs/syncfs01.c b/testcases/kernel/syscalls/syncfs/syncfs01.c
index 333726eaa..24e3f2285 100644
--- a/testcases/kernel/syscalls/syncfs/syncfs01.c
+++ b/testcases/kernel/syscalls/syncfs/syncfs01.c
@@ -62,6 +62,10 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.all_filesystems = 1,
+	.skip_filesystems = (const char*[]) {
+		"tmpfs",
+		NULL
+	},
 	.mntpoint = MNTPOINT,
 	.setup = setup,
 	.test_all = verify_syncfs,
-- 
2.26.3

