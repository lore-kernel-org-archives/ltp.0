From: Sandeep Patil <sspatil@android.com>
Date: Thu, 28 Mar 2019 20:46:59 +0900
Subject: [LTP] [PATCH v2 1/2] syscalls/accept01: convert to new library.
Message-ID: <20190328114700.189583-1-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

...and drop the duplicate "invalid addrlen" test case.

Signed-off-by: Sandeep Patil <sspatil@android.com>
---

v1->v2
======
- Removed the per-test case setup/cleanup function calls
- Fixed the socket fd for "UDP accept" test case
- Removed some needless comments
- Changed description of ENOTSOCK test to 'fd is not socket'
- Fixed the test result check / prints

 testcases/kernel/syscalls/accept/accept01.c | 211 +++++++-------------
 1 file changed, 74 insertions(+), 137 deletions(-)

diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index b50056520..150faa977 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -1,26 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
  *   07/2001 Ported by Wayne Boyer
  *
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
-
-/*
- * Description:
- *  Verify that accept() returns the proper errno for various failure cases
+ *   Description:
+ *     Verify that accept() returns the proper errno for various failure cases
  */
 
 #include <stdio.h>
@@ -34,150 +19,102 @@
 
 #include <netinet/in.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-char *TCID = "accept01";
-int testno;
+struct sockaddr_in sin0, sin1, fsin1;
 
-int s;				/* socket descriptor */
-struct sockaddr_in sin0, fsin1;
-socklen_t sinlen;
+int invalid_socketfd = 400; /* anything that is not an open file */
+int devnull_fd;
+int socket_fd;
+int udp_fd;
 
-static void setup(void);
-static void cleanup(void);
-static void setup0(void);
-static void cleanup0(void);
-static void setup1(void);
-static void cleanup1(void);
-static void setup2(void);
-static void setup3(void);
-
-struct test_case_t {		/* test case structure */
+static struct test_case {
 	int domain;		/* PF_INET, PF_UNIX, ... */
 	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
 	int proto;		/* protocol number (usually 0 = default) */
+	int *fd;		/* File descriptor for the test case */
 	struct sockaddr *sockaddr;	/* socket address buffer */
-	socklen_t *salen;	/* accept's 3rd argument */
-	int retval;		/* syscall return value */
+	socklen_t salen;	/* accept's 3rd argument */
 	int experrno;		/* expected errno */
-	void (*setup) (void);
-	void (*cleanup) (void);
 	char *desc;
-} tdat[] = {
+} tcases[] = {
 	{
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    &sinlen, -1, EBADF, setup0, cleanup0,
-		    "bad file descriptor"}, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    &sinlen, -1, ENOTSOCK, setup0, cleanup0,
-		    "bad file descriptor"}, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)3,
-		    &sinlen, -1, EINVAL, setup1, cleanup1,
-		    "invalid socket buffer"}, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    (socklen_t *) 1, -1, EINVAL, setup1, cleanup1,
-		    "invalid salen"}, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    &sinlen, -1, EINVAL, setup2, cleanup1,
-		    "invalid salen"}, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    &sinlen, -1, EINVAL, setup3, cleanup1,
-		    "no queued connections"}, {
-	PF_INET, SOCK_DGRAM, 0, (struct sockaddr *)&fsin1,
-		    &sinlen, -1, EOPNOTSUPP, setup1, cleanup1,
-		    "UDP accept"},};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int ac, char *av[])
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			tdat[testno].setup();
-
-			TEST(accept(s, tdat[testno].sockaddr,
-				    tdat[testno].salen));
-			if (TEST_RETURN > 0)
-				TEST_RETURN = 0;
-			if (TEST_RETURN != tdat[testno].retval ||
-			    (TEST_RETURN < 0 &&
-			     TEST_ERRNO != tdat[testno].experrno)) {
-				tst_resm(TFAIL, "%s ; returned"
-					 " %ld (expected %d), errno %d (expected"
-					 " %d)", tdat[testno].desc,
-					 TEST_RETURN, tdat[testno].retval,
-					 TEST_ERRNO, tdat[testno].experrno);
-			} else {
-				tst_resm(TPASS, "%s successful",
-					 tdat[testno].desc);
-			}
-			tdat[testno].cleanup();
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
+		PF_INET, SOCK_STREAM, 0, &invalid_socketfd,
+		(struct sockaddr *)&fsin1, sizeof(fsin1), EBADF,
+		"bad file descriptor"
+	},
+	{
+		PF_INET, SOCK_STREAM, 0, &devnull_fd, (struct sockaddr *)&fsin1,
+		sizeof(fsin1), ENOTSOCK, "fd is not socket"
+	},
+	{
+		PF_INET, SOCK_STREAM, 0, &socket_fd, (struct sockaddr *)3,
+		sizeof(fsin1), EINVAL, "invalid socket buffer"
+	},
+	{
+		PF_INET, SOCK_STREAM, 0, &socket_fd, (struct sockaddr *)&fsin1,
+		1, EINVAL, "invalid salen"
+	},
+	{
+		PF_INET, SOCK_STREAM, 0, &socket_fd, (struct sockaddr *)&fsin1,
+		sizeof(fsin1), EINVAL, "no queued connections"
+	},
+	{
+		PF_INET, SOCK_STREAM, 0, &udp_fd, (struct sockaddr *)&fsin1,
+		sizeof(fsin1), EOPNOTSUPP, "UDP accept"
+	},
+};
 
