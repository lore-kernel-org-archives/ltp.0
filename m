From: Steve Muckle <smuckle@google.com>
Date: Mon, 28 Jan 2019 18:37:14 -0800
Subject: [LTP] [PATCH] syscalls/ustat: convert to new lib, use direct syscall
Message-ID: <20190129023714.191820-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use direct syscall to expand test compatibility to Android.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 include/lapi/ustat.h                      |  8 ++
 testcases/kernel/syscalls/ustat/ustat01.c | 84 +++++----------------
 testcases/kernel/syscalls/ustat/ustat02.c | 92 +++++------------------
 3 files changed, 45 insertions(+), 139 deletions(-)
 create mode 100644 include/lapi/ustat.h

diff --git a/include/lapi/ustat.h b/include/lapi/ustat.h
new file mode 100644
index 000000000..bcc4e83eb
--- /dev/null
+++ b/include/lapi/ustat.h
@@ -0,0 +1,8 @@
+#include <sys/types.h>
+
+struct ustat {
+	daddr_t f_tfree;
+	ino_t f_tinode;
+	char f_fname[6];
+	char f_fpack[6];
+};
diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 31d7f86dc..3f1186c49 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-
-/*
  * Check that ustat() succeeds given correct parameters.
  */
 
@@ -24,71 +10,35 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
-#include "config.h"
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "ustat01";
-
-#ifdef HAVE_USTAT
-# ifdef HAVE_SYS_USTAT_H
-#  include <sys/ustat.h>
-# endif
-
-static void setup(void);
-
-int TST_TOTAL = 1;
+#include "lapi/syscalls.h"
+#include "lapi/ustat.h"
+#include "tst_test.h"
 
 static dev_t dev_num;
-static struct ustat ubuf;
 
-int main(int argc, char *argv[])
+void run(void)
 {
-	int lc, i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+	struct ustat ubuf;
 
-	setup();
+	TEST(tst_syscall(__NR_ustat, dev_num, &ubuf));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(ustat(dev_num, &ubuf));
-
-			if (TEST_RETURN == -1 && TEST_ERRNO == ENOSYS)
-				tst_brkm(TCONF, NULL, "ustat not supported");
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "ustat(2) failed and set"
-					 "the errno to %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TPASS, "ustat(2) passed");
-			}
-		}
-	}
-
-	tst_exit();
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "ustat(2) failed");
+	else
+		tst_res(TPASS, "ustat(2) passed");
 }
 
 static void setup(void)
 {
 	struct stat buf;
 
-	tst_sig(NOFORK, DEF_HANDLER, NULL);
-
-	TEST_PAUSE;
-
 	/* Find a valid device number */
-	SAFE_STAT(NULL, "/", &buf);
+	SAFE_STAT("/", &buf);
 
 	dev_num = buf.st_dev;
 }
-#else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have ustat() support");
-}
-#endif
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index fe644f9a9..9bbe4f3f5 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-
-/*
  * Test whether ustat(2) system call returns appropriate error number for
  * invalid dev_t parameter and for bad address paramater.
  */
@@ -25,18 +11,9 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
-#include "config.h"
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "ustat02";
-
-#ifdef HAVE_USTAT
-# ifdef HAVE_SYS_USTAT_H
-#  include <sys/ustat.h>
-# endif
-
-static void setup(void);
+#include "lapi/syscalls.h"
+#include "lapi/ustat.h"
+#include "tst_test.h"
 
 static dev_t invalid_dev = -1;
 static dev_t root_dev;
@@ -57,59 +34,30 @@ static struct test_case_t {
 
 int TST_TOTAL = ARRAY_SIZE(tc);
 
-int main(int ac, char **av)
+void run(unsigned int test)
 {
-
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(ustat(*tc[i].dev, tc[i].buf));
-
-			if (TEST_RETURN == -1 && TEST_ERRNO == ENOSYS)
-				tst_brkm(TCONF, NULL, "ustat not supported");
-
-			if ((TEST_RETURN == -1)
-			    && (TEST_ERRNO == tc[i].exp_errno)) {
-				tst_resm(TPASS,
-					 "ustat(2) expected failure;"
-					 " Got errno - %s : %s",
-					 tc[i].exp_errval, tc[i].err_desc);
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-				         "ustat(2) failed to produce"
-					 " expected error; %d, errno"
-					 ": %s",
-					 tc[i].exp_errno, tc[i].exp_errval);
-			}
-		}
-	}
-
-	tst_exit();
+	TEST(tst_syscall(__NR_ustat, *tc[test].dev, tc[test].buf));
+
+	if ((TST_RET == -1) && (TST_ERR == tc[test].exp_errno))
+		tst_res(TPASS | TTERRNO, "ustat(2) expected failure");
+	else
+		tst_res(TFAIL | TTERRNO,
+			"ustat(2) failed to produce expected error; %d, errno"
+			": %s", tc[test].exp_errno, tc[test].exp_errval);
 }
 
 static void setup(void)
 {
 	struct stat buf;
 
-	tst_sig(NOFORK, DEF_HANDLER, NULL);
-
-	TEST_PAUSE;
-
 	/* Find a valid device number */
-	SAFE_STAT(NULL, "/", &buf);
+	SAFE_STAT("/", &buf);
 
 	root_dev = buf.st_dev;
 }
-#else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have ustat() support");
-}
-#endif
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tc),
+};
-- 
2.20.1.495.gaa96b0ce6b-goog

