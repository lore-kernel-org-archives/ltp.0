From: Li Wang <liwang@redhat.com>
Date: Wed, 31 Aug 2016 17:58:19 +0800
Subject: [LTP] [PATCH v4] test.sh: make the loop device size can be increased
Message-ID: <1472637499-6076-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For the purpose of satisfying specific requirements, here adding
parameter '@size' to tst_acquire_device() to make the test device
can be increased according to real need.

This change gives a limitation for the test device size, you can just
set '-1' as default, it's requred that at least 150MB for the function.

And, updating test-writing-guidelines.txt documents.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/test-writing-guidelines.txt                   | 12 ++++++----
 include/old/old_device.h                          |  4 ++--
 lib/tests/tst_device.c                            |  2 +-
 lib/tst_device.c                                  | 29 +++++++++++++++++------
 lib/tst_test.c                                    |  2 +-
 testcases/kernel/syscalls/access/access06.c       |  2 +-
 testcases/kernel/syscalls/acct/acct01.c           |  2 +-
 testcases/kernel/syscalls/chmod/chmod06.c         |  2 +-
 testcases/kernel/syscalls/chown/chown04.c         |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod06.c       |  2 +-
 testcases/kernel/syscalls/fchown/fchown04.c       |  2 +-
 testcases/kernel/syscalls/ftruncate/ftruncate04.c |  2 +-
 testcases/kernel/syscalls/inotify/inotify03.c     |  2 +-
 testcases/kernel/syscalls/lchown/lchown03.c       |  2 +-
 testcases/kernel/syscalls/link/link08.c           |  2 +-
 testcases/kernel/syscalls/linkat/linkat02.c       |  2 +-
 testcases/kernel/syscalls/mkdir/mkdir03.c         |  2 +-
 testcases/kernel/syscalls/mkdirat/mkdirat02.c     |  2 +-
 testcases/kernel/syscalls/mknod/mknod07.c         |  2 +-
 testcases/kernel/syscalls/mknodat/mknodat02.c     |  2 +-
 testcases/kernel/syscalls/mmap/mmap16.c           |  2 +-
 testcases/kernel/syscalls/mount/mount01.c         |  2 +-
 testcases/kernel/syscalls/mount/mount02.c         |  2 +-
 testcases/kernel/syscalls/mount/mount03.c         |  2 +-
 testcases/kernel/syscalls/mount/mount04.c         |  2 +-
 testcases/kernel/syscalls/mount/mount06.c         |  2 +-
 testcases/kernel/syscalls/open/open12.c           |  2 +-
 testcases/kernel/syscalls/quotactl/quotactl02.c   |  2 +-
 testcases/kernel/syscalls/rename/rename11.c       |  2 +-
 testcases/kernel/syscalls/renameat/renameat01.c   |  2 +-
 testcases/kernel/syscalls/rmdir/rmdir02.c         |  2 +-
 testcases/kernel/syscalls/umount/umount01.c       |  2 +-
 testcases/kernel/syscalls/umount/umount02.c       |  2 +-
 testcases/kernel/syscalls/umount/umount03.c       |  2 +-
 testcases/kernel/syscalls/umount2/umount2_01.c    |  2 +-
 testcases/kernel/syscalls/umount2/umount2_02.c    |  2 +-
 testcases/kernel/syscalls/umount2/umount2_03.c    |  2 +-
 testcases/kernel/syscalls/utime/utime06.c         |  2 +-
 testcases/kernel/syscalls/utimes/utimes01.c       |  2 +-
 testcases/lib/test.sh                             |  8 +++++--
 40 files changed, 74 insertions(+), 51 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index c7d301f..44dd444 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1318,12 +1318,16 @@ Following functions similar to the LTP C interface are available.
 * tst_rmdir()
 * tst_fs_has_free()
 * tst_mkfs()
-* tst_acquire_device()
 * tst_release_device()
 
-There is one more function called 'tst_check_cmds()' that gets unspecified
-number of parameters and asserts that each parameter is a name of an
-executable in '$PATH' and exits the test with 'TCONF' on first missing.
+One more function called 'tst_check_cmds()' that gets unspecified number
+of parameters and asserts that each parameter is a name of an executable
+in '$PATH' and exits the test with 'TCONF' on first missing.
+
+Another one is 'tst_acquire_device()' that looks for LTP_DEV env variable
+first (which may be passed by the test driver or by a user) and returns while
+it's value greater than 150MB. It also does clear first sectors of $LTP_DEV
+and makes the block device size can be increased according to real need.
 
 tst_sleep
 +++++++++
diff --git a/include/old/old_device.h b/include/old/old_device.h
index 4dae05e..94870c0 100644
--- a/include/old/old_device.h
+++ b/include/old/old_device.h
@@ -36,13 +36,13 @@ const char *tst_dev_fs_type(void);
  * Looks for LTP_DEV env variable first (which may be passed by the test
  * driver or by a user) and returns just it's value if found.
  *
