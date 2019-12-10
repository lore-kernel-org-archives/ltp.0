From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Tue, 10 Dec 2019 16:14:18 -0500
Subject: [LTP] [PATCH 3/3] syscalls/llseek02: convert to new library and add
 SEEK_SET test
In-Reply-To: <1576012458-31108-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1576012458-31108-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <1576012458-31108-3-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 testcases/kernel/syscalls/llseek/llseek03.c | 161 +++++++++++++---------------
 1 file changed, 73 insertions(+), 88 deletions(-)

diff --git a/testcases/kernel/syscalls/llseek/llseek03.c b/testcases/kernel/syscalls/llseek/llseek03.c
index 4c08a8e..4c60fe4 100644
--- a/testcases/kernel/syscalls/llseek/llseek03.c
+++ b/testcases/kernel/syscalls/llseek/llseek03.c
@@ -1,104 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
- *
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
  */
-
 /*
  * Description:
  * Verify that,
- *    1. llseek() succeeds to set the file pointer position to the current
+ *    1. llseek() succeeds to set the file pointer position to the first of
+ *  the file when 'whence' value is set to SEEK_SET and the data read form
+ *  the SEEK_SET should match the expexted data.
+ *    2. llseek() succeeds to set the file pointer position to the current
  *  specified location, when 'whence' value is set to SEEK_CUR and the data
  *  read from the specified location should match the expected data.
- *    2. llseek() succeeds to set the file pointer position to the end of
+ *    3. llseek() succeeds to set the file pointer position to the end of
  *  the file when 'whence' value set to SEEK_END and any attempts to read
  *  from that position should return 0.
- *
  */
-
 #define _GNU_SOURCE
 
-#include <unistd.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <utime.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/resource.h>
-#include <sys/stat.h>
-#include <sys/types.h>
 #include <inttypes.h>
+#include <stdio.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define TEST_FILE "testfile"
+#define STR "abcdefgh"
 
-static void setup(void);
-static void cleanup(void);
-
+static void testfunc_seekset(void);
 static void testfunc_seekcur(void);
 static void testfunc_seekend(void);
 
-static void (*testfunc[])(void) = { testfunc_seekcur, testfunc_seekend };
-
-char *TCID = "llseek03";
-int TST_TOTAL = 2;
+static void (*testfunc[])(void) = {testfunc_seekset, testfunc_seekcur, testfunc_seekend};
 
 static size_t file_size;
 
-int main(int ac, char **av)
+static void verify_llseek(unsigned int n)
 {
-	int i, lc;
+	(*testfunc[n])();
+}
 
-	tst_parse_opts(ac, av, NULL, NULL);
+static void setup(void)
+{
+	int fd;
+	struct stat stat_buf;
 
-	setup();
+	fd = SAFE_CREAT(TEST_FILE, 0644);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	SAFE_WRITE(1, fd, STR, sizeof(STR) - 1);
 
-		for (i = 0; i < TST_TOTAL; i++)
-			(*testfunc[i])();
-	}
+	SAFE_FSTAT(fd, &stat_buf);
+
+	SAFE_CLOSE(fd);
 
-	cleanup();
-	tst_exit();
+	file_size = stat_buf.st_size;
 }
 
-static void setup(void)
+static void testfunc_seekset(void)
 {
 	int fd;
-	struct stat stat_buf;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
+	static char read_buf[BUFSIZ];
 
-	TEST_PAUSE;
+	fd = SAFE_OPEN(TEST_FILE,O_RDONLY);
 
-	fd = SAFE_CREAT(cleanup, TEST_FILE, 0644);
+	SAFE_READ(1, fd, read_buf, 4);
+	
+	TEST(lseek64(fd, 1, SEEK_SET));
+	
+	if (TST_RET == -1) {
+                tst_res(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
+                goto cleanup_seekcur;
+        }
 
-	#define STR "abcdefgh"
-	SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);
+        if (TST_RET != 1) {
+                tst_res(TFAIL, "llseek return a incorrect file offset");
+                goto cleanup_seekcur;
+        }
+        memset(read_buf, 0, sizeof(read_buf));
 
-	SAFE_FSTAT(cleanup, fd, &stat_buf);
+        SAFE_READ(0, fd, read_buf, 3);
 
-	SAFE_CLOSE(cleanup, fd);
+        if (strcmp(read_buf, "bcd"))
+                tst_res(TFAIL, "Read wrong bytes after llseek");
+        else
+                tst_res(TPASS, "test SEEK_SET for llseek success");
 
-	file_size = stat_buf.st_size;
+cleanup_seekcur:
+        SAFE_CLOSE(fd);
 }
 
 static void testfunc_seekcur(void)
@@ -106,73 +93,71 @@ static void testfunc_seekcur(void)
 	int fd;
 	static char read_buf[BUFSIZ];
 
-	/* reopen TEST_FILE and file offset will be 0 */
-	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
+	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
 
-	/* after read, file offset will be 4 */
-	SAFE_READ(cleanup, 1, fd, read_buf, 4);
+	SAFE_READ(1, fd, read_buf, 4);
 
 	TEST(lseek64(fd, (loff_t) 1, SEEK_CUR));
 
-	if (TEST_RETURN == (loff_t) -1) {
-		tst_resm(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
 		goto cleanup_seekcur;
 	}
 
-	if (TEST_RETURN != 5) {
-		tst_resm(TFAIL, "llseek return a incorrect file offset");
+	if (TST_RET != 5) {
+		tst_res(TFAIL, "llseek return a incorrect file offset");
 		goto cleanup_seekcur;
 	}
 
 	memset(read_buf, 0, sizeof(read_buf));
 
-	/* the expected characters are "fgh" */
-	SAFE_READ(cleanup, 1, fd, read_buf, 3);
+	SAFE_READ(1, fd, read_buf, 3);
 
 	if (strcmp(read_buf, "fgh"))
-		tst_resm(TFAIL, "Read wrong bytes after llseek");
+		tst_res(TFAIL, "Read wrong bytes after llseek");
 	else
-		tst_resm(TPASS, "test SEEK_SET for llseek success");
+		tst_res(TPASS, "test SEEK_CUR for llseek success");
 
 cleanup_seekcur:
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 }
 
-
 static void testfunc_seekend(void)
 {
 	int fd;
 	ssize_t nread;
 	static char read_buf[BUFSIZ];
 
-	/* reopen TEST_FILE and file offset will be 0 */
-	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
+	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
 
 	TEST(lseek64(fd, (loff_t) 0, SEEK_END));
 
-	if (TEST_RETURN == (loff_t) -1) {
-		tst_resm(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
 		goto cleanup_seekend;
 	}
 
-	if (TEST_RETURN != (long)file_size) {
-		tst_resm(TFAIL, "llseek return a incorrect file offset");
+	if (TST_RET != (long)file_size) {
+		tst_res(TFAIL, "llseek return a incorrect file offset");
 		goto cleanup_seekend;
 	}
 
 	memset(read_buf, 0, sizeof(read_buf));
 
-	nread = SAFE_READ(cleanup, 0, fd, read_buf, file_size);
+	nread = SAFE_READ(0, fd, read_buf, file_size);
 	if (nread > 0)
-		tst_resm(TFAIL, "Read bytes after llseek to end of file");
+		tst_res(TFAIL, "Read bytes after llseek to end of file");
 	else
-		tst_resm(TPASS, "test SEEK_END for llseek success");
+		tst_res(TPASS, "test SEEK_END for llseek success");
 
 cleanup_seekend:
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test = verify_llseek,
+	.tcnt = ARRAY_SIZE(testfunc),
+};
-- 
1.8.3.1