-static void setup(void)
+static void test_setup(void)
 {
-	TEST_PAUSE;
-
 	/* initialize local sockaddr */
 	sin0.sin_family = AF_INET;
 	sin0.sin_port = 0;
 	sin0.sin_addr.s_addr = INADDR_ANY;
-}
 
-static void cleanup(void)
-{
-}
+	devnull_fd = SAFE_OPEN("/dev/null", O_WRONLY);
 
-static void setup0(void)
-{
-	if (tdat[testno].experrno == EBADF)
-		s = 400;	/* anything not an open file */
-	else if ((s = open("/dev/null", O_WRONLY)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "error opening /dev/null");
-}
+	socket_fd = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(socket_fd, (struct sockaddr *)&sin0, sizeof(sin0));
 
-static void cleanup0(void)
-{
-	s = -1;
-}
+	sin1.sin_family = AF_INET;
+	sin1.sin_port = 0;
+	sin1.sin_addr.s_addr = INADDR_ANY;
 
-static void setup1(void)
-{
-	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
-			tdat[testno].proto);
-	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
-	sinlen = sizeof(fsin1);
+	udp_fd = SAFE_SOCKET(PF_INET, SOCK_DGRAM, 0);
+	SAFE_BIND(udp_fd, (struct sockaddr *)&sin1, sizeof(sin1));
 }
 
-static void cleanup1(void)
+static void test_cleanup(void)
 {
-	(void)close(s);
-	s = -1;
+	SAFE_CLOSE(devnull_fd);
+	SAFE_CLOSE(socket_fd);
 }
 
-static void setup2(void)
+void verify_accept(unsigned int nr)
 {
-	setup1();		/* get a socket in s */
-	sinlen = 1;		/* invalid s */
-}
+	struct test_case *tcase = &tcases[nr];
 
-static void setup3(void)
-{
-	int one = 1;
+	TEST(accept(*tcase->fd, tcase->sockaddr, &tcase->salen));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "%s: returned %i, expected -1",
+				tcase->desc, TST_RET);
+		return;
+	}
+
+	if (TST_ERR != tcase->experrno) {
+		tst_res(TFAIL | TTERRNO, "%s: expected errno %s, got ",
+				tcase->desc, tst_strerrno(tcase->experrno));
+		return;
+	}
 
-	setup1();
-	SAFE_IOCTL(cleanup, s, FIONBIO, &one);
+	tst_res(TPASS | TTERRNO, "%s successful", tcase->desc);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = test_setup,
+	.cleanup = test_cleanup,
+	.test = verify_accept,
+};
-- 
2.21.0.392.gf8f6787159e-goog

