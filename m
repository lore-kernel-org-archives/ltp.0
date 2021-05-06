From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 6 May 2021 21:09:48 +0800
Subject: [LTP] [PATCH 1/3] syscalls/fchown: Convert fchown01 to the new API
In-Reply-To: <20210506130950.110267-1-xieziyao@huawei.com>
References: <20210506130950.110267-1-xieziyao@huawei.com>
Message-ID: <20210506130950.110267-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cleanup and convert fchown01 to the new API.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/fchown/fchown01.c | 110 ++++++--------------
 1 file changed, 30 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/syscalls/fchown/fchown01.c b/testcases/kernel/syscalls/fchown/fchown01.c
index 23cc78787..32fc53d6c 100644
--- a/testcases/kernel/syscalls/fchown/fchown01.c
+++ b/testcases/kernel/syscalls/fchown/fchown01.c
@@ -1,100 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *    AUTHOR		: William Roske
- *    CO-PILOT		: Dave Fenner
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
+ * AUTHOR: William Roske
+ * CO-PILOT: Dave Fenner
+ */
+
+/*\
+ * [Description]
  *
+ * Basic test for fchown(). Call fchown() on a fd and expect it to pass.
  */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>

-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/types.h>

-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
+#include "compat_tst_16.h"

-TCID_DEFINE(fchown01);
-int TST_TOTAL = 1;
+#define FILENAME "fchown01_testfile"
+#define MODE 0700

 static int fd;
+static int uid, gid;

-int main(int ac, char **av)
+static void run(void)
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
-		UID16_CHECK(geteuid(), "fchown", cleanup)
-		GID16_CHECK(getegid(), "fchown", cleanup)
-
-		TEST(FCHOWN(cleanup, fd, geteuid(), getegid()));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "fchown failed");
-		} else {
-			tst_resm(TPASS,
-				 "fchown(fd, geteuid(), getegid()) "
-				 "returned %ld", TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS(FCHOWN(fd, uid, gid));
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-	fd = SAFE_OPEN(cleanup, "tempfile", O_RDWR | O_CREAT, 0700);
+	UID16_CHECK(uid = geteuid(), "fchown");
+	GID16_CHECK(gid = getegid(), "fchown");
+	fd = SAFE_OPEN(FILENAME, O_RDWR | O_CREAT, MODE);
 }

 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_resm(TWARN | TERRNO, "Failed to close fd");
-
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
--
2.17.1

