Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Nxm00-00022y-9M
	for ltp-list@lists.sourceforge.net; Fri, 02 Apr 2010 18:53:44 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 38E595362F
	for <ltp-list@lists.sourceforge.net>;
	Fri,  2 Apr 2010 20:53:36 +0200 (CEST)
Date: Fri, 2 Apr 2010 20:59:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100402185908.GA478@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [LTP] [PATCH] fix fs_perms tests
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
To: ltp-list@lists.sourceforge.net


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
It looks (at least for me) that fs_perms tests are broken for a long time (as
they are trying to find binaries in working directory instead of LTPROOT).

Attached patch fixes fs_perm.c to look for test binary in
$LTPROOT/testcases/bin/ rather than in ./ and converts silly and broken
fs_perms_simple.sh script into runtest file that is also added into runltp
script.


The way how now fs_perm is copying test file into temporary directory is not
ideall either because the test fails when executed by hand. I could think of
creating file with a such line:

#!/bin/true

Or maybe more robust:

#!/bin/sh
true

But I'm not sure if there is always /bin/true (as it's buildin in most of the
shells) or if I it's good idea to add dependecy for /bin/sh. But this would
avoid compiling dummy C program and copying it from $LTPROOT/testcases/bin/.

Or we could do some trickery to embed the "dummy" binary file into the code as
array.

Any ideas here?


However the problem discussed above fs_perms tests are at least working with
this patch.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--Nq2Wo0NMKNjxTN9z
Content-Type: text/x-patch; charset=iso-8859-1
Content-Disposition: attachment; filename="fix_fs_perms.patch"
Content-Transfer-Encoding: quoted-printable

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
diff --git a/testcases/kernel/fs/fs_perms/fs_perms.c b/testcases/kernel/f=
s/fs_perms/fs_perms.c
index ad44028..274988d 100644
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
@@ -42,111 +43,132 @@
 char *TCID =3D "fs_perms";
 int TST_TOTAL =3D 1;
=20
-static int testsetup(mode_t mode, int cuserId, int cgroupId)
+void cleanup(void)
+{
+	tst_rmdir();
+	tst_exit();
+}
+
+/*
+ * Create temporary directory and copy binary file equivalent to /bin/tr=
ue into
+ * it as test.file.
+ */
+static int testsetup(mode_t mode, int user_id, int group_id)
 {
 	int ret;
-	char cmd_str[256];
+	char *ltp_root =3D getenv("LTPROOT");
+	char cmd_str[1024];
=20
-	sprintf(cmd_str, "cp %s/testx test.file", getcwd(NULL, 0));
 	tst_tmpdir();
=20
-	ret =3D unlink("test.file");
-	if (ret && errno !=3D ENOENT)
-		goto done;
+	if (ltp_root =3D=3D NULL)
+		tst_brkm(TBROK, cleanup, "LTPROOT variable is not exported");=20
+
+	snprintf(cmd_str, sizeof(cmd_str), "cp %s/testcases/bin/fs_perms_testx =
test.file",
+                 ltp_root);
+
 	ret =3D system(cmd_str);
+=09
 	if (ret)
-		goto done;
+		return ret;
+
 	ret =3D chmod("test.file", mode);
+=09
 	if (ret)
-		goto done;
-	ret =3D chown("test.file", cuserId, cgroupId);
+		return ret;
=20
- done:
+	ret =3D chown("test.file", user_id, group_id);
+=09
 	return ret;
 }
=20
-void cleanup(void)
+static int testfperm(int user_id, int group_id, char *fperm)
 {
-	tst_rmdir();
-	tst_exit();
-}
-
-static int testfperm(int userId, int groupId, char *fperm)
-{
-	/* SET CURRENT USER/GROUP PERMISSIONS */
-	if (setegid(groupId)) {
-		tst_brkm(TBROK, cleanup, "could not setegid to %d: %s", groupId, strer=
ror(errno));
+	FILE *testfile;
+	int ret;
+=09
+	if (setegid(group_id)) {
+		tst_brkm(TBROK, cleanup, "could not setegid to %d: %s", group_id, stre=
rror(errno));
 		seteuid(0);
 		setegid(0);
 		return -1;
 	}
-	if (seteuid(userId)) {
-		tst_brkm(TBROK, cleanup, "could not seteuid to %d: %s", userId, strerr=
or(errno));
+
+	if (seteuid(user_id)) {
+		tst_brkm(TBROK, cleanup, "could not seteuid to %d: %s", user_id, strer=
ror(errno));
 		seteuid(0);
 		setegid(0);
 		return -1;
 	}
=20
-	switch (tolower(fperm[0])) {
-	case 'x': {
+	if (tolower(fperm[0]) =3D=3D 'x') {
 		int status;
+	=09
 		if (fork() =3D=3D 0) {
 			execlp("./test.file", "test.file", NULL);
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
+	if ((testfile =3D fopen("test.file", fperm))) {
+		fclose(testfile);
+		ret =3D 0;
+	} else
+		ret =3D 1;=09
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
+	int result, exresult, cuser_id, cgroup_id, user_id, group_id;
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
+	if (argc !=3D 8) {
+		print_usage(argv[0]);
 		return 1;
 	}
=20
-	result =3D testsetup(mode, cuserId, cgroupId);
-	if (result) {
+	mode      =3D strtol(argv[1], NULL, 010);
+	cuser_id  =3D atoi(argv[2]);
+	cgroup_id =3D atoi(argv[3]);
+	user_id   =3D atoi(argv[4]);
+	group_id  =3D atoi(argv[5]);
+	fperm     =3D argv[6];
+	exresult  =3D atoi(argv[7]);
+
+	result =3D testsetup(mode, cuser_id, cgroup_id);
+
+	if (result)
 		tst_brkm(TBROK, cleanup, "testsetup() failed: %s", strerror(errno));
-	}
=20
-	result =3D testfperm(userId, groupId, fperm);
-	unlink("test.file");
+	result =3D testfperm(user_id, group_id, fperm);
+
 	tst_resm(exresult =3D=3D result ? TPASS : TFAIL, "%c a %03o file owned =
by (%d/%d) as user/group(%d/%d)",
-		fperm[0], mode, cuserId, cgroupId, userId, groupId);
-	cleanup();
-	return 0;
+		fperm[0], mode, cuser_id, cgroup_id, user_id, group_id);
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
diff --git a/testcases/kernel/fs/fs_perms/fs_perms_testx.c b/testcases/ke=
rnel/fs/fs_perms/fs_perms_testx.c
new file mode 100644
index 0000000..4af2aea
--- /dev/null
+++ b/testcases/kernel/fs/fs_perms/fs_perms_testx.c
@@ -0,0 +1,29 @@
+/*
+ *   Copyright (c) 2010 Cyril Hrubis chrubis@suse.cz
+ *
+ *   This program is free software;  you can redistribute it and/or modi=
fy
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
+ */
+
+ /*
+  * This program just mimics /bin/true behaviour (as the main test tries=
 to
+  * execute this).
+  */
+
+#include <stdio.h>
+
+int main(void)
+{
+	return 0;
+}
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

--Nq2Wo0NMKNjxTN9z
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
--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--Nq2Wo0NMKNjxTN9z--

