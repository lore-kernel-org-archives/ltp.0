From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 6 Feb 2020 14:04:32 +0800
Subject: [LTP] [PATCH v3 1/2] syscalls/fcntl30: clean up && add more range
 test
In-Reply-To: <20200127162016.GD30831@rei.lan>
References: <20200127162016.GD30831@rei.lan>
Message-ID: <1580969073-27367-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When I write pipe12 test case, I have a question
about F_SETPIPE_SZ can set the min and max value.
So cleanup this case and add min/max/gt_max value test.

--------
v2->v3:
1. remove memfree check
2. move size compution into setup and add size check under unprivileged user
3. fix other things pointed by Cyril
--------

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/capability.h                 |   4 +
 testcases/kernel/syscalls/fcntl/fcntl30.c | 223 ++++++++++++++--------
 2 files changed, 147 insertions(+), 80 deletions(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 8833f0605..7ade78985 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -28,6 +28,10 @@
 # define CAP_SYS_ADMIN        21
 #endif
 
+#ifndef CAP_SYS_RESOURCE
+# define CAP_SYS_RESOURCE     24
+#endif
+
 #ifndef CAP_AUDIT_READ
 # define CAP_AUDIT_READ       37
 #endif
diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
index 4a409b868..860d42e8d 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl30.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
@@ -1,111 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2014 Fujitsu Ltd.
+ * Copyright (c) 2014-2020 FUJITSU LIMITED. All rights reserved.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
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
- */
-
-/*
  * Description:
- * Verify that,
- *     Basic test for fcntl(2) using F_SETPIPE_SZ, F_GETPIPE_SZ argument.
+ * Basic test for fcntl(2) using F_SETPIPE_SZ, F_GETPIPE_SZ argument.
  */
 
-
-#include <stdio.h>
-#include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <string.h>
-#include <signal.h>
 #include <sys/types.h>
 #include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/fcntl.h"
-
-char *TCID = "fcntl30";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+#include "lapi/abisize.h"
+#include "lapi/capability.h"
+
+static int fds[2];
+static unsigned int shift;
+static struct passwd *pw;
+
+static struct tcase {
+	unsigned int setsize;
+	unsigned int expsize;
+	unsigned int root_user;
+	int pass_flag;
+	char *message;
+} tcases[] = {
+	{0, 0, 0, 1, "set a value of below page size"},
+	{0, 0, 0, 1, "set a normal value"},
+	{0, 0, 1, 1, "set a value of below page size"},
+	{0, 0, 1, 1, "set a normal value"},
+	{0, 0, 1, 1, "set a max value"},
+	{0, 0, 1, 0, "set a value beyond max"},
+};
+
+static void verify_fcntl(unsigned int n)
 {
-	int lc;
-	int pipe_fds[2], test_fd;
-	int orig_pipe_size, new_pipe_size;
-
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	struct tcase *tc = &tcases[n];
 
-		SAFE_PIPE(cleanup, pipe_fds);
-		test_fd = pipe_fds[1];
+	tst_res(TINFO, "%s, size is %u", tc->message, tc->setsize);
 
-		TEST(fcntl(test_fd, F_GETPIPE_SZ));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "fcntl get pipe size failed");
+	TEST(fcntl(fds[1], F_SETPIPE_SZ, tc->setsize));
+	if (tc->pass_flag) {
+		if (TST_RET == -1) {
+			tst_res(TFAIL | TTERRNO, "F_SETPIPE_SZ failed");
+			return;
 		}
-
-		orig_pipe_size = TEST_RETURN;
-		new_pipe_size = orig_pipe_size * 2;
-		TEST(fcntl(test_fd, F_SETPIPE_SZ, new_pipe_size));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "fcntl test F_SETPIPE_SZ failed");
+		tst_res(TPASS, "F_SETPIPE_SZ succeed as expected");
+	} else {
+		if (TST_RET == -1) {
+			if ((TST_ERR == ENOMEM && shift < 31) ||
+				(TST_ERR == EINVAL && shift == 31))
+				tst_res(TPASS | TTERRNO, "F_SETPIPE_SZ failed");
+			else
+				tst_res(TFAIL | TTERRNO,
+					"F_SETPIPE_SZ failed with unexpected error");
+			return;
 		}
+		tst_res(TFAIL, "F_SETPIPE_SZ succeed unexpectedly");
+	}
 