- * Otherwise creates a temp file and loop device.
+ * Otherwise creates a temp file and loop device according to real need.
  *
  * Note that you have to call tst_tmpdir() beforehand.
  *
  * Returns path to the device or NULL if it cannot be created.
  */
-const char *tst_acquire_device(void (cleanup_fn)(void));
+const char *tst_acquire_device(void (cleanup_fn)(void), const int size);
 
 /*
  * @dev: device path returned by the tst_acquire_device()
diff --git a/lib/tests/tst_device.c b/lib/tests/tst_device.c
index c010475..e22eb9d 100644
--- a/lib/tests/tst_device.c
+++ b/lib/tests/tst_device.c
@@ -40,7 +40,7 @@ int main(void)
 {
 	tst_tmpdir();
 
-	dev = tst_acquire_device(cleanup);
+	dev = tst_acquire_device(cleanup, -1);
 	if (!dev)
 		tst_brkm(TCONF, cleanup, "Failed to acquire test device");
 
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 30b1be2..5226d0f 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -182,10 +182,15 @@ static void detach_device(const char *dev)
 		"ioctl(%s, LOOP_CLR_FD, 0) no ENXIO for too long", dev);
 }
 
-const char *tst_acquire_device(void (cleanup_fn)(void))
+const char *tst_acquire_device(void (cleanup_fn)(void), const int size)
 {
+	int fd;
 	char *dev;
 	struct stat st;
+	unsigned long acq_dev_size;
+	unsigned long ltp_dev_size;
+
+	acq_dev_size = size > 150 ? size : 150;
 
 	if (device_acquired)
 		tst_brkm(TBROK, cleanup_fn, "Device allready acquired");
@@ -204,18 +209,28 @@ const char *tst_acquire_device(void (cleanup_fn)(void))
 
 		if (!S_ISBLK(st.st_mode)) {
 			tst_brkm(TBROK, cleanup_fn,
-			         "%s is not a block device", dev);
+					"%s is not a block device", dev);
 		}
 
-		if (tst_fill_file(dev, 0, 1024, 512)) {
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
-				 "Failed to clear the first 512k of %s", dev);
+		fd = SAFE_OPEN(cleanup_fn, dev, O_RDONLY);
+		SAFE_IOCTL(cleanup_fn, fd, BLKGETSIZE64, &ltp_dev_size);
+		SAFE_CLOSE(cleanup_fn, fd);
+		ltp_dev_size = ltp_dev_size/1024/1024;
+
+		if (acq_dev_size <= ltp_dev_size) {
+			if (tst_fill_file(dev, 0, 1024, 512)) {
+				tst_brkm(TBROK | TERRNO, cleanup_fn,
+					"Failed to clear the first 512k of %s", dev);
+			}
+
+			return dev;
 		}
 
-		return dev;
+		tst_resm(TINFO, "Skipping $LTP_DEV size %luMB, requested size %luMB",
+				ltp_dev_size, acq_dev_size);
 	}
 
-	if (tst_fill_file(DEV_FILE, 0, 1024, 153600)) {
+	if (tst_fill_file(DEV_FILE, 0, 1024, 1024 * acq_dev_size)) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 		         "Failed to create " DEV_FILE);
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 12ca051..8b37d75 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -596,7 +596,7 @@ static void do_setup(int argc, char *argv[])
 	}
 
 	if (tst_test->needs_device) {
-		tdev.dev = tst_acquire_device(NULL);
+		tdev.dev = tst_acquire_device(NULL, -1);
 		tdev.fs_type = tst_dev_fs_type();
 
 		if (!tdev.dev)
diff --git a/testcases/kernel/syscalls/access/access06.c b/testcases/kernel/syscalls/access/access06.c
index e9372f8..6f476ac 100644
--- a/testcases/kernel/syscalls/access/access06.c
+++ b/testcases/kernel/syscalls/access/access06.c
@@ -88,7 +88,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 3137c05..8d57438 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -145,7 +145,7 @@ static void setup(void)
 
 	/* EROFS SETTING */
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index 0cb060e..4882c45 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -181,7 +181,7 @@ void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index 7827067..22b7979 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -145,7 +145,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index 619d54e..4cc50e7 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -122,7 +122,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index bae0796..783a182 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
@@ -104,7 +104,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index b10c6dd..68da7f1 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -235,7 +235,7 @@ static void setup(void)
 	tst_resm(TINFO, "TMPDIR does not support mandatory locks");
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 2ad75b4..66b11b5 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -174,7 +174,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
diff --git a/testcases/kernel/syscalls/lchown/lchown03.c b/testcases/kernel/syscalls/lchown/lchown03.c
index 3f66a38..e2eaba8 100644
--- a/testcases/kernel/syscalls/lchown/lchown03.c
+++ b/testcases/kernel/syscalls/lchown/lchown03.c
@@ -97,7 +97,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
index 05662e2..83068d1 100644
--- a/testcases/kernel/syscalls/link/link08.c
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -131,7 +131,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 6766b5a..f73bf6d 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -149,7 +149,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 5b43ab4..7a90078 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -106,7 +106,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat02.c b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
index e4dd999..2b58f87 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat02.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
@@ -95,7 +95,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index bdb6640..24dcd39 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -118,7 +118,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index 0216aa2..c66272d 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -118,7 +118,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index b23700d..0b86839 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -156,7 +156,7 @@ static void setup(void)
 
 	page_size = getpagesize();
 
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 	tst_mkfs(cleanup, device, fs_type, fs_opts, "10240");
diff --git a/testcases/kernel/syscalls/mount/mount01.c b/testcases/kernel/syscalls/mount/mount01.c
index 1d902ba..1fe8aa2 100644
--- a/testcases/kernel/syscalls/mount/mount01.c
+++ b/testcases/kernel/syscalls/mount/mount01.c
@@ -78,7 +78,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
index e8adfe0..85da470 100644
--- a/testcases/kernel/syscalls/mount/mount02.c
+++ b/testcases/kernel/syscalls/mount/mount02.c
@@ -181,7 +181,7 @@ static void setup(void)
 	SAFE_TOUCH(cleanup, file, FILE_MODE, NULL);
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index a8abbff..de60636 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -355,7 +355,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/mount/mount04.c b/testcases/kernel/syscalls/mount/mount04.c
index e931d6d..7dc3bca 100644
--- a/testcases/kernel/syscalls/mount/mount04.c
+++ b/testcases/kernel/syscalls/mount/mount04.c
@@ -93,7 +93,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/mount/mount06.c b/testcases/kernel/syscalls/mount/mount06.c
index 143c9af..58c3a5f 100644
--- a/testcases/kernel/syscalls/mount/mount06.c
+++ b/testcases/kernel/syscalls/mount/mount06.c
@@ -124,7 +124,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 4702d08..26f45b9 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -99,7 +99,7 @@ static void setup(void)
 		}
 
 		fs_type = tst_dev_fs_type();
