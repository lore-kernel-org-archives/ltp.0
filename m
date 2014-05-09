Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Wiiw9-0001QA-95
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 11:25:57 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wiiw7-000515-0q
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 11:25:57 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s49BPiYw025894
	for <ltp-list@lists.sourceforge.net>; Fri, 9 May 2014 19:25:44 +0800
Message-ID: <1399634696.3515.0.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 9 May 2014 19:24:56 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] statfs/statfs02.c: cleanup
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

From 841dc67dad71b7cdabc4d7d6804467e2cd7a6950 Mon Sep 17 00:00:00 2001
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 9 May 2014 17:06:54 +0800
Subject: [PATCH] statfs/statfs02.c: cleanup

* Delete some useless commtents.
* Use static.
* Move the test body from main() to statfs_verify().
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/statfs/statfs02.c | 191 ++++++++++------------------
 1 file changed, 67 insertions(+), 124 deletions(-)

diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
index af839d0..98d9111 100644
--- a/testcases/kernel/syscalls/statfs/statfs02.c
+++ b/testcases/kernel/syscalls/statfs/statfs02.c
@@ -1,30 +1,24 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 Ported by Wayne Boyer
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	statfs02.c
- *
  * DESCRIPTION
- *	Testcase to check that statfs(2) sets errno correctly.
- *
- * ALGORITHM
  *	1.	Use a component of the pathname, which is not a directory
  *		in the "path" parameter to statfs(). Expect ENOTDIR
  *	2.	Pass a filename which doesn't exist, and expect ENOENT.
@@ -34,23 +28,8 @@
  *		the process, and expect EFAULT.
  *	5.	Pass a pointer to the buf paramter outside the address space
  *		of the process, and expect EFAULT.
- *
- * USAGE:  <for command-line>
- *  statfs02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
- *
  */
+
 #include <sys/types.h>
 #include <sys/statfs.h>
 #include <sys/stat.h>
@@ -60,55 +39,45 @@
 #include <errno.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 char *TCID = "statfs02";
-int fileHandle = 0;
 
-int exp_enos[] = {
+static int exp_enos[] = {
 	ENOTDIR, ENOENT, ENAMETOOLONG,
 #if !defined(UCLINUX)
-	EFAULT, 0
+	EFAULT,
 #endif
+	0
 };
 
-char *bad_addr = 0;
+static int fd;
+
+#define TEST_FILE		"statfs_file"
+#define TEST_FILE1		TEST_FILE"/statfs_file1"
+#define TEST_NOEXIST		"statfs_noexist"
 
-char bad_file[] =
-    "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
-char good_dir[100] = "testdir";
-char fname[30] = "testfile";
-struct statfs fsbuf;
-char fname1[30];
+static char test_toolong[PATH_MAX+2];
+static struct statfs buf;
 
-struct test_case_t {
+static struct test_case_t {
 	char *path;
 	struct statfs *buf;
-	int error;
+	int exp_error;
 } TC[] = {
-	/* path has a component which is not a directory - ENOTDIR */
-	{
-	fname1, &fsbuf, ENOTDIR},
-	    /* path does not exist - ENOENT */
-	{
-	good_dir, &fsbuf, ENOENT},
-	    /* path is too long - ENAMETOOLONG */
-	{
-	bad_file, &fsbuf, ENAMETOOLONG},
+	{TEST_FILE1, &buf, ENOTDIR},
+	{TEST_NOEXIST, &buf, ENOENT},
+	{test_toolong, &buf, ENAMETOOLONG},
 #ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
-	    /* path is an invalid address - EFAULT */
-	{
-	(char *)-1, &fsbuf, EFAULT},
-	    /* buf is an invalid address - EFAULT */
-	{
-	fname, (struct statfs *)-1, EFAULT}
+	{(char *)-1, &buf, EFAULT},
+	{TEST_FILE, (struct statfs *)-1, EFAULT},
 #endif
 };
 
-int TST_TOTAL = sizeof(TC) / sizeof(*TC);
-
-void setup(void);
-void cleanup(void);
+int TST_TOTAL = ARRAY_SIZE(TC);
+static void setup(void);
+static void cleanup(void);
+static void statfs_verify(const struct test_case_t *);
 
 int main(int ac, char **av)
 {
@@ -116,93 +85,67 @@ int main(int ac, char **av)
 	char *msg;
 	int i;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
-	/* set up the expected errnos */
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(statfs(TC[i].path, TC[i].buf));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			statfs_verify(&TC[i]);
 	}
 
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* make a temporary directory and cd to it */
 	tst_tmpdir();
 
-	sprintf(fname, "%s.%d", fname, getpid());
-	if ((fileHandle = creat(fname, 0444)) == -1) {
-		tst_resm(TFAIL, "creat(2) FAILED to creat temp file");
-	}
-	sprintf(fname1, "%s/%s", fname, fname);
+	fd = SAFE_CREAT(cleanup, TEST_FILE, 0444);
 
-	sprintf(good_dir, "%s.statfs.%d", good_dir, getpid());
+	memset(test_toolong, 'a', PATH_MAX+1);
 
 #if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	TC[3].path = bad_addr;
+	TC[3].path = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+			       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 #endif
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void statfs_verify(const struct test_case_t *test)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	close(fileHandle);
+	TEST(statfs(test->path, test->buf));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "call succeeded unexpectedly");
+		return;
+	}
+
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == test->exp_error) {
+		tst_resm(TPASS | TTERRNO, "expected failure");
+	} else {
+		tst_resm(TFAIL | TTERRNO, "unexpected error, expected %d",
+			 TEST_ERRNO);
+	}
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		close(fd);
 
 	TEST_CLEANUP;
 
 	tst_rmdir();
-
 }
-- 
1.8.4.2




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
