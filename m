From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 4 Dec 2019 16:12:46 +0800
Subject: [LTP] [PATCH] Remove duplicated ".needs_tmpdir=1" when using
 equivalent flags
Message-ID: <1575447166-7813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From ltp library code, when we have used these flags(".needs_device"
".mntpoint" ".resource_file" ".needs_checkpoints" ".format_device"
"mount_device" ".all_filesystems"), we don't need to set ".needs_tmpdir=1".
So remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt                              | 5 ++++-
 lib/newlib_tests/tst_device.c                                | 1 -
 testcases/kernel/fs/fs_fill/fs_fill.c                        | 1 -
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c       | 1 -
 testcases/kernel/security/dirtyc0w/dirtyc0w.c                | 1 -
 testcases/kernel/syscalls/access/access04.c                  | 1 -
 testcases/kernel/syscalls/acct/acct01.c                      | 1 -
 .../kernel/syscalls/copy_file_range/copy_file_range01.c      | 1 -
 .../kernel/syscalls/copy_file_range/copy_file_range02.c      | 1 -
 testcases/kernel/syscalls/creat/creat06.c                    | 1 -
 testcases/kernel/syscalls/execveat/execveat03.c              | 1 -
 testcases/kernel/syscalls/fallocate/fallocate04.c            | 1 -
 testcases/kernel/syscalls/fallocate/fallocate05.c            | 1 -
 testcases/kernel/syscalls/fanotify/fanotify01.c              | 1 -
 testcases/kernel/syscalls/fanotify/fanotify05.c              | 1 -
 testcases/kernel/syscalls/fanotify/fanotify06.c              | 1 -
 testcases/kernel/syscalls/fanotify/fanotify10.c              | 1 -
 testcases/kernel/syscalls/fanotify/fanotify15.c              | 1 -
 testcases/kernel/syscalls/fcntl/fcntl33.c                    | 1 -
 testcases/kernel/syscalls/fgetxattr/fgetxattr01.c            | 1 -
 testcases/kernel/syscalls/flock/flock03.c                    | 1 -
 testcases/kernel/syscalls/fremovexattr/fremovexattr01.c      | 1 -
 testcases/kernel/syscalls/fremovexattr/fremovexattr02.c      | 1 -
 testcases/kernel/syscalls/fsetxattr/fsetxattr01.c            | 1 -
 testcases/kernel/syscalls/fsync/fsync01.c                    | 1 -
 testcases/kernel/syscalls/ftruncate/ftruncate04.c            | 1 -
 testcases/kernel/syscalls/getxattr/getxattr04.c              | 1 -
 testcases/kernel/syscalls/inotify/inotify03.c                | 1 -
 testcases/kernel/syscalls/inotify/inotify07.c                | 1 -
 testcases/kernel/syscalls/inotify/inotify08.c                | 1 -
 testcases/kernel/syscalls/ioctl/ioctl04.c                    | 1 -
 testcases/kernel/syscalls/lremovexattr/lremovexattr01.c      | 1 -
 testcases/kernel/syscalls/mkdir/mkdir03.c                    | 1 -
 testcases/kernel/syscalls/msync/msync04.c                    | 1 -
 testcases/kernel/syscalls/preadv2/preadv203.c                | 1 -
 testcases/kernel/syscalls/quotactl/quotactl01.c              | 1 -
 testcases/kernel/syscalls/quotactl/quotactl02.c              | 1 -
 testcases/kernel/syscalls/quotactl/quotactl03.c              | 1 -
 testcases/kernel/syscalls/quotactl/quotactl04.c              | 1 -
 testcases/kernel/syscalls/quotactl/quotactl05.c              | 1 -
 testcases/kernel/syscalls/readahead/readahead02.c            | 1 -
 testcases/kernel/syscalls/statx/statx01.c                    | 1 -
 testcases/kernel/syscalls/statx/statx04.c                    | 1 -
 testcases/kernel/syscalls/statx/statx06.c                    | 1 -
 testcases/kernel/syscalls/umount/umount01.c                  | 1 -
 testcases/kernel/syscalls/umount/umount02.c                  | 1 -
 testcases/kernel/syscalls/umount/umount03.c                  | 1 -
 testcases/kernel/uevents/uevent01.c                          | 1 -
 testcases/kernel/uevents/uevent02.c                          | 1 -
 testcases/kernel/uevents/uevent03.c                          | 1 -
 50 files changed, 4 insertions(+), 50 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 546bb7a49..29b0e5db2 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -493,7 +493,10 @@ this needed.
 
 If '.needs_tmpdir' is set to '1' in the 'struct tst_test' unique test
 temporary is created and it's set as the test working directory. Tests *MUST
