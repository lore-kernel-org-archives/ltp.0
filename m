From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 22 Feb 2018 13:48:07 +0800
Subject: [LTP] [PATCH v4 1/4] lib/get_high_address.c: Add tst_get_bad_addr.h
	for new API
In-Reply-To: <20180220160847.GA13149@rei>
References: <20180220160847.GA13149@rei>
Message-ID: <1519278490-18615-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Use mmap() with PROT_NONE to get a bad address and rename get_high_address
   as tst_get_bad_addr
2) Make sure tst_get_bad_addr can be used by both new API and old API
3) Apply tst_get_bad_addr and remove duplicate tests for EFAULT
4) Just use sbrk(0) + 4 * PAGE_SIZE to test ENOMEM in msync03
5) Remove UCLINUX

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/old/test.h                              |  4 +--
 include/tst_get_bad_addr.h                      | 25 ++++++++++++++
 include/tst_test.h                              |  1 +
 lib/get_high_address.c                          | 40 ----------------------
 lib/tst_get_bad_addr.c                          | 31 +++++++++++++++++
 testcases/kernel/syscalls/lchown/lchown02.c     | 28 ++--------------
 testcases/kernel/syscalls/link/link04.c         | 43 ++++++++----------------
 testcases/kernel/syscalls/lstat/lstat02.c       | 23 +++----------
 testcases/kernel/syscalls/mkdir/mkdir01.c       | 39 ++--------------------
 testcases/kernel/syscalls/mknod/mknod06.c       | 34 +++----------------
 testcases/kernel/syscalls/mremap/mremap03.c     | 13 +-------
 testcases/kernel/syscalls/msync/msync03.c       |  9 +----
 testcases/kernel/syscalls/rmdir/rmdir05.c       | 44 ++-----------------------
 testcases/kernel/syscalls/stat/stat03.c         | 31 +++--------------
 testcases/kernel/syscalls/symlink/symlink03.c   | 32 ++++--------------
 testcases/kernel/syscalls/truncate/truncate03.c | 19 ++++-------
 testcases/kernel/syscalls/unlink/unlink07.c     | 32 +++---------------
 17 files changed, 111 insertions(+), 337 deletions(-)
 create mode 100644 include/tst_get_bad_addr.h
 delete mode 100644 lib/get_high_address.c
 create mode 100644 lib/tst_get_bad_addr.c

diff --git a/include/old/test.h b/include/old/test.h
index 137ebb1..74d11a1 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -63,6 +63,7 @@
 #include "old_device.h"
 #include "old_tmpdir.h"
 #include "tst_minmax.h"
+#include "tst_get_bad_addr.h"
 
 /*
  * Ensure that NUMSIGS is defined.
@@ -203,9 +204,6 @@ extern int tst_count;
 /* lib/tst_sig.c */
 void tst_sig(int fork_flag, void (*handler)(), void (*cleanup)());
 
-/* lib/get_high_address.c */
-char *get_high_address(void);
-
 /* lib/self_exec.c */
 void maybe_run_child(void (*child)(), const char *fmt, ...);
 int self_exec(const char *argv0, const char *fmt, ...);
diff --git a/include/tst_get_bad_addr.h b/include/tst_get_bad_addr.h
new file mode 100644
index 0000000..aed1752
--- /dev/null
+++ b/include/tst_get_bad_addr.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TST_GET_BAD_ADDR_H__
+#define TST_GET_BAD_ADDR_H__
+
+/* Functions from lib/tst_get_bad_addr.c */
+void *tst_get_bad_addr(void (*cleanup_fn) (void));
+
+#endif	/* TST_GET_BAD_ADDR_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index eaf7a1f..af97b89 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -40,6 +40,7 @@
 #include "tst_clone.h"
 #include "tst_kernel.h"
 #include "tst_minmax.h"
