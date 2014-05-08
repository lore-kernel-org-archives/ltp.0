Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WiL1I-0001RQ-Al
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:53:40 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WiL1F-0007Di-AH
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:53:40 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s489rTfQ018371
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 17:53:29 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Thu, 8 May 2014 17:50:52 +0800
Message-ID: <1399542652-5795-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1399542652-5795-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1399542652-5795-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 2/2] openat/openat02.c: add a new case to test flags
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

From: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>

create a new case to test flags for openat(2):
O_APPEND
O_CLOEXEC
O_LARGEFILE
O_NOATIME
O_NOFOLLOW
O_TRUNC

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 configure.ac                                      |   1 +
 m4/ltp-openat.m4                                  |  25 ++
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/.gitignore              |   1 +
 testcases/kernel/syscalls/openat/openat.h         |  35 +++
 testcases/kernel/syscalls/openat/openat01.c       |  13 +-
 testcases/kernel/syscalls/openat/openat02.c       | 308 ++++++++++++++++++++++
 testcases/kernel/syscalls/openat/openat02_child.c |  41 +++
 8 files changed, 416 insertions(+), 9 deletions(-)
 create mode 100644 m4/ltp-openat.m4
 create mode 100644 testcases/kernel/syscalls/openat/openat.h
 create mode 100644 testcases/kernel/syscalls/openat/openat02.c
 create mode 100644 testcases/kernel/syscalls/openat/openat02_child.c

diff --git a/configure.ac b/configure.ac
index 8081b06..b509e26 100644
--- a/configure.ac
+++ b/configure.ac
@@ -180,5 +180,6 @@ LTP_CHECK_READLINKAT
 LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_TIRPC
+LTP_CHECK_OPENAT
 
 AC_OUTPUT