-NOT* create temporary files outside that directory.
+NOT* create temporary files outside that directory. If we have used one of
+these flags(".needs_device" ".mntpoint" ".resource_file" ".needs_checkpoints"
+".format_device" "mount_device" ".all_filesystems"), we don't need to set
+'.needs_tmpdir' again because these flags also will create temporary directory.
 
 IMPORTANT: Close all file descriptors (that point to files in test temporary
            directory, even the unlinked ones) either in the 'test()' function
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 6058b3928..1344495b3 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -32,7 +32,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.needs_device = 1,
 	.dev_min_size = 300,
 	.test_all = do_test,
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 2604a1c63..66b3974fc 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -110,7 +110,6 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 9353564e4..f7ac881bc 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -333,7 +333,6 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.needs_tmpdir = 1,
 	.options = options,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index e7857037d..a0a81b6ed 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -92,7 +92,6 @@ void dirtyc0w_test(void)
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index 68cbff509..328be1b73 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -110,7 +110,6 @@ static void setup(void)
 
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
 	.needs_rofs = 1,
diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index ec570017b..c161d2a2c 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -120,7 +120,6 @@ static void verify_acct(unsigned int nr)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mntpoint = "mntpoint",
 	.needs_rofs = 1,
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
index 6097c85b3..7d27007a3 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -227,7 +227,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tcases),
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index e4159cad7..c09766fe6 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -248,6 +248,5 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.test_variants = TEST_VARIANTS,
 };
diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 880159b3f..5c82e4757 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -153,7 +153,6 @@ static struct tst_test test = {
 	.test = verify_creat,
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.needs_tmpdir = 1,
 	.mntpoint = "mntpoint",
 	.setup = setup,
 };
diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index b0d9033e3..27247e664 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -75,7 +75,6 @@ static const char *const resource_files[] = {
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.needs_overlay = 1,
 	.mntpoint = mntpoint,
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 936d0d1b0..1901502c2 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -310,6 +310,5 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 17034e5b1..3639ac57a 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -84,7 +84,6 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 44966dce5..03e453f41 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -379,7 +379,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 112295709..e53cc333a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -127,7 +127,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 };
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 4e6977954..99e312a4f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -252,7 +252,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = mntpoint,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 1d1712e98..ef0807761 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -440,7 +440,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
 	.resource_files = resource_files,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index 48ed368ae..e0d513025 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -233,7 +233,6 @@ static void do_cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_POINT,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
