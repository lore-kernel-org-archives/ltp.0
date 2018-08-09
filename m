From: Li Wang <liwang@redhat.com>
Date: Thu,  9 Aug 2018 13:29:26 +0800
Subject: [LTP] [PATCH v2] execve: rewrite to newlib
Message-ID: <20180809052926.27360-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

execve01: Put IPC_ENV_VAR in envp[] to propagate environment vairiable
          to child in execve().

execve02/3/4: Just rewrite tests in new API.

execve05: Verify execve(2) system call by spawning a few(nchild) children,
          each of which would execute "execve_child" simultaneously.

execve_child: Modify to be used by more testcase.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v1 --> v2:
    
    * remove SAFE_WAITPID() in parent process
    * remove .needs_root
    * use the resource_files[] array
    * remove the USAGE and RESTRICTIONS
    * remove getpid() part
    * remove UCLINUX part
    * remove separate function for option parsing
    * take use of TST_CHECKPOINT_WAKE2(0, nchild)

 runtest/syscalls                                  |   2 +-
 testcases/kernel/syscalls/execve/execve01.c       |  88 ++++-----
 testcases/kernel/syscalls/execve/execve01_child.c |  58 +++---
 testcases/kernel/syscalls/execve/execve02.c       | 106 +++++------
 testcases/kernel/syscalls/execve/execve03.c       | 217 ++++++++--------------
 testcases/kernel/syscalls/execve/execve04.c       | 121 ++++--------
 testcases/kernel/syscalls/execve/execve05.c       | 216 ++++++---------------
 testcases/kernel/syscalls/execve/execve_child.c   |  45 +++--
 8 files changed, 309 insertions(+), 544 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index dc72484..d3dfde5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -145,7 +145,7 @@ execve01 execve01
 execve02 execve02
 execve03 execve03
 execve04 execve04
-execve05 execve05 20 $LTPROOT/testcases/bin/execve05 $LTPROOT/testcases/bin/execve05 4
+execve05 execve05 -i 5 -n 32
 execvp01 execvp01
 
 exit01 exit01
