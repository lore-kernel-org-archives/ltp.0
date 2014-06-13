Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WvHdN-00016b-Oi
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 02:54:29 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvHdL-0007gm-Rj
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 02:54:29 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5D2sLUO022978
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Jun 2014 10:54:21 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 13 Jun 2014 10:53:19 +0800
Message-ID: <1402627999-11535-3-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1402627999-11535-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1402627999-11535-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] utimes/utimes01.c: add EPERM and EROFS error
	value tests
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

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 runtest/syscalls                            |  2 +-
 testcases/kernel/syscalls/utimes/utimes01.c | 59 ++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index c132a69..8514942 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1310,7 +1310,7 @@ utime04 utime04
 utime05 utime05
 utime06 utime06
 
-utimes01 utimes01
+utimes01 utimes01 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 # Introduced from Kernel 2.6.22 onwards
 utimensat01 utimensat_tests.sh
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index 25d6bfa..7f9dffb 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -27,6 +27,11 @@
  *      does not exist.
  *   3) utimes() returns -1 and sets errno to EFAULT if filename
  *      is NULL.
+ *   4) utimes() returns -1 and sets errno to EPERM if times is
+ *      not NULL, the caller's effective UID does not match the
+ *      owner of the file, and the caller is not privileged.
+ *   5) utimes() returns -1 and sets errno to EROFS if path resides
+ *      on a read-only file system.
  */
 
 #include <sys/types.h>
@@ -40,20 +45,34 @@
 #include <errno.h>
 #include <stdio.h>
 #include <pwd.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
 #include "linux_syscall_numbers.h"
 
+#define MNTPOINT "mntpoint"
 #define TESTFILE1 "testfile1"
 #define TESTFILE2 "testfile2"
+#define TESTFILE3 "mntpoint/testfile"
 #define FILE_MODE (S_IRWXU | S_IRGRP | S_IXGRP | \
 					S_IROTH | S_IXOTH)
+#define DIR_MODE (S_IRWXU | S_IRWXG | S_IRWXO)
 
 #define LTPUSER1 "nobody"
 #define LTPUSER2 "bin"
 
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
 static struct timeval a_tv[2] = { {0, 0}, {1000, 0} };
 static struct timeval m_tv[2] = { {1000, 0}, {0, 0} };
 static struct timeval tv[2] = { {1000, 0}, {2000, 0} };
@@ -68,25 +87,34 @@ static struct test_case_t {
 	{ TESTFILE2, NULL, EACCES },
 	{ "notexistfile", tv, ENOENT },
 	{ NULL, tv, EFAULT },
+	{ TESTFILE2, tv, EPERM },
+	{ TESTFILE3, tv, EROFS },
 };
 
 static void setup(void);
 static void cleanup(void);
 static void utimes_verify(const struct test_case_t *);
+static void help(void);
 
 char *TCID = "utimes01";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
-static int exp_enos[] = { EACCES, ENOENT, EFAULT, 0 };
+static int exp_enos[] = { EACCES, ENOENT, EFAULT,
+							EPERM, EROFS, 0 };
 
 int main(int ac, char **av)
 {
 	int i, lc;
 	const char *msg;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	if (!device) {
+		tst_brkm(TCONF, NULL, "you must specify the device "
+			"used for mounting with -D option");
+	}
+
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -124,6 +152,23 @@ void setup(void)
 	SAFE_CHOWN(cleanup, TESTFILE2, ltpuser->pw_uid,
 		ltpuser->pw_gid);
 
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
+	if (mount(device, MNTPOINT, fstype, 0, NULL) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"mount device:%s failed", device);
+	}
+	SAFE_TOUCH(cleanup, TESTFILE3, FILE_MODE, NULL);
+	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER1);
+	SAFE_CHOWN(cleanup, TESTFILE3, ltpuser->pw_uid,
+		ltpuser->pw_gid);
+	if (mount(device, MNTPOINT, fstype,
+			MS_REMOUNT | MS_RDONLY, NULL) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
 	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER1);
 	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 }
@@ -163,7 +208,17 @@ void cleanup(void)
 	if (seteuid(0) == -1)
 		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
 
+	if (mount_flag && umount(MNTPOINT) == -1)
+		tst_resm(TWARN | TERRNO, "umount %s failed", MNTPOINT);
+
 	TEST_CLEANUP;
 
 	tst_rmdir();
 }
+
+static void help(void)
+{
+	printf("-T type   : specifies the type of filesystem to be mounted. "
+		"Default ext2.\n");
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