index 804a718e9..70d5ec5ff 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl33.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -226,7 +226,6 @@ static void cleanup(void)
 static struct tst_test test = {
 	.forks_child = 1,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.needs_checkpoints = 1,
 	.tcnt = ARRAY_SIZE(test_cases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
index 227e090ea..35c46a1c3 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
@@ -141,7 +141,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
 
diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.c
index 57dcc5f5c..92e21a6a1 100644
--- a/testcases/kernel/syscalls/flock/flock03.c
+++ b/testcases/kernel/syscalls/flock/flock03.c
@@ -92,7 +92,6 @@ static void setup(void)
 static struct tst_test test = {
 	.test_all = verify_flock,
 	.needs_checkpoints = 1,
-	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.setup = setup,
 };
diff --git a/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c b/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
index a3ea1aa2b..907d210d1 100644
--- a/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
+++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
@@ -89,7 +89,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
 
diff --git a/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
index 534179eae..eb106a8fa 100644
--- a/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
+++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
@@ -112,7 +112,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
 
diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
index b37dba57b..ffec8104f 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
@@ -221,7 +221,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
 
diff --git a/testcases/kernel/syscalls/fsync/fsync01.c b/testcases/kernel/syscalls/fsync/fsync01.c
index 9af38dce0..4e2281b05 100644
--- a/testcases/kernel/syscalls/fsync/fsync01.c
+++ b/testcases/kernel/syscalls/fsync/fsync01.c
@@ -47,7 +47,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.setup = setup,
 	.test_all = verify_fsync,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = "mntpoint",
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index 53d395d1f..ad5c7bbb9 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -171,7 +171,6 @@ static struct tst_test test = {
 	.test_all = verify_ftruncate,
 	.setup = setup,
 	.needs_checkpoints = 1,
-	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.mount_device = 1,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index 0ac83775a..e64f2a1f1 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -106,7 +106,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 1b4685204..01a115546 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -168,7 +168,6 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.format_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index a4894ffc7..a496489ac 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -179,7 +179,6 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.needs_overlay = 1,
 	.mntpoint = mntpoint,
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index 41bb5157f..6a4278cba 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -173,7 +173,6 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.needs_overlay = 1,
 	.mntpoint = mntpoint,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index efbe9ce53..353114cc0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -81,7 +81,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.format_device = 1,
 	.needs_root = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
index 26194f114..0c19c62ac 100644
--- a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
+++ b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
@@ -121,7 +121,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 5428cc70d..d5141bb64 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -87,7 +87,6 @@ static void setup(void)
 
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(TC),
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.needs_rofs = 1,
 	.mntpoint = MNT_POINT,
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 04ad1379b..dad07b264 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -93,7 +93,6 @@ static struct tst_test test = {
 	.test_all = test_msync,
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.mntpoint = "msync04",
 	.mount_device = 1,
diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 91618f5f5..47c46d526 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -279,6 +279,5 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index d33ed3bde..ede61d7e4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -226,7 +226,6 @@ static const char *kconfigs[] = {
 };
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.needs_kconfigs = kconfigs,
 	.test = verify_quota,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 07ce8ab47..cd8a0c388 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -141,7 +141,6 @@ static void verify_quota(unsigned int n)
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.needs_kconfigs = kconfigs,
 	.test = verify_quota,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index e2a0448d8..d95719521 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -70,7 +70,6 @@ static const char *kconfigs[] = {
 };
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.needs_kconfigs = kconfigs,
 	.test_all = verify_quota,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index b4581e2f9..8dab83da0 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -148,7 +148,6 @@ static const char *kconfigs[] = {
 };
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.needs_kconfigs = kconfigs,
 	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index 8fa07f739..af5a164e4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -98,7 +98,6 @@ static void verify_quota(unsigned int n)
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.needs_kconfigs = kconfigs,
 	.test = verify_quota,
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 56739be28..fb06be755 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -401,7 +401,6 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.mntpoint = mntpoint,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index c3ba94394..4f9d58282 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -165,5 +165,4 @@ static struct tst_test test = {
 	.needs_devfs = 1,
 	.mntpoint = MNTPOINT,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index 71de734f5..f8350ed2d 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -180,7 +180,6 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.all_filesystems = 1,
 	.mount_device = 1,
-	.needs_tmpdir = 1,
 	.mntpoint = MOUNT_POINT,
 	.min_kver = "4.11",
 };
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 831f73092..0469d66c5 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -169,7 +169,6 @@ static struct tst_test test = {
 	.test = test_statx,
 	.min_kver = "4.11",
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.mntpoint = MOUNT_POINT,
 	.mount_device = 1,
 	.dev_fs_type = "ext4",
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index fb5384434..d05296dce 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -53,7 +53,6 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.format_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index cd67aa6d2..34a38c998 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -81,7 +81,6 @@ static void cleanup(void)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.format_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index 28309a305..1cef06fa1 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -58,7 +58,6 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.format_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/uevents/uevent01.c b/testcases/kernel/uevents/uevent01.c
index 0dd1344a7..5c65556c9 100644
--- a/testcases/kernel/uevents/uevent01.c
+++ b/testcases/kernel/uevents/uevent01.c
@@ -88,7 +88,6 @@ static void verify_uevent(void)
 static struct tst_test test = {
 	.test_all = verify_uevent,
 	.forks_child = 1,
-	.needs_tmpdir = 1,
 	.needs_checkpoints = 1,
 	.needs_drivers = (const char *const []) {
 		"loop",
diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
index 9dd4cd65b..ce0cf757d 100644
--- a/testcases/kernel/uevents/uevent02.c
+++ b/testcases/kernel/uevents/uevent02.c
@@ -134,7 +134,6 @@ static void verify_uevent(void)
 static struct tst_test test = {
 	.test_all = verify_uevent,
 	.forks_child = 1,
-	.needs_tmpdir = 1,
 	.needs_checkpoints = 1,
 	.needs_drivers = (const char *const []) {
 		"tun",
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index 6eda86067..ed15fea93 100644
--- a/testcases/kernel/uevents/uevent03.c
+++ b/testcases/kernel/uevents/uevent03.c
@@ -234,7 +234,6 @@ static void verify_uevent(void)
 static struct tst_test test = {
 	.test_all = verify_uevent,
 	.forks_child = 1,
-	.needs_tmpdir = 1,
 	.needs_checkpoints = 1,
 	.needs_drivers = (const char *const[]) {
 		"uinput",
-- 
2.18.0



