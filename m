From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 13 Mar 2020 16:36:30 +0100
Subject: [LTP] [PATCH 1/2] Port readv01 to new LTP library
Message-ID: <20200313153631.751-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/readv/readv01.c | 110 ++++++++--------------
 1 file changed, 38 insertions(+), 72 deletions(-)

diff --git a/testcases/kernel/syscalls/readv/readv01.c b/testcases/kernel/syscalls/readv/readv01.c
index 82fec39e1..ad0ab187b 100644
--- a/testcases/kernel/syscalls/readv/readv01.c
+++ b/testcases/kernel/syscalls/readv/readv01.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *   07/2001 Ported by Wayne Boyer
- *
  * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
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
  */
 
 /*
@@ -31,16 +17,11 @@
 #include <sys/uio.h>
 #include <fcntl.h>
 #include <memory.h>
-#include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define	CHUNK		64
 
-char *TCID = "readv01";
-int TST_TOTAL = 1;
-
 static char buf[CHUNK];
 
 static struct iovec rd_iovec[] = {
@@ -51,74 +32,59 @@ static struct iovec rd_iovec[] = {
 
 static int fd;
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc, i, fail;
+	int i, fail;
 	char *vec;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
 
-	setup();
+	if (readv(fd, rd_iovec, 0) == -1)
+		tst_res(TFAIL | TERRNO, "readv failed unexpectedly");
+	else
+		tst_res(TPASS, "readv read 0 io vectors");
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	memset(rd_iovec[0].iov_base, 0x00, CHUNK);
 
-		SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
+	if (readv(fd, rd_iovec, 3) != CHUNK) {
+		tst_res(TFAIL, "readv failed reading %d bytes, "
+			 "followed by two NULL vectors", CHUNK);
+	} else {
+		fail = 0;
+		vec = rd_iovec[0].iov_base;
 
-		if (readv(fd, rd_iovec, 0) == -1)
-			tst_resm(TFAIL | TERRNO, "readv failed unexpectedly");
-		else
-			tst_resm(TPASS, "readv read 0 io vectors");
-
-		memset(rd_iovec[0].iov_base, 0x00, CHUNK);
-
-		if (readv(fd, rd_iovec, 3) != CHUNK) {
-			tst_resm(TFAIL, "readv failed reading %d bytes, "
-				 "followed by two NULL vectors", CHUNK);
-		} else {
-			fail = 0;
-			vec = rd_iovec[0].iov_base;
-
-			for (i = 0; i < CHUNK; i++) {
-				if (vec[i] != 0x42)
-					fail++;
-			}
-
-			if (fail)
-				tst_resm(TFAIL, "Wrong buffer content");
-			else
-				tst_resm(TPASS, "readv passed reading %d bytes "
-				         "followed by two NULL vectors", CHUNK);
+		for (i = 0; i < CHUNK; i++) {
+			if (vec[i] != 0x42)
+				fail++;
 		}
-	}
 
-	cleanup();
-	tst_exit();
+		if (fail)
+			tst_res(TFAIL, "Wrong buffer content");
+		else
+			tst_res(TPASS, "readv passed reading %d bytes "
+			         "followed by two NULL vectors", CHUNK);
+	}
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	memset(buf, 0x42, sizeof(buf));
 
-	fd = SAFE_OPEN(cleanup, "data_file", O_WRONLY | O_CREAT, 0666);
-	SAFE_WRITE(cleanup, 1, fd, buf, sizeof(buf));
-	SAFE_CLOSE(cleanup, fd);
-	fd = SAFE_OPEN(cleanup, "data_file", O_RDONLY);
+	fd = SAFE_OPEN("data_file", O_WRONLY | O_CREAT, 0666);
+	SAFE_WRITE(1, fd, buf, sizeof(buf));
+	SAFE_CLOSE(fd);
+	fd = SAFE_OPEN("data_file", O_RDONLY);
 }
 
 static void cleanup(void)
 {
-	if (fd > 0)
-		close(fd);
-
-	tst_rmdir();
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.25.1

