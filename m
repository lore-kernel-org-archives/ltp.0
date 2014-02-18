Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WFmUR-0004nV-4W
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 15:21:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFmUP-00056e-Tt
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 15:21:43 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1IFLXcR008457
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 23:21:34 +0800
Message-ID: <1392736891.2654.15.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 18 Feb 2014 23:21:31 +0800
In-Reply-To: <1392736686.2654.13.camel@G08JYZSD130126>
References: <1390210456.6682.12.camel@G08JYZSD130126>
	<1390210861.6682.14.camel@G08JYZSD130126>
	<1392736686.2654.13.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] mkdir/mkdir03.c: add new error number tests
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
 testcases/kernel/syscalls/mkdir/mkdir03.c | 61 +++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index f0f444f..8058fcf 100644
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
@@ -27,6 +27,8 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include <sys/mount.h>
+
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
@@ -36,16 +38,34 @@ struct test_case_t;
 static void mkdir_verify(struct test_case_t *tc);
 static void bad_addr_setup(struct test_case_t *tc);
 static void cleanup(void);
+static void help(void);
 
 #define TST_EEXIST	"tst_eexist"
 #define TST_ENOENT	"tst_enoent/tst"
 #define TST_ENOTDIR	"tst_enotdir/tst"
 #define MODE		0777
 
+#define MNT_POINT	"mntpoint"
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define TST_EROFS      "mntpoint/tst_erofs"
+
 char *TCID = "mkdir03";
 
 static char long_dir[PATH_MAX+2];
-static int exp_enos[] = { EFAULT, ENAMETOOLONG, EEXIST, ENOENT, ENOTDIR, 0 };
+static char loop_dir[PATH_MAX] = ".";
+static char *fstype = "ext2";
+static char *device;
+static int mount_flag;
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", NULL, &device},
+	{NULL, NULL, NULL}
+};
+
+static int exp_enos[] = { EFAULT, ENAMETOOLONG, EEXIST, ENOENT,
+			  ENOTDIR, ELOOP, EROFS, 0 };
 
 static struct test_case_t {
 	char *pathname;
@@ -60,6 +80,8 @@ static struct test_case_t {
 	{TST_EEXIST, MODE, EEXIST, NULL},
 	{TST_ENOENT, MODE, ENOENT, NULL},
 	{TST_ENOTDIR, MODE, ENOTDIR, NULL},
+	{loop_dir, MODE, ELOOP, NULL},
+	{TST_EROFS, MODE, EROFS, NULL},
 };
 
 int TST_TOTAL = ARRAY_SIZE(TC);
@@ -69,10 +91,16 @@ int main(int ac, char **av)
 	int i, lc;
 	char *msg;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	if (!device) {
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
+
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -87,6 +115,10 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	int i;
+
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
@@ -100,6 +132,19 @@ static void setup(void)
 	SAFE_TOUCH(cleanup, TST_EEXIST, MODE, NULL);
 
 	SAFE_TOUCH(cleanup, "tst_enotdir", MODE, NULL);
+
+	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	for (i = 0; i < 43; i++)
+		strcat(loop_dir, "/test_eloop");
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+	if (mount(device, MNT_POINT, fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
 }
 
 #if !defined(UCLINUX)
@@ -138,5 +183,15 @@ static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	if (mount_flag && umount(MNT_POINT) < 0)
+		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
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
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
