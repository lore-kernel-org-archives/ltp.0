From: Li Wang <liwang@redhat.com>
Date: Tue,  7 Jan 2020 15:13:24 +0800
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
Message-ID: <20200107071324.29492-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To follow up commit: 0e2ec72de49ab48c151a3c30a1e6ea0cdaea321c
  tst_device: do sync() before reading test block device stat file

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt                        |  5 ++++-
 include/tst_device.h                                   | 10 ++++++++++
 testcases/kernel/syscalls/fdatasync/fdatasync03.c      |  3 +--
 testcases/kernel/syscalls/fsync/fsync04.c              |  3 +--
 testcases/kernel/syscalls/sync/sync03.c                |  3 +--
 .../syscalls/sync_file_range/sync_file_range02.c       |  3 +--
 testcases/kernel/syscalls/syncfs/syncfs01.c            |  3 +--
 7 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 88f771823..dfe28ef3f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1072,7 +1072,10 @@ unsigned long tst_dev_bytes_written(const char *dev);
 -------------------------------------------------------------------------------
 
 This function reads test block device stat file (/sys/block/<device>/stat) and
-returns the bytes written since the last invocation of this function.
+returns the bytes written since the last invocation of this function. To avoid
+FS deferred IO metadata/cache interferes the result, we suggest doing "syncfs"
+before the tst_dev_bytes_written first invocation. And an inline function named
+tst_dev_sync is created for that intention.
 
 2.2.16 Formatting a device with a filesystem
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/include/tst_device.h b/include/tst_device.h
index 56835e712..992d1383d 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -68,6 +68,16 @@ int tst_attach_device(const char *dev_path, const char *file_path);
  */
 int tst_detach_device(const char *dev_path);
 
+/*
+ * To avoid FS deferred IO metadata/cache interferes test result, so we do
+ * syncfs simply before the tst_dev_bytes_written invocation. For easy to
+ * use, we create this inline function tst_dev_sync.
+ */
+static inline void tst_dev_sync(int fd)
+{
+	syncfs(fd);
+}
+
 /*
  * Reads test block device stat file and returns the bytes written since the
  * last call of this function.
diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync03.c b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
index 032ac4b58..263175b85 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync03.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
@@ -32,8 +32,7 @@ static void verify_fdatasync(void)
 
 	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
 
-	sync();
-
+	tst_dev_sync(fd);
 	tst_dev_bytes_written(tst_device->dev);
 
 	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
diff --git a/testcases/kernel/syscalls/fsync/fsync04.c b/testcases/kernel/syscalls/fsync/fsync04.c
index 3c1f45e94..1e4b8754c 100644
--- a/testcases/kernel/syscalls/fsync/fsync04.c
+++ b/testcases/kernel/syscalls/fsync/fsync04.c
@@ -32,8 +32,7 @@ static void verify_fsync(void)
 
 	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
 
-	sync();
-
+	tst_dev_sync(fd);
 	tst_dev_bytes_written(tst_device->dev);
 
 	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
diff --git a/testcases/kernel/syscalls/sync/sync03.c b/testcases/kernel/syscalls/sync/sync03.c
index 085ccfdeb..c5c02f877 100644
--- a/testcases/kernel/syscalls/sync/sync03.c
+++ b/testcases/kernel/syscalls/sync/sync03.c
@@ -32,8 +32,7 @@ static void verify_sync(void)
 
 	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
 
-	sync();
-
+	tst_dev_sync(fd);
 	tst_dev_bytes_written(tst_device->dev);
 
 	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index 1a6d84c49..64d069e93 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -48,8 +48,7 @@ static void verify_sync_file_range(struct testcase *tc)
 
 	lseek(fd, tc->write_off, SEEK_SET);
 
-	sync();
-
+	tst_dev_sync(fd);
 	tst_dev_bytes_written(tst_device->dev);
 
 	tst_fill_fd(fd, 0, TST_MB, tc->write_size_mb);
diff --git a/testcases/kernel/syscalls/syncfs/syncfs01.c b/testcases/kernel/syscalls/syncfs/syncfs01.c
index 3cf404450..333726eaa 100644
--- a/testcases/kernel/syscalls/syncfs/syncfs01.c
+++ b/testcases/kernel/syscalls/syncfs/syncfs01.c
@@ -33,8 +33,7 @@ static void verify_syncfs(void)
 
 	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
 
-	sync();
-
+	tst_dev_sync(fd);
 	tst_dev_bytes_written(tst_device->dev);
 
 	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
-- 
2.20.1

