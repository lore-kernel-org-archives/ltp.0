Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VZcWr-0001Pl-42
	for ltp-list@lists.sourceforge.net; Fri, 25 Oct 2013 08:13:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VZcWn-0000ni-7o
	for ltp-list@lists.sourceforge.net; Fri, 25 Oct 2013 08:13:57 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9P8Dfng005574
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Oct 2013 16:13:41 +0800
Message-ID: <526A2834.5090503@cn.fujitsu.com>
Date: Fri, 25 Oct 2013 16:13:40 +0800
From: "Wang, Xiaoguang" <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] chmod/chmod06.c: add ELOOP,
	EROFS error number test for chmod(2)
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


Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/syscalls                          |    2 +-
 testcases/kernel/syscalls/chmod/chmod06.c |   65 +++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 09e5f7f..b2a0cc0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -55,7 +55,7 @@ chmod02 chmod02
 chmod03 chmod03
 chmod04 chmod04
 chmod05 chmod05
-chmod06 chmod06
+chmod06 chmod06 -D DEVICE -T DEVICE_FS_TYPE
 chmod07 chmod07
 
 chown01 chown01
diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index 0745f02..0dd2433 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -92,9 +92,11 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 #define MODE_RWX	(S_IRWXU|S_IRWXG|S_IRWXO)
 #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
@@ -102,16 +104,33 @@
 #define TEST_FILE1	"tfile_1"
 #define TEST_FILE2	"testdir_1/tfile_2"
 #define TEST_FILE3	"t_file/tfile_3"
+#define TEST_FILE4	"test_file4"
+#define MNT_POINT	"mntpoint"
+
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
 
 int setup1();			/* setup function to test chmod for EPERM */
 int setup2();			/* setup function to test chmod for EACCES */
 int setup3();			/* setup function to test chmod for ENOTDIR */
 int longpath_setup();		/* setup function to test chmod for ENAMETOOLONG */
+static void help();
 
 char *test_home;		/* variable to hold TESTHOME env. */
 char Longpathname[PATH_MAX + 2];
 char High_address_node[64];
 
+static char *fstype = "ext2";
+static char *device;
+static int dflag;
+static int mount_flag;
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
+
 struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	char *pathname;
 	mode_t mode;
@@ -140,8 +159,10 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	{
 	"", FILE_MODE, ENOENT, NULL},
 	    /* Pathname contains a regular file. */
-	{
-TEST_FILE3, FILE_MODE, ENOTDIR, setup3},};
+	{TEST_FILE3, FILE_MODE, ENOTDIR, setup3},
+	{MNT_POINT, FILE_MODE, EROFS, NULL},
+	{TEST_FILE4, FILE_MODE, ELOOP, NULL},
+};
 
 char *TCID = "chmod06";
 int TST_TOTAL = sizeof(test_cases) / sizeof(*test_cases);
@@ -162,9 +183,16 @@ int main(int ac, char **av)
 	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	/* Check for mandatory option of the testcase */
+	if (!dflag) {
+		tst_brkm(TBROK, NULL, "you must specify the device "
+			 "used for mounting with -D option");
+	}
+
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -240,6 +268,19 @@ void setup()
 
 	tst_tmpdir();
 
+	tst_mkfs(NULL, device, fstype, NULL);
+
+	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+
+	/*
+	 * mount a read-only file system for test EROFS
+	 */
+	if (mount(device, MNT_POINT, fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
 	bad_addr = mmap(0, 1, PROT_NONE,
 			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
 	if (bad_addr == MAP_FAILED)
@@ -249,6 +290,13 @@ void setup()
 	for (i = 0; i < TST_TOTAL; i++)
 		if (test_cases[i].setupfunc != NULL)
 			test_cases[i].setupfunc();
+
+	/*
+	 * create two symbolic links who point to each other for
+	 * test ELOOP.
+	 */
+	SAFE_SYMLINK(cleanup, "test_file4", "test_file5");
+	SAFE_SYMLINK(cleanup, "test_file5", "test_file4");
 }
 
 /*
@@ -355,5 +403,16 @@ void cleanup()
 	if (chmod(DIR_TEMP, MODE_RWX) == -1)
 		tst_resm(TBROK | TERRNO, "chmod(%s) failed", DIR_TEMP);
 
+	if (mount_flag && umount(MNT_POINT) < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "umount device:%s failed", device);
+	}
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
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