-		device = tst_acquire_device(cleanup);
+		device = tst_acquire_device(cleanup, -1);
 
 		if (!device) {
 			tst_resm(TINFO, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 486ea93..b048f5c 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -202,7 +202,7 @@ static void setup(void)
 
 	SAFE_MKDIR(cleanup, mntpoint, 0755);
 
-	block_dev = tst_acquire_device(cleanup);
+	block_dev = tst_acquire_device(cleanup, -1);
 
 	if (!block_dev)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
index 0c3e3b3..f0bcbaa 100644
--- a/testcases/kernel/syscalls/rename/rename11.c
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -99,7 +99,7 @@ static void setup(void)
 	TEST_PAUSE;
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index f6797da..48928ea 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -147,7 +147,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index 9e75818..85d1db2 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -132,7 +132,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index 4597651..10b528c 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -88,7 +88,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index 7d469fd..fbd804f 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -112,7 +112,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index 322005e..b691143 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -95,7 +95,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
index 46a6d59..c84684a 100644
--- a/testcases/kernel/syscalls/umount2/umount2_01.c
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -73,7 +73,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index 7d558fa..1272dd9 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -113,7 +113,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/umount2/umount2_03.c b/testcases/kernel/syscalls/umount2/umount2_03.c
index a8fddf6..ee891ab 100644
--- a/testcases/kernel/syscalls/umount2/umount2_03.c
+++ b/testcases/kernel/syscalls/umount2/umount2_03.c
@@ -93,7 +93,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index 5a02f1e..b7b1e5c 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -115,7 +115,7 @@ static void setup(void)
 	SAFE_TOUCH(cleanup, TEMP_FILE, 0644, NULL);
 
 	fs_type = tst_dev_fs_type();
-	dev = tst_acquire_device(cleanup);
+	dev = tst_acquire_device(cleanup, -1);
 	if (!dev)
 		tst_brkm(TCONF, cleanup, "Failed to acquire test device");
 
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index 6cade0e..7f6331a 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -124,7 +124,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	device = tst_acquire_device(cleanup, -1);
 
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index a1fa2d9..76b7062 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -283,11 +283,15 @@ EXPECT_FAIL()
 
 tst_acquire_device()
 {
+	local acq_dev_size=${1:-150}
+
 	if [ -z ${TST_TMPDIR} ]; then
 		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
 	fi
 
-	if [ -n "${LTP_DEV}" ]; then
+	ltp_dev_size=$((`blockdev --getsize64 $LTP_DEV`/1024/1024))
+
+	if [ -n "${LTP_DEV}" ] && [ ${acq_dev_size} -le ${ltp_dev_size} ]; then
 		tst_resm TINFO "Using test device LTP_DEV='${LTP_DEV}'"
 		if [ ! -b ${LTP_DEV} ]; then
 			tst_brkm TBROK "${LTP_DEV} is not a block device"
@@ -300,7 +304,7 @@ tst_acquire_device()
 		return
 	fi
 
-	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=153600
+	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$((1024*$acq_dev_size))
 
 	TST_DEVICE=$(losetup -f)
 	if [ $? -ne 0 ]; then
-- 
1.8.3.1

