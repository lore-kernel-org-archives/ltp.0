From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 29 Jul 2019 09:27:32 +0800
Subject: [LTP] [PATCH 2/2] syscalls/nanosleep04: Ported into new library
In-Reply-To: <1564363652-3975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1564363652-3975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1564363652-3975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also add EINVAL test when tv_nsec is negative.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/nanosleep/nanosleep04.c   | 69 +++++--------------
 1 file changed, 17 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep04.c b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
index f5108d026..572738c96 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep04.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
@@ -1,20 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *  07/2001 Ported by Wayne Boyer
  *
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
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Ported to new library:
+ * 07/2019    Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  */
 
 /*
@@ -27,60 +17,35 @@
  */
 
 #include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/wait.h>
 #include <time.h>
-
-#include "test.h"
+#include "tst_test.h"
 
 static struct timespec tcases[] = {
 	{.tv_sec = -5, .tv_nsec = 9999},
 	{.tv_sec = 0, .tv_nsec = 1000000000},
+	{.tv_sec = 1, .tv_nsec = -100},
 };
 
-char *TCID = "nanosleep04";
-int TST_TOTAL = ARRAY_SIZE(tcases);
-
-static void setup(void);
-
-static void verify_nanosleep(struct timespec *tcase)
+static void verify_nanosleep(unsigned int n)
 {
-	TEST(nanosleep(tcase, NULL));
+	TEST(nanosleep(&tcases[n], NULL));
 
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "nanosleep() succeded unexpectedly");
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "nanosleep() succeded unexpectedly");
 		return;
 	}
 
-	if (TEST_ERRNO != EINVAL) {
-		tst_resm(TFAIL | TTERRNO,
-		         "nanosleep() expected failure with EINVAL");
+	if (TST_ERR != EINVAL) {
+		tst_res(TFAIL | TTERRNO,
+			"nanosleep() failed,expected EINVAL, got");
 		return;
 	}
 
-	tst_resm(TPASS, "nanoslep() failed with EINVAL");
-}
-
-int main(int ac, char **av)
-{
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_nanosleep(&tcases[i]);
-	}
-
-	tst_exit();
+	tst_res(TPASS, "nanosleep() failed with EINVAL");
 }
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, NULL);
+static struct tst_test test = {
+	.test = verify_nanosleep,
+	.tcnt = ARRAY_SIZE(tcases),
+};
 
-	TEST_PAUSE;
-}
-- 
2.18.1



