From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Mon, 26 Jul 2021 15:55:22 +0800
Subject: [LTP] [PATCH] [1/2] syscalls/memset01: Convert to new API
Message-ID: <20210726075522.11529-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/memset/memset01.c b/testcases/kernel/syscalls/memset/memset01.c
index 1a0ccd0df..0864443c7 100644
--- a/testcases/kernel/syscalls/memset/memset01.c
+++ b/testcases/kernel/syscalls/memset/memset01.c
@@ -1,36 +1,14 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2002
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */

 /* 01/02/2003	Port to LTP	avenkat@us.ibm.com */
 /* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */

-/*
- * NAME
- *	memset1.c -- test setting of  buffer
+/*\
+ * [DESCRIPTION]
  *
- * CALLS
- *	memset(3)
- *
- * ALGORITHM
- *	Check boundary conditions, go through 64 byte window.
- *
- * RESTRICTIONS
+ * The testcase for test setting of buffer by check boundary conditions.
  */

 #include <stdio.h>
@@ -39,62 +17,44 @@
 #include <stdlib.h>
 #include <errno.h>

-#include "test.h"
-
-char *TCID = "memset01";
+#include "tst_test.h"

 #undef BSIZE
 #define BSIZE	4096
-#define LEN	100
-#define FAILED 0
-#define PASSED 1

 char buf[BSIZE];

-int local_flag = PASSED;
-int block_number;
-int TST_TOTAL = 1;
-
 void fill(void);
 int checkit(char *str);

-int main(int argc, char *argv[])
+static void setup(void)
 {
-	register int i, j;
-	char *p;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	local_flag = PASSED;
-
 	fill();
+}
+
+static void verify_memset(void)
+{
+	register int i, j;
+	char *p = &buf[400];

 	for (i = 0; i < 200; i++) {
 		fill();
-		p = &buf[400];
 		memset(p, 0, i);
 		if ((j = checkit(p)) != i) {
-			tst_resm(TINFO,
-				 "Not enough zero bytes, wanted %d, got %d", i,
-				 j);
-			local_flag = FAILED;
+			tst_res(TINFO, "Not enough zero bytes, wanted %d, got %d", i, j);
 			break;
 		}
 		if (!p[-1] || !p[i]) {
-			tst_resm(TINFO, "Boundary error, clear of %d", i);
-			local_flag = FAILED;
-		}
-		if (local_flag == FAILED)
+			tst_res(TINFO, "Boundary error, clear of %d", i);
 			break;
+		}
 	}

-	(local_flag == FAILED) ? tst_resm(TFAIL,
-					  "Test failed") : tst_resm(TPASS,
-								    "Test passed");
-	(local_flag == FAILED) ? tst_resm(TFAIL,
-					  "Test failed") : tst_resm(TPASS,
-								    "Test passed");
-	tst_exit();
+	if (i == 200) {
+		tst_res(TPASS, "Test passed");
+	} else {
+		tst_res(TFAIL, "Test fails");
+	}
 }

 void fill(void)
@@ -113,3 +73,7 @@ int checkit(char *str)

 	return (i);
 }
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_memset,
+};
--
2.20.1



