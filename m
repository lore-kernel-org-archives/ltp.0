Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VYZDj-00054Z-53
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 10:29:51 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYZDh-0003hC-Dh
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 10:29:51 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9MARJX7000496
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Oct 2013 18:28:08 +0800
Message-ID: <5266530C.5070604@cn.fujitsu.com>
Date: Tue, 22 Oct 2013 18:27:24 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] acct/acct01.c: Add ELOOP ENAMETOOLONG EROFS
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

Add ELOOP, ENAMETOOLONG, EROFS error number test in acct01.c for acct(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/syscalls                        |  2 +-
 testcases/kernel/syscalls/acct/acct01.c | 77 ++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 09e5f7f..a3a65b6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -10,7 +10,7 @@ access03 access03
 access04 access04
 access05 access05
 
-acct01 acct01
+acct01 acct01 -D DEVICE -T DEVICE_FS_TYPE
 acct02 acct02
 
 add_key01 add_key01
diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 062cc2b..1545df1 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -44,22 +44,41 @@
 #include <stdio.h>		/* needed by testhead.h */
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
 
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
 #define TEST_FILE1	"/"
 #define TEST_FILE2	"/dev/null"
 #define TEST_FILE3	"/tmp/does/not/exist"
 #define TEST_FILE4	"/etc/fstab/"
 #define TEST_FILE5	"./tmpfile"
+#define TEST_FILE6	"test_file_eloop1"
+#define TEST_FILE7	nametoolong
+#define TEST_FILE8	"mntpoint/tmp"
+
+static char nametoolong[PATH_MAX+2];
+static char *fstype = "ext2";
+static char *device;
+static int dflag;
+static int mount_flag;
 
 static void setup(void);
 static void cleanup(void);
 static void setup2(void);
 static void cleanup2(void);
 static void acct_verify(int);
+static void help(void);
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
 
 static struct test_case_t {
 	char *filename;
@@ -73,18 +92,33 @@ static struct test_case_t {
 	{TEST_FILE3, "ENOENT",  ENOENT,  NULL,   NULL},
 	{TEST_FILE4, "ENOTDIR", ENOTDIR, NULL,   NULL},
 	{TEST_FILE5, "EPERM",   EPERM,   setup2, cleanup2},
+	{TEST_FILE6, "ELOOP",        ELOOP,        NULL, NULL},
+	{TEST_FILE7, "ENAMETOOLONG", ENAMETOOLONG, NULL, NULL},
+	{TEST_FILE8, "EROFS",        EROFS,        NULL, NULL},
 };
 
 char *TCID = "acct01";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
 struct passwd *ltpuser;
-static int exp_enos[] = { EISDIR, EACCES, ENOENT, ENOTDIR, EPERM, 0 };
+static int exp_enos[] = { EISDIR, EACCES, ENOENT, ENOTDIR, EPERM,
+			  ELOOP, ENAMETOOLONG, EROFS, 0 };
 
 int main(int argc, char *argv[])
 {
 	int lc;
+	char *msg;
 	int i;
 
+	msg = parse_opts(argc, argv, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	/* Check for mandatory option of the testcase */
+	if (!dflag) {
+		tst_brkm(TBROK, NULL, "you must specify the device used for "
+			 "mounting with -D option");
+	}
+
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -101,10 +135,39 @@ int main(int argc, char *argv[])
 
 static void setup(void)
 {
+	int fd;
+
 	tst_require_root(NULL);
 
+	tst_mkfs(NULL, device, fstype, NULL);
+
 	tst_tmpdir();
 
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+
+	/* ELOOP SETTING */
+	SAFE_SYMLINK(cleanup, TEST_FILE6, "test_file_eloop2");
+	SAFE_SYMLINK(cleanup, "test_file_eloop2", TEST_FILE6);
+
+	/* ENAMETOOLONG SETTING */
+	memset(nametoolong, 'a', PATH_MAX+1);
+
+	/* EROFS SETTING */
+	if (mount(device, "mntpoint", fstype, 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+	/* Create a file in the file system, then remount it as read-only */
+	fd = SAFE_CREAT(cleanup, TEST_FILE8, 0644);
+	SAFE_CLOSE(cleanup, fd);
+	if (mount(device, "mntpoint", fstype,
+		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
 	/* turn off acct, so we are in a known state */
 	if (acct(NULL) == -1) {
 		if (errno == ENOSYS) {
@@ -143,6 +206,7 @@ static void acct_verify(int i)
 	}
 }
 
+/* EPERM SETTING */
 static void setup2(void)
 {
 	int fd;
@@ -169,6 +233,17 @@ static void cleanup(void)
 
 	if (acct(NULL) == -1)
 		tst_resm(TBROK | TERRNO, "acct(NULL) failed");
+	if (mount_flag && umount("mntpoint") < 0) {
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
1.8.2.1



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
