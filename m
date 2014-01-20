Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1W5BM9-0002fv-Ax
	for ltp-list@lists.sourceforge.net; Mon, 20 Jan 2014 09:41:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W5BM7-0001Jc-RW
	for ltp-list@lists.sourceforge.net; Mon, 20 Jan 2014 09:41:21 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0K9fDaK012811
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Jan 2014 17:41:13 +0800
Message-ID: <1390210861.6682.14.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 20 Jan 2014 17:41:01 +0800
In-Reply-To: <1390210456.6682.12.camel@G08JYZSD130126>
References: <1390210456.6682.12.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/2] mkdir/mkdir03.c: add new error number tests
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

Add ELOOP, EROFS error number tests fof mkdir(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |  2 +-
 runtest/stress.part3                      |  2 +-
 runtest/syscalls                          |  2 +-
 testcases/kernel/syscalls/mkdir/mkdir03.c | 58 +++++++++++++++++++++++++++++--
 4 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index 4b5300d..edc67e8 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -415,7 +415,7 @@ mlockall03 mlockall03
 
 mkdir01 mkdir01
 mkdir02 mkdir02
-mkdir03 mkdir03
+mkdir03 mkdir03 -D DEVICE -T DEVICE_FS_TYPE
 mkdir04 mkdir04
 mkdir05 mkdir05
 mkdir05A symlink01 -T mkdir05
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index bb4807c..66ad4c6 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -348,7 +348,7 @@ mlockall03 mlockall03
 
 mkdir01 mkdir01
 mkdir02 mkdir02
-mkdir03 mkdir03
+mkdir03 mkdir03 -D DEVICE -T DEVICE_FS_TYPE
 mkdir04 mkdir04
 mkdir05 mkdir05
 mkdir05A symlink01 -T mkdir05
diff --git a/runtest/syscalls b/runtest/syscalls
index afa7976..bebf2b5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -530,7 +530,7 @@ mlockall03 mlockall03
 
 mkdir01 mkdir01
 mkdir02 mkdir02
-mkdir03 mkdir03
+mkdir03 mkdir03 -D DEVICE -T DEVICE_FS_TYPE
 mkdir04 mkdir04
 mkdir05 mkdir05
 mkdir05A symlink01 -T mkdir05
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 3aabe1c..b983f79 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -19,7 +19,7 @@
 /*
  * DESCRIPTION
  *	check mkdir() with various error conditions that should produce
- *	EFAULT, ENAMETOOLONG, EEXIST, ENOENT and ENOTDIR
+ *	EFAULT, ENAMETOOLONG, EEXIST, ENOENT, ENOTDIR, ELOOP and EROFS
  */
 
 #include <errno.h>
@@ -27,6 +27,7 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include <sys/mount.h>
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
@@ -35,16 +36,32 @@ static void setup(int ac, char **av);
 static void bad_addr_setup(int);
 static void mkdir_verify(int);
 static void cleanup(void);
+static void help(void);
 
 #define TST_EEXIST	"tst_eexist"
 #define TST_ENOENT	"tst_enoent/tst"
 #define TST_ENOTDIR	"tst_enotdir/tst"
+#define TST_EROFS	"mntpoint/tst_erofs"
 #define MODE		0777
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
 
 char *TCID = "mkdir03";
 
 static char long_dir[PATH_MAX+2];
-static int exp_enos[] = { EFAULT, ENAMETOOLONG, EEXIST, ENOENT, ENOTDIR, 0 };
+static char loop_dir[PATH_MAX];
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
+static int exp_enos[] = { EFAULT, ENAMETOOLONG, EEXIST, ENOENT, ENOTDIR,
+			  ELOOP, EROFS, 0 };
 
 static struct test_case_t {
 	char *pathname;
@@ -59,6 +76,8 @@ static struct test_case_t {
 	{TST_EEXIST, MODE, EEXIST, NULL},
 	{TST_ENOENT, MODE, ENOENT, NULL},
 	{TST_ENOTDIR, MODE, ENOTDIR, NULL},
+	{loop_dir, MODE, ELOOP, NULL},
+	{TST_EROFS, MODE, EROFS, NULL},
 };
 
 int TST_TOTAL = ARRAY_SIZE(TC);
@@ -87,11 +106,18 @@ static void setup(int ac, char **av)
 {
 	char *msg;
 	struct stat statbuf;
+	int i;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	if (!dflag) {
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
@@ -107,6 +133,20 @@ static void setup(int ac, char **av)
 	if (stat(TST_ENOENT, &statbuf) != -1)
 		tst_brkm(TBROK, cleanup, "directory exists - test #4");
 
+	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	strcpy(loop_dir, ".");
+	for (i = 0; i < 43; i++)
+		strcat(loop_dir, "/test_eloop");
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+	if (mount(device, "mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
 	TEST_EXP_ENOS(exp_enos);
 }
 
@@ -146,5 +186,17 @@ static void cleanup(void)
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
1.8.4.2




------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
