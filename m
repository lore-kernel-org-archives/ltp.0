From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 24 Jun 2016 17:04:50 +0800
Subject: [LTP] [PATCH 1/4] syscalls/socket01: convert to new API
Message-ID: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/socket/socket01.c | 171 ++++++++++------------------
 1 file changed, 62 insertions(+), 109 deletions(-)

diff --git a/testcases/kernel/syscalls/socket/socket01.c b/testcases/kernel/syscalls/socket/socket01.c
index f471d8b..ad36aca 100644
--- a/testcases/kernel/syscalls/socket/socket01.c
+++ b/testcases/kernel/syscalls/socket/socket01.c
@@ -1,127 +1,80 @@
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
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
- */
+* Copyright (c) International Business Machines  Corp., 2001
+*
+* This program is free software;  you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY;  without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+* the GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program.
+*/
 
 /*
- * Test Name: socket01
- *
- * Test Description:
- *  Verify that socket() returns the proper errno for various failure cases
- *
- * Usage:  <for command-line>
- *  socket01 [-c n] [-e][-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *  None.
- *
- */
+* Test Name: socket01
+*
+* Test Description:
+* Verify that socket() returns the proper errno for various failure cases
+*
+*/
 
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
-
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-
 #include <netinet/in.h>
-
-#include "test.h"
-
-char *TCID = "socket01";
-int testno;
-
-void setup(void), cleanup(void);
-
-struct test_case_t {		/* test case structure */
-	int domain;		/* PF_INET, PF_UNIX, ... */
-	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
-	int proto;		/* protocol number (usually 0 = default) */
-	int retval;		/* syscall return value */
-	int experrno;		/* expected errno */
+#include "tst_test.h"
+
+struct test_case_t {
+	int domain;
+	int type;
+	int proto;
+	int retval;
+	int experrno;
 	char *desc;
 } tdat[] = {
-	{
-	0, SOCK_STREAM, 0, -1, EAFNOSUPPORT, "invalid domain"}, {
-	PF_INET, 75, 0, -1, EINVAL, "invalid type"}, {
-	PF_UNIX, SOCK_DGRAM, 0, 0, 0, "UNIX domain dgram"}, {
-	PF_INET, SOCK_RAW, 0, -1, ESOCKTNOSUPPORT, "raw open as non-root"},
-	{
-	PF_INET, SOCK_DGRAM, 17, 0, 0, "UDP socket"}, {
-	PF_INET, SOCK_STREAM, 17, -1, ESOCKTNOSUPPORT, "UDP stream"}, {
-	PF_INET, SOCK_DGRAM, 6, -1, ESOCKTNOSUPPORT, "TCP dgram"}, {
-	PF_INET, SOCK_STREAM, 6, 0, 0, "TCP socket"}, {
-PF_INET, SOCK_STREAM, 1, -1, ESOCKTNOSUPPORT, "ICMP stream"},};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char *argv[])
+	{0, SOCK_STREAM, 0, -1, EAFNOSUPPORT, "invalid domain"},
+	{PF_INET, 75, 0, -1, EINVAL, "invalid type"},
+	{PF_UNIX, SOCK_DGRAM, 0, 0, 0, "UNIX domain dgram"},
+	{PF_INET, SOCK_RAW, 0, -1, ESOCKTNOSUPPORT, "raw open as non-root"},
+	{PF_INET, SOCK_DGRAM, 17, 0, 0, "UDP socket"},
+	{PF_INET, SOCK_STREAM, 17, -1, ESOCKTNOSUPPORT, "UDP stream"},
+	{PF_INET, SOCK_DGRAM, 6, -1, ESOCKTNOSUPPORT, "TCP dgram"},
+	{PF_INET, SOCK_STREAM, 6, 0, 0, "TCP socket"},
+	{PF_INET, SOCK_STREAM, 1, -1, ESOCKTNOSUPPORT, "ICMP stream"}
+};
+
+static void verify_socket(unsigned int n)
 {
-	int lc;
-	int s;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST((s = socket(tdat[testno].domain, tdat[testno].type,
-					 tdat[testno].proto)));
-			if (TEST_RETURN >= 0) {
-				TEST_RETURN = 0;	/* > 0 equivalent */
-			} else {
-			}
-			if (TEST_RETURN != tdat[testno].retval || (TEST_RETURN < 0 && (TEST_ERRNO != tdat[testno].experrno && TEST_ERRNO != EPROTONOSUPPORT))) {	/* Change for defect 21065 for kernel change */
-				tst_resm(TFAIL, "%s ; returned"	/* of return code for this test but don't want */
-					 " %d (expected %d), errno %d (expected"	/* to break on older kernels */
-					 " %d)", tdat[testno].desc,
-					 s, tdat[testno].retval,
-					 TEST_ERRNO, tdat[testno].experrno);
-			} else {
-				tst_resm(TPASS, "%s successful",
-					 tdat[testno].desc);
-			}
-			(void)close(s);
-		}
+	int fd;
+	struct test_case_t *tc = &tdat[n];
+
+	TEST(fd = socket(tc->domain, tc->type, tc->proto));
+	if (TEST_RETURN >= 0)
+		TEST_RETURN = 0;
+
+	if (TEST_RETURN != tc->retval || (TEST_RETURN < 0 &&
+	   (TEST_ERRNO != tc->experrno && TEST_ERRNO != EPROTONOSUPPORT))) {
+		tst_res(TFAIL, "%s returned %d (expected %d), errno %d "
+			"(expected %d)", tc->desc, fd, tc->retval, TEST_ERRNO,
+			tc->experrno);
+	} else {
+		tst_res(TPASS, "%s successful", tc->desc);
 	}
-	cleanup();
-	tst_exit();
-
-}
 
-void setup(void)
-{
-
-	TEST_PAUSE;
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tid = "socket01",
+	.tcnt = ARRAY_SIZE(tdat),
+	.test = verify_socket
+};
-- 
1.8.3.1



