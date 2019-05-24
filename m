From: Murphy Zhou <xzhou@redhat.com>
Date: Fri, 24 May 2019 17:04:41 +0800
Subject: [LTP] [PATCH v3 2/2] OVL_MNT: setup overlayfs dirs and mount in a
	separated mountpoint
In-Reply-To: <20190524090441.21586-1-xzhou@redhat.com>
References: <20190524073045.GA29592@dell5510>
 <20190524090441.21586-1-xzhou@redhat.com>
Message-ID: <20190524090441.21586-2-xzhou@redhat.com>
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

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 .../kernel/syscalls/execveat/execveat03.c     | 24 +++++--------
 testcases/kernel/syscalls/inotify/inotify07.c | 29 +++++----------
 testcases/kernel/syscalls/inotify/inotify08.c | 31 ++++++----------
 .../kernel/syscalls/readahead/readahead02.c   | 36 ++++---------------
 4 files changed, 34 insertions(+), 86 deletions(-)

diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index def33923b..7ec038134 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -55,10 +55,11 @@
 #include "lapi/fcntl.h"
 #include "execveat.h"
 
-#define OVL_MNT "ovl"
 #define TEST_APP "execveat_child"
 #define TEST_FILE_PATH OVL_MNT"/"TEST_APP
 
+static const char mntpoint[] = OVL_BASE_MNTPOINT;
+
 static int ovl_mounted;
 
 static void do_child(void)
@@ -90,21 +91,10 @@ static void setup(void)
 
 	check_execveat();
 
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
+	setup_overlayfs_files();
+	ret = SAFE_MOUNT_OVERLAYFS(3);
+	if (ret == 0)
+		ovl_mounted = 1;
 }
 
 static void cleanup(void)
@@ -121,6 +111,8 @@ static const char *const resource_files[] = {
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = mntpoint,
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index 96370b5cf..c903032cb 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -73,13 +73,13 @@ struct event_t {
 	unsigned int mask;
 };
 
-#define OVL_MNT "ovl"
 #define DIR_NAME "test_dir"
 #define DIR_PATH OVL_MNT"/"DIR_NAME
 #define FILE_NAME "test_file"
 #define FILE_PATH OVL_MNT"/"DIR_NAME"/"FILE_NAME
 
 static int ovl_mounted;
+static const char mntpoint[] = OVL_BASE_MNTPOINT;
 
 static struct event_t event_set[EVENT_MAX];
 
@@ -164,24 +164,12 @@ static void setup(void)
 	int ret;
 
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
+	setup_overlayfs_files();
+	SAFE_MKDIR(OVL_LOWER"/"DIR_NAME, 0755);
+	SAFE_TOUCH(OVL_LOWER"/"DIR_NAME"/"FILE_NAME, 0644, NULL);
+	ret = SAFE_MOUNT_OVERLAYFS(2);
+	if (ret == 0)
+		ovl_mounted = 1;
 
 	fd_notify = myinotify_init1(O_NONBLOCK);
 	if (fd_notify < 0) {
@@ -221,7 +209,6 @@ static void cleanup(void)
 	if (reap_wd && myinotify_rm_watch(fd_notify, wd) < 0) {
 		tst_res(TWARN,
 			"inotify_rm_watch (%d, %d) failed,", fd_notify, wd);
-
 	}
 
 	if (fd_notify > 0)
@@ -234,6 +221,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = mntpoint,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index acdb95345..fb80a55a5 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -74,11 +74,11 @@ struct event_t {
 	unsigned int mask;
 };
 
-#define OVL_MNT "ovl"
 #define FILE_NAME "test_file"
 #define FILE_PATH OVL_MNT"/"FILE_NAME
 
 static int ovl_mounted;
+static const char mntpoint[] = OVL_BASE_MNTPOINT;
 
 static struct event_t event_set[EVENT_MAX];
 
@@ -104,8 +104,8 @@ void verify_inotify(void)
 	test_cnt++;
 
 	/* Make sure events on upper/lower do not show in overlay watch */
-	SAFE_TOUCH("lower/"FILE_NAME, 0644, NULL);
-	SAFE_TOUCH("upper/"FILE_NAME, 0644, NULL);
+	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
+	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
 
 	int len = read(fd_notify, event_buf, EVENT_BUF_LEN);
 	if (len == -1 && errno != EAGAIN) {
@@ -157,23 +157,11 @@ static void setup(void)
 	int ret;
 
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
+	setup_overlayfs_files();
+	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
+	ret = SAFE_MOUNT_OVERLAYFS(2);
+	if (ret == 0)
+		ovl_mounted = 1;
 
 	fd_notify = myinotify_init1(O_NONBLOCK);
 	if (fd_notify < 0) {
@@ -217,7 +205,6 @@ static void cleanup(void)
 	if (reap_wd && myinotify_rm_watch(fd_notify, wd) < 0) {
 		tst_res(TWARN,
 			"inotify_rm_watch (%d, %d) failed,", fd_notify, wd);
-
 	}
 
 	if (fd_notify > 0)
@@ -230,6 +217,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = mntpoint,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 39ddbd583..57251c892 100644
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
@@ -132,7 +127,7 @@ static void create_testfile(int use_overlay)
 	char *tmp;
 	size_t i;
 
-	sprintf(testfile, "%s/testfile", use_overlay ? OVL_MNT : MNTPOINT);
+	sprintf(testfile, "%s/testfile", use_overlay ? OVL_MNT : OVL_BASE_MNTPOINT);
 	tst_res(TINFO, "creating test file of size: %zu", testfile_size);
 	tmp = SAFE_MALLOC(pagesize);
 
@@ -329,27 +324,6 @@ static void test_readahead(unsigned int n)
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
@@ -396,6 +370,7 @@ static void setup_readahead_length(void)
 
 static void setup(void)
 {
+	int ret;
 	if (opt_fsizestr)
 		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
 
@@ -413,7 +388,10 @@ static void setup(void)
 	setup_readahead_length();
 	tst_res(TINFO, "readahead length: %d", readahead_length);
 
-	setup_overlay();
+	setup_overlayfs_files();
+	ret = SAFE_MOUNT_OVERLAYFS(1);
+	if (ret == 0)
+		ovl_mounted = 1;
 }
 
 static void cleanup(void)
-- 
2.21.0