-		TEST(fcntl(test_fd, F_GETPIPE_SZ));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "fcntl test F_GETPIPE_SZ failed");
-		}
-		tst_resm(TINFO, "orig_pipe_size: %d new_pipe_size: %d",
-			 orig_pipe_size, new_pipe_size);
-		if (TEST_RETURN >= new_pipe_size) {
-			tst_resm(TPASS, "fcntl test F_GETPIPE_SZ"
-				 "and F_SETPIPE_SZ success");
-		} else {
-			tst_resm(TFAIL, "fcntl test F_GETPIPE_SZ"
-				 "and F_SETPIPE_SZ fail");
-		}
-		SAFE_CLOSE(cleanup, pipe_fds[0]);
-		SAFE_CLOSE(cleanup, pipe_fds[1]);
+	TEST(fcntl(fds[1], F_GETPIPE_SZ));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "F_GETPIPE_SZ failed");
+		return;
 	}
+	if ((unsigned int)TST_RET == tc->expsize)
+		tst_res(TPASS, "F_SETPIPE_SZ %u bytes F_GETPIPE_SZ %u bytes",
+			tc->setsize, (unsigned int)TST_RET);
+	else
+		tst_res(TFAIL, "F_SETPIPE_SZ %u bytes but F_GETPIPE_SZ %u bytes",
+			tc->setsize, (unsigned int)TST_RET);
+}
 
-	cleanup();
-	tst_exit();
+static void do_test(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (!SAFE_FORK()) {
+		if (!tc->root_user) {
+			SAFE_SETUID(pw->pw_uid);
+			tst_res(TINFO, "under an unprivileged user");
+		} else
+			tst_res(TINFO, "under a privileged user");
+		verify_fcntl(n);
+	}
+	tst_reap_children();
 }
 
 static void setup(void)
 {
-	if ((tst_kvercmp(2, 6, 35)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels"
-			 "that are 2.6.35 and higher");
+	unsigned int pg_size, struct_shift, max_shift, pg_shift = 0;
+
+	SAFE_PIPE(fds);
+	TEST(fcntl(fds[1], F_GETPIPE_SZ));
+	if (TST_ERR == EINVAL)
+		tst_brk(TCONF, "kernel doesn't support F_GET/SETPIPE_SZ");
+
+	/*
+	 * See kernel fs/pipe.c, the size of struct pipe buffer is 40 bytes
+	 * (round up 2^6) on 64bit system and 24 bytes(round up 2^5). kcalloc
+	 * mallocs a memory space range stores struct pipe buffer. kcalloc can
+	 * malloc max space depend on KMALLOC_SHIFT_MAX macro.
+	 *  #define KMALLOC_SHIFT_MAX  (MAX_ORDER + PAGE_SHIFT - 1)
+	 * the MAX_ORDER is 11.
+	 * For example, if page size is 4k, on 64bit system. the max pipe size
+	 * as below:
+	 *  kcalloc space(4M): 1 << (11+12-1)= 2^22
+	 *  space can store struct pipi buffer: 2^22/2^6= 2^16
+	 *  max pipe size: 2^16* 2^12 = 2^28
+	 * it should be 256M. On 32bit system, this value is 512M.
+	 */
+#ifdef TST_ABI64
+	struct_shift = 6;
+#else
+	struct_shift = 5;
+#endif
+	max_shift = 10;
+
+	pg_size = getpagesize();
+	tst_res(TINFO, "page size is %d bytes", pg_size);
+	while (pg_size >>= 1)
+		pg_shift++;
+
+	shift = max_shift - struct_shift + 2 * pg_shift;
+
+	/*
+	 * On 64k page size machine, this will beyond 2G and trigger EINVAL error,
+	 * so truncate it.
+	 */
+	if (shift > 31) {
+		tst_res(TINFO, "pipe size truncated into 2G");
+		shift = 31;
 	}
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tcases[0].setsize = (1 << pg_shift) - 1;
+	tcases[0].expsize = 1 << pg_shift;
 
-	TEST_PAUSE;
+	tcases[1].setsize = 2 << pg_shift;
+	tcases[1].expsize = 2 << pg_shift;
+
+	tcases[2].setsize = (1 << pg_shift) - 1;
+	tcases[2].expsize = 1 << pg_shift;
+
+	tcases[3].setsize = 2 << pg_shift;
+	tcases[3].expsize = 2 << pg_shift;
+
+	tcases[4].setsize = 1 << shift;
+	tcases[4].expsize = 1 << shift;
+
+	tcases[5].setsize = (1 << shift) + 1;
+
+	pw = SAFE_GETPWNAM("nobody");
 }
 
 static void cleanup(void)
 {
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = do_test,
+	.forks_child = 1,
+	.needs_root = 1,
+};
-- 
2.18.0



