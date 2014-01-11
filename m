Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1W1p0p-00026v-I8
	for ltp-list@lists.sourceforge.net; Sat, 11 Jan 2014 03:13:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W1p0n-0005Mb-5j
	for ltp-list@lists.sourceforge.net; Sat, 11 Jan 2014 03:13:27 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0B3DH9H026315
	for <ltp-list@lists.sourceforge.net>; Sat, 11 Jan 2014 11:13:17 +0800
Message-ID: <1389409991.2061.14.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Sat, 11 Jan 2014 11:13:11 +0800
In-Reply-To: <1389353374.2061.9.camel@G08JYZSD130126>
References: <1389353374.2061.9.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v2] linkat/linkat02.c: add new error number tests
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

Add new error number tests for linkat(2):
* ENAMETOOLONG
* EEXIST
* ELOOP
* EACCES
* EMLINK
* EROFS

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/.gitignore        |   1 +
 testcases/kernel/syscalls/linkat/linkat02.c | 296 ++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 testcases/kernel/syscalls/linkat/linkat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index afa7976..4a6b891 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -487,6 +487,7 @@ link07 link07
 
 #linkat test cases
 linkat01 linkat01
+linkat02 linkat02 -D DEVICE -T DEVICE_FS_TYPE
 
 listen01 listen01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 91cf0f1..d1a8547 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -445,6 +445,7 @@
 /link/link06
 /link/link07
 /linkat/linkat01
