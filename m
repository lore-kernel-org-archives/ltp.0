From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Aug 2019 17:10:01 +0200
Subject: [LTP] [PATCH v2 3/3] syscalls/ftruncate: Rewrite ftruncate04
In-Reply-To: <1564645349-10859-3-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1564395109-7165-3-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1564645349-10859-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1564645349-10859-3-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20190813151001.GC23369@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, thanks.

diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index 097c283f4..53d395d1f 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -38,7 +38,7 @@
 #define MNTPOINT	"mntpoint"
 #define TESTFILE	MNTPOINT"/testfile"
 
-static int len = 1024;
+static int len = 8 * 1024;
                  ^
		  This was needlessly modified so I just returned it to
		  previous value.

 static int recstart, reclen;
 
 static void ftruncate_expect_fail(int fd, off_t offset, const char *msg)
@@ -151,14 +151,11 @@ static void verify_ftruncate(void)
 
 static void setup(void)
 {
-	struct statvfs fs;
-
-	if (statvfs(".", &fs) == -1)
-		tst_brk(TFAIL | TERRNO, "statvfs failed");
-
-	if ((fs.f_flag & MS_MANDLOCK))
-		return;
-

When the test was mounting the device in the setup this code was here to
skip the mkfs and mount in a case that the tmp was mounted with
mandatory locking, but after the change to .mount_device it became
meaningless. Moreover it would break the test in a case that the TMPDIR
was in fact mounted with mandatory locking.

+	 /*
+	  * Kernel returns EPERM when CONFIG_MANDATORY_FILE_LOCKING is not
+	  * supported - to avoid false negatives, mount the fs first without
+	  * flags and then remount it as MS_MANDLOCK
+	  */

And I've restored this comment as this is one of the places where it
makes sense to explain why we are not mounting the fs with MS_MANDLOCK
in the first place.

 	if (mount(NULL, MNTPOINT, NULL, MS_REMOUNT|MS_MANDLOCK, NULL) == -1) {
 		if (errno == EPERM) {
 			tst_brk(TCONF,
@@ -177,5 +174,6 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.mount_device = 1,
+	.needs_root = 1,
 	.mntpoint = MNTPOINT,
 };

-- 
Cyril Hrubis
chrubis@suse.cz
