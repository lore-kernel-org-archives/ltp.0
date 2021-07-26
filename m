From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Mon, 26 Jul 2021 11:49:28 +0800
Subject: [LTP] [PATCH] syscalls/memcmp01: Convert to new API
Message-ID: <20210726034928.15766-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/memcmp/memcmp01.c b/testcases/kernel/syscalls/memcmp/memcmp01.c
index 3b4b4e3cd..6ac9de385 100644
--- a/testcases/kernel/syscalls/memcmp/memcmp01.c
+++ b/testcases/kernel/syscalls/memcmp/memcmp01.c
@@ -1,237 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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

 /* 01/02/2003	Port to LTP	avenkat&us.ibm.com */
 /* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */

-/*
- * NAME
- *	memcmp1 -- buffer  compare
+/*\
+ * [DESCRIPTION]
  *
- * CALLS
- *	memcmp(3)
- *
- * ALGORITHM
- *	Check boundary conditions.
- *
- * RESTRICTIONS
+ * The testcase for buffer comparison by check boundary conditions.
  */

 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
-#include <errno.h>
-
-#include "test.h"
-
-char *TCID = "memcmp1";
+#include "tst_test.h"

 #undef  BSIZE
 #define BSIZE	4096
 #define LEN	100
-#define FAILED 0
-#define PASSED 1

 char buf[BSIZE];

-int local_flag = PASSED;
-int block_number;
-FILE *temp;
-int TST_TOTAL = 2;
-int anyfail();
-int blenter();
-int blexit();
-int instress();
+static struct test_case {
+	char *p;
+	char *q;
+	int len;
+} tcases[] = {
+	{ &buf[100], &buf[800], LEN},
+	{ &buf[800], &buf[100], LEN},
+};

-void setup();
-
-void clearit();
-void fill(char *str);
-int checkit(char *str);
-
-int main(int argc, char *argv[])
+void fill(char *str, int len)
 {
-	char *p, *q;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-	blenter();
-
-	clearit();
-
-	p = &buf[100];
-	q = &buf[800];
-
-	fill(p);
-	fill(q);
-
-	if (memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp fails - should have succeeded.\n");
-		local_flag = FAILED;
-	}
-
-	p[LEN - 1] = 0;
-
-	if (!memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp succeeded - should have failed.\n");
-		local_flag = FAILED;
-	};
-
-	p[LEN - 1] = 'a';
-	p[0] = 0;
-
-	if (!memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp succeeded - should have failed.\n");
-		local_flag = FAILED;
-	};
-
-	p[0] = 'a';
-	q[LEN - 1] = 0;
-
-	if (!memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp succeeded - should have failed.\n");
-		local_flag = FAILED;
-	};
-
-	q[LEN - 1] = 'a';
-	q[0] = 0;
-
-	if (!memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp succeeded - should have failed.\n");
-		local_flag = FAILED;
-	};
+	register int i;
+	for (i = 0; i < len; i++)
+		*str++ = 'a';
+}

-	q[0] = 'a';
+static void setup(void)
+{
+	register int i;

-	if (memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp fails - should have succeeded.\n");
-		local_flag = FAILED;
+	for (i = 0; i < BSIZE; i++) {
+		buf[i] = 0;
 	}

-	blexit();
-/*--------------------------------------------------------------*/
-	blenter();
-
-	clearit();
-
-	p = &buf[800];
-	q = &buf[100];
+	return ;
+}

-	fill(p);
-	fill(q);
+static void verify_memcmp(char *p, char *q, int len)
+{
+	fill(p, len);
+	fill(q, len);

-	if (memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp fails - should have succeeded.\n");
-		local_flag = FAILED;
+	if (memcmp(p, q, len)) {
+		tst_res(TFAIL, "\tmemcmp fails - should have succeeded.");
+		goto out;
 	}

-	p[LEN - 1] = 0;
+	p[len - 1] = 0;

-	if (!memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp succeeded - should have failed.\n");
-		local_flag = FAILED;
+	if (!memcmp(p, q, len)) {
+		tst_res(TFAIL, "\tmemcmp succeeded - should have failed.");
+		goto out;
 	};

-	p[LEN - 1] = 'a';
+	p[len - 1] = 'a';
 	p[0] = 0;

-	if (!memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp succeeded - should have failed.\n");
-		local_flag = FAILED;
+	if (!memcmp(p, q, len)) {
+		tst_res(TFAIL, "\tmemcmp succeeded - should have failed.");
+		goto out;
 	};

 	p[0] = 'a';
-	q[LEN - 1] = 0;
+	q[len - 1] = 0;

-	if (!memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp succeeded - should have failed.\n");
-		local_flag = FAILED;
+	if (!memcmp(p, q, len)) {
+		tst_res(TFAIL, "\tmemcmp succeeded - should have failed.");
+		goto out;
 	};

-	q[LEN - 1] = 'a';
+	q[len - 1] = 'a';
 	q[0] = 0;

-	if (!memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp succeeded - should have failed.\n");
-		local_flag = FAILED;
+	if (!memcmp(p, q, len)) {
+		tst_res(TFAIL, "\tmemcmp succeeded - should have failed.");
+		goto out;
 	};

 	q[0] = 'a';

-	if (memcmp(p, q, LEN)) {
-		fprintf(temp, "\tmemcmp fails - should have succeeded.\n");
-		local_flag = FAILED;
+	if (memcmp(p, q, len)) {
+		tst_res(TFAIL, "\tmemcmp fails - should have succeeded.");
+		goto out;
 	}
-
-	blexit();
-
-	anyfail();
-	tst_exit();
-}
-
-void clearit(void)
-{
-	register int i;
-
-	for (i = 0; i < BSIZE; i++)
-		buf[i] = 0;
+
+	tst_res(TPASS, "Test passed");
+out:
+	return ;
 }

-void fill(char *str)
+static void run_test(unsigned int nr)
 {
-	register int i;
-	for (i = 0; i < LEN; i++)
-		*str++ = 'a';
-}
+	struct test_case *tcase = &tcases[nr];

-int checkit(char *str)
-{
-	register int i;
-	for (i = 0; i < LEN; i++)
-		if (*str++ != 'a')
-			return (-1);
-
-	return (0);
-}
+	verify_memcmp(tcase->p, tcase->q, tcase->len);

-int anyfail(void)
-{
-	tst_exit();
+	return ;
 }

-void setup(void)
-{
-	temp = stderr;
-}
-
-int blenter(void)
-{
-	local_flag = PASSED;
-	return 0;
-}
-
-int blexit(void)
-{
-	(local_flag == FAILED) ? tst_resm(TFAIL,
-					  "Test failed") : tst_resm(TPASS,
-								    "Test passed");
-	return 0;
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.test = run_test,
+};
--
2.20.1



