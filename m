From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 30 Apr 2019 12:39:57 +0800
Subject: [LTP] [PATCH] OVL_MNT: put overlayfs lower, upper, work,
	mnt dir in separated mountpoint
Message-ID: <20190430043957.479-1-xzhou@redhat.com>
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

Fixing this by put overlayfs dirs in a separaed mountpoint, like
readahead02 by Amir.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 .../kernel/syscalls/execveat/execveat03.c     | 21 ++++++++++-----
 testcases/kernel/syscalls/inotify/inotify07.c | 24 +++++++++++------
 testcases/kernel/syscalls/inotify/inotify08.c | 26 ++++++++++++-------
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index def33923b..8ba6a656f 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -55,10 +55,17 @@
 #include "lapi/fcntl.h"
 #include "execveat.h"
 
-#define OVL_MNT "ovl"
+#define MNTPOINT	"mntpoint"
+#define OVL_LOWER	MNTPOINT"/lower"
+#define OVL_UPPER	MNTPOINT"/upper"
+#define OVL_WORK	MNTPOINT"/work"
+#define OVL_MNT		MNTPOINT"/ovl"
+
 #define TEST_APP "execveat_child"
 #define TEST_FILE_PATH OVL_MNT"/"TEST_APP
 
+static const char mntpoint[] = MNTPOINT;
+
 static int ovl_mounted;
 
 static void do_child(void)
@@ -91,12 +98,12 @@ static void setup(void)
 	check_execveat();
 
 	/* Setup an overlay mount with lower file */
-	SAFE_MKDIR("lower", 0755);
-	SAFE_MKDIR("upper", 0755);
-	SAFE_MKDIR("work", 0755);
+	SAFE_MKDIR(OVL_LOWER, 0755);
+	SAFE_MKDIR(OVL_UPPER, 0755);
+	SAFE_MKDIR(OVL_WORK, 0755);
 	SAFE_MKDIR(OVL_MNT, 0755);
-	ret = mount("overlay", OVL_MNT, "overlay", 0,
-		    "lowerdir=lower,upperdir=upper,workdir=work");
+	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
+		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
 	if (ret < 0) {
 		if (errno == ENODEV) {
 			tst_brk(TCONF,
@@ -121,6 +128,8 @@ static const char *const resource_files[] = {
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = mntpoint,
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index 96370b5cf..3e2d06485 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -73,13 +73,19 @@ struct event_t {
 	unsigned int mask;
 };
 
-#define OVL_MNT "ovl"
+#define MNTPOINT	"mntpoint"
+#define OVL_LOWER	MNTPOINT"/lower"
+#define OVL_UPPER	MNTPOINT"/upper"
+#define OVL_WORK	MNTPOINT"/work"
+#define OVL_MNT		MNTPOINT"/ovl"
+
 #define DIR_NAME "test_dir"
 #define DIR_PATH OVL_MNT"/"DIR_NAME
 #define FILE_NAME "test_file"
 #define FILE_PATH OVL_MNT"/"DIR_NAME"/"FILE_NAME
 
 static int ovl_mounted;
+static const char mntpoint[] = MNTPOINT;
 
 static struct event_t event_set[EVENT_MAX];
 
@@ -164,14 +170,14 @@ static void setup(void)
 	int ret;
 
 	/* Setup an overlay mount with lower dir and file */
-	SAFE_MKDIR("lower", 0755);
-	SAFE_MKDIR("lower/"DIR_NAME, 0755);
-	SAFE_TOUCH("lower/"DIR_NAME"/"FILE_NAME, 0644, NULL);
-	SAFE_MKDIR("upper", 0755);
-	SAFE_MKDIR("work", 0755);
+	SAFE_MKDIR(OVL_LOWER, 0755);
+	SAFE_MKDIR(OVL_LOWER"/"DIR_NAME, 0755);
+	SAFE_TOUCH(OVL_LOWER"/"DIR_NAME"/"FILE_NAME, 0644, NULL);
+	SAFE_MKDIR(OVL_UPPER, 0755);
+	SAFE_MKDIR(OVL_WORK, 0755);
 	SAFE_MKDIR(OVL_MNT, 0755);
-	ret = mount("overlay", OVL_MNT, "overlay", 0,
-		    "lowerdir=lower,upperdir=upper,workdir=work");
+	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
+		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
 	if (ret < 0) {
 		if (errno == ENODEV) {
 			tst_brk(TCONF,
@@ -234,6 +240,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = mntpoint,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index acdb95345..a512dfe22 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -74,11 +74,17 @@ struct event_t {
 	unsigned int mask;
 };
 
-#define OVL_MNT "ovl"
+#define MNTPOINT	"mntpoint"
+#define OVL_LOWER	MNTPOINT"/lower"
+#define OVL_UPPER	MNTPOINT"/upper"
+#define OVL_WORK	MNTPOINT"/work"
+#define OVL_MNT		MNTPOINT"/ovl"
+
 #define FILE_NAME "test_file"
 #define FILE_PATH OVL_MNT"/"FILE_NAME
 
 static int ovl_mounted;
+static const char mntpoint[] = MNTPOINT;
 
 static struct event_t event_set[EVENT_MAX];
 
@@ -104,8 +110,8 @@ void verify_inotify(void)
 	test_cnt++;
 
 	/* Make sure events on upper/lower do not show in overlay watch */
-	SAFE_TOUCH("lower/"FILE_NAME, 0644, NULL);
-	SAFE_TOUCH("upper/"FILE_NAME, 0644, NULL);
+	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
+	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
 
 	int len = read(fd_notify, event_buf, EVENT_BUF_LEN);
 	if (len == -1 && errno != EAGAIN) {
@@ -157,13 +163,13 @@ static void setup(void)
 	int ret;
 
 	/* Setup an overlay mount with lower file */
-	SAFE_MKDIR("lower", 0755);
-	SAFE_TOUCH("lower/"FILE_NAME, 0644, NULL);
-	SAFE_MKDIR("upper", 0755);
-	SAFE_MKDIR("work", 0755);
+	SAFE_MKDIR(OVL_LOWER, 0755);
+	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
+	SAFE_MKDIR(OVL_UPPER, 0755);
+	SAFE_MKDIR(OVL_WORK, 0755);
 	SAFE_MKDIR(OVL_MNT, 0755);
-	ret = mount("overlay", OVL_MNT, "overlay", 0,
-		    "lowerdir=lower,upperdir=upper,workdir=work");
+	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
+		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
 	if (ret < 0) {
 		if (errno == ENODEV) {
 			tst_brk(TCONF,
@@ -230,6 +236,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = mntpoint,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
-- 
2.21.0

