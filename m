Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Vbnup-0004oi-NA
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:47:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vbnuo-0004rb-6d
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:47:43 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9V8lXgC022376
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 16:47:35 +0800
Message-ID: <52721920.8080702@cn.fujitsu.com>
Date: Thu, 31 Oct 2013 16:47:28 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] acct/acct01.c: Add ELOOP ENAMETOOLONG EROFS
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
 runtest/ltplite                         |  2 +-
 runtest/stress.part3                    |  2 +-
 runtest/syscalls                        |  2 +-
 testcases/kernel/syscalls/acct/acct01.c | 72 ++++++++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index 60140e2..1e85cfd 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -67,7 +67,7 @@ access03 access03
 access04 access04
 access05 access05
 
-acct01 acct01
+acct01 acct01 -D DEVICE -T DEVICE_FS_TYPE
 
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 7e7f1b7..0eeb0c3 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -9,7 +9,7 @@ access03 access03
 access04 access04
 access05 access05
 
-acct01 acct01
+acct01 acct01 -D DEVICE -T DEVICE_FS_TYPE
 
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
diff --git a/runtest/syscalls b/runtest/syscalls
index 0486b95..ae3f0c7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -10,7 +10,7 @@ access03 access03
 access04 access04
 access05 access05
 
-acct01 acct01
+acct01 acct01 -D DEVICE -T DEVICE_FS_TYPE
 
 add_key01 add_key01
 add_key02 add_key02
diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index c38d4db..f067e9a 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -34,22 +34,41 @@
 #include <stdio.h>
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
@@ -64,18 +83,33 @@ static struct test_case_t {
 	{TEST_FILE4, "ENOTDIR", ENOTDIR, NULL,   NULL},
 	{TEST_FILE5, "EPERM",   EPERM,   setup2, cleanup2},
 	{NULL,       "EPERM",   EPERM,   setup2, cleanup2},
+	{TEST_FILE6, "ELOOP",        ELOOP,        NULL, NULL},
+	{TEST_FILE7, "ENAMETOOLONG", ENAMETOOLONG, NULL, NULL},
+	{TEST_FILE8, "EROFS",        EROFS,        NULL, NULL},
 };
 
 char *TCID = "acct01";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
 static struct passwd *ltpuser;
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
@@ -106,6 +140,31 @@ static void setup(void)
 	if (acct(TEST_FILE5) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
 
+	/* ELOOP SETTING */
+	SAFE_SYMLINK(cleanup, TEST_FILE6, "test_file_eloop2");
+	SAFE_SYMLINK(cleanup, "test_file_eloop2", TEST_FILE6);
+
+	/* ENAMETOOLONG SETTING */
+	memset(nametoolong, 'a', PATH_MAX+1);
+
+	/* EROFS SETTING */
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
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
@@ -160,6 +219,17 @@ static void cleanup(void)
 
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
-- 1.8.2.1 





------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
