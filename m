Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VtEtk-0002OT-Lg
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 11:02:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VtEti-000777-R0
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 11:02:40 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBIB2WfK020107
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Dec 2013 19:02:32 +0800
Message-ID: <1387364550.1634.4.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Wed, 18 Dec 2013 19:02:30 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH v3] creat/creat06.c: add new error tests
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
To: ltp-list <ltp-list@lists.sourceforge.net>

add ELOOP and EROFS tests in creat06.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |  2 +-
 runtest/stress.part3                      |  2 +-
 runtest/syscalls                          |  2 +-
 testcases/kernel/syscalls/creat/creat06.c | 93 ++++++++++++++++++++++++++-----
 4 files changed, 82 insertions(+), 17 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index c90bc48..11a79d9 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -140,7 +140,7 @@ creat01 creat01
 creat03 creat03
 creat04 creat04
 creat05 creat05
-creat06 creat06
+creat06 creat06 -D DEVICE -T DEVICE_FS_TYPE
 creat07 creat07
 creat08 creat08
 creat09 creat09
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index eac28d0..5ccd259 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -81,7 +81,7 @@ creat01 creat01
 creat03 creat03
 creat04 creat04
 creat05 creat05
-creat06 creat06
+creat06 creat06 -D DEVICE -T DEVICE_FS_TYPE
 creat07 creat07
 creat08 creat08
 creat09 creat09
diff --git a/runtest/syscalls b/runtest/syscalls
index c5bbe8f..c613406 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -98,7 +98,7 @@ creat01 creat01
 creat03 creat03
 creat04 creat04
 creat05 creat05
-creat06 creat06
+creat06 creat06 -D DEVICE -T DEVICE_FS_TYPE
 creat07 creat07
 creat08 creat08
 creat09 creat09
diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index f892200..6caf5d1 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -26,6 +26,8 @@
  *	4.	ENOTDIR
  *	5.	EFAULT
  *	6.	EACCES
+ *	7.	ELOOP
+ *	8.	EROFS
  *
  *
  * ALGORITHM
@@ -41,6 +43,10 @@
  *		and test for EFAULT
  *	6.	Attempt to creat(2) a file in a directory with no
  *		execute permission and test for EACCES
+ *	7.	Attempt to creat(2) a file which links the other file that
+ *		links the former and test for ELOOP
+ *	8.	Attempt to creat(2) a file in a Read-only file system
+ *		and test for EROFS
  */
 
 #include <stdio.h>
@@ -51,6 +57,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <sys/mount.h>
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
@@ -59,37 +66,54 @@
 #define	NO_DIR		"testfile/testdir"
 #define	NOT_DIR		"file1/testdir"
 #define	TEST6_FILE	"dir6/file6"
+#define	TEST7_FILE	"file7"
+#define	TEST8_FILE	"mntpoint/tmp"
 
 #define	MODE1		0444
 #define	MODE2		0666
 
 static void setup(void);
 static void cleanup(void);
+static void test6_setup(void);
+static void test6_cleanup(void);
+static void help(void);
 #if !defined(UCLINUX)
 static void bad_addr_setup(int);
 #endif
 
 static char long_name[PATH_MAX+2];
+static char *fstype = "ext2";
+static char *device;
+static int dflag;
+static int mount_flag;
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
 static struct test_case_t {
 	char *fname;
 	int mode;
 	int error;
 	void (*setup)();
+	void (*cleanup)(void);
 } TC[] = {
-	{TEST_FILE, MODE1, EISDIR, NULL},
-	{long_name, MODE1, ENAMETOOLONG, NULL},
-	{NO_DIR, MODE1, ENOENT, NULL},
-	{NOT_DIR, MODE1, ENOTDIR, NULL},
+	{TEST_FILE, MODE1, EISDIR, NULL, NULL},
+	{long_name, MODE1, ENAMETOOLONG, NULL, NULL},
+	{NO_DIR, MODE1, ENOENT, NULL, NULL},
+	{NOT_DIR, MODE1, ENOTDIR, NULL, NULL},
 #if !defined(UCLINUX)
-	{NULL, MODE1, EFAULT, bad_addr_setup},
+	{NULL, MODE1, EFAULT, bad_addr_setup, NULL},
 #endif
-	{TEST6_FILE, MODE1, EACCES, NULL},
+	{TEST6_FILE, MODE1, EACCES, test6_setup, test6_cleanup},
+	{TEST7_FILE, MODE1, ELOOP, NULL, NULL},
+	{TEST8_FILE, MODE1, EROFS, NULL, NULL},
 };
 
 char *TCID = "creat06";
 int TST_TOTAL = ARRAY_SIZE(TC);
 static int exp_enos[] = { EISDIR, ENAMETOOLONG, ENOENT, ENOTDIR,
-			  EFAULT, EACCES, 0 };
+			  EFAULT, EACCES, ELOOP, EROFS, 0 };
 
 int main(int ac, char **av)
 {
@@ -97,9 +121,16 @@ int main(int ac, char **av)
 	char *msg;
 	int i;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	if (!dflag) {
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
+
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -115,6 +146,9 @@ int main(int ac, char **av)
 
 			TEST(creat(TC[i].fname, TC[i].mode));
 
+			if (TC[i].cleanup != NULL)
+				TC[i].cleanup();
+
 			if (TEST_RETURN != -1) {
 				tst_resm(TFAIL, "call succeeded unexpectedly");
 				continue;
@@ -137,14 +171,8 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
-	struct passwd *ltpuser;
-
 	tst_require_root(NULL);
 
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
-
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
@@ -158,6 +186,17 @@ static void setup(void)
 	SAFE_TOUCH(cleanup, "file1", MODE1, NULL);
 
 	SAFE_MKDIR(cleanup, "dir6", MODE2);
+
+	SAFE_SYMLINK(cleanup, TEST7_FILE, "test_file_eloop2");
+	SAFE_SYMLINK(cleanup, "test_file_eloop2", TEST7_FILE);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, "mntpoint", 0777);
+	if (mount(device, "mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
 }
 
 #if !defined(UCLINUX)
@@ -168,9 +207,35 @@ static void bad_addr_setup(int i)
 }
 #endif
 
+static void test6_setup(void)
+{
+	struct passwd *ltpuser;
+
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+}
+
+static void test6_cleanup(void)
+{
+	SAFE_SETEUID(cleanup, 0);
+}
+
 static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	if (mount_flag && umount("mntpoint") < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "umount device:%s failed", device);
+	}
+
 	tst_rmdir();
 }
+
+static void help(void)
+{
+	printf("-T type   : specifies the type of filesystem to be mounted. "
+	       "Default ext2.\n");
+	printf("-D device : device used for mounting.\n");
+}
-- 
1.8.2.1




------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
