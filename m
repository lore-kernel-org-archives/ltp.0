From: Sandeep Patil <sspatil@android.com>
Date: Mon, 25 Mar 2019 16:20:10 -0700
Subject: [LTP] [PATCH 2/4] syscalls/accept01: convert to new library.
In-Reply-To: <20190325232012.67123-1-sspatil@android.com>
References: <20190325232012.67123-1-sspatil@android.com>
Message-ID: <20190325232012.67123-3-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

...and drop the duplicate "invalid addrlen" test case.

Signed-off-by: Sandeep Patil <sspatil@android.com>
---
 testcases/kernel/syscalls/accept/accept01.c | 236 +++++++++-----------
 1 file changed, 103 insertions(+), 133 deletions(-)

diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index b50056520..5982c09f8 100644
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
@@ -34,150 +19,135 @@
 
 #include <netinet/in.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "accept01";
-int testno;
+#include "tst_test.h"
 
-int s;				/* socket descriptor */
 struct sockaddr_in sin0, fsin1;
-socklen_t sinlen;
-
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
+
+struct test_case;
+static void setup_invalid_fd(struct test_case *tcase);
+static void setup_nonsocket_fd(struct test_case *tcase);
+static void setup_socket(struct test_case *tcase);
+static void setup_fionbio(struct test_case *tcase);
+static void cleanup_tcase(struct test_case *tcase);
+
+/* test cases */
+static struct test_case {
 	int domain;		/* PF_INET, PF_UNIX, ... */
 	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
 	int proto;		/* protocol number (usually 0 = default) */
+	int socketfd;		/* socketfd for the test case */
 	struct sockaddr *sockaddr;	/* socket address buffer */
-	socklen_t *salen;	/* accept's 3rd argument */
+	socklen_t salen;	/* accept's 3rd argument */
 	int retval;		/* syscall return value */
 	int experrno;		/* expected errno */
-	void (*setup) (void);
-	void (*cleanup) (void);
+	void (*setup) (struct test_case *);
+	void (*cleanup) (struct test_case *);
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
+		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)&fsin1,
+		sizeof(fsin1), -1, EBADF, setup_invalid_fd, NULL,
+		"bad file descriptor"
+	},
+	{
+		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)&fsin1,
+		sizeof(fsin1), -1, ENOTSOCK, setup_nonsocket_fd,
+		cleanup_tcase, "bad file descriptor"
+	},
+	{
+		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)3,
+		sizeof(fsin1), -1, EINVAL, setup_socket, cleanup_tcase,
+		"invalid socket buffer"
+	},
+	{
+		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)&fsin1,
+		1, -1, EINVAL, setup_socket, cleanup_tcase,
+		"invalid salen"
+	},
+	{
+		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)&fsin1,
+		sizeof(fsin1), -1, EINVAL, setup_fionbio, cleanup_tcase,
+		"no queued connections"
+	},
+	{
+		PF_INET, SOCK_DGRAM, 0, -1, (struct sockaddr *)&fsin1,
+		sizeof(fsin1), -1, EOPNOTSUPP, setup_socket, cleanup_tcase,
+		"UDP accept"
+	},
+};
 
-static void setup(void)
-{
-	TEST_PAUSE;
 
-	/* initialize local sockaddr */
-	sin0.sin_family = AF_INET;
-	sin0.sin_port = 0;
-	sin0.sin_addr.s_addr = INADDR_ANY;
-}
 
-static void cleanup(void)
+static void setup_invalid_fd(struct test_case *tcase)
 {
+	tcase->socketfd = 400; /* anything that is not an open file */
 }
 
-static void setup0(void)
+static void setup_nonsocket_fd(struct test_case *tcase)
 {
-	if (tdat[testno].experrno == EBADF)
-		s = 400;	/* anything not an open file */
-	else if ((s = open("/dev/null", O_WRONLY)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "error opening /dev/null");
+	tcase->socketfd = SAFE_OPEN("/dev/null", O_WRONLY);
 }
 
-static void cleanup0(void)
+static void setup_socket(struct test_case *tcase)
 {
-	s = -1;
+	tcase->socketfd = SAFE_SOCKET(tcase->domain, tcase->type, tcase->proto);
+	SAFE_BIND(tcase->socketfd, (struct sockaddr *)&sin0, sizeof(sin0));
+	tcase->salen = sizeof(fsin1);
 }
 
-static void setup1(void)
+static void setup_fionbio(struct test_case *tcase)
 {
-	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
-			tdat[testno].proto);
-	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
-	sinlen = sizeof(fsin1);
+	int one = 1;
+	setup_socket(tcase);
+	SAFE_IOCTL(tcase->socketfd, FIONBIO, &one);
 }
 
-static void cleanup1(void)
+static void cleanup_tcase(struct test_case *tcase)
 {
-	(void)close(s);
-	s = -1;
+	if (tcase->socketfd >= 0)
+		SAFE_CLOSE(tcase->socketfd);
+
+	tcase->socketfd = -1;
 }
 
-static void setup2(void)
+void verify_accept(unsigned int nr)
 {
-	setup1();		/* get a socket in s */
-	sinlen = 1;		/* invalid s */
+	struct test_case *tcase = &tcases[nr];
+
+	if (tcase->setup)
+		tcase->setup(tcase);
+
+	TEST(accept(tcase->socketfd, tcase->sockaddr, &tcase->salen));
+	if (TST_RET > 0) {
+		/* don't leak accepted socket, close them first */
+		SAFE_CLOSE(TST_RET);
+		TST_RET = 0;
+	}
+
+	if (TST_RET != tcase->retval ||
+		(TST_RET < 0 && TST_ERR != tcase->experrno)) {
+		tst_res(TFAIL, "%s ; returned"
+				" %ld (expected %d), errno %d (expected"
+				" %d)", tcase->desc, TST_RET, tcase->retval,
+				TST_ERR, tcase->experrno);
+	} else {
+		tst_res(TPASS, "%s successful", tcase->desc);
+	}
+
+	if (tcase->cleanup)
+		tcase->cleanup(tcase);
 }
 
-static void setup3(void)
+static void test_setup(void)
 {
-	int one = 1;
-
-	setup1();
-	SAFE_IOCTL(cleanup, s, FIONBIO, &one);
+	/* initialize local sockaddr */
+	sin0.sin_family = AF_INET;
+	sin0.sin_port = 0;
+	sin0.sin_addr.s_addr = INADDR_ANY;
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = test_setup,
+	.test = verify_accept,
+};
-- 
2.21.0.392.gf8f6787159e-goog