+/linkat/linkat02
 /listen/listen01
 /llseek/llseek01
 /llseek/llseek02
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
new file mode 100644
index 0000000..af5162a
--- /dev/null
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -0,0 +1,296 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ */
+/*
+ * Test that linkat() fails and sets the proper errno values.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <error.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <pwd.h>
+#include <sys/mount.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+#include "safe_macros.h"
+
+#ifndef AT_FDCWD
+# define AT_FDCWD -100
+#endif
+#ifndef AT_SYMLINK_FOLLOW
+# define AT_SYMLINK_FOLLOW 0x400
+#endif
+
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define TEST_FILE	"testfile"
+#define TEST_EXIST	"testexist"
+#define TEST_ELOOP	"testeloop"
+#define TEST_EACCES	"./tmp/testeeacces"
+#define TEST_EACCES2	"./tmp/testeeacces2"
+#define TEST_EROFS	"mntpoint"
+#define TEST_EROFS2	"mntpoint/testerofs2"
+#define TEST_EMLINK	"mntpoint/testemlink"
+#define BASENAME	"mntpoint/basename"
+
+static long link_max;
+static char lname[PATH_MAX];
+static char nametoolong[PATH_MAX+2];
+static char *fstype = "ext2";
+static char *device;
+static int dflag;
+static int mount_flag;
+
+static void setup(void);
+static void cleanup(void);
+
+static void setup_eacces(void);
+static void setup_erofs(void);
+static void cleanup_erofs(void);
+static void cleanup_eacces(void);
+static void setup_emlink(void);
+static void cleanup_emlink(void);
+static void help(void);
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
+
+static struct test_struct {
+	const char *oldfn;
+	const char *newfn;
+	int flags;
+	int expected_errno;
+	void (*setupfunc) ();
+	void (*cleanfunc) ();
+} test_cases[] = {
+	{TEST_FILE, nametoolong, 0, ENAMETOOLONG, NULL, NULL},
+	{nametoolong, TEST_FILE, 0, ENAMETOOLONG, NULL, NULL},
+	{TEST_EXIST, TEST_EXIST, 0, EEXIST, NULL, NULL},
+	{TEST_ELOOP, TEST_FILE, AT_SYMLINK_FOLLOW, ELOOP, NULL, NULL},
+	{TEST_EACCES, TEST_EACCES2, 0, EACCES, setup_eacces, cleanup_eacces},
+	{TEST_EROFS, TEST_EROFS2, 0, EROFS, setup_erofs, cleanup_erofs},
+	{TEST_EMLINK, lname, 0, EMLINK, setup_emlink, cleanup_emlink},
+};
+
+char *TCID = "linkat02";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+static struct passwd *ltpuser;
+static void verify_linkat(struct test_struct *);
+
+static int exp_enos[] = { ENAMETOOLONG, EEXIST, ELOOP,
+			  EACCES, EROFS, EMLINK, 0 };
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+	int i;
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
+
+	setup();
+
+	TEST_EXP_ENOS(exp_enos);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			verify_linkat(&test_cases[i]);
+
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void verify_linkat(struct test_struct *desc)
+{
+	if (desc->setupfunc != NULL)
+		desc->setupfunc();
+
+	TEST(ltp_syscall(__NR_linkat, AT_FDCWD, desc->oldfn,
+			 AT_FDCWD, desc->newfn, desc->flags));
+
+	if (desc->cleanfunc != NULL)
+		desc->cleanfunc();
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL,
+			 "linkat(%s, %s, %s, %s, %d) succeeded unexpectedly",
+			 "AT_FDCWD", desc->oldfn,
+			 "AT_FDCWD", desc->newfn, desc->flags);
+		return;
+	}
+
+	if (TEST_ERRNO == desc->expected_errno) {
+		tst_resm(TPASS | TTERRNO, "linkat failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "linkat failed unexpectedly; expected: "
+			 "%d - %s", desc->expected_errno,
+			 strerror(desc->expected_errno));
+	}
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 16)) < 0)
+		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	TEST_PAUSE;
+
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+
+	SAFE_TOUCH(cleanup, TEST_FILE, 0644, NULL);
+
+	memset(nametoolong, 'a', PATH_MAX+1);
+
+	SAFE_TOUCH(cleanup, TEST_EXIST, 0644, NULL);
+
+	SAFE_SYMLINK(cleanup, TEST_ELOOP, "test_file_eloop2");
+	SAFE_SYMLINK(cleanup, "test_file_eloop2", TEST_ELOOP);
+
+	SAFE_MKDIR(cleanup, "./tmp", DIR_MODE);
+	SAFE_TOUCH(cleanup, TEST_EACCES, 0666, NULL);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+}
+
+static void setup_emlink(void)
+{
+	if (mount(device, "mntpoint", fstype, 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	SAFE_TOUCH(cleanup, TEST_EMLINK, 0666, NULL);
+
+	link_max = 0;
+
+	while (1) {
+		sprintf(lname, "%s%ld", BASENAME, ++link_max);
+		TEST(link(TEST_EMLINK, lname));
+		if (TEST_RETURN == -1) {
+			switch (TEST_ERRNO) {
+			case EMLINK:
+				tst_resm(TINFO, "for %s the max links is %ld",
+					 fstype, link_max);
+				break;
+			default:
+				tst_brkm(TBROK | TERRNO, cleanup_emlink,
+					 "Unexpected error: ");
+				break;
+			}
+			break;
+		}
+	}
+}
+
+static void cleanup_emlink(void)
+{
+	long i;
+
+	for (i = 1; i < link_max; i++) {
+		sprintf(lname, "%s%ld", BASENAME, i);
+		SAFE_UNLINK(cleanup, lname);
+	}
+
+	SAFE_UNLINK(cleanup, TEST_EMLINK);
+
+	if (mount_flag && umount("mntpoint") < 0) {
+		mount_flag = 0;
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "umount device:%s failed", device);
+	}
+	mount_flag = 0;
+}
+
+static void setup_eacces(void)
+{
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+}
+
+static void cleanup_eacces(void)
+{
+	SAFE_SETEUID(cleanup, 0);
+}
+
+static void setup_erofs(void)
+{
+	if (mount(device, "mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+}
+
+static void cleanup_erofs(void)
+{
+	if (mount_flag && umount("mntpoint") < 0) {
+		mount_flag = 0;
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "umount device:%s failed", device);
+	}
+	mount_flag = 0;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (mount_flag && umount("mntpoint") < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "umount device:%s failed", device);
+	}
+
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
