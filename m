From: Murphy Zhou <xzhou@redhat.com>
Date: Thu, 30 May 2019 10:53:01 +0800
Subject: [LTP] [PATCH v6 2/2] OVL_MNT: setup overlayfs dirs and mount in a
	separated mountpoint
In-Reply-To: <20190530025301.9616-1-xzhou@redhat.com>
References: <CAOQ4uxhYVDDh961PCBqikrO=QjPG-yUEUvwWn8hBCkB0ugMuzg@mail.gmail.com>
 <20190530025301.9616-1-xzhou@redhat.com>
Message-ID: <20190530025301.9616-2-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some tests are mounting overlayfs internally and run tests on it.
This mount can fail if the filesystem we are running on does not
support overlay mount upon it. For example, we are already running
tests on overlayfs or NFS, or CIFS. Test will report broken and
failure.

Fixing this by put overlayfs dirs in a separated mountpoint, like in
readahead02 by Amir.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 .../kernel/syscalls/execveat/execveat03.c     | 31 ++--------------
 testcases/kernel/syscalls/inotify/inotify07.c | 33 ++++-------------
 testcases/kernel/syscalls/inotify/inotify08.c | 37 +++++--------------
 .../kernel/syscalls/readahead/readahead02.c   | 33 ++---------------
 4 files changed, 26 insertions(+), 108 deletions(-)

diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index def33923b..7df1b0faa 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -55,11 +55,10 @@
 #include "lapi/fcntl.h"
 #include "execveat.h"
 
-#define OVL_MNT "ovl"
 #define TEST_APP "execveat_child"
 #define TEST_FILE_PATH OVL_MNT"/"TEST_APP
 
