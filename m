Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Wwno1-0002R1-Lw
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 07:27:45 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wwno0-0001rT-6B
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 07:27:45 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5H7RZkh027546
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 15:27:35 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Tue, 17 Jun 2014 15:26:31 +0800
Message-ID: <1402989991-19613-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1402989991-19613-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1398079016-9193-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1402989991-19613-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 2/2] renameat/renameat01.c: add ELOOP,
	EROFS and EMLINK error value tests
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
To: ltp-list@lists.sourceforge.net

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 runtest/syscalls                                |  2 +-
 testcases/kernel/syscalls/renameat/renameat01.c | 88 ++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index c132a69..abb7906 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -850,7 +850,7 @@ rename13 rename13
 rename14 rename14
 
 #renameat test cases
-renameat01 renameat01
+renameat01 renameat01 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 rmdir01 rmdir01
 rmdir02 rmdir02 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index 8632950..ce1e146 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -24,6 +24,15 @@
  *      is relative and olddirfd is a file descriptor referring to
  *      a file other than a directory, or similar for newpath and
  *      newdirfd.
+ *   3) renameat(2) returns -1 and sets errno to ELOOP if too many
+ *      symbolic links were encountered in resolving oldpath or
+ *      newpath.
+ *   4) renameat(2) returns -1 and sets errno to EROFS if the file
+ *      is on a read-only file system.
+ *   5) renameat(2) returns -1 and sets errno to EMLINK if oldpath
+ *      already has the maximum number of links to it, or it is a
+ *      directory and the directory containing newpath has the
+ *      maximum number of links.
  */
 
 #define _GNU_SOURCE
@@ -37,6 +46,7 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -44,14 +54,21 @@
 #include "lapi/fcntl.h"
 #include "lapi/renameat.h"
 
+#define MNTPOINT "mntpoint"
 #define TESTDIR "testdir"
 #define NEW_TESTDIR "new_testdir"
+#define TESTDIR2 "/loopdir"
+#define NEW_TESTDIR2 "newloopdir"
+#define TESTDIR3 "emlinkdir"
+#define NEW_TESTDIR3 "testemlinkdir/new_emlinkdir"
 #define TESTFILE "testfile"
 #define NEW_TESTFILE "new_testfile"
 #define TESTFILE2 "testfile2"
 #define NEW_TESTFILE2 "new_testfile2"
 #define TESTFILE3 "testdir/testfile"
 #define TESTFILE4 "testfile4"
+#define TESTFILE5 "mntpoint/rofile"
+#define NEW_TESTFILE5 "mntpoint/newrofile"
 
 #define DIRMODE (S_IRWXU | S_IRWXG | S_IRWXO)
 #define FILEMODE (S_IRWXU | S_IRWXG | S_IRWXO)
@@ -63,6 +80,18 @@ static int badfd = 100;
 static int filefd;
 static char absoldpath[256];
 static char absnewpath[256];
+static char looppathname[sizeof(TESTDIR2) * 43] = ".";
+static int max_subdirs;
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
 	int *oldfdptr;
@@ -76,25 +105,35 @@ static struct test_case_t {
 	{ &olddirfd, absoldpath, &newdirfd, absnewpath, 0 },
 	{ &badfd, TESTFILE, &badfd, NEW_TESTFILE, EBADF },
 	{ &filefd, TESTFILE, &filefd, NEW_TESTFILE, ENOTDIR },
+	{ &curfd, looppathname, &curfd, NEW_TESTDIR2, ELOOP },
+	{ &curfd, TESTFILE5, &curfd, NEW_TESTFILE5, EROFS },
+	{ &curfd, TESTDIR3, &curfd, NEW_TESTDIR3, EMLINK },
 };
 
 static void setup(void);
 static void cleanup(void);
 static void renameat_verify(const struct test_case_t *);
+static void help(void);
 
 char *TCID = "renameat01";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
-static int exp_enos[] = { EBADF, ENOTDIR, 0 };
+static int exp_enos[] = { EBADF, ENOTDIR, ELOOP, EROFS,
+							EMLINK, 0 };
 
 int main(int ac, char **av)
 {
 	int i, lc;
 	const char *msg;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	if (!device) {
+		tst_brkm(TCONF, NULL, "you must specify the device "
+			"used for mounting with -D option");
+	}
+
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -113,6 +152,7 @@ int main(int ac, char **av)
 static void setup(void)
 {
 	char *tmpdir;
+	int i;
 
 	if ((tst_kvercmp(2, 6, 16)) < 0) {
 		tst_brkm(TCONF, NULL,
@@ -120,6 +160,8 @@ static void setup(void)
 			"2.6.16 and higher");
 	}
 
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_tmpdir();
@@ -143,10 +185,42 @@ static void setup(void)
 
 	filefd = SAFE_OPEN(cleanup, TESTFILE4,
 				O_RDWR | O_CREAT, FILEMODE);
+
+	/*
+	 * NOTE: the ELOOP test is written based on that the
+	 * consecutive symlinks limit in kernel is hardwired
+	 * to 40.
+	 */
+	SAFE_MKDIR(cleanup, "loopdir", DIRMODE);
+	SAFE_SYMLINK(cleanup, "../loopdir", "loopdir/loopdir");
+	for (i = 0; i < 43; i++)
+		strcat(looppathname, TESTDIR2);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, MNTPOINT, DIRMODE);
+	if (mount(device, MNTPOINT, fstype, 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"mount device:%s failed", device);
+	}
+	mount_flag = 1;
+	SAFE_TOUCH(cleanup, TESTFILE5, FILEMODE, NULL);
+	if (mount(device, MNTPOINT, fstype,
+			MS_REMOUNT | MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"mount device:%s failed", device);
+	}
+
+	SAFE_MKDIR(cleanup, TESTDIR3, DIRMODE);
+	max_subdirs = tst_fs_fill_subdirs(cleanup, "testemlinkdir");
 }
 
 static void renameat_verify(const struct test_case_t *tc)
 {
+	if (tc->exp_errno == EMLINK && max_subdirs == 0) {
+		tst_resm(TCONF, "EMLINK test is not appropriate");
+		return;
+	}
+
 	TEST(renameat(*(tc->oldfdptr), tc->oldpath,
 			*(tc->newfdptr), tc->newpath));
 
@@ -181,5 +255,15 @@ static void cleanup(void)
 	if (filefd && close(filefd) < 0)
 		tst_resm(TWARN | TERRNO, "close filefd failed");
 
+	if (mount_flag && umount(MNTPOINT) < 0)
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
1.9.3


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
