Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1W83Ei-0007mw-Ct
	for ltp-list@lists.sourceforge.net; Tue, 28 Jan 2014 07:37:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W83Ef-0001vb-G9
	for ltp-list@lists.sourceforge.net; Tue, 28 Jan 2014 07:37:30 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0S7bJms023439
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Jan 2014 15:37:19 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 28 Jan 2014 15:36:05 +0800
Message-Id: <1390894565-463-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1390894565-463-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1390894565-463-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] mknod/mknod07.c: add EROFS and ELOOP error value
	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                           |  2 +-
 runtest/stress.part3                      |  2 +-
 runtest/syscalls                          |  2 +-
 testcases/kernel/syscalls/mknod/mknod07.c | 63 ++++++++++++++++++++++++++++++-
 4 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index 78e8801..d88bf5e 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -429,7 +429,7 @@ mknod03 mknod03
 mknod04 mknod04
 mknod05 mknod05
 mknod06 mknod06
-mknod07 mknod07
+mknod07 mknod07 -D DEVICE -T DEVICE_FS_TYPE
 mknod08 mknod08
 mknod09 mknod09
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 3b73c0c..b3de12a 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -362,7 +362,7 @@ mknod03 mknod03
 mknod04 mknod04
 mknod05 mknod05
 mknod06 mknod06
-mknod07 mknod07
+mknod07 mknod07 -D DEVICE -T DEVICE_FS_TYPE
 mknod08 mknod08
 mknod09 mknod09
 
diff --git a/runtest/syscalls b/runtest/syscalls
index d6c6c6b..246fcd2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -548,7 +548,7 @@ mknod03 mknod03
 mknod04 mknod04
 mknod05 mknod05
 mknod06 mknod06
-mknod07 mknod07
+mknod07 mknod07 -D DEVICE -T DEVICE_FS_TYPE
 mknod08 mknod08
 mknod09 mknod09
 
diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index 09ff604..7e507b1 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -25,6 +25,10 @@
  *	the caller is not super-user.
  *   2) mknod(2) returns -1 and sets errno to EACCES if parent directory
  *	does not allow  write  permission  to  the process.
+ *   3) mknod(2) returns -1 and sets errno to EROFS if pathname refers to
+ *      a file on a read-only file system.
+ *   4) mknod(2) returns -1 and sets errno to ELOOP if Too many symbolic
+ *      links were encountered in resolving pathname.
  *
  */
 
@@ -37,6 +41,7 @@
 #include <pwd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -44,12 +49,27 @@
 
 #define DIR_TEMP		"testdir_1"
 #define DIR_TEMP_MODE		(S_IRUSR | S_IXUSR)
+#define DIR_MODE		(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+				 S_IXGRP|S_IROTH|S_IXOTH)
+#define MNT_POINT		"mntpoint"
 
 #define FIFO_MODE	(S_IFIFO | S_IRUSR | S_IRGRP | S_IROTH)
 #define SOCKET_MODE	(S_IFSOCK | S_IRWXU | S_IRWXG | S_IRWXO)
 #define CHR_MODE	(S_IFCHR | S_IRUSR | S_IWUSR)
 #define BLK_MODE 	(S_IFBLK | S_IRUSR | S_IWUSR)
 
+static char *fstype = "ext2";
+static char *device;
+static int dflag;
+static int mount_flag;
+
+static char tst_eloop[PATH_MAX];
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
 
 static struct test_case_t {
 	char *pathname;
@@ -60,15 +80,18 @@ static struct test_case_t {
 	{ "testdir_1/tnode_2", FIFO_MODE, EACCES },
 	{ "tnode_3", CHR_MODE, EPERM },
 	{ "tnode_4", BLK_MODE, EPERM },
+	{ "mntpoint/tnode_5", SOCKET_MODE, EROFS },
+	{ tst_eloop, FIFO_MODE, ELOOP },
 };
 
 char *TCID = "mknod07";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
-static int exp_enos[] = { EPERM, EACCES, 0 };
+static int exp_enos[] = { EPERM, EACCES, EROFS, ELOOP, 0 };
 
 static void setup(int ac, char **argv);
 static void mknod_verify(int i);
 static void cleanup(void);
+static void help(void);
 
 int main(int ac, char **av)
 {
@@ -91,16 +114,25 @@ int main(int ac, char **av)
 
 static void setup(int ac, char **av)
 {
+	int i;
 	char *msg;
 	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	/* Check for mandatory option of the testcase */
+	if (!dflag) {
+		tst_brkm(TBROK, NULL, "you must specify the device "
+			 "used for mounting with -D option");
+	}
+
 	tst_require_root(NULL);
 
+	tst_mkfs(NULL, device, fstype, NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
@@ -109,10 +141,25 @@ static void setup(int ac, char **av)
 
 	TEST_PAUSE;
 
+	/* mount a read-only file system for EROFS test */
+	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+	if (mount(device, MNT_POINT, fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
 	ltpuser = SAFE_GETPWNAM(cleanup, nobody_uid);
 	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 	SAFE_MKDIR(cleanup, DIR_TEMP, DIR_TEMP_MODE);
+
+	/* create this pathname for ELOOP test */
+	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	strcpy(tst_eloop, ".");
+	for (i = 0; i < 50; i++)
+		strcat(tst_eloop, "/test_eloop");
 }
 
 static void mknod_verify(int i)
@@ -140,5 +187,17 @@ static void cleanup(void)
 
 	SAFE_SETEUID(NULL, 0);
 
+	if (mount_flag && umount(MNT_POINT) < 0) {
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
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
