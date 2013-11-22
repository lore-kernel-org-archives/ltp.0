Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VjpTq-0004up-Ph
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 12:05:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjpTn-0000Qp-4a
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 12:05:02 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAMC4opx005325
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Nov 2013 20:04:51 +0800
Message-ID: <1385121884.1572.13.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Fri, 22 Nov 2013 20:04:44 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] creat/creat06.c: add new errors test
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

add ELOOP, EROFS in creat06.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |  2 +-
 runtest/stress.part3                      |  2 +-
 runtest/syscalls                          |  2 +-
 testcases/kernel/syscalls/creat/creat06.c | 63 ++++++++++++++++++++++++++++++-
 4 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index f0738c7..25b6908 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -139,7 +139,7 @@ creat01 creat01
 creat03 creat03
 creat04 creat04
 creat05 creat05
-creat06 creat06
+creat06 creat06 -D DEVICE -T DEVICE_FS_TYPE
 creat07 creat07
 creat08 creat08
 creat09 creat09
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 951b00e..c7d1861 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -80,7 +80,7 @@ creat01 creat01
 creat03 creat03
 creat04 creat04
 creat05 creat05
-creat06 creat06
+creat06 creat06 -D DEVICE -T DEVICE_FS_TYPE
 creat07 creat07
 creat08 creat08
 creat09 creat09
diff --git a/runtest/syscalls b/runtest/syscalls
index e5a5508..5c7867e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -97,7 +97,7 @@ creat01 creat01
 creat03 creat03
 creat04 creat04
 creat05 creat05
-creat06 creat06
+creat06 creat06 -D DEVICE -T DEVICE_FS_TYPE
 creat07 creat07
 creat08 creat08
 creat09 creat09
diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 6247c11..674fb53 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -67,6 +67,7 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/mount.h>
 #include <fcntl.h>
 #include "test.h"
 #include "usctest.h"
@@ -74,19 +75,34 @@
 
 static void setup(void);
 static void cleanup(void);
+static void test8_setup(void);
+static void help(void);
 
 #define	MODE1		0444
 #define	MODE2		0666
 #define NSIZE		1000
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
 #define NO_DIR		"testfile/testdir"
 #define NOT_DIR		"file1/testdir"
 #define TEST6_FILE	"dir6/file6"
+#define TEST7_FILE	"mntpoint/tmp"
+#define TEST8_FILE	"file8"
 
 static char long_name[PATH_MAX+2];
 static char good_dir[NSIZE];
 static int filehandle;
 static char *bad_addr;
+static char *fstype = "ext2";
+static char *device;
+static int dflag;
+static int mount_flag;
 static struct passwd *ltpuser;
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
 static struct test_case_t {
 	char *fname;
 	int mode;
@@ -101,17 +117,30 @@ static struct test_case_t {
 	{(char *)-1, MODE1, EFAULT, NULL},
 #endif
 	{TEST6_FILE, MODE1, EACCES, NULL},
+	{TEST7_FILE, MODE1, EROFS, NULL},
+	{TEST8_FILE, MODE1, ELOOP, test8_setup},
 };
 
 char *TCID = "creat06";
 int TST_TOTAL = ARRAY_SIZE(TC);
 static int exp_enos[] = { EISDIR, ENAMETOOLONG, ENOENT, ENOTDIR,
-			  EFAULT, EACCES, 0 };
+			  EFAULT, EACCES, EROFS, ELOOP, 0 };
 
 int main(int ac, char **av)
 {
 	int lc;
 	int i;
+	char *msg;
+
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (!dflag) {
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
 
 	setup();
 
@@ -179,11 +208,43 @@ static void setup(void)
 #endif
 
 	SAFE_MKDIR(cleanup, "dir6", MODE2);
+
+	SAFE_SETEUID(cleanup, 0);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+	if (mount(device, "mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	SAFE_SYMLINK(cleanup, TEST8_FILE, "test_file_eloop2");
+	SAFE_SYMLINK(cleanup, "test_file_eloop2", TEST8_FILE);
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+}
+
+static void test8_setup(void)
+{
+	SAFE_SETEUID(cleanup, 0);
 }
 
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
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