+#include "tst_get_bad_addr.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/get_high_address.c b/lib/get_high_address.c
deleted file mode 100644
index eed9cf1..0000000
--- a/lib/get_high_address.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/* $Header: /cvsroot/ltp/ltp/lib/get_high_address.c,v 1.6 2009/07/20 10:59:32 vapier Exp $ */
-
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- */
-
-#include <unistd.h>
-
-char *get_high_address(void)
-{
-	return (char *)sbrk(0) + (4 * getpagesize());
-}
diff --git a/lib/tst_get_bad_addr.c b/lib/tst_get_bad_addr.c
new file mode 100644
index 0000000..098e72b
--- /dev/null
+++ b/lib/tst_get_bad_addr.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <sys/mman.h>
+#include "test.h"
+#include "tst_get_bad_addr.h"
+
+void *tst_get_bad_addr(void (*cleanup_fn) (void))
+{
+	void *bad_addr;
+
+	bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (bad_addr == MAP_FAILED)
+		tst_brkm(TBROK, cleanup_fn, "mmap() failed to get bad address");
+
+	return bad_addr;
+}
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index 326e584..97966f6 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -74,12 +74,13 @@
 TCID_DEFINE(lchown02);
 int TST_TOTAL = 7;
 
+static void setup(void);
+static void cleanup(void);
 static void setup_eperm(int pos);
 static void setup_eacces(int pos);
 static void setup_enotdir(int pos);
 static void setup_longpath(int pos);
 static void setup_efault(int pos);
-static void setup_highaddress(int pos);
 
 static char path[PATH_MAX + 2];
 
