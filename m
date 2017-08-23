From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 23 Aug 2017 19:00:31 +0800
Subject: [LTP] [PATCH 1/2] syscalls/keyctl01: Convert to the new library &&
	Cleanup
Message-ID: <20170823110032.1795-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/keyctl/keyctl01.c | 150 ++++++++++------------------
 1 file changed, 50 insertions(+), 100 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 6af8001..30d51bd 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -1,121 +1,71 @@
-/******************************************************************************
- * Copyright (c) Crackerjack Project., 2007				      *
- *									      *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or	      *
- * (at your option) any later version.					      *
- *									      *
- * This program is distributed in the hope that it will be useful,	      *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of	      *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		      *
- * the GNU General Public License for more details.			      *
- *									      *
- * You should have received a copy of the GNU General Public License	      *
- * along with this program;  if not, write to the Free Software Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *                                                                            *
- ******************************************************************************/
+/*
+ * Copyright (c) Crackerjack Project., 2007
+ * Copyright (c) 2017 Fujitsu Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
 /*
  * Description: This tests the keyctl() syscall
  *		Manipulate the kernel's key management facility
  *
- * History:     Porting from Crackerjack to LTP is done by
- *	      Manas Kumar Nayak maknayak@in.ibm.com>
+ * Ported by Manas Kumar Nayak maknayak@in.ibm.com>
+ * Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */
 
-#include "config.h"
-#include <sys/types.h>
 #include <errno.h>
-#include <limits.h>
-#include <stdio.h>
 #include <stdint.h>
-#ifdef HAVE_LINUX_KEYCTL_H
-# include <linux/keyctl.h>
-#endif
 
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "lapi/keyctl.h"
 
-char *TCID = "keyctl01";
-int testno;
-int TST_TOTAL = 2;
-
-#ifdef HAVE_LINUX_KEYCTL_H
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-}
+typedef int32_t key_serial_t;
 
-int main(int ac, char **av)
+static void do_test(void)
 {
-	int ret;
-	int lc;
-	int32_t ne_key;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (testno = 1; testno < TST_TOTAL; ++testno) {
+	key_serial_t key;
 
-			/* Call keyctl() and ask for a keyring's ID. */
-			ret = ltp_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
-				      KEY_SPEC_USER_SESSION_KEYRING);
-			if (ret != -1) {
-				tst_resm(TPASS,
-					 "KEYCTL_GET_KEYRING_ID succeeded");
-			} else {
-				tst_resm(TFAIL | TERRNO,
-					 "KEYCTL_GET_KEYRING_ID");
-			}
+	TEST(tst_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
+		KEY_SPEC_USER_SESSION_KEYRING));
 
-			for (ne_key = INT32_MAX; ne_key > INT32_MIN; ne_key--) {
-				ret = ltp_syscall(__NR_keyctl, KEYCTL_READ,
-					ne_key);
-				if (ret == -1 && errno == ENOKEY)
-					break;
-			}
+	if (TEST_RETURN != -1)
+		tst_res(TPASS, "KEYCTL_GET_KEYRING_ID succeeded");
+	else
+		tst_res(TFAIL | TTERRNO, "KEYCTL_GET_KEYRING_ID failed");
 
-			/* Call keyctl. */
-			ret = ltp_syscall(__NR_keyctl, KEYCTL_REVOKE, ne_key);
-			if (ret != -1) {
-				tst_resm(TFAIL | TERRNO,
-					 "KEYCTL_REVOKE succeeded unexpectedly");
-			} else {
-				/* Check for the correct error num. */
-				if (errno == ENOKEY) {
-					tst_resm(TPASS | TERRNO,
-						 "KEYCTL_REVOKE got expected "
-						 "errno");
-				} else {
-					tst_resm(TFAIL | TERRNO,
-						 "KEYCTL_REVOKE got unexpected "
-						 "errno");
-				}
+	for (key = INT32_MAX; key > INT32_MIN; key--) {
+		TEST(tst_syscall(__NR_keyctl, KEYCTL_READ, key));
+		if (TEST_RETURN == -1 && TEST_ERRNO == ENOKEY)
+			break;
+	}
 
-			}
+	TEST(tst_syscall(__NR_keyctl, KEYCTL_REVOKE, key));
 
-		}
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "KEYCTL_REVOKE succeeded unexpectedly");
+		return;
+	}
 
+	if (TEST_ERRNO != ENOKEY) {
+		tst_res(TFAIL | TTERRNO, "KEYCTL_REVOKE failed unexpectedly");
+		return;
 	}
-	cleanup();
-	tst_exit();
-}
-#else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "keyctl syscall support not available on system");
+
+	tst_res(TPASS | TTERRNO, "KEYCTL_REVOKE failed as expected");
 }
-#endif /* HAVE_LINUX_KEYCTL_H */
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.9.4