diff --git a/testcases/kernel/syscalls/execve/execve01.c b/testcases/kernel/syscalls/execve/execve01.c
index c849473..c342eba 100644
--- a/testcases/kernel/syscalls/execve/execve01.c
+++ b/testcases/kernel/syscalls/execve/execve01.c
@@ -1,86 +1,60 @@
 /*
+ * Copyright (c) 2018 Linux Test Project
+ * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
  *    DATE STARTED	: 06/01/02
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
  *
- * http://www.sgi.com
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
  *
- * For further information regarding this notice, see:
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
+
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
-#include "test.h"
-
-static void setup(void);
+#include "tst_test.h"
 
-char *TCID = "execve01";
-int TST_TOTAL = 1;
+#define IPC_ENV_VAR "LTP_IPC_PATH"
 
-int main(int ac, char **av)
+static void verify_execve(void)
 {
-	int lc;
 	pid_t pid;
 	char *const args[] = {"execve01_child", "canary", NULL};
-	char *const env[] = {"LTP_TEST_ENV_VAR=test", NULL};
-	char path[2048];
+	char path[512];
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	char ipc_env_var[1024];
+	sprintf(ipc_env_var, IPC_ENV_VAR "=%s", getenv(IPC_ENV_VAR));
 
-	setup();
+	char *const envp[] = { "LTP_TEST_ENV_VAR=test", ipc_env_var, NULL };
 
 	if (tst_get_path("execve01_child", path, sizeof(path)))
-		tst_brkm(TCONF, NULL, "Couldn't find execve01_child in $PATH");
+		tst_brk(TCONF, "Couldn't find execve01_child in $PATH");
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		switch (pid = FORK_OR_VFORK()) {
-		case 0:
-			execve(path, args, env);
-			tst_brkm(TFAIL | TERRNO, NULL,
-			         "Failed to execute execl01_child");
-		case -1:
-			tst_brkm(TBROK, NULL, "fork failed");
-		default:
-			tst_record_childstatus(NULL, pid);
-		}
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		execve(path, args, envp);
+		tst_brk(TFAIL | TERRNO, "Failed to execute execl01_child");
 	}
-
-	tst_exit();
 }
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, NULL);
-
-	TEST_PAUSE;
-}
+static struct tst_test test = {
+	.forks_child = 1,
+	.child_needs_reinit = 1,
+	.test_all = verify_execve,
+};
diff --git a/testcases/kernel/syscalls/execve/execve01_child.c b/testcases/kernel/syscalls/execve/execve01_child.c
index f529fb8..0ebfaa8 100644
--- a/testcases/kernel/syscalls/execve/execve01_child.c
+++ b/testcases/kernel/syscalls/execve/execve01_child.c
@@ -1,55 +1,49 @@
 /*
+ * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "test.h"
-
-char *TCID = "execl01_child";
+#define TST_NO_DEFAULT_MAIN
+#include <stdlib.h>
+#include "tst_test.h"
 
 int main(int argc, char *argv[])
 {
 	char *env;
 
+	tst_reinit();
+
 	if (argc != 2)
-		tst_brkm(TFAIL, NULL, "argc is %d, expected 2", argc);
+		tst_brk(TFAIL, "argc is %d, expected 2", argc);
 
-	if (strcmp(argv[1], "canary")) {
-		tst_brkm(TFAIL, NULL, "argv[1] is %s, expected 'canary'",
-		         argv[1]);
-	}
+	if (strcmp(argv[1], "canary"))
+		tst_brk(TFAIL, "argv[1] is %s, expected 'canary'", argv[1]);
 
 	env = getenv("LTP_TEST_ENV_VAR");
 
 	if (!env)
-		tst_brkm(TFAIL, NULL, "LTP_TEST_ENV_VAR is missing");
+		tst_brk(TFAIL, "LTP_TEST_ENV_VAR is missing");
 
-	if (strcmp(env, "test")) {
-		tst_brkm(TFAIL, NULL, "LTP_TEST_ENV_VAR='%s', expected test",
-		         env);
-	}
+	if (strcmp(env, "test"))
+		tst_brk(TFAIL, "LTP_TEST_ENV_VAR='%s', expected test", env);
 
 	if (getenv("PATH"))
-		tst_brkm(TFAIL, NULL, "PATH is in environment");
+		tst_brk(TFAIL, "PATH is in environment");
+
+	tst_res(TPASS, "%s executed", argv[0]);
 
-	tst_resm(TPASS, "%s executed", argv[0]);
-	tst_exit();
+	return 0;
 }
diff --git a/testcases/kernel/syscalls/execve/execve02.c b/testcases/kernel/syscalls/execve/execve02.c
index dddbfbc..fc06a8e 100644
--- a/testcases/kernel/syscalls/execve/execve02.c
+++ b/testcases/kernel/syscalls/execve/execve02.c
@@ -1,23 +1,23 @@
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2018 Linux Test Project
  * Copyright (c) 2015 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) International Business Machines  Corp., 2001
  *
  *  07/2001 Ported by Wayne Boyer
  *  21/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
  *
- * This program is free software;  you can redistribute it and/or modify
+ * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
+ * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
@@ -31,94 +31,72 @@
 #endif
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/wait.h>
 #include <errno.h>
-#include <libgen.h>
 #include <pwd.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "execve02";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
 #define TEST_APP "execve_child"
 #define USER_NAME "nobody"
 
-static void setup(void);
-static void cleanup(void);
-
 static uid_t nobody_uid;
 
 static void do_child(void)
 {
 	char *argv[2] = {TEST_APP, NULL};
 
-	SAFE_SETEUID(NULL, nobody_uid);
+	SAFE_SETEUID(nobody_uid);
 
-	TEST(execve(TEST_APP, argv, NULL));
+	/* Use environ:
+	 *     Inherit a copy of parent's environment
+	 *     for tst_reinit() in execve_child.c
+	 */
+	TEST(execve(TEST_APP, argv, environ));
 
-	if (!TEST_RETURN)
-		tst_brkm(TFAIL, NULL, "execve() passed unexpectedly");
+	if (!TST_RET)
+		tst_brk(TFAIL, "execve() passed unexpectedly");
 
-	if (TEST_ERRNO != EACCES) {
-		tst_brkm(TFAIL | TTERRNO, NULL,
-		         "execve() failed unexpectedly");
+	if (TST_ERR != EACCES) {
+		tst_brk(TFAIL | TERRNO, "execve() failed unexpectedly");
 	}
 
-	tst_resm(TPASS | TTERRNO, "execve() failed expectedly");
-	tst_exit();
+	tst_res(TPASS | TERRNO, "execve() failed expectedly");
+
+	exit(0);
 }
 
