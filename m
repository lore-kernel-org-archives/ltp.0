Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WcCDv-0006df-51
	for ltp-list@lists.sourceforge.net; Mon, 21 Apr 2014 11:17:19 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WcCDt-0004Rg-DR
	for ltp-list@lists.sourceforge.net; Mon, 21 Apr 2014 11:17:19 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3LBH3EN030684
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Apr 2014 19:17:03 +0800
From: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>
Date: Mon, 21 Apr 2014 11:17:05 +0000
Message-ID: <1398079016-9193-2-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1398079016-9193-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1398079016-9193-1-git-send-email-gux.fnst@cn.fujitsu.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] renameat/renameat01.c: add ELOOP,
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/renameat/renameat01.c | 115 +++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index bc08477..20526c5 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -25,6 +25,15 @@
  *      newdirfd.
  *   2) renameat(2) returns -1 and sets errno to EBADF if olddirfd
  *      or newdirfd is not a valid file descriptor.
+ *   3) renameat(2) returns -1 and sets errno to ELOOP if too many
+ *      symbolic links were encountered in resolving oldpath or
+ *      newpath.
+ *   4) renameat(2) returns -1 and sets errno to EROFS if the file
+ *      is on a read-only file system.
+ *   5) renameat(2) returns -1 and sets errno to EMLINK if oldpath
+ *      already has the maximum number of links to it, or it was a
+ *      directory and the directory containing newpath has the maximum
+ *      number of links.
  */
 
 #define _GNU_SOURCE
@@ -38,6 +47,7 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -49,14 +59,24 @@
 #define DIR_MODE (S_IRWXU | S_IRWXG | S_IRWXO)
 #define FILE_MODE (S_IRWXU | S_IRWXG | S_IRWXO)
 
+#define MNTPOINT "mntpoint"
 #define TESTDIR "testdir"
 #define NEW_TESTDIR "newtestdir"
+#define TESTDIR2 "/loopdir"
+#define NEW_TESTDIR2 "newloopdir"
+#define TESTDIR3 "mntpoint/mlinkdir"
+#define NEW_TESTDIR3 "mntpoint/testmlink/newmlinkdir"
 #define TESTFILE "testfile"
 #define NEW_TESTFILE "newtestfile"
 #define TESTFILE2 "testdir/testfile"
 #define NEW_TESTFILE2 "newtestdir/newtestfile"
 #define TESTFILE3 "/tmp/testfile3"
 #define NEW_TESTFILE3 "/tmp/newtestfile3"
+#define TESTFILE4 "mntpoint/rofile"
+#define NEW_TESTFILE4 "mntpoint/newrofile"
+
+static char looppathname[sizeof(TESTDIR2) * 43] = ".";
+static char *device;
 
 static void setup(void);
 static void cleanup(void);
@@ -65,14 +85,18 @@ static void test_success2(void);
 static void test_success3(void);
 static void test_enotdir(void);
 static void test_ebadf(void);
+static void test_eloop(void);
+static void test_erofs(void);
+static void test_emlink(void);
 static void check_and_print(int expected_errno);
 
 static void (*testfunc[])(void) = { test_success1, test_success2,
-				test_success3, test_enotdir, test_ebadf };
+				test_success3, test_enotdir, test_ebadf,
+				test_eloop, test_erofs, test_emlink };
 
 char *TCID = "renameat01";
 int TST_TOTAL = ARRAY_SIZE(testfunc);
-static int exp_enos[] = { ENOTDIR, EBADF, 0 };
+static int exp_enos[] = { ENOTDIR, EBADF, ELOOP, EROFS, EMLINK, 0 };
 
 int main(int ac, char **av)
 {
@@ -100,12 +124,27 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	int i, ret;
+	char lname[PATH_MAX];
+	unsigned long long link_count = 0;
+	const char *const opts[] = { "-O", "^dir_index", NULL };
+
 	if ((tst_kvercmp(2, 6, 16)) < 0) {
 		tst_brkm(TCONF, NULL,
 			"This test can only run on kernels that are "
 			"2.6.16 and higher");
 	}
 
+	tst_require_root(NULL);
+
+	device = getenv("LTP_BIG_DEV");
+	if (device == NULL) {
+		tst_brkm(TCONF, NULL,
+			"you must specify a big blockdevice(>500MB)");
+	} else {
+		tst_mkfs(NULL, device, "ext4", opts);
+	}
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_tmpdir();
@@ -119,6 +158,46 @@ static void setup(void)
 	SAFE_MKDIR(cleanup, NEW_TESTDIR, DIR_MODE);
 
 	SAFE_TOUCH(cleanup, TESTFILE3, FILE_MODE, NULL);
+
+	/*
+	 * NOTE: the ELOOP test is written based on that the
+	 * consecutive symlinks limit in kernel is hardwired
+	 * to 40.
+	 */
+	SAFE_MKDIR(cleanup, "loopdir", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../loopdir", "loopdir/loopdir");
+	for (i = 0; i < 43; i++)
+		strcat(looppathname, TESTDIR2);
+
+	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
+
+	if (mount(device, MNTPOINT, "ext4", 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"mount device:%s failed", device);
+	}
+
+	SAFE_TOUCH(cleanup, TESTFILE4, FILE_MODE, NULL);
+
+	SAFE_MKDIR(cleanup, TESTDIR3, DIR_MODE);
+	SAFE_MKDIR(cleanup, "mntpoint/testmlink", DIR_MODE);
+	while (1) {
+		sprintf(lname, "mntpoint/testmlink/mlink%lld", ++link_count);
+		ret = mkdir(lname, DIR_MODE);
+		if (ret == -1) {
+			switch (errno) {
+			case EMLINK:
+				tst_resm(TINFO, "for ext4 the max links is"
+					" %lld", link_count + 1);
+				break;
+			default:
+				tst_brkm(TCONF | TERRNO, cleanup,
+				"we do not hit the maximum number of "
+				"links to dir test_parent_dir in ext4."
+				"Unexpected error:");
+			}
+			break;
+		}
+	}
 }
 
 static void test_success1(void)
@@ -207,6 +286,35 @@ static void test_ebadf(void)
 	check_and_print(EBADF);
 }
 
+static void test_eloop(void)
+{
+	TEST(renameat(AT_FDCWD, looppathname, AT_FDCWD, NEW_TESTDIR2));
+	check_and_print(ELOOP);
+}
+
+static void test_erofs(void)
+{
+	if (mount(device, MNTPOINT, "ext4", MS_REMOUNT | MS_RDONLY,
+			NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"mount device:%s failed", device);
+	}
+
+	TEST(renameat(AT_FDCWD, TESTFILE4, AT_FDCWD, NEW_TESTFILE4));
+	check_and_print(EROFS);
+}
+
+static void test_emlink(void)
+{
+	if (mount(device, MNTPOINT, "ext4", MS_REMOUNT, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"mount device:%s failed", device);
+	}
+
+	TEST(renameat(AT_FDCWD, TESTDIR3, AT_FDCWD, NEW_TESTDIR3));
+	check_and_print(EMLINK);
+}
+
 static void check_and_print(int expected_errno)
 {
 	if (TEST_ERRNO == expected_errno) {
@@ -223,5 +331,8 @@ static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	if (umount(MNTPOINT) == -1)
+		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
+
 	tst_rmdir();
 }
-- 
1.9.0
------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
