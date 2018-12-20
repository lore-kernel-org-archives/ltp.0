From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Dec 2018 17:08:10 +0800
Subject: [LTP] [PATCH 1/2] readdir: rewrite readdir02
Message-ID: <20181220090811.21514-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/readdir/readdir02.c | 132 ++++++++------------------
 1 file changed, 42 insertions(+), 90 deletions(-)

diff --git a/testcases/kernel/syscalls/readdir/readdir02.c b/testcases/kernel/syscalls/readdir/readdir02.c
index 3f3151f6a..441c4b431 100644
--- a/testcases/kernel/syscalls/readdir/readdir02.c
+++ b/testcases/kernel/syscalls/readdir/readdir02.c
@@ -1,20 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) Bull S.A. 2001
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) IBM Corp., 2001
+ * Copyright (c) Jacky Malcles. 2002
+ * Copyright (c) Robbie Williamson. 2003
+ * Copyright (c) Linux Test Project. 2018
  */
 
 /*
@@ -23,24 +13,17 @@
  *
  * ALGORITHM
  *      loop if that option was specified
- *      call readdir() with an invalid file descriptor
+ *      call readdir() with an invalid directory stream descriptor
  *      check the errno value
  *        issue a PASS message if we get EBADF - errno 9
  *      otherwise, the tests fails
  *        issue a FAIL message
- *        call cleanup
  *
  * NOTE
  *	The POSIX standard says:
  *	  The readdir() function may fail if:
  *	  [EBADF] The dirp argument does not refer to an open directory stream.
  *	  (Note that readdir() is not _required_ to fail in this case.)
- *
- * HISTORY
- *      04/2002 - Written by Jacky Malcles
- *
- *      06/2003 - Added code to catch SIGSEGV and return TCONF.
- *		Robbie Williamson<robbiew@us.ibm.com>
  */
 
 #include <sys/types.h>
@@ -52,91 +35,60 @@
 #include <string.h>
 #include <signal.h>
 
-#include "test.h"
+#include "tst_test.h"
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "readdir02";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void verify_readdir(void)
 {
-	int lc;
 	DIR *test_dir;
 	struct dirent *dptr;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		if ((test_dir = opendir(".")) == NULL) {
-			tst_resm(TFAIL, "opendir(\".\") Failed, errno=%d : %s",
+	if ((test_dir = opendir(".")) == NULL) {
+		tst_res(TFAIL, "opendir(\".\") Failed, errno=%d : %s",
+			 errno, strerror(errno));
+	} else {
+		if (closedir(test_dir) < 0) {
+			tst_res(TFAIL,
+				 "closedir(\".\") Failed, errno=%d : %s",
 				 errno, strerror(errno));
 		} else {
-			if (closedir(test_dir) < 0) {
-				tst_resm(TFAIL,
-					 "closedir(\".\") Failed, errno=%d : %s",
+			dptr = readdir(test_dir);
+			switch (errno) {
+			case EBADF:
+				tst_res(TPASS,
+					 "expected failure - errno = %d : %s",
 					 errno, strerror(errno));
-			} else {
-				dptr = readdir(test_dir);
-				switch (errno) {
-				case EBADF:
-					tst_resm(TPASS,
-						 "expected failure - errno = %d : %s",
-						 errno, strerror(errno));
-					break;
-				default:
-					if (dptr != NULL) {
-						tst_brkm(TFAIL, cleanup,
-							 "call failed with an "
-							 "unexpected error - %d : %s",
-							 errno,
-							 strerror(errno));
-					} else {
-						tst_resm(TINFO,
-							 "readdir() is not _required_ to fail, "
-							 "errno = %d  ", errno);
-					}
+				break;
+			default:
+				if (dptr != NULL) {
+					tst_brk(TFAIL,
+						 "call failed with an "
+						 "unexpected error - %d : %s",
+						 errno,
+						 strerror(errno));
+				} else {
+					tst_res(TINFO,
+						 "readdir() is not _required_ to fail, "
+						 "errno = %d  ", errno);
 				}
 			}
-
 		}
-
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-static void sigsegv_handler(int sig)
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	tst_resm(TCONF,
-		 "This system's implementation of closedir() will not allow this test to execute properly.");
-	cleanup();
+	tst_res(TCONF,
+		 "This system's implementation of closedir() "
+		 "will not allow this test to execute properly.");
 }
 
 static void setup(void)
 {
-	struct sigaction act;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	act.sa_handler = sigsegv_handler;
-	act.sa_flags = 0;
-	sigemptyset(&act.sa_mask);
-	sigaction(SIGSEGV, &act, NULL);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	SAFE_SIGNAL(SIGSEGV, sighandler);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = verify_readdir,
+};
-- 
2.14.5