-int main(int ac, char **av)
+static void verify_execve(void)
 {
-	int lc;
-	pid_t pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		if ((pid = FORK_OR_VFORK()) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
+	pid_t pid = SAFE_FORK();
 
-		if (pid == 0)
-			do_child();
-
-		tst_record_childstatus(cleanup, pid);
-	}
-
-	cleanup();
-	tst_exit();
+	if (pid == 0)
+		do_child();
 }
 
 static void setup(void)
 {
-	char path[PATH_MAX];
 	struct passwd *pwd;
 
-	tst_require_root();
-
-	if (tst_get_path(TEST_APP, path, sizeof(path))) {
-		tst_brkm(TBROK, NULL,
-		         "Couldn't found "TEST_APP" binary in $PATH");
-	}
+	SAFE_CHMOD(TEST_APP, 0700);
 
-	tst_tmpdir();
-
-	SAFE_CP(tst_rmdir, path, ".");
-	SAFE_CHMOD(cleanup, TEST_APP, 0700);
-
-	pwd = SAFE_GETPWNAM(tst_rmdir, USER_NAME);
+	pwd = SAFE_GETPWNAM(USER_NAME);
 	nobody_uid = pwd->pw_uid;
 }
 
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static const char *const resource_files[] = {
+	TEST_APP,
+	NULL,
+};
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.child_needs_reinit = 1,
+	.setup = setup,
+	.resource_files = resource_files,
+	.test_all = verify_execve,
+};
diff --git a/testcases/kernel/syscalls/execve/execve03.c b/testcases/kernel/syscalls/execve/execve03.c
index 15b575d..00d6875 100644
--- a/testcases/kernel/syscalls/execve/execve03.c
+++ b/testcases/kernel/syscalls/execve/execve03.c
@@ -1,20 +1,22 @@
 /*
+ * Copyright (c) 2018 Linux Test Project
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
+ *  21/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
@@ -49,22 +51,13 @@
  *	6.	Attempt to execve(2) a zero length file with executable
  *		permissions - fails with ENOEXEC.
  *
- * USAGE:  <for command-line>
- *  execve03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	test #5 will fail with ETXTBSY not EACCES if the test is run as root
  */
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
@@ -72,141 +65,95 @@
 #include <fcntl.h>
 #include <pwd.h>
 #include <stdio.h>