-static int ovl_mounted;
+static const char mntpoint[] = OVL_BASE_MNTPOINT;
 
 static void do_child(void)
 {
@@ -86,31 +85,7 @@ static void verify_execveat(void)
 
 static void setup(void)
 {
-	int ret;
-
 	check_execveat();
-
-	/* Setup an overlay mount with lower file */
-	SAFE_MKDIR("lower", 0755);
-	SAFE_MKDIR("upper", 0755);
-	SAFE_MKDIR("work", 0755);
-	SAFE_MKDIR(OVL_MNT, 0755);
-	ret = mount("overlay", OVL_MNT, "overlay", 0,
-		    "lowerdir=lower,upperdir=upper,workdir=work");
-	if (ret < 0) {
-		if (errno == ENODEV) {
-			tst_brk(TCONF,
-				"overlayfs is not configured in this kernel.");
-		}
-		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
-	}
-	ovl_mounted = 1;
-}
-
-static void cleanup(void)
-{
-	if (ovl_mounted)
-		SAFE_UMOUNT(OVL_MNT);
 }
 
 static const char *const resource_files[] = {
@@ -121,10 +96,12 @@ static const char *const resource_files[] = {
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.needs_overlay = 1,
+	.mntpoint = mntpoint,
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = verify_execveat,
 	.resource_files = resource_files,
 };
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index 96370b5cf..47817cd42 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -73,13 +73,12 @@ struct event_t {
 	unsigned int mask;
 };
 
-#define OVL_MNT "ovl"
 #define DIR_NAME "test_dir"
 #define DIR_PATH OVL_MNT"/"DIR_NAME
 #define FILE_NAME "test_file"
 #define FILE_PATH OVL_MNT"/"DIR_NAME"/"FILE_NAME
 
-static int ovl_mounted;
+static const char mntpoint[] = OVL_BASE_MNTPOINT;
 
 static struct event_t event_set[EVENT_MAX];
 
@@ -161,27 +160,12 @@ void verify_inotify(void)
 static void setup(void)
 {
 	struct stat buf;
-	int ret;
 
 	/* Setup an overlay mount with lower dir and file */
-	SAFE_MKDIR("lower", 0755);
-	SAFE_MKDIR("lower/"DIR_NAME, 0755);
-	SAFE_TOUCH("lower/"DIR_NAME"/"FILE_NAME, 0644, NULL);
-	SAFE_MKDIR("upper", 0755);
-	SAFE_MKDIR("work", 0755);
-	SAFE_MKDIR(OVL_MNT, 0755);
-	ret = mount("overlay", OVL_MNT, "overlay", 0,
-		    "lowerdir=lower,upperdir=upper,workdir=work");
-	if (ret < 0) {
-		if (errno == ENODEV) {
-			tst_brk(TCONF,
-				"overlayfs is not configured in this kernel.");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"overlayfs mount failed");
-		}
-	}
-	ovl_mounted = 1;
+	SAFE_UMOUNT(OVL_MNT);
+	SAFE_MKDIR(OVL_LOWER"/"DIR_NAME, 0755);
+	SAFE_TOUCH(OVL_LOWER"/"DIR_NAME"/"FILE_NAME, 0644, NULL);
+	SAFE_MOUNT_OVERLAY();
 
 	fd_notify = myinotify_init1(O_NONBLOCK);
 	if (fd_notify < 0) {
@@ -221,19 +205,18 @@ static void cleanup(void)
 	if (reap_wd && myinotify_rm_watch(fd_notify, wd) < 0) {
 		tst_res(TWARN,
 			"inotify_rm_watch (%d, %d) failed,", fd_notify, wd);
-
 	}
 
 	if (fd_notify > 0)
 		SAFE_CLOSE(fd_notify);
-
-	if (ovl_mounted)
-		SAFE_UMOUNT(OVL_MNT);
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.needs_overlay = 1,
+	.mntpoint = mntpoint,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index acdb95345..067c01dbb 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -74,11 +74,10 @@ struct event_t {
 	unsigned int mask;
 };
 
-#define OVL_MNT "ovl"
 #define FILE_NAME "test_file"
 #define FILE_PATH OVL_MNT"/"FILE_NAME
 
-static int ovl_mounted;
+static const char mntpoint[] = OVL_BASE_MNTPOINT;
 
 static struct event_t event_set[EVENT_MAX];
 
@@ -104,8 +103,8 @@ void verify_inotify(void)
 	test_cnt++;
 
 	/* Make sure events on upper/lower do not show in overlay watch */
-	SAFE_TOUCH("lower/"FILE_NAME, 0644, NULL);
-	SAFE_TOUCH("upper/"FILE_NAME, 0644, NULL);
+	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
+	SAFE_TOUCH(OVL_UPPER"/"FILE_NAME, 0644, NULL);
 
 	int len = read(fd_notify, event_buf, EVENT_BUF_LEN);
 	if (len == -1 && errno != EAGAIN) {
@@ -154,32 +153,17 @@ void verify_inotify(void)
 static void setup(void)
 {
 	struct stat buf;
-	int ret;
 
 	/* Setup an overlay mount with lower file */
-	SAFE_MKDIR("lower", 0755);
-	SAFE_TOUCH("lower/"FILE_NAME, 0644, NULL);
-	SAFE_MKDIR("upper", 0755);
-	SAFE_MKDIR("work", 0755);
-	SAFE_MKDIR(OVL_MNT, 0755);
-	ret = mount("overlay", OVL_MNT, "overlay", 0,
-		    "lowerdir=lower,upperdir=upper,workdir=work");
-	if (ret < 0) {
-		if (errno == ENODEV) {
-			tst_brk(TCONF,
-				"overlayfs is not configured in this kernel.");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"overlayfs mount failed");
-		}
-	}
-	ovl_mounted = 1;
+	SAFE_UMOUNT(OVL_MNT);
+	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
+	SAFE_MOUNT_OVERLAY();
 
 	fd_notify = myinotify_init1(O_NONBLOCK);
 	if (fd_notify < 0) {
 		if (errno == ENOSYS) {
 			tst_brk(TCONF,
-				"inotify is not configured in this kernel.");
+				"inotify is not configured in this kernel");
 		} else {
 			tst_brk(TBROK | TERRNO,
 				"inotify_init () failed");
@@ -217,19 +201,18 @@ static void cleanup(void)
 	if (reap_wd && myinotify_rm_watch(fd_notify, wd) < 0) {
 		tst_res(TWARN,
 			"inotify_rm_watch (%d, %d) failed,", fd_notify, wd);
-
 	}
 
 	if (fd_notify > 0)
 		SAFE_CLOSE(fd_notify);
-
-	if (ovl_mounted)
-		SAFE_UMOUNT(OVL_MNT);
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.needs_overlay = 1,
+	.mntpoint = mntpoint,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 39ddbd583..f6e07173d 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -44,16 +44,11 @@ static int pagesize;
 static unsigned long cached_max;
 static int ovl_mounted;
 
-#define MNTPOINT        "mntpoint"
-#define OVL_LOWER	MNTPOINT"/lower"
-#define OVL_UPPER	MNTPOINT"/upper"
-#define OVL_WORK	MNTPOINT"/work"
-#define OVL_MNT		MNTPOINT"/ovl"
 static int readahead_length  = 4096;
 static char sys_bdi_ra_path[PATH_MAX];
 static int orig_bdi_limit;
 
-static const char mntpoint[] = MNTPOINT;
+static const char mntpoint[] = OVL_BASE_MNTPOINT;
 
 static struct tst_option options[] = {
 	{"s:", &opt_fsizestr, "-s    testfile size (default 64MB)"},
@@ -132,7 +127,8 @@ static void create_testfile(int use_overlay)
 	char *tmp;
 	size_t i;
 
-	sprintf(testfile, "%s/testfile", use_overlay ? OVL_MNT : MNTPOINT);
+	sprintf(testfile, "%s/testfile",
+		use_overlay ? OVL_MNT : OVL_BASE_MNTPOINT);
 	tst_res(TINFO, "creating test file of size: %zu", testfile_size);
 	tmp = SAFE_MALLOC(pagesize);
 
@@ -329,27 +325,6 @@ static void test_readahead(unsigned int n)
 	}
 }
 
-static void setup_overlay(void)
-{
-	int ret;
-
-	/* Setup an overlay mount with lower dir and file */
-	SAFE_MKDIR(OVL_LOWER, 0755);
-	SAFE_MKDIR(OVL_UPPER, 0755);
-	SAFE_MKDIR(OVL_WORK, 0755);
-	SAFE_MKDIR(OVL_MNT, 0755);
-	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
-		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
-	if (ret < 0) {
-		if (errno == ENODEV) {
-			tst_res(TINFO,
-				"overlayfs is not configured in this kernel.");
-			return;
-		}
-		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
-	}
-	ovl_mounted = 1;
-}
 
 /*
  * We try raising bdi readahead limit as much as we can. We write
@@ -413,7 +388,7 @@ static void setup(void)
 	setup_readahead_length();
 	tst_res(TINFO, "readahead length: %d", readahead_length);
 
-	setup_overlay();
+	ovl_mounted = TST_MOUNT_OVERLAY();
 }
 
 static void cleanup(void)
-- 
2.21.0

