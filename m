Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VZe72-0004qz-El
	for ltp-list@lists.sourceforge.net; Fri, 25 Oct 2013 09:55:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VZe70-0007Qq-Dj
	for ltp-list@lists.sourceforge.net; Fri, 25 Oct 2013 09:55:24 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9P9tE1G013234
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Oct 2013 17:55:15 +0800
Message-ID: <526A4001.5050909@cn.fujitsu.com>
Date: Fri, 25 Oct 2013 17:55:13 +0800
From: "Wang, Xiaoguang" <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] access(2): add ELOOP, ENOTDIR, EROFS error values test
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
 runtest/ltplite                             |    2 +-
 runtest/stress.part3                        |    2 +-
 runtest/syscalls                            |    2 +-
 testcases/kernel/syscalls/access/access05.c |  123 ++++++++++++++++++++++++---
 4 files changed, 114 insertions(+), 15 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index 8ff55ee..f3aaea7 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -65,7 +65,7 @@ access01 access01
 access02 access02
 access03 access03
 access04 access04
-access05 access05
+access05 access05 -D DEVICE -T DEVICE_FS_TYPE
 
 acct01 acct01
 acct02 acct02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 0533d4d..9a97743 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -7,7 +7,7 @@ access01 access01
 access02 access02
 access03 access03
 access04 access04
-access05 access05
+access05 access05 -D DEVICE -T DEVICE_FS_TYPE
 
 acct01 acct01
 acct02 acct02
diff --git a/runtest/syscalls b/runtest/syscalls
index 09e5f7f..c6056f5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -8,7 +8,7 @@ access01 access01
 access02 access02
 access03 access03
 access04 access04
-access05 access05
+access05 access05 -D DEVICE -T DEVICE_FS_TYPE
 
 acct01 acct01
 acct02 acct02
diff --git a/testcases/kernel/syscalls/access/access05.c b/testcases/kernel/syscalls/access/access05.c
index 739b4b2..416b97b 100644
--- a/testcases/kernel/syscalls/access/access05.c
+++ b/testcases/kernel/syscalls/access/access05.c
@@ -32,6 +32,12 @@
  *	if the specified file doesn't exist (or pathname is NULL).
  *   5. access() fails with -1 return value and sets errno to ENAMETOOLONG
  *      if the pathname size is > PATH_MAX characters.
+ *   6. access() fails with -1 return value and sets errno to ENOTDIR
+ *      if a component used as a directory in pathname is not a directory.
+ *   7. access() fails with -1 return value and sets errno to ELOOP
+ *      if too many symbolic links were encountered in resolving pathname.
+ *   8. access() fails with -1 return value and sets errno to EROFS
+ *      if write permission was requested for files on a read-only file system.
  *
  *   07/2001 Ported by Wayne Boyer
  */
@@ -46,6 +52,7 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <pwd.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -56,7 +63,23 @@
 #define TEST_FILE2	"test_file2"
 #define TEST_FILE3	"test_file3"
 #define TEST_FILE4	"test_file4"
-
+#define TEST_FILE5	"test_file5/test_file5"
+#define TEST_FILE6	"test_file6"
+
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define MNT_POINT	"mntpoint"
+
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
 
 #if !defined(UCLINUX)
 static char high_address_node[64];
@@ -79,19 +102,34 @@ static struct test_case_t {
 #endif
 	{"", W_OK, ENOENT},
 	{longpathname, R_OK, ENAMETOOLONG},
+	{TEST_FILE5, R_OK, ENOTDIR},
+	{TEST_FILE6, R_OK, ELOOP},
+	{MNT_POINT, W_OK, EROFS},
 };
 
 char *TCID = "access05";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
 
-static int exp_enos[] = { EACCES, EFAULT, EINVAL, ENOENT, ENAMETOOLONG, 0 };
+static int exp_enos[] = { EACCES, EFAULT, EINVAL, ENOENT, ENAMETOOLONG,
+			  ENOTDIR, ELOOP, EROFS, 0 };
 
 static const char nobody_uid[] = "nobody";
 static struct passwd *ltpuser;
 
 static void setup(void);
+
+/*
+ * EROFS need superuser privilege (mount and umount a readonly file system),
+ * but the other error values tests need a normal user.
+ * So we first call setup1() with superuser privilege to test EROFS, and then
+ * use setup() to call setuid()to change the real user id to perform
+ * other tests.
+ */
+static void setup1(void);
 static void access_verify(int i);
 static void cleanup(void);
+static void cleanup1(void);
+static void help(void);
 
 static char *bad_addr;
 
@@ -101,35 +139,70 @@ int main(int ac, char **av)
 	char *msg;
 	int i;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	setup();
+	/* Check for mandatory option of the testcase */
+	if (!dflag) {
+		tst_brkm(TBROK, NULL, "you must specify the device "
+			 "used for mounting with -D option");
+	}
+
+	setup1();
 
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
+		access_verify(TST_TOTAL - 1);
+	}
+	cleanup1();
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
 
-		for (i = 0; i < TST_TOTAL; i++)
+		for (i = 0; i < TST_TOTAL - 1; i++)
 			access_verify(i);
 	}
-
 	cleanup();
+
 	tst_exit();
 }
+static void setup1(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup1);
+
+	tst_require_root(NULL);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup1, MNT_POINT, DIR_MODE);
+
+	TEST_PAUSE;
+
+	/*
+	 *mount a read-only file system for test EROFS
+	 */
+	if (mount(device, MNT_POINT, fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup1,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+}
 
 static void setup(void)
 {
 	int fd;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	tst_require_root(NULL);
-
 	ltpuser = SAFE_GETPWNAM(cleanup, nobody_uid);
 	SAFE_SETUID(cleanup, ltpuser->pw_uid);
-	TEST_PAUSE;
+
+	tst_tmpdir();
 
 #if !defined(UCLINUX)
 	bad_addr = mmap(0, 1, PROT_NONE,
@@ -141,8 +214,6 @@ static void setup(void)
 	test_cases[5].pathname = get_high_address();
 #endif
 
-	tst_tmpdir();
-
 	/*
 	 * create TEST_FILE1 to test R_OK EACCESS
 	 */
@@ -172,6 +243,17 @@ static void setup(void)
 	 *the MAX length of PATH_MAX.
 	 */
 	memset(longpathname, 'a', sizeof(longpathname) - 1);
+
+	/* create test_file5 for test ENOTDIR. */
+	fd = SAFE_CREAT(cleanup, "test_file5", 0644);
+	SAFE_CLOSE(cleanup, fd);
+
+	/*
+	 * create two symbolic links who point to each other for
+	 * test ELOOP.
+	 */
+	SAFE_SYMLINK(cleanup, "test_file6", "test_file7");
+	SAFE_SYMLINK(cleanup, "test_file7", "test_file6");
 }
 
 static void access_verify(int i)
@@ -206,3 +288,20 @@ static void cleanup(void)
 
 	tst_rmdir();
 }
+static void cleanup1(void)
+{
+	TEST_CLEANUP;
+
+	if (mount_flag && umount(MNT_POINT) < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "umount device:%s failed", device);
+	}
+	tst_rmdir();
+}
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