+#include <unistd.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-char *TCID = "execve03";
-int fileHandle = 0;
+static char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
+static char long_fname[] = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
+static char no_dir[] = "testdir";
+static char test_name3[1024];
+static char test_name5[1024];
+static char test_name6[1024];
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-#ifndef UCLINUX
-void *bad_addr = NULL;
-#endif
-
-void setup(void);
-void cleanup(void);
-
-char long_file[] =
-    "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
-char no_dir[] = "testdir";
-char test_name3[1000];
-char test_name5[1000];
-char test_name6[1000];
-
-struct test_case_t {
-	char *tname;		/* the command name to pass to execve() */
+static struct tcase {
+	char *tname;	/* the command name to pass to execve() */
 	int error;
-} TC[] = {
+} tcases[] = {
 	/* the file name is greater than VFS_MAXNAMELEN - ENAMTOOLONG */
-	{
-	long_file, ENAMETOOLONG},
-	    /* the filename does not exist - ENOENT */
-	{
-	no_dir, ENOENT},
-	    /* the path contains a directory name which doesn't exist - ENOTDIR */
-	{
-	test_name3, ENOTDIR},
-#if !defined(UCLINUX)
-	    /* the filename isn't part of the process address space - EFAULT */
-	{
-	(char *)-1, EFAULT},
-#endif
-	    /* the filename does not have execute permission - EACCES */
-	{
-	test_name5, EACCES},
-	    /* the file is zero length with execute permissions - ENOEXEC */
-	{
-	test_name6, ENOEXEC}
+	{long_fname, ENAMETOOLONG},
+	/* the filename does not exist - ENOENT */
+	{no_dir, ENOENT},
+	/* the path contains a directory name which doesn't exist - ENOTDIR */
+	{test_name3, ENOTDIR},
+	/* the filename isn't part of the process address space - EFAULT */
+	{NULL, EFAULT},
+	/* the filename does not have execute permission - EACCES */
+	{test_name5, EACCES},
+	/* the file is zero length with execute permissions - ENOEXEC */
+	{test_name6, ENOEXEC}
 };
 
-int TST_TOTAL = ARRAY_SIZE(TC);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(execve(TC[i].tname, av, NULL));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error)
-				tst_resm(TPASS | TTERRNO,
-					 "execve failed as expected");
-			else
-				tst_resm(TFAIL | TTERRNO,
-					 "execve failed unexpectedly; expected "
-					 "%d - %s",
-					 TC[i].error, strerror(TC[i].error));
-		}
-	}
-	cleanup();
-
-	tst_exit();
-}
-
-void setup(void)
+static void setup(void)
 {
 	char *cwdname = NULL;
+	unsigned i;
 	int fd;
 
-	tst_require_root();
-
 	umask(0);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	ltpuser = SAFE_GETPWNAM(nobody_uid);
 
-	ltpuser = SAFE_GETPWNAM(NULL, nobody_uid);
+	SAFE_SETGID(ltpuser->pw_gid);
 
-	SAFE_SETGID(NULL, ltpuser->pw_gid);
+	cwdname = SAFE_GETCWD(cwdname, 0);
 
-	tst_tmpdir();
+	sprintf(test_name5, "%s/fake", cwdname);
 
-	cwdname = SAFE_GETCWD(cleanup, cwdname, 0);
+	fd = SAFE_CREAT(test_name5, 0444);
+	SAFE_CLOSE(fd);
 
-	sprintf(test_name5, "%s/fake.%d", cwdname, getpid());
+	sprintf(test_name3, "%s/fake", test_name5);
 
-	fileHandle = SAFE_CREAT(cleanup, test_name5, 0444);
+	/* creat() and close a zero length file with executeable permission */
+	sprintf(test_name6, "%s/execve03", cwdname);
 
-	sprintf(test_name3, "%s/fake.%d", test_name5, getpid());
+	fd = SAFE_CREAT(test_name6, 0755);
+	SAFE_CLOSE(fd);
 
-	/* creat() and close a zero length file with executeable permission */
-	sprintf(test_name6, "%s/execve03.%d", cwdname, getpid());
-
-	fd = SAFE_CREAT(cleanup, test_name6, 0755);
-	fd = SAFE_CLOSE(cleanup, fd);
-#ifndef UCLINUX
-	bad_addr = SAFE_MMAP(cleanup, NULL, 1, PROT_NONE,
-			     MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	TC[3].tname = bad_addr;
-#endif
+	for (i = 0; i < ARRAY_SIZE(tcases); i++)
+		if (!tcases[i].tname)
+			tcases[i].tname = tst_get_bad_addr(NULL);
 }
 
-void cleanup(void)
+static void verify_execve(unsigned int i)
 {
-#ifndef UCLINUX
-	SAFE_MUNMAP(NULL, bad_addr, 1);
-#endif
-	SAFE_CLOSE(NULL, fileHandle);
+	struct tcase *tc = &tcases[i];
+	char *argv[2] = {tc->tname, NULL};
 
-	tst_rmdir();
+	TEST(execve(tc->tname, argv, NULL));
 
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "call succeeded unexpectedly");
+		return;
+	}
+
+	if (TST_ERR == tc->error)
+		tst_res(TPASS | TTERRNO,
+				"execve failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO,
+				"execve failed unexpectedly; expected "
+				"%d - %s",
+				tc->error, strerror(tc->error));
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_execve,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.child_needs_reinit = 1,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index 7847470..e7046cf 100644
--- a/testcases/kernel/syscalls/execve/execve04.c
+++ b/testcases/kernel/syscalls/execve/execve04.c
@@ -1,23 +1,23 @@
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2018 Linux Test Project
  * Copyright (c) 2015 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) International Business Machines  Corp., 2001
  *
  *  07/2001 Ported by Wayne Boyer
  *  04/2008 Roy Lee <roylee@andestech.com>
  *
- * This program is free software;  you can redistribute it and/or modify
+ * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
+ * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
@@ -34,98 +34,57 @@
 #include <fcntl.h>
 #include <libgen.h>
 #include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define TEST_APP "execve_child"
 
-char *TCID = "execve04";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
 static void do_child(void);
 
-int main(int ac, char **av)
+static void verify_execve(void)
 {
-	int lc;
 	pid_t pid;
 	char *argv[2] = {TEST_APP, NULL};
-	char *env[1] = {NULL};
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork failed");
-		} else if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "") < 0)
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-#else
-			do_child();
-#endif
-		}
-
-		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
-
-		TEST(execve(TEST_APP, argv, env));
-
-		if (TEST_ERRNO != ETXTBSY)
-			tst_resm(TFAIL | TTERRNO, "execve succeeded, expected failure");
-		else
-			tst_resm(TPASS | TTERRNO, "execve failed as expected");
 
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-		SAFE_WAIT(cleanup, NULL);
-	}
+	pid = SAFE_FORK();
+	if (pid == 0)
+		do_child();
 
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	char path[PATH_MAX];
+	TST_CHECKPOINT_WAIT(0);
 
