From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Apr 2019 11:53:17 +0300
Subject: [LTP] [PATCH] fanotify06: add a test case for overlayfs
Message-ID: <20190424085317.409-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test fails on overlayfs since kernel v4.19.
Added a test case for overlayfs mount.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Cyril,

The new test case covers a bug reported by Murphy Zhou:
https://lore.kernel.org/linux-fsdevel/20190423065024.12695-1-jencce.kernel@gmail.com/

Once again, I tried looking at making overlayfs test variant generic.
Once again, I gave it up.

Thanks,
Amir.

 .../kernel/syscalls/fanotify/fanotify06.c     | 74 +++++++++++++++----
 1 file changed, 61 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 6a2e2494f..62defb23c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -54,8 +54,23 @@ static int fd_notify[FANOTIFY_PRIORITIES][GROUPS_PER_PRIO];
 
 static char event_buf[EVENT_BUF_LEN];
 
-#define MOUNT_NAME "mntpoint"
+#define MNTPOINT "mntpoint"
+#define OVL_LOWER "ovl-lower"
+#define OVL_UPPER "ovl-upper"
+#define OVL_WORK "ovl-work"
+#define OVL_MNT "ovl-mnt"
+
 static int mount_created;
+static int ovl_mounted;
+
+static struct tcase {
+	const char *tname;
+	const char *mnt;
+	int use_overlay;
+} tcases[] = {
+	{ "Fanotify merge mount mark", MNTPOINT, 0 },
+	{ "Fanotify merge overlayfs mount mark", OVL_MNT, 1 },
+};
 
 static void create_fanotify_groups(void)
 {
@@ -72,12 +87,12 @@ static void create_fanotify_groups(void)
 			ret = fanotify_mark(fd_notify[p][i],
 					    FAN_MARK_ADD | FAN_MARK_MOUNT,
 					    FAN_MODIFY,
-					    AT_FDCWD, ".");
+					    AT_FDCWD, fname);
 			if (ret < 0) {
 				tst_brk(TBROK | TERRNO,
 					"fanotify_mark(%d, FAN_MARK_ADD | "
 					"FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
-					" '.') failed", fd_notify[p][i]);
+					" %s) failed", fd_notify[p][i], fname);
 			}
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
@@ -130,11 +145,23 @@ static void verify_event(int group, struct fanotify_event_metadata *event)
 	}
 }
 
-void test01(void)
+void test_fanotify(unsigned int n)
 {
 	int ret;
 	unsigned int p, i;
 	struct fanotify_event_metadata *event;
+	struct tcase *tc = &tcases[n];
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	if (tc->use_overlay && !ovl_mounted) {
+		tst_res(TCONF,
+		        "overlayfs is not configured in this kernel.");
+		return;
+	}
+
+	sprintf(fname, "%s/tfile_%d", tc->mnt, getpid());
+	SAFE_TOUCH(fname, 0644, NULL);
 
 	create_fanotify_groups();
 
@@ -194,29 +221,50 @@ void test01(void)
 	cleanup_fanotify_groups();
 }
 
+static void setup_overlay(void)
+{
+	int ret;
+
+	SAFE_MKDIR(OVL_LOWER, 0755);
+	SAFE_MKDIR(OVL_UPPER, 0755);
+	SAFE_MKDIR(OVL_WORK, 0755);
+	SAFE_MKDIR(OVL_MNT, 0755);
+	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
+		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
+	if (ret < 0) {
+		if (errno == ENODEV) {
+			tst_res(TINFO,
+				"overlayfs is not configured in this kernel.");
+			return;
+		}
+		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
+	}
+	ovl_mounted = 1;
+}
+
 static void setup(void)
 {
-	SAFE_MKDIR(MOUNT_NAME, 0755);
-	SAFE_MOUNT(MOUNT_NAME, MOUNT_NAME, "none", MS_BIND, NULL);
+	SAFE_MKDIR(MNTPOINT, 0755);
+	SAFE_MOUNT(MNTPOINT, MNTPOINT, "none", MS_BIND, NULL);
 	mount_created = 1;
-	SAFE_CHDIR(MOUNT_NAME);
 
-	sprintf(fname, "tfile_%d", getpid());
-	SAFE_FILE_PRINTF(fname, "1");
+	setup_overlay();
 }
 
 static void cleanup(void)
 {
 	cleanup_fanotify_groups();
 
-	SAFE_CHDIR("../");
+	if (ovl_mounted)
+		SAFE_UMOUNT(OVL_MNT);
 
-	if (mount_created && tst_umount(MOUNT_NAME) < 0)
-		tst_brk(TBROK | TERRNO, "umount failed");
+	if (mount_created)
+		SAFE_UMOUNT(MNTPOINT);
 }
 
 static struct tst_test test = {
-	.test_all = test01,
+	.test = test_fanotify,
+	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-- 
2.17.1

