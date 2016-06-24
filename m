From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 24 Jun 2016 17:04:52 +0800
Subject: [LTP] [PATCH 3/4] syscalls/socketpair01: convert to new API
In-Reply-To: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1466759093-15755-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/socketpair/socketpair01.c      | 180 +++++++--------------
 1 file changed, 62 insertions(+), 118 deletions(-)

diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index 3a045b7..be7bcfb 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -1,144 +1,88 @@
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
- * Test Name: socketpair01
- *
- * Test Description:
- *  Verify that socketpair() returns the proper errno for various failure cases
- *
- * Usage:  <for command-line>
- *  socketpair01 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
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
+* Test Name: socketpair01
+*
+* Test Description:
+* Verify that socketpair() returns the proper errno for various failure cases
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
+#include "tst_test.h"
 
-#include "test.h"
-
-char *TCID = "socketpair01";
-int testno;
-
-int sv[2];
+static int fds[2];
 
-void setup(void), cleanup(void);
-
-struct test_case_t {		/* test case structure */
-	int domain;		/* PF_INET, PF_UNIX, ... */
-	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
-	int proto;		/* protocol number (usually 0 = default) */
-	int *sv;		/* socket descriptor vector */
-	int retval;		/* syscall return value */
-	int experrno;		/* expected errno */
+struct test_case_t {
+	int domain;
+	int type;
+	int proto;
+	int *sv;
+	int retval;
+	int experrno;
 	char *desc;
 } tdat[] = {
-	{
-	0, SOCK_STREAM, 0, sv, -1, EAFNOSUPPORT, "invalid domain"}, {
-	PF_INET, 75, 0, sv, -1, EINVAL, "invalid type"}, {
-	PF_UNIX, SOCK_DGRAM, 0, sv, 0, 0, "UNIX domain dgram"}, {
-	PF_INET, SOCK_RAW, 0, sv, -1, ESOCKTNOSUPPORT,
-		    "raw open as non-root"},
+	{0, SOCK_STREAM, 0, fds, -1, EAFNOSUPPORT, "invalid domain"},
+	{PF_INET, 75, 0, fds, -1, EINVAL, "invalid type"},
+	{PF_UNIX, SOCK_DGRAM, 0, fds, 0, 0, "UNIX domain dgram"},
+	{PF_INET, SOCK_RAW, 0, fds, -1, ESOCKTNOSUPPORT, "raw open as non-root"},
 #ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
-	{
-	PF_UNIX, SOCK_STREAM, 0, 0, -1, EFAULT, "bad aligned pointer"}, {
-	PF_UNIX, SOCK_STREAM, 0, (int *)7, -1, EFAULT,
-		    "bad unaligned pointer"},
+	{PF_UNIX, SOCK_STREAM, 0, 0, -1, EFAULT, "bad aligned pointer"},
+	{PF_UNIX, SOCK_STREAM, 0, (int *)7, -1, EFAULT, "bad unaligned pointer"},
 #endif
-	{
-	PF_INET, SOCK_DGRAM, 17, sv, -1, EOPNOTSUPP, "UDP socket"}, {
-	PF_INET, SOCK_DGRAM, 6, sv, -1, ESOCKTNOSUPPORT, "TCP dgram"}, {
-	PF_INET, SOCK_STREAM, 6, sv, -1, EOPNOTSUPP, "TCP socket"}, {
-PF_INET, SOCK_STREAM, 1, sv, -1, ESOCKTNOSUPPORT, "ICMP stream"},};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
+	{PF_INET, SOCK_DGRAM, 17, fds, -1, EOPNOTSUPP, "UDP socket"},
+	{PF_INET, SOCK_DGRAM, 6, fds, -1, ESOCKTNOSUPPORT, "TCP dgram"},
+	{PF_INET, SOCK_STREAM, 6, fds, -1, EOPNOTSUPP, "TCP socket"},
+	{PF_INET, SOCK_STREAM, 1, fds, -1, ESOCKTNOSUPPORT, "ICMP stream"}
+};
 
-int main(int argc, char *argv[])
+static void verify_socketpair(unsigned int n)
 {
-	int lc;
-	int s;
+	int res;
+	struct test_case_t *tc = &tdat[n];
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	TEST(res = socketpair(tc->domain, tc->type, tc->proto, tc->sv));
 
-	setup();
+	if (TEST_RETURN >= 0)
+		TEST_RETURN = 0;
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST((s = socketpair(tdat[testno].domain,
-					     tdat[testno].type,
-					     tdat[testno].proto,
-					     tdat[testno].sv)));
-			if (TEST_RETURN >= 0) {
-				TEST_RETURN = 0;	/* > 0 equivalent */
-			} else {
-			}
-			if (TEST_RETURN != tdat[testno].retval ||
-			    (TEST_RETURN &&
-			     (TEST_ERRNO != tdat[testno].experrno
-			      && TEST_ERRNO != EPROTONOSUPPORT))) {
-				tst_resm(TFAIL,
-					 "%s ; returned"
-					 " %d (expected %d), errno %d (expected"
-					 " %d)", tdat[testno].desc, s,
-					 tdat[testno].retval, TEST_ERRNO,
-					 tdat[testno].experrno);
-			} else {
-				tst_resm(TPASS, "%s successful",
-					 tdat[testno].desc);
-			}
-			(void)close(s);
-		}
+	if (TEST_RETURN != tc->retval || (TEST_RETURN &&
+	   (TEST_ERRNO != tc->experrno && TEST_ERRNO != EPROTONOSUPPORT))) {
+		tst_res(TFAIL, "%s returned %d (expected %d), errno %d "
+			"(expected %d)", tc->desc, res, tc->retval, TEST_ERRNO,
+			tc->experrno);
+	}  else {
+		tst_res(TPASS, "%s successful", tc->desc);
 	}
 
-	cleanup();
-
-	tst_exit();
-}
-
-void setup(void)
-{
-
-	TEST_PAUSE;
+	if (res > 0) {
+		SAFE_CLOSE(fds[0]);
+		SAFE_CLOSE(fds[1]);
+	}
 }
 
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tid = "sokcetpair01",
+	.tcnt = ARRAY_SIZE(tdat),
+	.test = verify_socketpair
+};
-- 
1.8.3.1