-	if (tst_get_path(TEST_APP, path, sizeof(path))) {
-		tst_brkm(TBROK, NULL,
-		         "Couldn't found "TEST_APP" binary in $PATH");
-	}
+	TEST(execve(TEST_APP, argv, environ));
 
-	tst_tmpdir();
+	if (TST_ERR != ETXTBSY)
+		tst_res(TFAIL | TTERRNO, "execve succeeded, expected failure");
+	else
+		tst_res(TPASS | TTERRNO, "execve failed as expected");
 
-	TST_CHECKPOINT_INIT(tst_rmdir);
-
-	SAFE_CP(tst_rmdir, path, ".");
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
+	TST_CHECKPOINT_WAKE(0);
 }
 
 static void do_child(void)
 {
-	int fd;
-
-#ifdef UCLINUX
-	TST_CHECKPOINT_INIT(NULL);
-#endif
+	int fd = SAFE_OPEN(TEST_APP, O_WRONLY);
+	TST_CHECKPOINT_WAKE(0);
 
-	if ((fd = open(TEST_APP, O_WRONLY)) == -1) {
-		perror("open failed");
-		exit(1);
-	}
-
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
+	SAFE_CLOSE(fd);
 
 	exit(0);
 }
+
+static const char *const resource_files[] = {
+	TEST_APP,
+	NULL,
+};
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.test_all = verify_execve,
+	.forks_child = 1,
+	.child_needs_reinit = 1,
+	.needs_checkpoints = 1,
+	.resource_files = resource_files,
+};
diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index 66290f6..551f93f 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -1,20 +1,22 @@
 /*
+ * Copyright (c) 2018 Linux Test Project
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
+ *  21/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
@@ -26,174 +28,76 @@
  *	call.
  *
  * ALGORITHM
- *	This program also gets the names "test1", and "test2". This tests
- *	the functionality of the execve(2) system call by spawning a few
- *	children, each of which would execute "test1/test2" executables, and
- *	finally the parent ensures that they terminated correctly.
+ *	This tests the functionality of the execve(2) system call by spawning
+ *	a few children, each of which would execute "execve_child" simultaneously,
+ *	and finally the parent ensures that they terminated correctly.
  *
  * USAGE
- *	execve05 20 test1 test2 4
- *
- * RESTRICTIONS
- * 	This program does not follow the LTP format - *PLEASE FIX*
+ *	execve05 -i 5 -n 20
  */
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
+#include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <pwd.h>
 
-#undef DEBUG			/* change this to #define if needed */
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
+#define TEST_APP "execve_child"
 
-char *TCID = "execve05";
-int TST_TOTAL = 1;
+static int nchild = 8;
 
-int iterations;
-char *fname1;
-char *fname2;
-char *prog;
-char *av[6];
-char *ev[1];
+static char *opt_nchild;
+static struct tst_option exe_options[] = {
+	{"n:", &opt_nchild, "-n    numbers of children"},
+	{NULL, NULL, NULL}
+};
 
-void usage(void)
-{
-	tst_brkm(TBROK, NULL, "usage: %s <iters> <fname1> <fname2> <count>",
-		 TCID);
-}
+static const char *const resource_files[] = {
+	TEST_APP,
+	NULL,
+};
 
