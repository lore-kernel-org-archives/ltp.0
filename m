Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UuGzb-0001v0-UN
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 06:56:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UuGzZ-0004hU-FF
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 06:56:43 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r636uXOi015029
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jul 2013 14:56:33 +0800
Message-ID: <51D3CADF.3070000@cn.fujitsu.com>
Date: Wed, 03 Jul 2013 14:55:27 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] mount/mount06.c: new case to test MS_MOVE of mount
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
To: LTP list <ltp-list@lists.sourceforge.net>


Create new test case "mount06.c" for MS_MOVE of mount.

Checking if file is visible from the new location after move mount.


Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/.gitignore      |   1 +
 testcases/kernel/syscalls/mount/mount06.c | 197 ++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount/mount06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3ab19f5..9468d81 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -578,6 +578,7 @@ mount01 mount01 -D DEVICE -T DEVICE_FS_TYPE
 mount02 mount02 -D DEVICE -T DEVICE_FS_TYPE
 mount03 mount03 -D DEVICE -T DEVICE_FS_TYPE
 mount04 mount04 -D DEVICE -T DEVICE_FS_TYPE
+mount06 mount06 -D DEVICE -T DEVICE_FS_TYPE

 move_pages01 move_pages.sh 01
 move_pages02 move_pages.sh 02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index fede145..4ed5a9a 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -521,6 +521,7 @@
 /mount/mount02
 /mount/mount03
 /mount/mount04
+/mount/mount06
 /mount/setuid_test
 /move_pages/move_pages01
 /move_pages/move_pages02
diff --git a/testcases/kernel/syscalls/mount/mount06.c b/testcases/kernel/syscalls/mount/mount06.c
new file mode 100644
index 0000000..79def55
--- /dev/null
+++ b/testcases/kernel/syscalls/mount/mount06.c
@@ -0,0 +1,197 @@
+/*
+ * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
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
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+/**************************************************************************
+ *
+ *    EXECUTED BY	: root / superuser
+ *
+ *    DESCRIPTION
+ *	Test for feature MS_MOVE of mount.
+ *	"Move a subtree"
+ *
+ *	Setup:
+ *	  Setup signal handling.
+ *	  Create a mount point.
+ *	  Pause for SIGUSR1 if option specified.
+ *
+ *	Test:
+ *	 Loop if the proper options are given.
+ *	  Execute system call
+ *	  Check return code, if system call failed (return=-1)
+ *		Log the errno and Issue a FAIL message.
+ *	  Otherwise, Issue a PASS message.
+ *
+ *	Cleanup:
+ *	  Delete the mount point.
+ *
+ *    RESTRICTIONS
+ *	test must run with the -D option
+ *	test doesn't support -c option to run it in parallel, as mount
+ *	syscall is not supposed to run in parallel.
+ *****************************************************************************/
+
+#include <errno.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define MNTPOINT_SRC	"mnt_src"
+#define MNTPOINT_DES	"mnt_des"
+#define TMP_FILE	"tstfile"
+#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
+
+static void help(void);
+static void setup(void);
+static void cleanup(void);
+
+char *TCID = "mount06";
+int TST_TOTAL = 1;
+
+static const char *fs_type = "ext2";
+
+static int tflag;
+static int dflag;
+static char *fstype;
+static char *device;
+static char path_name[PATH_MAX];
+static char file_src[PATH_MAX];
+static char file_des[PATH_MAX];
+static char mntpoint_src[PATH_MAX];
+static char mntpoint_des[PATH_MAX];
+
+static option_t options[] = {
+	{"T:", &tflag, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL},
+};
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, &help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	/* Check for mandatory option of the testcase */
+	if (!dflag)
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "the -D option");
+
+	if (tflag)
+		fs_type = fstype;
+
+	if (STD_COPIES != 1) {
+		tst_resm(TINFO, "-c option has no effect for this testcase - "
+			 "%s doesn't allow running more than one instance "
+			 "at a time", TCID);
+		STD_COPIES = 1;
+	}
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+
+		if (mount(device, mntpoint_src, fs_type, 0, NULL) == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "mount %s failed",
+				 mntpoint_src);
+
+		SAFE_FILE_PRINTF(cleanup, file_src, "TEST FILE");
+
+		TEST(mount(mntpoint_src, mntpoint_des, fs_type, MS_MOVE, NULL));
+
+		if (TEST_RETURN != 0) {
+			tst_resm(TFAIL | TTERRNO, "mount(2) failed");
+		} else {
+
+			if (open(file_des, O_CREAT | O_EXCL) == -1 &&
+			    errno == EEXIST)
+				tst_resm(TPASS, "move mount is ok");
+			else
+				tst_resm(TFAIL, "file %s is not available",
+					 file_des);
+
+			TEST(umount(mntpoint_des));
+			if (TEST_RETURN != 0)
+				tst_brkm(TBROK | TTERRNO, cleanup,
+					 "umount(2) failed");
+		}
+	}
+	cleanup();
+
+	tst_exit();
+}
+
+void setup(void)
+{
+	tst_require_root(NULL);
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	if (getcwd(path_name, sizeof(path_name)) == NULL)
+		tst_brkm(TBROK, cleanup, "getcwd failed");
+
+	/*
+	 * Turn current dir into a private mount point being a parent
+	 * mount which is required by move mount.
+	 */
+	if (mount(path_name, path_name, "none", MS_BIND, NULL) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "bind mount failed");
+
+	if (mount("none", path_name, "none", MS_PRIVATE, NULL) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "mount private failed");
+
+	snprintf(mntpoint_src, PATH_MAX, "%s/%s", path_name, MNTPOINT_SRC);
+	snprintf(mntpoint_des, PATH_MAX, "%s/%s", path_name, MNTPOINT_DES);
+
+	snprintf(file_src, PATH_MAX, "%s/%s/%s",
+		 path_name, MNTPOINT_SRC, TMP_FILE);
+	snprintf(file_des, PATH_MAX, "%s/%s/%s",
+		 path_name, MNTPOINT_DES, TMP_FILE);
+
+	SAFE_MKDIR(cleanup, mntpoint_src, DIR_MODE);
+	SAFE_MKDIR(cleanup, mntpoint_des, DIR_MODE);
+
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	if (umount(path_name) != 0)
+		tst_brkm(TBROK | TTERRNO, NULL, "umount(2) %s failed",
+			 path_name);
+
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
+
+void help(void)
+{
+	printf("-T type	  : specifies the type of filesystem to be mounted. "
+	       "Default ext2.\n");
+	printf("-D device : device used for mounting.\n");
+}
-- 
1.8.1

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
