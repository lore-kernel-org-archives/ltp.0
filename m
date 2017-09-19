From: Sandeep Patil <sspatil@google.com>
Date: Tue, 19 Sep 2017 12:49:58 -0700
Subject: [LTP] [PATCH v4 1/2] libltp: add support to mount tmpfs for EROFS
	testing
Message-ID: <20170919194959.126495-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some tests go through losetup, create, format and mount filesystems only
to test for 'EROFS' return value from system calls. The tests end up
being flaky depending on the tools available on the platform. e.g.
mkfs.<filesystem> tool is required for mounting a device with
filesystem.

If the test is only to check for EROFS, this can be achieved by simply
by the bind mounting (MS_BIND) for '/' on 'mntpoint' and then remount
the same as 'read-only'.

Example of tests that can benefit from this are:
  access04, mkdirat02, mknodat02, acct01, fchown04, mknod07 etc.

This also allows for these tests to successfully run on Android.

Signed-off-by: Sandeep Patil <sspatil@google.com>
Tested-by: Jan Stancek <jstancek@redhat.com>
---

v3->v4
------
- s/mntpoint_active/mntpoint_mounted
- removed duplicate check for tst_test->mntpoint
- added TERRNO to the message about unsuccessful tmpfs mount

v2->v3
------
- Added Tested-by from Jan Stancek

v1->v2
------
- Changed the interface to be at a higher level, i.e. instead of
  making tests specify that they need a read-only tmpfs mount, we
  do that automatically in the library as a preference and fallback
  to the old way if that doesn't succeed.

- The read-only bind mount of "/" option was tried and it worked just
  fine with an Android system, but broke my ubuntu instance badly (I lost root).
  I could never find out why, since hte patch worked fine on Android
  and it correctly did the bind mount. However, I figured if there is any 
  chance of possible breakage, we should simply avoid that path for now.

 include/tst_test.h |  1 +
 lib/tst_test.c     | 41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index e90312ae3..ad468e8cf 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -124,6 +124,7 @@ struct tst_test {
 	int needs_checkpoints:1;
 	int format_device:1;
 	int mount_device:1;
+	int needs_rofs:1;
 
 	/* Minimal device size in megabytes */
 	unsigned int dev_min_size;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index f72de82d4..439284cab 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -21,6 +21,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/time.h>
@@ -41,7 +42,7 @@ struct tst_test *tst_test;
 static int iterations = 1;
 static float duration = -1;
 static pid_t main_pid, lib_pid;
-static int device_mounted;
+static int mntpoint_mounted;
 
 struct results {
 	int passed;
@@ -701,7 +702,32 @@ static void do_setup(int argc, char *argv[])
 	if (needs_tmpdir() && !tst_tmpdir_created())
 		tst_tmpdir();
 
-	if (tst_test->needs_device) {
+	if (tst_test->mntpoint)
+		SAFE_MKDIR(tst_test->mntpoint, 0777);
+
+	if ((tst_test->needs_rofs || tst_test->mount_device) &&
+	    !tst_test->mntpoint) {
+		tst_brk(TBROK, "tst_test->mntpoint must be set!");
+	}
+
+	if (tst_test->needs_rofs) {
+		/* If we failed to do read-only bind mount for '/'. Fallback to
+		 * using a device with empty read-only filesystem.
+		 */
+		if (mount(NULL, tst_test->mntpoint, "tmpfs", MS_RDONLY, NULL)) {
+			tst_res(TINFO | TERRNO, "Can't mount tmpfs read-only"
+				" at %s, setting up a device instead\n",
+				tst_test->mntpoint);
+			tst_test->mount_device = 1;
+			tst_test->needs_device = 1;
+			tst_test->format_device = 1;
+			tst_test->mnt_flags = MS_RDONLY;
+		} else {
+			mntpoint_mounted = 1;
+		}
+	}
+
+	if (tst_test->needs_device && !mntpoint_mounted) {
 		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
 
 		if (!tdev.dev)
@@ -721,16 +747,9 @@ static void do_setup(int argc, char *argv[])
 		}
 
 		if (tst_test->mount_device) {
-
-			if (!tst_test->mntpoint) {
-				tst_brk(TBROK,
-					"tst_test->mntpoint must be set!");
-			}
-
-			SAFE_MKDIR(tst_test->mntpoint, 0777);
 			SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
 				   tst_test->mnt_flags, tst_test->mnt_data);
-			device_mounted = 1;
+			mntpoint_mounted = 1;
 		}
 	}
 
@@ -751,7 +770,7 @@ static void do_test_setup(void)
 
 static void do_cleanup(void)
 {
-	if (device_mounted)
+	if (mntpoint_mounted)
 		tst_umount(tst_test->mntpoint);
 
 	if (tst_test->needs_device && tdev.dev)
-- 
2.14.1.690.gbb1197296e-goog

