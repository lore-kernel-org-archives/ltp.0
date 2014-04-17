Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Waju2-0001P3-5W
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 10:50:46 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wajtz-0003wd-Gg
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 10:50:46 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3HAoP6V014977
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Apr 2014 18:50:25 +0800
From: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>
Date: Thu, 17 Apr 2014 10:50:24 +0000
Message-ID: <1397731818-26430-2-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1397731818-26430-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1397731818-26430-1-git-send-email-gux.fnst@cn.fujitsu.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] rmdir/rmdir02.c: add ELOOP,
 EROFS and EBUSY error value tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/rmdir/rmdir02.c | 92 ++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index 9ae919a..9d55d76 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -18,11 +18,11 @@
  */
 /*
  * Description:
- *   1) create a directory tstdir1, create a file under it. call
- *      rmdir(), verify the return value is -1 and the errno is
- *      ENOTEMPTY.
- *   2) create a directory with long path, call rmdir(), verify
- *      the return value is -1 and the errno is ENAMETOOLONG.
+ *   1) create a directory tstdir1, create a file under it.
+ *      call rmdir(tstdir1), verify the return value is -1
+ *      and the errno is ENOTEMPTY.
+ *   2) create a directory with long path, call rmdir(tstdir1),
+ *      verify the return value is -1 and the errno is ENAMETOOLONG.
  *   3) pass a pathname containing non-exist directory component
  *      to rmdir(), verify the return value is -1 and the errno
  *      is ENOENT.
@@ -35,6 +35,14 @@
  *   6) attempt to pass an invalid pathname with NULL, as the
  *      argument to rmdir(), verify the return value is -1 and
  *      the errno is EFAULT.
+ *   7) pass a pathname with too many symbolic links to rmdir(),
+ *      verify the return value is -1 and the errno is ELOOP.
+ *   8) pass a pathname which refers to a directory on a read-only
+ *      file system to rmdir(), verify the return value is -1 and
+ *      the errno is EROFS.
+ *   9) pass a pathname which is currently used as a mount point
+ *      to rmdir(), verify the return value is -1 and the errno is
+ *      EBUSY.
  */
 
 #include <errno.h>
@@ -43,6 +51,8 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <pwd.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -54,10 +64,24 @@
 #define TESTDIR		"testdir"
 #define TESTDIR2	"nosuchdir/testdir2"
 #define TESTDIR3	"testfile2/testdir3"
+#define TESTDIR4	"/loopdir"
+#define MNTPOINT	"mntpoint"
+#define TESTDIR5	"mntpoint/testdir5"
 #define TESTFILE    "testdir/testfile"
 #define TESTFILE2   "testfile2"
 
 static char longpathname[PATH_MAX + 2];
+static char looppathname[sizeof(TESTDIR4) * 43] = ".";
+
+static char *fstype = "ext2";
+static char *device;
+static int mount_flag;
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", NULL, &device},
+	{NULL, NULL, NULL},
+};
 
 static struct test_case_t {
 	char *dir;
@@ -71,26 +95,35 @@ static struct test_case_t {
 	{ (char *)-1, EFAULT },
 #endif
 	{ NULL, EFAULT },
+	{ looppathname, ELOOP },
+	{ TESTDIR5, EROFS },
+	{ MNTPOINT, EBUSY },
 };
 
 static void setup(void);
 static void rmdir_verify(struct test_case_t *tc);
 static void cleanup(void);
+static void help(void);
 
 char *TCID = "rmdir02";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
 static int exp_enos[] = { ENOTEMPTY, ENAMETOOLONG, ENOENT, ENOTDIR,
-				EFAULT, 0 };
+				EFAULT, ELOOP, EROFS, EBUSY, 0 };
 
 int main(int ac, char **av)
 {
 	int i, lc;
 	char *msg;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	if (!device) {
+		tst_brkm(TBROK, NULL, "you must specify the device "
+			"used for mounting with -D option");
+	}
+
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -108,12 +141,34 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	int i;
+	struct passwd *ltpuser;
+
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
 	tst_tmpdir();
 
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
+	if (mount(device, MNTPOINT, fstype, 0, NULL) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"mount device:%s failed", device);
+	}
+	SAFE_MKDIR(cleanup, TESTDIR5, DIR_MODE);
+	if (mount(device, MNTPOINT, fstype, MS_REMOUNT | MS_RDONLY,
+			NULL) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+
 	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
 	SAFE_TOUCH(cleanup, TESTFILE, FILE_MODE, NULL);
 
@@ -125,6 +180,16 @@ static void setup(void)
 	test_cases[4].dir = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
 		MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
 #endif
+
+	/*
+	 * NOTE: the ELOOP test is written based on that the
+	 * consecutive symlinks limit in kernel is hardwired
+	 * to 40.
+	 */
+	SAFE_MKDIR(cleanup, "loopdir", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../loopdir", "loopdir/loopdir");
+	for (i = 0; i < 43; i++)
+		strcat(looppathname, TESTDIR4);
 }
 
 static void rmdir_verify(struct test_case_t *tc)
@@ -153,5 +218,18 @@ static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	if (seteuid(0) == -1)
+		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
+
+	if (mount_flag && umount(MNTPOINT) == -1)
+		tst_resm(TWARN | TERRNO, "umount %s failed", MNTPOINT);
+
 	tst_rmdir();
 }
+
+static void help(void)
+{
+	printf("-T type   : specifies the type of filesystem to be mounted. "
+		"Default ext2.\n");
+	printf("-D device : device used for mounting.\n");
+}
-- 
1.9.0
------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
