Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VZera-0000rt-Ir
	for ltp-list@lists.sourceforge.net; Fri, 25 Oct 2013 10:43:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VZerY-0004gD-J3
	for ltp-list@lists.sourceforge.net; Fri, 25 Oct 2013 10:43:30 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9PAhKm7016390
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Oct 2013 18:43:20 +0800
Message-ID: <526A4B44.4030809@cn.fujitsu.com>
Date: Fri, 25 Oct 2013 18:43:16 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] chown/chown04.c: Add ELOOP EROFS
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

Add ELOOP, EROFS error number test in chown04.c for chown(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |  2 +-
 runtest/stress.part3                      |  2 +-
 runtest/syscalls                          |  4 +--
 testcases/kernel/syscalls/chown/chown04.c | 58 +++++++++++++++++++++++++++++--
 4 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index 60140e2..a6f57e2 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -110,7 +110,7 @@ chmod07 chmod07
 chown01 chown01
 chown02 chown02
 chown03 export change_owner=$LTPROOT/testcases/bin/change_owner;chown03
-chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chown04
+chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chown04 -D DEVICE -T DEVICE_FS_TYPE
 chown05 chown05
 
 chroot01 chroot01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 7e7f1b7..2962cc4 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -52,7 +52,7 @@ chmod07 chmod07
 chown01 chown01
 chown02 chown02
 chown03 export change_owner=$LTPROOT/testcases/bin/change_owner;chown03
-chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chown04
+chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chown04 -D DEVICE -T DEVICE_FS_TYPE
 chown05 chown05
 
 chroot01 chroot01
diff --git a/runtest/syscalls b/runtest/syscalls
index 0486b95..180fb58 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -63,8 +63,8 @@ chown02 chown02
 chown02_16 chown02_16
 chown03 chown03
 chown03_16 chown03_16
-chown04 chown04
-chown04_16 chown04_16
+chown04 chown04 -D DEVICE -T DEVICE_FS_TYPE
+chown04_16 chown04_16 -D DEVICE -T DEVICE_FS_TYPE
 chown05 chown05
 chown05_16 chown05_16
 
diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index f45afc5..47b54bb 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -88,24 +88,41 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 #define MODE_RWX		 (S_IRWXU|S_IRWXG|S_IRWXO)
 #define FILE_MODE		 (S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
+#define DIR_MODE		 (S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+				 S_IXGRP|S_IROTH|S_IXOTH)
 #define DIR_TEMP		 "testdir_1"
 #define TEST_FILE1		 "tfile_1"
 #define TEST_FILE2		 (DIR_TEMP "/tfile_2")
 #define TEST_FILE3		 "t_file/tfile_3"
+#define TEST_FILE4		 "test_eloop1"
+#define TEST_FILE5		 "mntpoint"
 
 void setup1();
 void setup2();
 void setup3();
 void longpath_setup();
+static void help(void);
 
 char Longpathname[PATH_MAX + 2];
 char high_address_node[64];
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
 
 struct test_case_t {
 	char *pathname;
@@ -119,11 +136,14 @@ struct test_case_t {
 	(char *)-1, EFAULT, NULL}, {
 	Longpathname, ENAMETOOLONG, longpath_setup}, {
 	"", ENOENT, NULL}, {
-TEST_FILE3, ENOTDIR, setup3},};
+	TEST_FILE3, ENOTDIR, setup3}, {
+	TEST_FILE4, ELOOP, NULL}, {
+	TEST_FILE5, EROFS, NULL},};
 
 char *TCID = "chown04";
 int TST_TOTAL = sizeof(test_cases) / sizeof(*test_cases);
-int exp_enos[] = { EPERM, EACCES, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR, 0 };
+int exp_enos[] = { EPERM, EACCES, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR,
+		   ELOOP, EROFS, 0 };
 
 struct passwd *ltpuser;
 
@@ -141,8 +161,13 @@ int main(int ac, char **av)
 	uid_t user_id;
 	gid_t group_id;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+	if (!dflag) {
+		tst_brkm(TBROK, NULL, "you must specify the device used for "
+			 "mounting with -D option");
+	}
 
 	setup();
 
@@ -185,9 +210,12 @@ int main(int ac, char **av)
 void setup()
 {
 	int i;
+	int fd;
 
 	tst_require_root(NULL);
 
+	tst_mkfs(NULL, device, fstype, NULL);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	ltpuser = getpwnam("nobody");
@@ -208,6 +236,19 @@ void setup()
 
 	test_cases[3].pathname = bad_addr;
 
+	SAFE_SYMLINK(cleanup, "test_eloop1", "test_eloop2");
+	SAFE_SYMLINK(cleanup, "test_eloop2", "test_eloop1");
+
+	SAFE_SETEUID(cleanup, 0);
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+	if (mount(device, "mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+
 	for (i = 0; i < TST_TOTAL; i++)
 		if (test_cases[i].setupfunc != NULL)
 			test_cases[i].setupfunc();
@@ -290,7 +331,18 @@ void cleanup()
 
 	if (seteuid(0) == -1)
 		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
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
