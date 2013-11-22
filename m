Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VjqZx-0008FT-NS
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 13:15:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjqZu-00046p-4V
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 13:15:25 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAMCa8IF006173
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Nov 2013 20:36:08 +0800
Message-ID: <1385123762.1572.16.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Fri, 22 Nov 2013 20:36:02 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] fchown/fchown04.c: add EROFS
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

Add case for fchown(2) with EROFS error.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |  2 +-
 runtest/stress.part3                        |  2 +-
 runtest/syscalls                            |  4 +-
 testcases/kernel/syscalls/fchown/fchown04.c | 87 ++++++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index 2382dec..eb776e8 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -189,7 +189,7 @@ fchmod07 fchmod07
 fchown01 fchown01
 fchown02 fchown02
 fchown03 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchown03
-fchown04 export change_owner=$LTPROOT/testcases/bin/change_owner;fchown04
+fchown04 export change_owner=$LTPROOT/testcases/bin/change_owner;fchown04 -D DEVICE -T DEVICE_FS_TYPE
 fchown05 fchown05
 
 fcntl01 fcntl01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 16247e9..915591e 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -130,7 +130,7 @@ fchmod07 fchmod07
 fchown01 fchown01
 fchown02 fchown02
 fchown03 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchown03
-fchown04 export change_owner=$LTPROOT/testcases/bin/change_owner;fchown04
+fchown04 export change_owner=$LTPROOT/testcases/bin/change_owner;fchown04 -D DEVICE -T DEVICE_FS_TYPE
 fchown05 fchown05
 
 fcntl01 fcntl01
diff --git a/runtest/syscalls b/runtest/syscalls
index fa01ff7..a121e5c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -184,8 +184,8 @@ fchown02 fchown02
 fchown02_16 fchown02_16
 fchown03 fchown03
 fchown03_16 fchown03_16
-fchown04 fchown04
-fchown04_16 fchown04_16
+fchown04 fchown04 -D DEVICE -T DEVICE_FS_TYPE
+fchown04_16 fchown04_16 -D DEVICE -T DEVICE_FS_TYPE
 fchown05 fchown05
 fchown05_16 fchown05_16
 
diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index 707a979..3c6ea97 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
@@ -79,6 +79,7 @@
 #include <pwd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -86,9 +87,24 @@
 
 #define TEST_FILE1	"tfile_1"
 #define TEST_FILE2	"tfile_2"
+#define TEST_FILE3	"mntpoint/tfile_3"
+#define TEST_FILE4	"tfile_4"
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
 
 static int fd1;
 static int fd2;
+static int fd3;
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
 
 static struct test_case_t {
 	int *fd;
@@ -96,19 +112,32 @@ static struct test_case_t {
 } test_cases[] = {
 	{&fd1, EPERM},
 	{&fd2, EBADF},
+	{&fd3, EROFS},
 };
 
 char *TCID = "fchown04";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
-static int exp_enos[] = { EPERM, EBADF, 0 };
+static int exp_enos[] = { EPERM, EBADF, EROFS, 0 };
 
 static void setup(void);
 static void cleanup(void);
+static void help(void);
 
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
+	/* Check for mandatory option of the testcase */
+	if (!dflag) {
+		tst_brkm(TBROK, NULL, "you must specify the device used for "
+			 "mounting with -D option");
+	}
 
 	setup();
 
@@ -139,6 +168,23 @@ int main(int ac, char **av)
 			}
 		}
 
+		TEST(chown(TEST_FILE4, geteuid(), getegid()));
+
+		if (TEST_RETURN == -1) {
+			if (TEST_ERRNO == ENOENT) {
+				tst_resm(TPASS | TTERRNO,
+					 "chown failed as expected");
+			} else {
+				tst_resm(TFAIL | TTERRNO,
+					 "chown failed unexpectedly; "
+					 "expected %d - %s",
+					 test_cases[i].exp_errno,
+					 strerror(test_cases[i].
+						  exp_errno));
+			}
+		} else {
+			tst_resm(TFAIL, "chown passed unexpectedly");
+		}
 	}
 
 	cleanup();
@@ -173,6 +219,31 @@ static void setup(void)
 	/* EBADF */
 	fd2 = SAFE_OPEN(cleanup, TEST_FILE2, O_RDWR | O_CREAT, 0666);
 
+	/* EROFS */
+	tst_mkfs(NULL, device, fstype, NULL);
+
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+
+	if (mount(device, "mntpoint", fstype, 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	/* Create a file in the file system, then remount it as read-only */
+	fd3 = SAFE_CREAT(cleanup, TEST_FILE3, 0644);
+
+	SAFE_CLOSE(cleanup, fd3);
+
+	if (mount(device, "mntpoint", fstype,
+		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	fd3 = SAFE_OPEN(cleanup, TEST_FILE3, O_RDONLY);
+
 	SAFE_CLOSE(cleanup, fd2);
 
 	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
@@ -184,6 +255,20 @@ static void cleanup(void)
 
 	SAFE_CLOSE(NULL, fd1);
 
+	SAFE_CLOSE(NULL, fd3);
+
+	SAFE_SETEUID(NULL, 0);
+	if (mount_flag && umount("mntpoint") < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "umount device:%s failed", device);
+	}
+
 	tst_rmdir();
+}
 
+static void help(void)
+{
+	printf("-T type   : specifies the type of filesystem to be mounted. "
+	       "Default ext2.\n");
+	printf("-D device : device used for mounting.\n");
 }
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