-int main(int ac, char **av)
+static void do_child(void)
 {
-	char iter[20];
-	int count, i, nchild, status;
-	pid_t pid;
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	char *argv[3] = {TEST_APP, "canary", NULL};
 
-	if (ac != 5)
-		usage();
+	TST_CHECKPOINT_WAIT(0);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		prog = av[0];
-		iterations = atoi(av[1]);
-		fname1 = av[2];
-		fname2 = av[3];
-		count = atoi(av[4]);
-#ifdef DEBUG
-		tst_resm(TINFO, "Entered %s %d %s %s %d -- pid = %d", prog,
-			 iterations, fname1, fname2, count, getpid());
-#endif
-
-		if (iterations == 0) {
-			tst_resm(TPASS, "Test DONE, pid %d, -- %s %d %s %s",
-				 getpid(), prog, iterations, fname1, fname2);
-			tst_exit();
-		}
-
-		if (!count) {
-			sprintf(iter, "%d", iterations - 1);
-			av[0] = fname1;
-			av[1] = iter;
-			av[2] = fname1;
-			av[3] = fname2;
-			av[4] = "0";
-			av[5] = 0;
-			ev[0] = 0;
-#ifdef DEBUG
-			tst_resm(TINFO, "doing execve(%s, av, ev)", fname1);
-			tst_resm(TINFO, "av[0,1,2,3,4] = %s, %s, %s, %s, %s",
-				 av[0], av[1], av[2], av[3], av[4]);
-#endif
-			(void)execve(fname1, av, ev);
-			tst_resm(TFAIL, "Execve fail, %s, errno=%d", fname1,
-				 errno);
-		}
-
-		nchild = count * 2;
-
-		sprintf(iter, "%d", iterations);
-		for (i = 0; i < count; i++) {
-
-			pid = FORK_OR_VFORK();
-			if (pid == -1) {
-				perror("fork failed");
-				exit(1);
-			} else if (pid == 0) {
-				av[0] = fname1;
-				av[1] = iter;
-				av[2] = fname1;
-				av[3] = fname2;
-				av[4] = "0";
-				av[5] = 0;
-				ev[0] = 0;
-				(void)execve(fname1, av, ev);
-				perror("execve failed");
-				exit(2);
-			}
-#ifdef DEBUG
-			tst_resm(TINFO, "Main - started pid %d", pid);
-#endif
-			SAFE_WAIT(cleanup, &status);
-			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-				tst_resm(TFAIL, "child exited abnormally");
-
-			pid = FORK_OR_VFORK();
-			if (pid == -1) {
-				perror("Fork failed");
-				exit(1);
-			} else if (pid == 0) {
-				av[0] = fname2;
-				av[1] = iter;
-				av[2] = fname2;
-				av[3] = fname1;
-				av[4] = "0";
-				av[5] = 0;
-				ev[0] = 0;
-				execve(fname2, av, ev);
-				perror("execve failed");
-				exit(2);
-			}
-#ifdef DEBUG
-			tst_resm(TINFO, "Main - started pid %d", pid);
-#endif
-			SAFE_WAIT(cleanup, &status);
-			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-				tst_resm(TFAIL, "child exited abnormally");
-
-		}
-
-		if (wait(&status) != -1)
-			tst_brkm(TBROK, cleanup,
-				 "leftover children haven't exited yet");
-
-	}
-	cleanup();
-
-	tst_exit();
+	TEST(execve(TEST_APP, argv, environ));
+	tst_res(TFAIL | TERRNO, "execve() returned unexpected errno");
 }
 
-void setup(void)
+static void verify_execve(void)
 {
+	int i;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	for (i = 0; i < nchild; i++)
+		if (SAFE_FORK() == 0)
+			do_child();
 
-	umask(0);
+	TST_CHECKPOINT_WAKE2(0, nchild);
 }
 
-void cleanup(void)
+static void setup(void)
 {
+	if (opt_nchild)
+		nchild = SAFE_STRTOL(opt_nchild, 1, INT_MAX);
 }
+
+static struct tst_test test = {
+	.test_all = verify_execve,
+	.options = exe_options,
+	.forks_child = 1,
+	.child_needs_reinit = 1,
+	.needs_checkpoints = 1,
+	.resource_files = resource_files,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/execve/execve_child.c b/testcases/kernel/syscalls/execve/execve_child.c
index 2ec8496..30e0d41 100644
--- a/testcases/kernel/syscalls/execve/execve_child.c
+++ b/testcases/kernel/syscalls/execve/execve_child.c
@@ -1,32 +1,41 @@
 /*
+ * Copyright (c) 2018 Linux Test Project
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
  * test3.c
- *	dummy program which is used by execve03.c testcase
+ *	dummy program which is used by execve02/4/5.c testcase
  */
 
+#define TST_NO_DEFAULT_MAIN
 #include <stdlib.h>
-#include <stdio.h>
+#include "tst_test.h"
 
-int main(void)
+int main(int argc, char *argv[])
 {
-	printf("Hello World\n");
-	exit(0);
+	tst_reinit();
+
+	/* For execve05 test, it should be returned here*/
+	if (!strcmp(argv[1], "canary")) {
+		tst_res(TPASS, "argv[1] is %s, expected 'canary'", argv[1]);
+		return 0;
+	}
+
+	/* For execve02/4 test, it shouldn't be executed */
+	tst_res(TFAIL, "%s shouldn't be executed", argv[0]);
+	return 0;
 }
-- 
2.9.5