@@ -93,7 +94,6 @@ struct test_case_t {
 static struct test_case_t test_cases[] = {
 	{SFILE1, "Process is not owner/root", EPERM, setup_eperm},
 	{SFILE2, "Search permission denied", EACCES, setup_eacces},
-	{NULL, "Address beyond address space", EFAULT, setup_highaddress},
 	{NULL, "Unaccessible address space", EFAULT, setup_efault},
 	{path, "Pathname too long", ENAMETOOLONG, setup_longpath},
 	{SFILE3, "Path contains regular file", ENOTDIR, setup_enotdir},
@@ -103,9 +103,6 @@ static struct test_case_t test_cases[] = {
 
 static struct passwd *ltpuser;
 
-static void setup(void);
-static void cleanup(void);
-
 int main(int argc, char *argv[])
 {
 	int lc;
@@ -252,26 +249,7 @@ static void setup_eacces(int pos LTP_ATTRIBUTE_UNUSED)
  */
 static void setup_efault(int pos)
 {
-	char *bad_addr = 0;
-
-	bad_addr = mmap(NULL, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, -1, 0);
-
-	if (bad_addr == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
-
-	test_cases[pos].pathname = bad_addr;
-}
-
-/*
- * setup_efault() -- setup for a test condition where lchown(2) returns -1 and
- *                   sets errno to EFAULT.
- *
- * Use ltp function get_high_address() to compute high address.
- */
-static void setup_highaddress(int pos)
-{
-	test_cases[pos].pathname = get_high_address();
+	test_cases[pos].pathname = tst_get_bad_addr(cleanup);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/link/link04.c b/testcases/kernel/syscalls/link/link04.c
index 679753f..d940884 100644
--- a/testcases/kernel/syscalls/link/link04.c
+++ b/testcases/kernel/syscalls/link/link04.c
@@ -51,12 +51,7 @@
 #include "test.h"
 #include "safe_macros.h"
 
-static char *bad_addr = 0;
-
 static char longpath[PATH_MAX + 2];
-#if !defined(UCLINUX)
-char high_addr[64];
-#endif
 
 struct test_case_t {
 	char *file1;
@@ -73,10 +68,7 @@ struct test_case_t {
 	{"regfile/file", "path contains a regular file", "nefile", "nefile",
 	 ENOTDIR},
 	{longpath, "pathname too long", "nefile", "nefile", ENAMETOOLONG},
-#if !defined(UCLINUX)
-	{high_addr, "address beyond address space", "nefile", "nefile", EFAULT},
-#endif
-	{(char *)-1, "negative address", "nefile", "nefile", EFAULT},
+	{NULL, "invalid address", "nefile", "nefile", EFAULT},
 	/* second path is invalid */
 	{"regfile", "regfile", "", "empty string", ENOENT},
 	{"regfile", "regfile", "neefile/file",
@@ -84,11 +76,7 @@ struct test_case_t {
 	{"regfile", "regfile", "file/file",
 		    "path contains a regular file", ENOENT},
 	{"regfile", "regfile", longpath, "pathname too long", ENAMETOOLONG},
-#if !defined(UCLINUX)
-	{"regfile", "regfile", high_addr,
-		    "address beyond address space", EFAULT},
-#endif
-	{"regfile", "regfile", (char *)-1, "negative address", EFAULT},
+	{"regfile", "regfile", NULL, "invalid address", EFAULT},
 	/* two existing files */
 	{"regfile", "regfile", "regfile2", "regfile2", EEXIST},
 };
@@ -121,14 +109,6 @@ int main(int ac, char **av)
 			fname2 = test_cases[i].file2;
 			desc2 = test_cases[i].desc2;
 
-#if !defined(UCLINUX)
-			if (fname1 == high_addr)
-				fname1 = get_high_address();
-
-			if (fname2 == high_addr)
-				fname2 = get_high_address();
-#endif
-
 			TEST(link(fname1, fname2));
 
 			if (TEST_RETURN == -1) {
@@ -160,23 +140,28 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	int n;
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
 	tst_tmpdir();
 
-#if !defined(UCLINUX)
-	bad_addr = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
-	                     MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	test_cases[6].file1 = bad_addr;
-	test_cases[12].file2 = bad_addr;
-#endif
-
 	memset(longpath, 'a', PATH_MAX+1);
 	SAFE_TOUCH(cleanup, "regfile", 0777, NULL);
 	SAFE_TOUCH(cleanup, "regfile2", 0777, NULL);
 	SAFE_MKDIR(cleanup, "dir", 0777);
+
+	void *bad_addr = tst_get_bad_addr(cleanup);
+
+	for (n = 0; n < TST_TOTAL; n++) {
+		if (!test_cases[n].file1)
+			test_cases[n].file1 = bad_addr;
+
+		if (!test_cases[n].file2)
+			test_cases[n].file2 = bad_addr;
+	}
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/lstat/lstat02.c b/testcases/kernel/syscalls/lstat/lstat02.c
index ab46787..15285e7 100644
--- a/testcases/kernel/syscalls/lstat/lstat02.c
+++ b/testcases/kernel/syscalls/lstat/lstat02.c
@@ -59,10 +59,10 @@
 static char longpathname[PATH_MAX + 2];
 static char elooppathname[sizeof(TEST_ELOOP) * 43] = ".";
 
-#if !defined(UCLINUX)
+static void setup(void);
+static void lstat_verify(int);
+static void cleanup(void);
 static void bad_addr_setup(int);
-static void high_address_setup(int);
-#endif
 
 static struct test_case_t {
 	char *pathname;
@@ -71,10 +71,7 @@ static struct test_case_t {
 } test_cases[] = {
 	{TEST_EACCES, EACCES, NULL},
 	{TEST_ENOENT, ENOENT, NULL},
-#if !defined(UCLINUX)
 	{NULL, EFAULT, bad_addr_setup},
-	{NULL, EFAULT, high_address_setup},
-#endif
 	{longpathname, ENAMETOOLONG, NULL},
 	{TEST_ENOTDIR, ENOTDIR, NULL},
 	{elooppathname, ELOOP, NULL},
@@ -83,10 +80,6 @@ static struct test_case_t {
 char *TCID = "lstat02";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
 
-static void setup(void);
-static void lstat_verify(int);
-static void cleanup(void);
-
 int main(int ac, char **av)
 {
 	int lc;
@@ -140,18 +133,10 @@ static void setup(void)
 		strcat(elooppathname, TEST_ELOOP);
 }
 
-#if !defined(UCLINUX)
 static void bad_addr_setup(int i)
 {
-	test_cases[i].pathname = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
-					   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-}
-
-static void high_address_setup(int i)
-{
-	test_cases[i].pathname = (char *)get_high_address();
+	test_cases[i].pathname = tst_get_bad_addr(cleanup);
 }
-#endif
 
 static void lstat_verify(int i)
 {
diff --git a/testcases/kernel/syscalls/mkdir/mkdir01.c b/testcases/kernel/syscalls/mkdir/mkdir01.c
index 9839a09..84012c0 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir01.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir01.c
@@ -116,7 +116,7 @@ void setup();
 void cleanup();
 
 char *TCID = "mkdir01";
-int TST_TOTAL = 2;
+int TST_TOTAL = 1;
 
 char *bad_addr = 0;
 
@@ -161,37 +161,6 @@ int main(int ac, char **av)
 				 "mkdir - path argument pointing below allocated address space succeeded unexpectedly.");
 
 		}
-#if !defined(UCLINUX)
-		/*
-		 * TEST CASE: 2
-		 * mkdir() call with pointer above allocated address space.
-		 */
-
-		/* Call mkdir(2) */
-		TEST(mkdir(get_high_address(), 0777));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-		}
-
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == EFAULT) {
-				tst_resm(TPASS,
-					 "mkdir - path argument pointing above allocated address space failed as expected with errno %d : %s",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL,
-					 "mkdir - path argument pointing above allocated address space failed with errno %d : %s but expected %d (EFAULT)",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO), EFAULT);
-			}
-		} else {
-			tst_resm(TFAIL,
-				 "mkdir - path argument pointing above allocated address space succeeded unexpectedly.");
-
-		}
-#endif /* if !defined(UCLINUX) */
 
 	}
 
@@ -212,11 +181,7 @@ void setup(void)
 	/* Create a temporary directory and make it current. */
 	tst_tmpdir();
 
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
+	bad_addr = tst_get_bad_addr(cleanup);
 }
 
 /***************************************************************
diff --git a/testcases/kernel/syscalls/mknod/mknod06.c b/testcases/kernel/syscalls/mknod/mknod06.c
index a8ee5ba..8f70cf0 100644
--- a/testcases/kernel/syscalls/mknod/mknod06.c
+++ b/testcases/kernel/syscalls/mknod/mknod06.c
@@ -93,7 +93,6 @@ int setup3();			/* setup function to test mknod for ENOTDIR */
 int longpath_setup();		/* setup function to test mknod for ENAMETOOLONG */
 int no_setup();			/* simply returns 0 to the caller */
 char Longpathname[PATH_MAX + 2];
-char High_address_node[64];
 
 struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	char *pathname;
@@ -101,15 +100,8 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	int exp_errno;
 	int (*setupfunc) ();
 } Test_cases[] = {
-	{
-	"tnode_1", "Specified node already exists", EEXIST, setup1},
-#if !defined(UCLINUX)
-	{
-	(char *)-1, "Negative address", EFAULT, no_setup}, {
-	High_address_node, "Address beyond address space", EFAULT,
-		    no_setup},
-#endif
-	{
+	{"tnode_1", "Specified node already exists", EEXIST, setup1}, {
+	NULL, "Invalid address", EFAULT, no_setup}, {
 	"testdir_2/tnode_2", "Non-existent file", ENOENT, no_setup}, {
 	"", "Pathname is empty", ENOENT, no_setup}, {
 	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
@@ -119,12 +111,6 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
 
 char *TCID = "mknod06";
 int TST_TOTAL = ARRAY_SIZE(Test_cases);
-#if !defined(UCLINUX)
-extern char *get_high_address();
-#else
-#endif
-
-char *bad_addr = 0;
 
 void setup();			/* setup function for the tests */
 void cleanup();			/* cleanup function for the tests */
@@ -152,12 +138,6 @@ int main(int ac, char **av)
 			node_name = Test_cases[ind].pathname;
 			test_desc = Test_cases[ind].desc;
 
-#if !defined(UCLINUX)
-			if (node_name == High_address_node) {
-				node_name = get_high_address();
-			}
-#endif
-
 			/*
 			 * Call mknod(2) to test different test conditions.
 			 * verify that it fails with -1 return value and
@@ -217,16 +197,10 @@ void setup(void)
 	/* Make a temp dir and cd to it */
 	tst_tmpdir();
 
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	Test_cases[2].pathname = bad_addr;
-#endif
 	/* call individual setup functions */
 	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
+		if (!Test_cases[ind].pathname)
+			Test_cases[ind].pathname = tst_get_bad_addr(cleanup);
 		Test_cases[ind].setupfunc();
 	}
 }
diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 5cd1a67..a85e986 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -92,7 +92,6 @@ int newsize;			/* new size of virtual memory block */
 void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
 
-#if !defined(UCLINUX)
 int main(int ac, char **av)
 {
 	int lc;
@@ -174,7 +173,7 @@ void setup(void)
 	 * Set the old virtual address point to some address
 	 * which is not mapped.
 	 */
-	bad_addr = (char *)get_high_address();
+	bad_addr = tst_get_bad_addr(cleanup);
 }
 
 /*
@@ -187,13 +186,3 @@ void cleanup(void)
 	/* Exit the program */
 
 }
-
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
-
-#endif /* if !defined(UCLINUX) */
diff --git a/testcases/kernel/syscalls/msync/msync03.c b/testcases/kernel/syscalls/msync/msync03.c
index 2e072ca..f504ed1 100644
--- a/testcases/kernel/syscalls/msync/msync03.c
+++ b/testcases/kernel/syscalls/msync/msync03.c
@@ -57,10 +57,7 @@ static int fd;
 static char *addr1;
 static char *addr2;
 static char *addr3;
-
-#if !defined(UCLINUX)
 static char *addr4;
-#endif
 
 static size_t page_sz;
 
@@ -74,9 +71,7 @@ static struct test_case_t {
 	{ &addr1, INV_SYNC, EINVAL },
 	{ &addr2, MS_SYNC, EINVAL },
 	{ &addr3, MS_SYNC, EINVAL },
-#if !defined(UCLINUX)
 	{ &addr4, MS_SYNC, ENOMEM },
-#endif
 };
 
 static void msync_verify(struct test_case_t *tc);
@@ -135,10 +130,8 @@ static void setup(void)
 	SAFE_GETRLIMIT(NULL, RLIMIT_DATA, &rl);
 	addr3 = (char *)rl.rlim_max;
 
-#if !defined(UCLINUX)
 	/* memory pointed to by addr4 was not mapped */
-	addr4 = get_high_address();
-#endif
+	addr4 = sbrk(0) + (4 * page_sz);
 }
 
 static void msync_verify(struct test_case_t *tc)
diff --git a/testcases/kernel/syscalls/rmdir/rmdir05.c b/testcases/kernel/syscalls/rmdir/rmdir05.c
index bef3b47..0eb54f0 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir05.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir05.c
@@ -50,12 +50,7 @@
 static void setup(void);
 static void cleanup(void);
 
-#if !defined(UCLINUX)
-extern char *get_high_address();
-int TST_TOTAL = 6;
-#else
-int TST_TOTAL = 4;
-#endif
+int TST_TOTAL = 5;
 
 char *TCID = "rmdir05";
 
@@ -119,7 +114,6 @@ int main(int argc, char **argv)
 		 * TEST CASE: 4
 		 * path argument points below the minimum allocated address space
 		 */
-#if !defined(UCLINUX)
 		TEST(rmdir(bad_addr));
 
 		if (TEST_RETURN == -1) {
@@ -144,34 +138,6 @@ int main(int argc, char **argv)
 
 		/*
 		 * TEST CASE: 5
-		 * path argument points above the maximum allocated address space
-		 */
-
-		TEST(rmdir(get_high_address()));
-
-		if (TEST_RETURN == -1) {
-		}
-
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == EFAULT) {
-				tst_resm(TPASS,
-					 "rmdir() - path argument points above the maximum allocated address space failed as expected with errno %d : %s",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL,
-					 "rmdir() - path argument points above the maximum allocated address space failed with errno %d : %s but expected %d (EFAULT)",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO), EFAULT);
-			}
-		} else {
-			tst_resm(TFAIL,
-				 "rmdir() - path argument points above the maximum allocated address space succeeded unexpectedly.");
-		}
-#endif
-
-		/*
-		 * TEST CASE: 6
 		 * able to remove a directory
 		 */
 
@@ -220,13 +186,7 @@ void setup(void)
 	/* Create a unique directory name. */
 	sprintf(dir_name, "./dir_%d", getpid());
 
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-#endif
+	bad_addr = tst_get_bad_addr(cleanup);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index ef3d937..2e4c83a 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -103,7 +103,6 @@ char nobody_uid[] = "nobody";
 struct passwd *ltpuser;
 
 char Longpathname[PATH_MAX + 2];
-char High_address_node[64];
 
 struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	char *pathname;
@@ -111,15 +110,8 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	int exp_errno;
 	int (*setupfunc) ();
 } Test_cases[] = {
-	{
-	TEST_FILE1, "No Search permissions to process", EACCES, setup1},
-#if !defined(UCLINUX)
-	{
-	High_address_node, "Address beyond address space", EFAULT, no_setup},
-	{
-	(char *)-1, "Negative address", EFAULT, no_setup},
-#endif
-	{
+	{TEST_FILE1, "No Search permissions to process", EACCES, setup1}, {
+	NULL, "Invalid address", EFAULT, no_setup}, {
 	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
 	"", "Pathname is empty", ENOENT, no_setup}, {
 	TEST_FILE2, "Path contains regular file", ENOTDIR, setup2}, {
@@ -129,8 +121,6 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
 char *TCID = "stat03";
 int TST_TOTAL = ARRAY_SIZE(Test_cases);
 
-char *bad_addr = 0;
-
 void setup();			/* Main setup function for the tests */
 void cleanup();			/* cleanup function for the test */
 
@@ -158,12 +148,6 @@ int main(int ac, char **av)
 			file_name = Test_cases[ind].pathname;
 			test_desc = Test_cases[ind].desc;
 
-#if !defined(UCLINUX)
-			if (file_name == High_address_node) {
-				file_name = (char *)get_high_address();
-			}
-#endif
-
 			/*
 			 * Call stat(2) to test different test conditions.
 			 * verify that it fails with -1 return value and
@@ -237,17 +221,10 @@ void setup(void)
 	/* Make a temp dir and cd to it */
 	tst_tmpdir();
 
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	Test_cases[2].pathname = bad_addr;
-#endif
-
 	/* call individual setup functions */
 	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
+		if (!Test_cases[ind].pathname)
+			Test_cases[ind].pathname = tst_get_bad_addr(cleanup);
 		Test_cases[ind].setupfunc();
 	}
 }
diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
index 89f23c9..c89fe5d 100644
--- a/testcases/kernel/syscalls/symlink/symlink03.c
+++ b/testcases/kernel/syscalls/symlink/symlink03.c
@@ -103,8 +103,6 @@
 char *TCID = "symlink03";
 int TST_TOTAL = 1;
 
-char *bad_addr = 0;
-
 int no_setup();
 int setup1();			/* setup function to test symlink for EACCES */
 int setup2();			/* setup function to test symlink for EEXIST */
@@ -121,18 +119,11 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	int exp_errno;
 	int (*setupfunc) ();
 } Test_cases[] = {
-	{
-	TEST_FILE1, SYM_FILE1, "No Search permissions to process",
+	{TEST_FILE1, SYM_FILE1, "No Search permissions to process",
 		    EACCES, setup1}, {
 	TEST_FILE2, SYM_FILE2, "Specified symlink already exists",
-		    EEXIST, setup2},
-#if !defined(UCLINUX)
-	{
-	TESTFILE, High_address_node, "Address beyond address space",
-		    EFAULT, no_setup},
-#endif
-	{
-	TESTFILE, (char *)-1, "Negative address", EFAULT, no_setup}, {
+		    EEXIST, setup2}, {
+	TESTFILE, NULL, "Invalid address", EFAULT, no_setup}, {
 	TESTFILE, Longpathname, "Symlink path too long", ENAMETOOLONG,
 		    longpath_setup}, {
 	TESTFILE, "", "Symlink Pathname is empty", ENOENT, no_setup}, {
@@ -171,11 +162,7 @@ int main(int ac, char **av)
 			test_file = Test_cases[ind].file;
 			sym_file = Test_cases[ind].link;
 			test_desc = Test_cases[ind].desc;
-#if !defined(UCLINUX)
-			if (sym_file == High_address_node) {
-				sym_file = (char *)get_high_address();
-			}
-#endif
+
 			/*
 			 * Call symlink(2) to test different test conditions.
 			 * verify that it fails with -1 return value and sets
@@ -241,17 +228,10 @@ void setup(void)
 
 	tst_tmpdir();
 
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	Test_cases[3].link = bad_addr;
-#endif
-
 	/* call individual setup functions */
 	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
+		if (!Test_cases[ind].link)
+			Test_cases[ind].link = tst_get_bad_addr(cleanup);
 		Test_cases[ind].setupfunc();
 	}
 }
diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index 0aa7b3e..401c16a 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -76,10 +76,7 @@ static struct test_case_t {
 } test_cases[] = {
 	{ TEST_FILE1, TRUNC_LEN, EACCES },
 	{ TEST_FILE2, TRUNC_LEN, ENOTDIR },
-#if !defined(UCLINUX)
 	{ NULL, TRUNC_LEN, EFAULT },
-	{ (char *)-1, TRUNC_LEN, EFAULT },
-#endif
 	{ long_pathname, TRUNC_LEN, ENAMETOOLONG },
 	{ "", TRUNC_LEN, ENOENT },
 	{ TEST_DIR1, TRUNC_LEN, EISDIR },
@@ -117,9 +114,9 @@ int main(int ac, char **av)
 void setup(void)
 {
 	struct passwd *ltpuser;
-	char *bad_addr;
 	struct rlimit rlim;
 	sigset_t signalset;
+	int n;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -136,14 +133,6 @@ void setup(void)
 
 	SAFE_TOUCH(cleanup, "t_file", FILE_MODE, NULL);
 
-#if !defined(UCLINUX)
-	test_cases[2].pathname = (char *)get_high_address();
-
-	bad_addr = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	test_cases[3].pathname = bad_addr;
-#endif
-
 	memset(long_pathname, 'a', PATH_MAX + 1);
 
 	SAFE_MKDIR(cleanup, TEST_DIR1, DIR_MODE);
@@ -162,6 +151,12 @@ void setup(void)
 	TEST(sigprocmask(SIG_BLOCK, &signalset, NULL));
 	if (TEST_RETURN != 0)
 		tst_brkm(TBROK | TTERRNO, cleanup, "sigprocmask");
+
+	for (n = 0; n < TST_TOTAL; n++) {
+		if (!test_cases[n].pathname)
+			test_cases[n].pathname = tst_get_bad_addr(cleanup);
+	}
+
 }
 
 void truncate_verify(struct test_case_t *tc)
diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
index 66e4db8..dc18ccf 100644
--- a/testcases/kernel/syscalls/unlink/unlink07.c
+++ b/testcases/kernel/syscalls/unlink/unlink07.c
@@ -123,13 +123,9 @@
 void setup();
 void cleanup();
 
-extern char *get_high_address();
-
 char *TCID = "unlink07";
 int TST_TOTAL = 6;
 
-char *bad_addr = 0;
-
 int longpath_setup();
 int no_setup();
 int filepath_setup();
@@ -146,21 +142,11 @@ struct test_case_t {
 	"nonexistfile", "non-existent file", ENOENT, no_setup}, {
 	"", "path is empty string", ENOENT, no_setup}, {
 	"nefile/file", "path contains a non-existent file",
-		    ENOENT, no_setup},
-#if !defined(UCLINUX)
-	{
-	High_address, "address beyond address space", EFAULT, no_setup},
-#endif
-	{
+		    ENOENT, no_setup}, {
 	"file/file", "path contains a regular file",
-		    ENOTDIR, filepath_setup},
-#if !defined(UCLINUX)
-	{
-	High_address, "address beyond address space", EFAULT, no_setup},
-#endif
-	{
+		    ENOTDIR, filepath_setup}, {
 	Longpathname, "pathname too long", ENAMETOOLONG, longpath_setup}, {
-	(char *)-1, "negative address", EFAULT, no_setup}, {
+	NULL, "invalid address", EFAULT, no_setup}, {
 	NULL, NULL, 0, no_setup}
 };
 
@@ -196,10 +182,6 @@ int main(int ac, char **av)
 			fname = Test_cases[ind].pathname;
 			desc = Test_cases[ind].desc;
 
-#if !defined(UCLINUX)
-			if (fname == High_address)
-				fname = get_high_address();
-#endif
 			/*
 			 *  Call unlink(2)
 			 */
@@ -245,13 +227,9 @@ void setup(void)
 
 	tst_tmpdir();
 
-	bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	Test_cases[7].pathname = bad_addr;
-
 	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
+		if (!Test_cases[ind].pathname)
+			Test_cases[ind].pathname = tst_get_bad_addr(cleanup);
 		Test_cases[ind].setupfunc();
 	}
 
-- 
1.8.3.1



