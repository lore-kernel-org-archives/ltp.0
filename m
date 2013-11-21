Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VjTCB-0003zh-VP
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 12:17:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjTC8-0008An-EN
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 12:17:19 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rALCH7sm018187
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Nov 2013 20:17:07 +0800
Message-ID: <1385036222.1529.2.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2013 20:17:02 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] fchmod/fchmod06.c: add EROFS
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

add EROFS error for fchmod(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fchmod/fchmod06.c | 63 ++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index 7776e1e..fa9cefd 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -80,6 +80,7 @@
 #include <unistd.h>
 #include <grp.h>
 #include <pwd.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -88,9 +89,23 @@
 #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
 #define TEST_FILE1	"tfile_1"
 #define TEST_FILE2	"tfile_2"
+#define TEST_FILE3	"mntpoint/tfile_3"
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
@@ -99,20 +114,33 @@ static struct test_case_t {
 } test_cases[] = {
 	{&fd1, FILE_MODE, EPERM},
 	{&fd2, FILE_MODE, EBADF},
+	{&fd3, FILE_MODE, EROFS},
 };
 
 char *TCID = "fchmod06";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
-static int exp_enos[] = { EPERM, EBADF, 0 };
+static int exp_enos[] = { EPERM, EBADF, EROFS, 0 };
 static struct passwd *ltpuser;
 
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
 
@@ -171,6 +199,24 @@ static void setup(void)
 			 TEST_FILE1);
 	}
 
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+	if (mount(device, "mntpoint", fstype, 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	fd3 = SAFE_CREAT(cleanup, TEST_FILE3, 0666);
+	SAFE_CLOSE(cleanup, fd3);
+	if (mount(device, "mntpoint", fstype,
+		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+	fd3 = SAFE_OPEN(cleanup, TEST_FILE3, O_RDONLY, 0666);
+
 	SAFE_CLOSE(cleanup, fd2);
 
 	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
@@ -182,5 +228,20 @@ static void cleanup(void)
 
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
