Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WvGoE-0003WF-6p
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 02:01:38 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvGoC-0006AA-1T
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 02:01:38 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5D21S23019744
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Jun 2014 10:01:29 +0800
Message-ID: <1402624868.2098.11.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 13 Jun 2014 10:01:08 +0800
In-Reply-To: <1402624697.2098.8.camel@G08JYZSD130126>
References: <1402624697.2098.8.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] utime/utime06.c: add EPERM and EROFS errno testes
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

Add EPERM and EROFS errno testes for utime(2).

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |  2 +-
 runtest/stress.part3                      |  2 +-
 runtest/syscalls                          |  2 +-
 testcases/kernel/syscalls/utime/utime06.c | 84 +++++++++++++++++++++++++++----
 4 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index d71f137..c8ac0ce 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -973,7 +973,7 @@ utime02 utime02
 utime03 utime03
 utime04 utime04
 utime05 utime05
-utime06 utime06
+utime06 utime06 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 vfork01 vfork01
 vfork02 vfork02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index bc71013..6340445 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -851,7 +851,7 @@ utime02 utime02
 utime03 utime03
 utime04 utime04
 utime05 utime05
-utime06 utime06
+utime06 utime06 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 vfork01 vfork01
 vfork02 vfork02
diff --git a/runtest/syscalls b/runtest/syscalls
index 3db5f2a..af11801 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1312,7 +1312,7 @@ utime02 utime02
 utime03 utime03
 utime04 utime04
 utime05 utime05
-utime06 utime06
+utime06 utime06 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 utimes01 utimes01
 
diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index 2dd68d8..2eed21c 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -26,6 +26,13 @@
  *	 - The user ID of the process is not "root".
  * 2. Verify that the system call utime() fails to set the modification
  *    and access times of a file if the specified file doesn't exist.
+ * 3. Verify that the system call utime() fails to set the modification
+ *    and access times of a file to the current time, under the following
+ *    constraints,
+ *	 - The times argument is not null.
+ *	 - The user ID of the process is not "root".
+ * 4. Verify that the system call utime() fails to set the modification
+ *    and access times of a file that resides on a read-only file system.
  */
 
 #include <errno.h>
@@ -40,30 +47,50 @@
 #include <wait.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
 
 #define TEMP_FILE	"tmp_file"
+#define MNT_POINT	"mntpoint"
 
 char *TCID = "utime06";
-static int exp_enos[] = { EACCES, ENOENT, 0 };
-
+static int exp_enos[] = { EACCES, ENOENT, EPERM, EROFS, 0 };
 static struct passwd *ltpuser;
+static const struct utimbuf times;
+static char *fstype = "ext2";
+static char *device;
+static int mount_flag;
+
+static void setup_nobody(void);
+static void cleanup_nobody(void);
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", NULL, &device},
+	{NULL, NULL, NULL}
+};
 
 struct test_case_t {
 	char *pathname;
 	int exp_errno;
+	const struct utimbuf *times;
+	void (*setup_func)(void);
+	void (*cleanup_func)(void);
 } Test_cases[] = {
-	{TEMP_FILE, EACCES},
-	{"", ENOENT},
+	{TEMP_FILE, EACCES, NULL, setup_nobody, cleanup_nobody},
+	{"", ENOENT, NULL, NULL, NULL},
+	{TEMP_FILE, EPERM, &times, setup_nobody, cleanup_nobody},
+	{MNT_POINT, EROFS, NULL, NULL, NULL},
 };
 
 int TST_TOTAL = ARRAY_SIZE(Test_cases);
 static void setup(void);
 static void utime_verify(const struct test_case_t *);
 static void cleanup(void);
+static void help(void);
 
 int main(int ac, char **av)
 {
@@ -71,10 +98,16 @@ int main(int ac, char **av)
 	const char *msg;
 	int i;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	if (!device) {
+		tst_brkm(TCONF, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
+
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -101,14 +134,26 @@ static void setup(void)
 
 	TEST_EXP_ENOS(exp_enos);
 
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, MNT_POINT, 0644);
+	if (mount(device, MNT_POINT, fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
 
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
 }
 
 static void utime_verify(const struct test_case_t *test)
 {
-	TEST(utime(test->pathname, NULL));
+	if (test->setup_func != NULL)
+		test->setup_func();
+
+	TEST(utime(test->pathname, test->times));
+
+	if (test->cleanup_func != NULL)
+		test->cleanup_func();
 
 	if (TEST_RETURN != -1) {
 		tst_resm(TFAIL, "utime succeeded unexpectedly");
@@ -124,12 +169,29 @@ static void utime_verify(const struct test_case_t *test)
 	}
 }
 
-static void cleanup(void)
+static void setup_nobody(void)
+{
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+}
+
+static void cleanup_nobody(void)
 {
-	if (seteuid(0) != 0)
-		tst_resm(TWARN | TERRNO, "seteuid failed");
+	SAFE_SETEUID(cleanup, 0);
+}
 
+static void cleanup(void)
+{
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
1.9.3




------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
