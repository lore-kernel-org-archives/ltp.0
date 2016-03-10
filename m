From: Zorro Lang <zlang@redhat.com>
Date: Fri, 11 Mar 2016 00:38:52 +0800
Subject: [LTP] [PATCH v3] tst_mkfs: add new parameter extra_opt to tst_mkfs
	function
Message-ID: <1457627932-12674-1-git-send-email-zlang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mmap16 always hit ETIMEDOUT error, if the test device is too large.
mkfs on the device will take lots of time. So I want to make ext4
with an appointed size. But the [fs_size] need behind the device
name for ext4, e.g. "mkfs -t ext4 dev [fs_size]".

Due to above reason, add a new parameter extra_opt to tst_mkfs.
extra_opt store the option need to behind the device name of mkfs.
Then mmap16 can make ext4 with an appointed (small) size. And this
change can make tst_mkfs() cover one more mkfs usage.

Due to I only find one option maybe need to behind the device name,
so I use extra_opt. If there're more, the extra_opt should be
changed to extra_opts[].

Because of tst_mkfs be changed, all testcases which use tst_mkfs add
NULL parameter for extra_opt.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi Cyril,

This's the V3 patch(actually I have sent many versions about this:)
Change from V2:
1. change extra_opts to extra_opt.
2. delete uncorrect syntax in ascii-doc.
3. use extra_opt ? extra_opt : "", and remove useless fs_extra_opts.

Thanks,
Zorro

 doc/test-writing-guidelines.txt                    |  9 ++++++--
 include/test.h                                     |  6 +++--
 lib/tests/tst_device.c                             |  2 +-
 lib/tst_mkfs.c                                     | 27 +++++++++++++++++++---
 testcases/kernel/io/direct_io/dma_thread_diotest.c |  2 +-
 testcases/kernel/syscalls/access/access06.c        |  2 +-
 testcases/kernel/syscalls/acct/acct01.c            |  2 +-
 testcases/kernel/syscalls/chmod/chmod06.c          |  2 +-
 testcases/kernel/syscalls/chown/chown04.c          |  2 +-
 testcases/kernel/syscalls/creat/creat06.c          |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod06.c        |  2 +-
 testcases/kernel/syscalls/fchown/fchown04.c        |  2 +-
 testcases/kernel/syscalls/ftruncate/ftruncate04.c  |  2 +-
 testcases/kernel/syscalls/inotify/inotify03.c      |  2 +-
 testcases/kernel/syscalls/lchown/lchown03.c        |  2 +-
 testcases/kernel/syscalls/link/link08.c            |  2 +-
 testcases/kernel/syscalls/linkat/linkat02.c        |  2 +-
 testcases/kernel/syscalls/mkdir/mkdir03.c          |  2 +-
 testcases/kernel/syscalls/mkdirat/mkdirat02.c      |  2 +-
 testcases/kernel/syscalls/mknod/mknod07.c          |  2 +-
 testcases/kernel/syscalls/mknodat/mknodat02.c      |  2 +-
 testcases/kernel/syscalls/mmap/mmap16.c            |  2 +-
 testcases/kernel/syscalls/mount/mount01.c          |  2 +-
 testcases/kernel/syscalls/mount/mount02.c          |  2 +-
 testcases/kernel/syscalls/mount/mount03.c          |  2 +-
 testcases/kernel/syscalls/mount/mount04.c          |  2 +-
 testcases/kernel/syscalls/mount/mount05.c          |  2 +-
 testcases/kernel/syscalls/mount/mount06.c          |  2 +-
 testcases/kernel/syscalls/open/open12.c            |  2 +-
 testcases/kernel/syscalls/quotactl/quotactl02.c    |  2 +-
 testcases/kernel/syscalls/rename/rename11.c        |  2 +-
 testcases/kernel/syscalls/renameat/renameat01.c    |  2 +-
 testcases/kernel/syscalls/rmdir/rmdir02.c          |  2 +-
 testcases/kernel/syscalls/umount/umount01.c        |  2 +-
 testcases/kernel/syscalls/umount/umount02.c        |  2 +-
 testcases/kernel/syscalls/umount/umount03.c        |  2 +-
 testcases/kernel/syscalls/umount2/umount2_01.c     |  2 +-
 testcases/kernel/syscalls/umount2/umount2_02.c     |  2 +-
 testcases/kernel/syscalls/umount2/umount2_03.c     |  2 +-
 testcases/kernel/syscalls/utime/utime06.c          |  2 +-
 testcases/kernel/syscalls/utimes/utimes01.c        |  2 +-
 41 files changed, 73 insertions(+), 45 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 1f260cb..f270526 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -906,15 +906,20 @@ NOTE: The default filesytem is hardcoded to 'ext2' in the sources and can be
 #include "test.h"
 
 void tst_mkfs(void (cleanup_fn)(void), const char *dev,
-              const char *fs_type, const char *const fs_opts[]);
+              const char *fs_type, const char *const fs_opts[]
+              const char *extra_opt);
 -------------------------------------------------------------------------------
 
 This function takes a path to a device, filesystem type and an array of extra
 options passed to mkfs.
 
