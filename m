Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O3w0H-0004y5-MW
	for ltp-list@lists.sourceforge.net; Mon, 19 Apr 2010 18:47:29 +0000
Date: Mon, 19 Apr 2010 20:41:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100419184131.GA20776@saboteur.suse.cz>
References: <20100402185908.GA478@saboteur.suse.cz>
	<g2x364299f41004021212z6e85833ybccad62e6780ec26@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <g2x364299f41004021212z6e85833ybccad62e6780ec26@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [LTP] [PATCH] fix fs_perms tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Okay, did some work on this and here comes the result:

* tst_get_path() function is introduced for looking for
  binaries in $PATH. Notice that there is allready
  search_path() however this one tries to figure out path
  to the current runnig binary and has a little strange
  interface (is used only in some fcntl tests so should be
  easy to fix).

* fs_test now tries to execute two different files instead
  of one. First one is empty and executed by execlp().
  Second one contains shebang and is executed by execl().
  This way we cover both kernel and libc codepath.

+ Various small fixups.

Patch attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--17pEHd4RhPHOinZp
Content-Type: text/x-patch; charset=iso-8859-1
Content-Disposition: attachment; filename="fix_fs_permsII.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/include/test.h b/include/test.h
index e291b36..7ac182a 100644
--- a/include/test.h
+++ b/include/test.h
@@ -262,6 +262,11 @@ int ltp_clone_quick(unsigned long clone_flags, int (=
*fn)(void *arg),
 char *get_block_device(const char *path);
 char *get_mountpoint(const char *path);
=20
+/*
+ * Function from lib/get_path.c
+ */
+int tst_get_path(const char *prog_name, char *buf, size_t buf_len);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/get_path.c b/lib/get_path.c
new file mode 100644
index 0000000..c82fcea
--- /dev/null
+++ b/lib/get_path.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright (C) 2010 Cyril Hrubis chrubis@suse.cz
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program wit=
h
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng
+ * with this program; if not, write the Free Software Foundation, Inc., =
59
+ */
+
+ /*
+  * Looks for binary prog_name in $PATH.=20
+  *
+  * If such file exists and if you are able at least to read it, zero is
+  * returned and absolute path to the file is filled into buf. In case b=
uf is
+  * too short to hold the absolute path + prog_name for the file we are =
looking
+  * for -1 is returned as well as when there is no such file in all path=
s in
+  * $PATH.
+  */
+
+#include "test.h"
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+static int file_exist(const char *path)
+{
+	struct stat st;
+
+	if (!access(path, R_OK) && !stat(path, &st) && S_ISREG(st.st_mode))
+		return 1;
+
+	return 0;
+}
+
+int tst_get_path(const char *prog_name, char *buf, size_t buf_len)
+{
+	const char *path =3D (const char*) getenv("PATH");
+	int i;
+
+	if (path =3D=3D NULL)
+		return -1;
+
+	do {
+		/* copy path */
+		for (i =3D 0; i < buf_len && path[i] !=3D '\0' && path[i] !=3D ':'; i+=
+)
+			buf[i] =3D path[i];
+	=09
+		/* add slash at the end if needed */
+		if (buf[i - 1] !=3D '/')
+			buf[i++] =3D '/';
+
+		/* copy the program name */
+		strncpy(buf + i, prog_name, buf_len - i);
+	=09
+		/* path + pname fits into buf *
+		 * look if such file exists   */
+		if (buf[buf_len - 1] =3D=3D '\0') {
+			if (file_exist(buf))
+				return 0;
+		}
+
+		/* eat all to the next delimiter */
+		while (*path !=3D '\0' && *path !=3D ':')
+			path++;
+	=09
+		/* eat all delimiters */
+		while (*path !=3D '\0' && *path =3D=3D ':')
+			path++;
+	=09
+	} while (*path !=3D '\0');
+
+	return -1;
+}
+
diff --git a/runltp b/runltp
index b848a7f..097e32e 100755
--- a/runltp
+++ b/runltp
@@ -557,6 +557,7 @@ main()
=20
         for SCENFILES in ${LTPROOT}/runtest/syscalls                \
                          ${LTPROOT}/runtest/fs                      \
+                         ${LTPROOT}/runtest/fs_perms_simple         \
                          ${LTPROOT}/runtest/fsx                     \
                          ${LTPROOT}/runtest/dio                     \
                          ${LTPROOT}/runtest/io                      \
diff --git a/runtest/fs b/runtest/fs
index 75c5e38..2de871d 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -64,9 +64,6 @@ writetest01	writetest
 #Also run the fs_di (Data Integrity tests)
 fs_di fs_di -d $TMPDIR
=20
-#Also run the fs_perms (File System Permission Tests)
-fs_perms fs_perms_simpletest.sh
-
 # Read every file in /proc. Not likely to crash, but does enough=20
 # to disturb the kernel. A good kernel latency killer too.
 # Was not sure why it should reside in runtest/crashme and won=C2=B4t ge=
t tested ever
diff --git a/runtest/fs_perms_simple b/runtest/fs_perms_simple
new file mode 100644
index 0000000..cc986bd
--- /dev/null
+++ b/runtest/fs_perms_simple
@@ -0,0 +1,26 @@
+#
+# These tests are setting file permissions/group/uid and are trying to
+# open/write/execute the file.
+#
+#
+#
+# fs_perms file_mode file_uid file_gid test_uid test_gid mode (r|w|x) ex=
pected_result
+#
+fs_perms01 fs_perms 001 99 99 12 100 x 0
+fs_perms02 fs_perms 010 99 99 200 99 x 0
+fs_perms03 fs_perms 100 99 99 99 500 x 0
+fs_perms04 fs_perms 002 99 99 12 100 w 0
+fs_perms05 fs_perms 020 99 99 200 99 w 0
+fs_perms06 fs_perms 200 99 99 99 500 w 0
+fs_perms07 fs_perms 004 99 99 12 100 r 0
+fs_perms08 fs_perms 040 99 99 200 99 r 0
+fs_perms09 fs_perms 400 99 99 99 500 r 0
+fs_perms10 fs_perms 000 99 99 99 99  r 1
+fs_perms11 fs_perms 000 99 99 99 99  w 1
+fs_perms12 fs_perms 000 99 99 99 99  x 1
+fs_perms13 fs_perms 010 99 99 99 500 x 1
+fs_perms14 fs_perms 100 99 99 200 99 x 1
+fs_perms15 fs_perms 020 99 99 99 500 w 1
+fs_perms16 fs_perms 200 99 99 200 99 w 1
+fs_perms17 fs_perms 040 99 99 99 500 r 1
+fs_perms18 fs_perms 400 99 99 200 99 r 1
diff --git a/testcases/kernel/fs/fs_perms/Makefile b/testcases/kernel/fs/=
fs_perms/Makefile
index 48aa7d6..c0377cc 100644
--- a/testcases/kernel/fs/fs_perms/Makefile
+++ b/testcases/kernel/fs/fs_perms/Makefile
@@ -23,7 +23,4 @@
 top_srcdir			?=3D ../../../..
=20
 include $(top_srcdir)/include/mk/testcases.mk
-
-INSTALL_TARGETS			:=3D fs_perms_simpletest.sh
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fs_perms/fs_perms.c b/testcases/kernel/f=
s/fs_perms/fs_perms.c
index ad44028..14a9d1a 100644
--- a/testcases/kernel/fs/fs_perms/fs_perms.c
+++ b/testcases/kernel/fs/fs_perms/fs_perms.c
@@ -1,5 +1,6 @@
 /*
  *   Copyright (c) International Business Machines  Corp., 2000
+ *   Copyright (c) 2010 Cyril Hrubis chrubis@suse.cz
  *
  *   This program is free software;  you can redistribute it and/or modi=
fy
  *   it under the terms of the GNU General Public License as published b=
y
@@ -25,9 +26,12 @@
  *     (04/19/01)v1.0  Added test for execute bit.
  *     (05/23/01)v1.1  Added command line parameter to specify test file=
.
  *     (07/12/01)v1.2  Removed conf file and went to command line parame=
ters.
+ *     (10/19/04)      Rewritten to fit ltp test interface.
+ *                     Also now we try to run two different files, one i=
s executed by execl,
+ *                     has shebang and should end up executed by kernel,=
 other one is empty
+ *                     is executed by execlp and should end up executed =
by libc.
  */
=20
-#include <errno.h>
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
@@ -39,114 +43,173 @@
=20
 #include "test.h"
=20
+#define TEST_FILE_NAME1 "./test.file1"
+#define TEST_FILE_NAME2 "./test.file2"
+#define MAX_PATH 1024
+
 char *TCID =3D "fs_perms";
 int TST_TOTAL =3D 1;
=20
-static int testsetup(mode_t mode, int cuserId, int cgroupId)
-{
-	int ret;
-	char cmd_str[256];
-
-	sprintf(cmd_str, "cp %s/testx test.file", getcwd(NULL, 0));
-	tst_tmpdir();
-
-	ret =3D unlink("test.file");
-	if (ret && errno !=3D ENOENT)
-		goto done;
-	ret =3D system(cmd_str);
-	if (ret)
-		goto done;
-	ret =3D chmod("test.file", mode);
-	if (ret)
-		goto done;
-	ret =3D chown("test.file", cuserId, cgroupId);
-
- done:
-	return ret;
-}
-
-void cleanup(void)
+static void cleanup(void)
 {
+	seteuid(0);
+	setegid(0);
+=09
 	tst_rmdir();
 	tst_exit();
 }
=20
-static int testfperm(int userId, int groupId, char *fperm)
+/*
+ * Create file and set permissions, user id, group id.
+ *
+ * If flag is non zero, the file contains #!/PATH/sh shebang otherwise i=
t's
+ * empty.
+ */
+static void testsetup(const char *file_name, int flag, mode_t mode,=20
+                      int user_id, int group_id)
 {
-	/* SET CURRENT USER/GROUP PERMISSIONS */
-	if (setegid(groupId)) {
-		tst_brkm(TBROK, cleanup, "could not setegid to %d: %s", groupId, strer=
ror(errno));
-		seteuid(0);
-		setegid(0);
-		return -1;
-	}
-	if (seteuid(userId)) {
-		tst_brkm(TBROK, cleanup, "could not seteuid to %d: %s", userId, strerr=
or(errno));
-		seteuid(0);
-		setegid(0);
-		return -1;
+	FILE *file;
+
+	file =3D fopen(file_name, "w");
+=09
+	if (file =3D=3D NULL)
+		tst_brkm(TBROK | TERRNO, cleanup,
+		         "Could not create test file %s.", file_name);
+=09
+	/* create file with shebang */
+	if (flag) {
+		char buf[MAX_PATH];
+
+		if (tst_get_path("sh", buf, MAX_PATH))
+			tst_brkm(TBROK, cleanup,
+			         "Could not find path to sh in $PATH.");
+
+		if (fprintf(file, "#!%s\n", buf) < 0)
+			tst_brkm(TBROK, cleanup, "Syscall fprintf failed.");
 	}
=20
-	switch (tolower(fperm[0])) {
-	case 'x': {
+	if (fclose(file))
+		tst_brkm(TBROK | TERRNO, cleanup, "Syscall fclose failed.");
+
+	if (chmod(file_name, mode))
+		tst_brkm(TBROK | TERRNO, cleanup,
+		         "Could not chmod test file %s.", file_name);=20
+
+	if (chown(file_name, user_id, group_id))
+		tst_brkm(TBROK | TERRNO, cleanup,
+		         "Could not chown test file %s.", file_name);=20
+}
+
+/*
+ * Test permissions.
+ */
+static int testfperm(const char *file_name, int flag, int user_id,
+                     int group_id, char *fperm)
+
+{
+	FILE *file;
+	int ret;
+=09
+	if (setegid(group_id))
+		tst_brkm(TBROK | TERRNO, cleanup, "Could not setegid to %d.",
+		         group_id);
+
+	if (seteuid(user_id))
+		tst_brkm(TBROK | TERRNO, cleanup, "Could not seteuid to %d.",
+		         user_id);
+
+	if (tolower(fperm[0]) =3D=3D 'x') {
 		int status;
+	=09
 		if (fork() =3D=3D 0) {
-			execlp("./test.file", "test.file", NULL);
+			/*
+			 * execlp runs file with sh in case kernel has
+			 * no binmft handler for it, execl does not.
+			 */
+			if (flag)
+				execl(file_name, file_name, NULL);
+			else
+				execlp(file_name, "test", NULL);
+=09
 			exit(1);
 		}
+	=09
 		wait(&status);
+	=09
 		seteuid(0);
 		setegid(0);
+	=09
 		return WEXITSTATUS(status);
 	}
-	default: {
-		FILE *testfile;
-		if ((testfile =3D fopen("test.file", fperm))) {
-			fclose(testfile);
-			seteuid(0);
-			setegid(0);
-			return 0;
-		} else {
-			seteuid(0);
-			setegid(0);
-			return 1;
-		}
-	}
-	}
+
+	if ((file =3D fopen(file_name, fperm)) !=3D NULL) {
+		fclose(file);
+		ret =3D 0;
+	} else
+		ret =3D 1;
+
+	seteuid(0);
+	setegid(0);
+
+	return ret;
+}
+
+static void print_usage(const char *bname)
+{
+	char *usage =3D "<file mode> <file UID> <file GID> "
+                      "<tester UID> <tester GID> <permission "
+                      "to test r|w|x> <expected result 0|1>";
+
+	printf("Usage: %s %s\n", bname, usage);
 }
=20
 int main(int argc, char *argv[])
 {
 	char *fperm;
-	int result, exresult =3D 0, cuserId =3D 0, cgroupId =3D 0, userId =3D 0=
, groupId =3D 0;
+	int exp_res, cuser_id, cgroup_id, user_id, group_id;
+	int res1, res2 =3D 1;
 	mode_t mode;
=20
 	tst_require_root(tst_exit);
=20
-	switch (argc) {
-	case 8:
-		mode =3D strtol(argv[1], (char **)NULL, 010);
-		cuserId =3D atoi(argv[2]);
-		cgroupId =3D atoi(argv[3]);
-		userId =3D atoi(argv[4]);
-		groupId =3D atoi(argv[5]);
-		fperm =3D argv[6];
-		exresult =3D atoi(argv[7]);
-		break;
-	default:
-		printf("Usage: %s <mode of file> <UID of file> <GID of file> <UID of t=
ester> <GID of tester> <permission to test r|w|x> <expected result as 0|1=
>\n", argv[0]);
-		return 1;
+	if (argc !=3D 8) {
+		print_usage(argv[0]);
+		tst_exit();
 	}
=20
-	result =3D testsetup(mode, cuserId, cgroupId);
-	if (result) {
-		tst_brkm(TBROK, cleanup, "testsetup() failed: %s", strerror(errno));
+	if (strlen(argv[6]) > 1) {
+		print_usage(argv[0]);
+		tst_exit();
 	}
=20
-	result =3D testfperm(userId, groupId, fperm);
-	unlink("test.file");
-	tst_resm(exresult =3D=3D result ? TPASS : TFAIL, "%c a %03o file owned =
by (%d/%d) as user/group(%d/%d)",
-		fperm[0], mode, cuserId, cgroupId, userId, groupId);
-	cleanup();
-	return 0;
+	mode      =3D strtol(argv[1], NULL, 10);
+	cuser_id  =3D atoi(argv[2]);
+	cgroup_id =3D atoi(argv[3]);
+	user_id   =3D atoi(argv[4]);
+	group_id  =3D atoi(argv[5]);
+	fperm     =3D argv[6];
+	exp_res   =3D atoi(argv[7]);
+
+	tst_tmpdir();
+	testsetup(TEST_FILE_NAME1, 0, mode, cuser_id, cgroup_id);
+=09
+	/* more tests for 'x' flag */
+	if (tolower(fperm[0]) =3D=3D 'x') {
+		testsetup(TEST_FILE_NAME2, 1, mode, cuser_id, cgroup_id);
+		res2 =3D testfperm(TEST_FILE_NAME2, 1, user_id, group_id, fperm);
+
+		if (res2 =3D=3D exp_res)
+			res2 =3D 1;
+		else
+			res2 =3D 0;
+	}
+
+	res1 =3D testfperm(TEST_FILE_NAME1, 0, user_id, group_id, fperm);
+
+	tst_resm((exp_res =3D=3D res1) && res2 ? TPASS : TFAIL,
+	         "%c a %03o file owned by (%d/%d) as user/group(%d/%d)",
+	         fperm[0], mode, cuser_id, cgroup_id, user_id, group_id);
+
+	tst_rmdir();
+	tst_exit();
 }
diff --git a/testcases/kernel/fs/fs_perms/fs_perms_simpletest.sh b/testca=
ses/kernel/fs/fs_perms/fs_perms_simpletest.sh
deleted file mode 100755
index 5a8df8b..0000000
--- a/testcases/kernel/fs/fs_perms/fs_perms_simpletest.sh
+++ /dev/null
@@ -1,35 +0,0 @@
-#!/bin/sh
-
-Code=3D0
-
-test()
-{
-    arg=3D${1}; shift
-    res=3D${1}
-
-    ./fs_perms ${arg} ${res}
-    if [ $? -ne 0 ]; then
-       Code=3D$((Code + 1))
-    fi
-}
-
-test "001 99 99 12 100 x" 0
-test "010 99 99 200 99 x" 0
-test "100 99 99 99 500 x" 0
-test "002 99 99 12 100 w" 0
-test "020 99 99 200 99 w" 0
-test "200 99 99 99 500 w" 0
-test "004 99 99 12 100 r" 0
-test "040 99 99 200 99 r" 0
-test "400 99 99 99 500 r" 0
-test "000 99 99 99 99 r" 1
-test "000 99 99 99 99 w" 1
-test "000 99 99 99 99 x" 1
-test "010 99 99 99 500 x" 1
-test "100 99 99 200 99 x" 1
-test "020 99 99 99 500 w" 1
-test "200 99 99 200 99 w" 1
-test "040 99 99 99 500 r" 1
-test "400 99 99 200 99 r" 1
-
-exit ${Code}
diff --git a/testcases/kernel/fs/fs_perms/testx.c b/testcases/kernel/fs/f=
s_perms/testx.c
deleted file mode 100644
index 5944ce0..0000000
--- a/testcases/kernel/fs/fs_perms/testx.c
+++ /dev/null
@@ -1,4 +0,0 @@
-#include <stdio.h>
-int main(void) {
-	return 0;
-}
diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ft=
est/ftest01.c
index c4dc5c8..41b14de 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -90,9 +90,6 @@ static int parent_pid;
 static int pidlist[MAXCHILD];
 static char test_name[2];
=20
-static char fuss[40];         /* directory to do this in */
-static char homedir[200];     /* where we started */
-
 static int local_flag;
=20
 int main(int ac, char *av[])
@@ -130,18 +127,8 @@ static void setup(void)
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	getcwd(homedir, sizeof(homedir));
 	parent_pid =3D getpid();
=20
-	if (!fuss[0])
-		sprintf(fuss, "./ftest1.%d", getpid());
-
-	mkdir(fuss, 0755);
-
-	if (chdir(fuss) < 0) {
-		tst_brkm(TBROK,0,"Can't chdir(%s): %s", fuss, strerror(errno));
-	}
-
 	/*
 	 * Default values for run conditions.
 	 */
@@ -162,16 +149,16 @@ static void setup(void)
=20
 static void runtest(void)
 {
-	int i, pid, child, status, count;
+	int i, child, status, count;
=20
-	for(i =3D 0; i < nchild; i++) {
+	for (i =3D 0; i < nchild; i++) {
=20
 		test_name[0] =3D 'a' + i;
 		test_name[1] =3D '\0';
 		fd =3D open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
=20
 		if (fd < 0)
-			tst_brkm(TBROK,0, "Can't creating %s/%s: %s", fuss, test_name, strerr=
or(errno));
+			tst_brkm(TBROK,0, "Can't creating %s: %s", test_name, strerror(errno)=
);
=20
 		if ((child =3D fork()) =3D=3D 0) {
 			dotest(nchild, i, fd);
@@ -221,29 +208,6 @@ static void runtest(void)
 	else
 		tst_resm(TFAIL, "Test failed in fork and wait.");
=20
-	chdir(homedir);
-	pid =3D fork();
-
-	if (pid < 0) {
-
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-		          " etc are likely to fail.");
-
-		tst_resm(TBROK, "Can not remove '%s' due to inability of fork.",fuss);
-		sync();
-		tst_exit();
-	}
-
-	if (pid =3D=3D 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-		tst_exit();
-	}
-
-	wait(&status);
-
-	if (status)
-		tst_resm(TINFO, "CAUTION - ftest1, '%s' may not be removed", fuss);
-
 	sync();
 }
=20
diff --git a/testcases/kernel/fs/ftest/ftest03.c b/testcases/kernel/fs/ft=
est/ftest03.c
index 1cb6d6f..0f0eccc 100644
--- a/testcases/kernel/fs/ftest/ftest03.c
+++ b/testcases/kernel/fs/ftest/ftest03.c
@@ -96,12 +96,9 @@ static int parent_pid;
 static int pidlist[MAXCHILD];
 static char test_name[2];     /* childs test directory name */
=20
-static char fuss[40];         /* directory to do this in */
-static char homedir[200];     /* where we started */
-
 static int local_flag;
=20
-int main (int ac, char *av[])
+int main(int ac, char *av[])
 {
         int lc;
         char *msg;
@@ -138,31 +135,14 @@ int main (int ac, char *av[])
=20
 static void setup(void)
 {
-	char wdbuf[MAXPATHLEN];
-
 	/*
 	 * Make a directory to do this in; ignore error if already exists.
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
=20
-	if (getcwd(homedir, sizeof(homedir)) =3D=3D NULL) {
-		tst_resm(TBROK, "getcwd() failed");
-		tst_exit();
-	}
-
 	parent_pid =3D getpid();
=20
-	if (!fuss[0])
-		sprintf(fuss, "%s/ftest03.%d", getcwd(wdbuf, sizeof( wdbuf)), getpid()=
);
-
-	mkdir(fuss, 0755);
-
-	if (chdir(fuss) < 0) {
-		tst_resm(TBROK,"\tCan't chdir(%s), error %d.", fuss, errno);
-		tst_exit() ;
-	}
-
 	/*
 	 * Default values for run conditions.
 	 */
@@ -181,9 +161,9 @@ static void setup(void)
=20
 static void runtest(void)
 {
-	int i, pid, child, status, count;
+	int i, child, status, count;
=20
-	for(i =3D 0; i < nchild; i++) {
+	for (i =3D 0; i < nchild; i++) {
=20
 		test_name[0] =3D 'a' + i;
 		test_name[1] =3D '\0';
@@ -191,7 +171,7 @@ static void runtest(void)
 		fd =3D open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
=20
 		if (fd < 0) {
-			tst_resm(TBROK, "\tError %d creating %s/%s.", errno, fuss, test_name)=
;
+			tst_resm(TBROK, "Error %d creating %s.", errno, test_name);
 			tst_exit();
 		}
=20
@@ -241,30 +221,6 @@ static void runtest(void)
 		local_flag =3D FAILED;
 	}
=20
-	chdir(homedir);
-
-	pid =3D fork();
-
-	if (pid < 0) {
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-                              " etc are likely to fail.");
-                tst_resm(TBROK, "Test broken due to inability of fork.")=
;
-		sync();
-		tst_exit();
-	}
-
-	if (pid =3D=3D 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-		tst_exit();
-	} else
-		wait(&status);
-
-	if (status) {
-		tst_resm(TINFO, "CAUTION - ftest03, '%s' may not be removed", fuss);
-		tst_resm(TINFO, "CAUTION - ftest03, '%s' may not be removed",
-		  fuss);
-	}
-
 	sync();
 }
=20
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ft=
est/ftest05.c
index 220d9fd..3c66ab0 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -94,9 +94,6 @@ static int parent_pid;
 static int pidlist[MAXCHILD];
 static char test_name[2];     /* childs test directory name */
=20
-static char fuss[40];         /* directory to do this in */
-static char homedir[200];     /* where we started */
-
 static int local_flag;
=20
 int main(int ac, char *av[])
@@ -135,19 +132,9 @@ static void setup(void)
 	 * Save starting directory.
 	 */
 	tst_tmpdir();
-	getcwd(homedir, sizeof (homedir));
+=09
 	parent_pid =3D getpid();
=20
-	if (!fuss[0])
-		sprintf(fuss, "./ftest05.%d", getpid());
-
-	mkdir(fuss, 0755);
-
-	if (chdir(fuss) < 0) {
-		tst_resm(TBROK,"\tCan't chdir(%s), error %d.", fuss, errno);
-		tst_exit();
-	}
-
 	/*
 	 * Default values for run conditions.
 	 */
@@ -167,7 +154,7 @@ static void setup(void)
=20
 static void runtest(void)
 {
-	int i, pid, child, status, count;
+	int i, child, status, count;
=20
 	for (i =3D 0; i < nchild; i++) {
 		test_name[0] =3D 'a' + i;
@@ -175,7 +162,7 @@ static void runtest(void)
 		fd =3D open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
=20
 		if (fd < 0) {
-			tst_resm(TBROK, "\tError %d creating %s/%s.", errno, fuss, test_name)=
;
+			tst_resm(TBROK, "Error %d creating %s.", errno, test_name);
 			tst_exit();
 		}
=20
@@ -221,28 +208,6 @@ static void runtest(void)
 		local_flag =3D FAILED;
 	}
=20
-	chdir(homedir);
-	pid =3D fork();
-
-	if (pid < 0) {
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-                                 " etc are likely to fail.");
-                tst_resm(TBROK, "Test broken due to inability of fork.")=
;
-		sync();
-                tst_exit();
-	}
-
-	if (pid =3D=3D 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-		tst_exit();
-	}
-
-	wait(&status);
-
-	if (status) {
-		tst_resm(TINFO,"CAUTION - ftest05, '%s' may not be removed", fuss);
-	}
-
 	sync();
 }
=20
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ft=
est/ftest07.c
index 8cda511..ef42daf 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -86,6 +86,7 @@ int TST_TOTAL =3D 1;
 #define	MAXIOVCNT	16
=20
 static void setup(void);
+static void cleanup(void);
 static void runtest(void);
 static void dotest(int, int, int);
 static void domisc(int, int, char*);
@@ -102,9 +103,6 @@ static int parent_pid;
 static int pidlist[MAXCHILD];
 static char test_name[2];     /* childs test directory name */
=20
-static char fuss[40];         /* directory to do this in */
-static char homedir[200];     /* where we started */
-
 static int local_flag;
=20
 int main(int ac, char *av[])
@@ -141,58 +139,45 @@ int main(int ac, char *av[])
 	return 0;
 }
=20
-static void setup(void)
+static void cleanup(void)
 {
-	char wdbuf[MAXPATHLEN], *cwd;
+	tst_rmdir();
+	tst_exit();
+}
=20
+static void setup(void)
+{
 	/*
 	 * Make a directory to do this in; ignore error if already exists.
 	 * Save starting directory.
 	 */
-	if ((cwd =3D getcwd(homedir, sizeof (homedir))) =3D=3D NULL ) {
-		tst_resm(TBROK,"Failed to get corrent directory") ;
-		tst_exit();
-	}
-
 	parent_pid =3D getpid();
 	tst_tmpdir();
-	if (!fuss[0])
-		sprintf(fuss, "%s/ftest07.%d", getcwd(wdbuf, sizeof( wdbuf)), getpid()=
);
-
-	mkdir(fuss, 0755);
-
-	if (chdir(fuss) < 0) {
-		tst_resm(TBROK,"\tCan't chdir(%s), error %d.", fuss, errno);
-		tst_exit() ;
-	}
-
+=09
 	/*
 	 * Default values for run conditions.
 	 */
-
 	iterations =3D 10;
 	nchild =3D 5;
 	csize =3D K_2;		/* should run with 1, 2, and 4 K sizes */
 	max_size =3D K_1 * K_1;
 	misc_intvl =3D 10;
=20
-	if (sigset(SIGTERM, term) =3D=3D SIG_ERR) {
-		tst_resm(TBROK, " sigset failed: signo =3D 15") ;
-		tst_exit() ;
-	}
-
+	if (sigset(SIGTERM, term) =3D=3D SIG_ERR)
+		tst_brkm(TBROK, cleanup,  " sigset failed: signo =3D 15");
 }
=20
 static void runtest(void)
 {
-	int pid, child, status, count, i;
+	int child, status, count, i;
=20
 	for (i =3D 0; i < nchild; i++) {
 		test_name[0] =3D 'a' + i;
 		test_name[1] =3D '\0';
 		fd =3D open(test_name, O_RDWR|O_CREAT|O_TRUNC, 0666);
+	=09
 		if (fd < 0) {
-			tst_resm(TBROK, "\tError %d creating %s/%s.", errno, fuss, test_name)=
;
+			tst_resm(TBROK, "Error %d creating %s.", errno, test_name);
 			tst_exit();
 		}
=20
@@ -241,25 +226,6 @@ static void runtest(void)
 		local_flag =3D FAILED;
 	}
=20
-	chdir(homedir);
-
-	pid =3D fork();
-	if (pid < 0) {
-		tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-                                    " etc are likely to fail.");
-                tst_resm(TBROK, "Test broken due to inability of fork.")=
;
-                tst_exit();
-	}
-
-	if (pid =3D=3D 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
-			exit(1);
-		} else
-			wait(&status);
-	if (status) {
-		tst_resm(TINFO, "CAUTION - ftest07, '%s' may not be removed", fuss);
-	}
-
 	sync();
 }
=20

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--17pEHd4RhPHOinZp--

