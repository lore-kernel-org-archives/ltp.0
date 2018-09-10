From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 10 Sep 2018 16:18:57 +0200
Subject: [LTP] [PATCH v2 1/5] setregid01: Convert to newlib
Message-ID: <20180910141901.20541-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compared to previous patchset, change tst_brk() to tst_res() as it
was in the original tests.

Store testcases in array and use newlib to iterate over this.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 testcases/kernel/syscalls/setregid/setregid01.c | 171 +++++-------------------
 1 file changed, 36 insertions(+), 135 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid01.c b/testcases/kernel/syscalls/setregid/setregid01.c
index 57a38eb62..f2e41e134 100644
--- a/testcases/kernel/syscalls/setregid/setregid01.c
+++ b/testcases/kernel/syscalls/setregid/setregid01.c
@@ -1,25 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *
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
  * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
  * Mountain View, CA  94043, or:
  *
@@ -37,128 +19,47 @@
  * Testcase to test the basic functionality of setregid(2) systemm call.
  */
 
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-
-#include "test.h"
-#include "compat_16.h"
-
-static void setup(void);
-
-TCID_DEFINE(setregid01);
-int TST_TOTAL = 5;
-
-static gid_t gid, egid;	/* current real and effective group id */
-
-int main(int ac, char **av)
+#include "tst_test.h"
+#include "compat_tst_16.h"
+
+static gid_t gid, egid;	    /* current real and effective group id */
+static gid_t neg_one = -1;
+
+static struct tcase {
+	gid_t *arg1;
+	gid_t *arg2;
+	const char *msg;
+} tcases[] = {
+	{&neg_one, &neg_one, "Dont change either real or effective gid" },
+	{&neg_one, &egid,    "Change effective to effective gid" },
+	{&gid,     &neg_one, "Change real to real gid" },
+	{&neg_one, &gid,     "Change effective to real gid" },
+	{&gid,     &gid,     "Try to change real to current real" }
+};
+
+static void run(unsigned int n)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * TEST CASE:
-		 *  Dont change either real or effective gid
-		 */
-		gid = getgid();
-		GID16_CHECK(gid, setregid, NULL);
-
-		egid = getegid();
-		GID16_CHECK(egid, setregid, NULL);
+	struct tcase *tc = &tcases[n];
 
-		TEST(SETREGID(NULL, -1, -1));
+	TEST(SETREGID(*tc->arg1, *tc->arg2));
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setregid -  Dont change either real or effective gid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setregid -  Dont change either real or effective gid returned %ld",
-				 TEST_RETURN);
-		}
-
-		/*
-		 * TEST CASE:
-		 *  change effective to effective gid
-		 */
-
-		TEST(SETREGID(NULL, -1, egid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setregid -  change effective to effective gid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setregid -  change effective to effective gid returned %ld",
-				 TEST_RETURN);
-		}
-
-		/*
-		 * TEST CASE:
-		 *  change real to real gid
-		 */
-
-		TEST(SETREGID(NULL, gid, -1));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setregid -  change real to real gid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setregid -  change real to real gid returned %ld",
-				 TEST_RETURN);
-		}
-
-		/*
-		 * TEST CASE:
-		 *  change effective to real gid
-		 */
-
-		TEST(SETREGID(NULL, -1, gid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setregid -  change effective to real gid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setregid -  change effective to real gid returned %ld",
-				 TEST_RETURN);
-		}
-
-		/*
-		 * TEST CASE:
-		 *  try to change real to current real
-		 */
-
-		TEST(SETREGID(NULL, gid, gid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "setregid failed");
-		} else {
-			tst_resm(TPASS, "setregid return %ld",
-				 TEST_RETURN);
-		}
-
-	}
-
-	tst_exit();
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, tc->msg);
+	else
+		tst_res(TPASS, tc->msg);
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, NULL);
+	gid = getgid();
+	GID16_CHECK(gid, setregid);
 
-	TEST_PAUSE;
+	egid = getegid();
+	GID16_CHECK(egid, setregid);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+};
-- 
2.16.4