diff --git a/m4/ltp-openat.m4 b/m4/ltp-openat.m4
new file mode 100644
index 0000000..aa3b0a3
--- /dev/null
+++ b/m4/ltp-openat.m4
@@ -0,0 +1,25 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2014
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_OPENAT
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_OPENAT],[
+AC_CHECK_FUNCS(openat,,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 7a067cd..52d63ba 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -710,6 +710,7 @@ open11 open11
 
 #openat test cases
 openat01 openat01
+openat02 openat02
 
 mincore01 mincore01
 mincore02 mincore02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0a16f74..b1c46de 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -602,6 +602,7 @@
 /open/open10
 /open/open11
 /openat/openat01
+/openat/openat02
 /pathconf/pathconf01
 /pause/pause01
 /pause/pause02
diff --git a/testcases/kernel/syscalls/openat/openat.h b/testcases/kernel/syscalls/openat/openat.h
new file mode 100644
index 0000000..fce4e3f
--- /dev/null
+++ b/testcases/kernel/syscalls/openat/openat.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2007
+ * Copyright (c) 2014 Fujitsu Ltd.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Library General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ */
+
+#ifndef OPENAT_H
+#define OPENAT_H
+
+#include <sys/types.h>
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_OPENAT)
+int openat(int dirfd, const char *pathname, int flags, mode_t mode)
+{
+	return ltp_syscall(__NR_openat, dirfd, pathname, flags, mode);
+}
+#endif
+
+#endif /* OPENAT_H */
diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
index d8c8e79..a1ec6bf 100644
--- a/testcases/kernel/syscalls/openat/openat01.c
+++ b/testcases/kernel/syscalls/openat/openat01.c
@@ -55,11 +55,11 @@
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
+#include "lapi/fcntl.h"
+#include "openat.h"
 
 #define TEST_CASES 5
-#ifndef AT_FDCWD
-#define AT_FDCWD -100
-#endif
+
 void setup();
 void cleanup();
 void setup_every_copy();
@@ -75,11 +75,6 @@ int fds[TEST_CASES];
 char *filenames[TEST_CASES];
 int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
 
-int myopenat(int dirfd, const char *filename, int flags, int mode)
-{
-	return ltp_syscall(__NR_openat, dirfd, filename, flags, mode);
-}
-
 int main(int ac, char **av)
 {
 	int lc;
@@ -116,7 +111,7 @@ int main(int ac, char **av)
 		 * Call openat
 		 */
 		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(myopenat
+			TEST(openat
 			     (fds[i], filenames[i], O_CREAT | O_WRONLY, 0600));
 
 			/* check return code */
diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
new file mode 100644
index 0000000..68e0879
--- /dev/null
+++ b/testcases/kernel/syscalls/openat/openat02.c
@@ -0,0 +1,308 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
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
+ */
+/*
+ * Description:
+ *   Verify that,
+ *   1)openat() succeeds to open a file in append mode, when
+ *     'flags' is set to O_APPEND.
+ *   2)openat() succeeds to enable the close-on-exec flag for a
+ *     file descriptor, when 'flags' is set to O_CLOEXEC.
+ *   3)openat() succeeds to allow files whose sizes cannot be
+ *     represented in an off_t but can be represented in an off64_t
+ *     to be opened, when 'flags' is set to O_LARGEFILE.
+ *   4)openat() succeeds to not update the file last access time
+ *     (st_atime in the inode) when the file is read, when 'flags'
+ *     is set to O_NOATIME.
+ *   5)openat() succeeds to open the file failed if the file is a
+ *     symbolic link, when 'flags' is set to O_NOFOLLOW.
+ *   6)openat() succeeds to truncate the file to length 0 if the file
+ *     already exists and is a regular file and the open mode allows
+ *     writing, when 'flags' is set to O_TRUNC.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <mntent.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "openat.h"
+
+#define TEST_APP "openat02_child"
+
+#define TEST_FILE "test_file"
+#define SFILE "sfile"
+#define LARGE_FILE "large_file"
+
+#define STR "abcdefg"
+
+static void setup(void);
+static void cleanup(void);
+
+static void testfunc_append(void);
+static void testfunc_cloexec(void);
+static void testfunc_largefile(void);
+static void testfunc_noatime(void);
+static void testfunc_nofollow(void);
+static void testfunc_trunc(void);
+
+static void (*testfunc[])(void) = {
+	testfunc_append,
+	testfunc_cloexec,
+	testfunc_largefile,
+	testfunc_noatime,
+	testfunc_nofollow,
+	testfunc_trunc,
+};
+
+char *TCID = "openat02";
+int TST_TOTAL = ARRAY_SIZE(testfunc);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+	char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void setup(void)
+{
+	tst_require_root(NULL);
+
+	TEST_PAUSE;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	SAFE_FILE_PRINTF(cleanup, TEST_FILE, "test file");
+
+	SAFE_SYMLINK(cleanup, TEST_FILE, SFILE);
+}
+
+void testfunc_append(void)
+{
+	off_t file_offset;
+
+	SAFE_FILE_PRINTF(cleanup, TEST_FILE, "test file");
+
+	TEST(openat(AT_FDCWD, TEST_FILE, O_APPEND | O_RDWR, 0777));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "openat failed");
+		return;
+	}
+
+	SAFE_WRITE(cleanup, 1, TEST_RETURN, STR, sizeof(STR) - 1);
+
+	file_offset = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
+
+	if (file_offset > (off_t)(sizeof(STR) - 1))
+		tst_resm(TPASS, "test O_APPEND for openat success");
+	else
+		tst_resm(TFAIL, "test O_APPEND for openat failed");
+
+	SAFE_CLOSE(cleanup, TEST_RETURN);
+}
+
+void testfunc_cloexec(void)
+{
+	pid_t pid;
+	int status;
+	char buf[20];
+
+	if ((tst_kvercmp(2, 6, 23)) < 0) {
+		tst_resm(TCONF, "test O_CLOEXEC flags for openat "
+						"needs kernel 2.6.23 or higher");
+		return;
+	}
+
+	TEST(openat(AT_FDCWD, TEST_FILE, O_CLOEXEC | O_RDWR, 0777));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "openat failed");
+		return;
+	}
+
+	sprintf(buf, "%ld", TEST_RETURN);
+
+	pid = tst_fork();
+
+	if (pid < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+
+	if (pid == 0) {
+		if (execlp(TEST_APP, TEST_APP, buf, NULL))
+			exit(1);
+	}
+
+	SAFE_CLOSE(cleanup, TEST_RETURN);
+
+	if (wait(&status) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "wait() failed");
+
+	if (WIFEXITED(status)) {
+		switch ((int8_t)WEXITSTATUS(status)) {
+		case -1:
+			tst_resm(TPASS, "test O_CLOEXEC for openat success");
+			break;
+		case 1:
+			tst_brkm(TBROK, cleanup, "execlp() failed");
+		default:
+			tst_resm(TFAIL, "test O_CLOEXEC for openat failed");
+		}
+	} else {
+		tst_brkm(TBROK, cleanup,
+				 "openat2_exec exits with unexpected error");
+	}
+}
+
+void testfunc_largefile(void)
+{
+	int fd;
+	off64_t offset;
+
+	fd = SAFE_OPEN(cleanup, LARGE_FILE,
+				O_LARGEFILE | O_RDWR | O_CREAT, 0777);
+
+	offset = lseek64(fd, 4.1*1024*1024*1024, SEEK_SET);
+	if (offset == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "lseek64 failed");
+
+	SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);
+
+	SAFE_CLOSE(cleanup, fd);
+
+	TEST(openat(AT_FDCWD, LARGE_FILE, O_LARGEFILE | O_RDONLY, 0777));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL, "test O_LARGEFILE for openat failed");
+	} else {
+		tst_resm(TPASS, "test O_LARGEFILE for openat success");
+		SAFE_CLOSE(cleanup, TEST_RETURN);
+	}
+}
+
+void testfunc_noatime(void)
+{
+	struct stat file_stat, file_newstat;
+	char buf;
+	const char *flags[] = {"noatime", "relatime", NULL};
+	int ret;
+
+	if ((tst_kvercmp(2, 6, 8)) < 0) {
+		tst_resm(TCONF, "test O_NOATIME flags for openat "
+						"needs kernel 2.6.8 or higher");
+		return;
+	}
+
+	ret = tst_path_has_mnt_flags(cleanup, TEST_FILE, flags);
+	if (ret > 0) {
+		tst_resm(TCONF, "test O_NOATIME flag for openat needs "
+			"filesystems which are mounted without "
+			"noatime and relatime");
+		return;
+	}
+
+	SAFE_STAT(cleanup, TEST_FILE, &file_stat);
+
+	sleep(2);
+
+	TEST(openat(AT_FDCWD, TEST_FILE, O_NOATIME | O_RDONLY, 0777));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "openat failed");
+		return;
+	}
+
+	SAFE_READ(cleanup, 1, TEST_RETURN, &buf, 1);
+
+	SAFE_CLOSE(cleanup, TEST_RETURN);
+
+	SAFE_STAT(cleanup, TEST_FILE, &file_newstat);
+
+	if (file_stat.st_atime == file_newstat.st_atime)
+		tst_resm(TPASS, "test O_NOATIME for openat success");
+	else
+		tst_resm(TFAIL, "test O_NOATIME for openat failed");
+}
+
+void testfunc_nofollow(void)
+{
+	TEST(openat(AT_FDCWD, SFILE, O_NOFOLLOW | O_RDONLY, 0777));
+
+	if (TEST_RETURN == -1 && TEST_ERRNO == ELOOP) {
+		tst_resm(TPASS, "test O_NOFOLLOW for openat success");
+	} else {
+		tst_resm(TFAIL, "test O_NOFOLLOW for openat failed");
+		SAFE_CLOSE(cleanup, TEST_RETURN);
+	}
+}
+
+void testfunc_trunc(void)
+{
+	struct stat file_stat;
+
+	TEST(openat(AT_FDCWD, TEST_FILE, O_TRUNC | O_RDWR, 0777));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "openat failed");
+		return;
+	}
+
+	SAFE_FSTAT(cleanup, TEST_RETURN, &file_stat);
+
+	if (file_stat.st_size == 0)
+		tst_resm(TPASS, "test O_TRUNC for openat success");
+	else
+		tst_resm(TFAIL, "test O_TRUNC for openat failed");
+
+	SAFE_CLOSE(cleanup, TEST_RETURN);
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
diff --git a/testcases/kernel/syscalls/openat/openat02_child.c b/testcases/kernel/syscalls/openat/openat02_child.c
new file mode 100644
index 0000000..d2af36b
--- /dev/null
+++ b/testcases/kernel/syscalls/openat/openat02_child.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
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
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+
+#define STR "abc"
+
+char *TCID = "openat02_child";
+
+int main(int argc, char **argv)
+{
+	int fd;
+	int ret;
+
+	if (argc != 2) {
+		fprintf(stderr, "%s <fd>\n", argv[0]);
+		exit(1);
+	}
+
+	fd = atoi(argv[1]);
+	ret = write(fd, STR, sizeof(STR) - 1);
+
+	exit(ret);
+}
-- 
1.9.0


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