-The extra options 'fs_opts' should either be 'NULL' if there are none, or a
+The fs options 'fs_opts' should either be 'NULL' if there are none, or a
 'NULL' terminated array of strings such as '{"-b", "1024", NULL}'.
 
+The extra options 'extra_opt' should either be 'NULL' if there are none, or
+a string such as "102400". 'extra_opt' will be used behind device name. e.g:
+mkfs -t ext4 -b 1024 /dev/sda1 102400
+
 2.2.16 Verifying a filesystem's free space
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/include/test.h b/include/test.h
index 5c78b1d..edd2069 100644
--- a/include/test.h
+++ b/include/test.h
@@ -316,10 +316,12 @@ int tst_system(const char *command);
  *
  * @dev: path to a device
  * @fs_type: filesystem type
- * @fs_opts: NULL or NULL terminated array of extra mkfs options
+ * @fs_opts: NULL or NULL terminated array of mkfs options
+ * @extra_opt: extranal mkfs options which need to behind the device name
  */
 void tst_mkfs(void (cleanup_fn)(void), const char *dev,
-	      const char *fs_type, const char *const fs_opts[]);
+              const char *fs_type, const char *const fs_opts[],
+              const char *extra_opt);
 
 /*
  * Returns filesystem type to be used for the testing. Unless your test is
diff --git a/lib/tests/tst_device.c b/lib/tests/tst_device.c
index 6a7925e..525bdc0 100644
--- a/lib/tests/tst_device.c
+++ b/lib/tests/tst_device.c
@@ -46,7 +46,7 @@ int main(void)
 
 	printf("Test device='%s'\n", dev);
 
-	tst_mkfs(cleanup, dev, "ext2", NULL);
+	tst_mkfs(cleanup, dev, "ext2", NULL, NULL);
 
 	cleanup();
 	tst_exit();
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 5f959a4..3710b4b 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -21,8 +21,19 @@
 
 #define OPTS_MAX 32
 
+/*
+ * tst_mkfs: mkfs.$fs_type on $dev with options $fs_opts and $extra_opt
+ *     cleanup_fn - run it when exit with error.
+ *     dev        - device path name
+ *     fs_opts    - store the options for mkfs (except -t fs_type). Set
+ *                  NULL if don't need options.
+ *     extra_opt - extranal mkfs options for mkfs, these options need
+ *                  behind the device name, e.g. [fs_size] for ext4.
+ *                  Set NULL, if don't need options behind device name.
+ */
 void tst_mkfs(void (cleanup_fn)(void), const char *dev,
-	      const char *fs_type, const char *const fs_opts[])
+              const char *fs_type, const char *const fs_opts[],
+              const char *extra_opt)
 {
 	int i, pos = 3;
 	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
@@ -68,10 +79,20 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 	}
 
 	argv[pos++] = dev;
+
+	if (extra_opt) {
+		argv[pos++] = extra_opt;
+
+		if (pos + 1 > OPTS_MAX) {
+			tst_brkm(TBROK, cleanup_fn,
+			         "Too much mkfs options");
+		}
+	}
+
 	argv[pos] = NULL;
 
-	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
-		 dev, fs_type, fs_opts_str);
+	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
+	         dev, fs_type, fs_opts_str, extra_opt ? extra_opt : "");
 	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 0);
 }
 
diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest.c b/testcases/kernel/io/direct_io/dma_thread_diotest.c
index 50b2222..80fbed4 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest.c
@@ -397,7 +397,7 @@ static void setup(void)
 			tst_brkm(TCONF, NULL,
 				 "you must specify a big blockdevice(>1.3G)");
 		} else {
-			tst_mkfs(NULL, device, "ext3", NULL);
+			tst_mkfs(NULL, device, "ext3", NULL, NULL);
 		}
 
 		if (mount(device, MNT_POINT, "ext3", 0, NULL) < 0) {
diff --git a/testcases/kernel/syscalls/access/access06.c b/testcases/kernel/syscalls/access/access06.c
index 59273bb..82044fe 100644
--- a/testcases/kernel/syscalls/access/access06.c
+++ b/testcases/kernel/syscalls/access/access06.c
@@ -93,7 +93,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
 
 	TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index d405a3e..9fce925 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -150,7 +150,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
 	if (mount(device, "mntpoint", fs_type, 0, NULL) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index 3857bf5..66db797 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -192,7 +192,7 @@ void setup(void)
 	SAFE_CHMOD(cleanup, DIR_TEMP, FILE_MODE);
 	SAFE_TOUCH(cleanup, "t_file", MODE_RWX, NULL);
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
 
diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index 311889b..e959ae4 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -149,7 +149,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 11b4c61..8100d92 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -179,7 +179,7 @@ static void setup(void)
 	SAFE_SYMLINK(cleanup, TEST7_FILE, "test_file_eloop2");
 	SAFE_SYMLINK(cleanup, "test_file_eloop2", TEST7_FILE);
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, "mntpoint", 0777);
 	if (mount(device, "mntpoint", fs_type, MS_RDONLY, NULL) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index a2a93ce..a08d43f 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -127,7 +127,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, "mntpoint", 0755);
 
diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index 0619375..0f0194f 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
@@ -113,7 +113,7 @@ static void setup(void)
 
 	fd1 = SAFE_OPEN(cleanup, "tfile_1", O_RDWR | O_CREAT, 0666);
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
 	if (mount(device, "mntpoint", fs_type, 0, NULL) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index 2136227..1cf8846 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -240,7 +240,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MOUNT(NULL, device, MOUNT_DIR, fs_type, MS_MANDLOCK, NULL);
 	mount_flag = 1;
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 36803d8..f73a891 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -178,7 +178,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	if (mkdir(mntpoint, DIR_MODE) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s, %#o) failed",
diff --git a/testcases/kernel/syscalls/lchown/lchown03.c b/testcases/kernel/syscalls/lchown/lchown03.c
index ab5aced..08612cf 100644
--- a/testcases/kernel/syscalls/lchown/lchown03.c
+++ b/testcases/kernel/syscalls/lchown/lchown03.c
@@ -107,7 +107,7 @@ static void setup(void)
 	for (i = 0; i < 43; i++)
 		strcat(test_eloop, "/test_eloop");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, TEST_EROFS, DIR_MODE);
 	if (mount(device, TEST_EROFS, fs_type, MS_RDONLY, NULL) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
index b06919e..f763c46 100644
--- a/testcases/kernel/syscalls/link/link08.c
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -143,7 +143,7 @@ static void setup(void)
 	for (i = 0; i < 43; i++)
 		strcat(test_file4, "/test_eloop");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
 	if (mount(device, MNT_POINT, fs_type, 0, NULL) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index e9a752a..4c31dd9 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -171,7 +171,7 @@ static void setup(void)
 	SAFE_MKDIR(cleanup, "./tmp", DIR_MODE);
 	SAFE_TOUCH(cleanup, TEST_EACCES, 0666, NULL);
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
 
 	if (mount(device, "mntpoint", fs_type, 0, NULL) < 0) {
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index ed6693f..0b6114f 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -122,7 +122,7 @@ static void setup(void)
 	for (i = 0; i < 43; i++)
 		strcat(loop_dir, "/test_eloop");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
 	if (mount(device, MNT_POINT, fs_type, MS_RDONLY, NULL) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat02.c b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
index c929043..f9d9240 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat02.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
@@ -116,7 +116,7 @@ static void setup(void)
 	for (i = 0; i < 43; i++)
 		strcat(test_file2, "/test_eloop");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, "test_dir/mntpoint", DIR_MODE);
 	if (mount(device, "test_dir/mntpoint", fs_type, MS_RDONLY, NULL) < 0) {
diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index bc9a07a..2ea50c0 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -123,7 +123,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index f6368fa..7cbde72 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -124,7 +124,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index c5828ea..494cd93 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -158,7 +158,7 @@ static void setup(void)
 	device = tst_acquire_device(cleanup);
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-	tst_mkfs(cleanup, device, fs_type, fs_opts);
+	tst_mkfs(cleanup, device, fs_type, fs_opts, "10240");
 
 	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
 	/*
diff --git a/testcases/kernel/syscalls/mount/mount01.c b/testcases/kernel/syscalls/mount/mount01.c
index 53cf57f..0850aa0 100644
--- a/testcases/kernel/syscalls/mount/mount01.c
+++ b/testcases/kernel/syscalls/mount/mount01.c
@@ -83,7 +83,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
 
diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
index 916c35e..3d98028 100644
--- a/testcases/kernel/syscalls/mount/mount02.c
+++ b/testcases/kernel/syscalls/mount/mount02.c
@@ -186,7 +186,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
 
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 1db2383..b46753a 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -355,7 +355,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
 
diff --git a/testcases/kernel/syscalls/mount/mount04.c b/testcases/kernel/syscalls/mount/mount04.c
index 6dde3fc..f348973 100644
--- a/testcases/kernel/syscalls/mount/mount04.c
+++ b/testcases/kernel/syscalls/mount/mount04.c
@@ -98,7 +98,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	ltpuser = SAFE_GETPWNAM(cleanup, nobody_uid);
 	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
diff --git a/testcases/kernel/syscalls/mount/mount05.c b/testcases/kernel/syscalls/mount/mount05.c
index 5c9e09e..bd664fd 100644
--- a/testcases/kernel/syscalls/mount/mount05.c
+++ b/testcases/kernel/syscalls/mount/mount05.c
@@ -104,7 +104,7 @@ void setup(void)
 	SAFE_MKDIR(cleanup, mntpoint_des, DIR_MODE);
 
 	if (dflag) {
-		tst_mkfs(NULL, device, fstype, NULL);
+		tst_mkfs(NULL, device, fstype, NULL, NULL);
 
 		if (mount(device, mntpoint_src, fstype, 0, NULL) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "mount failed");
diff --git a/testcases/kernel/syscalls/mount/mount06.c b/testcases/kernel/syscalls/mount/mount06.c
index 9350574..343e33a 100644
--- a/testcases/kernel/syscalls/mount/mount06.c
+++ b/testcases/kernel/syscalls/mount/mount06.c
@@ -129,7 +129,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	if (getcwd(path_name, sizeof(path_name)) == NULL)
 		tst_brkm(TBROK, cleanup, "getcwd failed");
diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 5bbf9ee..c34ae45 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -107,7 +107,7 @@ static void setup(void)
 			goto end;
 		}
 
-		tst_mkfs(cleanup, device, fs_type, NULL);
+		tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_STRICTATIME, NULL);
 		mount_flag = 1;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 9ca77d1..af44f78 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -207,7 +207,7 @@ static void setup(void)
 	if (!block_dev)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, block_dev, "xfs", NULL);
+	tst_mkfs(cleanup, block_dev, "xfs", NULL, NULL);
 
 	if (mount(block_dev, mntpoint, "xfs", 0, "uquota") < 0)
 		tst_brkm(TFAIL | TERRNO, NULL, "mount(2) fail");
diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
index 12c97fb..8aebb31 100644
--- a/testcases/kernel/syscalls/rename/rename11.c
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -104,7 +104,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
 	if (mount(device, MNTPOINT, fs_type, 0, NULL) < 0) {
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index f4cd51b..918df48 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -183,7 +183,7 @@ static void setup(void)
 	for (i = 0; i < 43; i++)
 		strcat(looppathname, TESTDIR2);
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNTPOINT, DIRMODE);
 	if (mount(device, MNTPOINT, fs_type, 0, NULL) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index 0492666..8fafaf2 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -137,7 +137,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to acquire device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
 	if (mount(device, MNTPOINT, fs_type, 0, NULL) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index 13b1567..52a55c9 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -93,7 +93,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	if (mkdir(mntpoint, DIR_MODE) < 0) {
 		tst_brkm(TBROK, cleanup, "mkdir(%s, %#o) failed; "
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index fbd5399..28a7252 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -117,7 +117,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	memset(long_path, 'a', PATH_MAX + 1);
 
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index add6691..e0b36e5 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -99,7 +99,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
 
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
index 86ea4a4..7376037 100644
--- a/testcases/kernel/syscalls/umount2/umount2_01.c
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -78,7 +78,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
 
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index 9ee2f02..f6782a1 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -115,7 +115,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
 
diff --git a/testcases/kernel/syscalls/umount2/umount2_03.c b/testcases/kernel/syscalls/umount2/umount2_03.c
index 217c5d1..571f389 100644
--- a/testcases/kernel/syscalls/umount2/umount2_03.c
+++ b/testcases/kernel/syscalls/umount2/umount2_03.c
@@ -96,7 +96,7 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
 
diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index 66ba3d8..0e67d2e 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -119,7 +119,7 @@ static void setup(void)
 	if (!dev)
 		tst_brkm(TCONF, cleanup, "Failed to acquire test device");
 
-	tst_mkfs(cleanup, dev, fs_type, NULL);
+	tst_mkfs(cleanup, dev, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNT_POINT, 0644);
 	if (mount(dev, MNT_POINT, fs_type, MS_RDONLY, NULL) < 0) {
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index e66f69e..3a9bd96 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -139,7 +139,7 @@ static void setup(void)
 	SAFE_CHOWN(cleanup, TESTFILE2, ltpuser->pw_uid,
 		ltpuser->pw_gid);
 
-	tst_mkfs(cleanup, device, fs_type, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
 	if (mount(device, MNTPOINT, fs_type, 0, NULL) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup,
-- 
2.5.0

