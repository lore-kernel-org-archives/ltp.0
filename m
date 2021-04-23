From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 23 Apr 2021 17:59:44 +0800
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile05 to the new
 API
In-Reply-To: <20210423095944.118255-1-xieziyao@huawei.com>
References: <20210423095944.118255-1-xieziyao@huawei.com>
Message-ID: <20210423095944.118255-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Convert sendfile05 to the new API;
2. Remove the socket code of server/client and use SAFE_SOCKETPAIR()
instead, which can simplify the code logic.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/sendfile/sendfile05.c     | 254 +++---------------
 1 file changed, 41 insertions(+), 213 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index 0f268ceb3..cfa6144b1 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -1,46 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *   Copyright (c) Red Hat Inc., 2007
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) Red Hat Inc., 2007
+ * 11/2007 Copyed from sendfile02.c by Masatake YAMATO
  */

-/*
- * NAME
- *	sendfile05.c
- *
- * DESCRIPTION
- *	Testcase to test that sendfile(2) system call returns EINVAL
- *	when passing negative offset.
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  sendfile05 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * Testcase to test that sendfile(2) system call returns EINVAL when passing
+ * negative offset.
  *
- * HISTORY
- *	11/2007 Copyed from sendfile02.c by Masatake YAMATO
+ * [Algorithm]
  *
- * RESTRICTIONS
- *	NONE
+ * Call sendfile with offset = -1.
  */
+
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -51,198 +26,51 @@
 #include <sys/mman.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
-#include "test.h"
-#include "safe_macros.h"
+
+#include "tst_test.h"

 #ifndef OFF_T
 #define OFF_T off_t
-#endif /* Not def: OFF_T */
-
-TCID_DEFINE(sendfile05);
-
-char in_file[100];
-char out_file[100];
-int out_fd;
-pid_t child_pid;
-static int sockfd, s;
-static struct sockaddr_in sin1;	/* shared between do_child and create_server */
-
-void cleanup(void);
-void do_child(void);
-void setup(void);
-int create_server(void);
-
-int TST_TOTAL = 1;
-
-#ifdef UCLINUX
-static char *argv0;
 #endif

-void do_sendfile(void)
-{
-	OFF_T offset;
-	int in_fd;
-	struct stat sb;
-
-	out_fd = create_server();
-
-	if ((in_fd = open(in_file, O_RDONLY)) < 0) {
-		tst_brkm(TBROK, cleanup, "open failed: %d", errno);
-	}
-	SAFE_STAT(cleanup, in_file, &sb);
-
-	offset = -1;
-	TEST(sendfile(out_fd, in_fd, &offset, sb.st_size));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "call succeeded unexpectedly");
-	} else {
-		if (TEST_ERRNO != EINVAL) {
-			tst_resm(TFAIL, "sendfile returned unexpected "
-				 "errno, expected: %d, got: %d",
-				 EINVAL, TEST_ERRNO);
-		} else {
-			tst_resm(TPASS, "sendfile() returned %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		}
-	}
-
-	shutdown(sockfd, SHUT_RDWR);
-	shutdown(s, SHUT_RDWR);
-	kill(child_pid, SIGKILL);
-	close(in_fd);
-}
-
-/*
- * do_child
- */
-void do_child(void)
-{
-	int lc;
-	socklen_t length;
-	char rbuf[4096];
+#define IN_FILE "sendfile05_infile"

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		length = sizeof(sin1);
-		recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1,
-			 &length);
-	}
-	exit(0);
-}
+int in_fd;
+int out_fd;
+int out[2];
+static char buf[] = "abcdefghijklmnopqrstuvwxyz";

-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	int fd;
-	char buf[100];
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	in_fd = SAFE_CREAT(IN_FILE, 00700);
+	SAFE_WRITE(1, in_fd, buf, strlen(buf));
+	SAFE_CLOSE(in_fd);

-	/* make a temporary directory and cd to it */
-	tst_tmpdir();
-	sprintf(in_file, "in.%d", getpid());
-	if ((fd = creat(in_file, 00700)) < 0) {
-		tst_brkm(TBROK, cleanup, "creat failed in setup, errno: %d",
-			 errno);
-	}
-	sprintf(buf, "abcdefghijklmnopqrstuvwxyz");
-	if (write(fd, buf, strlen(buf)) < 0) {
-		tst_brkm(TBROK, cleanup, "write failed, errno: %d", errno);
-	}
-	close(fd);
-	sprintf(out_file, "out.%d", getpid());
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, out);
+	out_fd = out[0];
 }

-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	close(out_fd);
-	/* delete the test directory created in setup() */
-	tst_rmdir();
-
+	SAFE_CLOSE(out[0]);
+	SAFE_CLOSE(out[1]);
 }

-int create_server(void)
+static void run(void)
 {
-	static int count = 0;
-	socklen_t slen = sizeof(sin1);
-
-	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0) {
-		tst_brkm(TBROK, cleanup, "call to socket() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
-	sin1.sin_family = AF_INET;
-	sin1.sin_port = 0; /* pick random free port */
-	sin1.sin_addr.s_addr = INADDR_ANY;
-	count++;
-	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
-		tst_brkm(TBROK, cleanup, "call to bind() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
-	SAFE_GETSOCKNAME(cleanup, sockfd, (struct sockaddr *)&sin1, &slen);
-
-	child_pid = FORK_OR_VFORK();
-	if (child_pid < 0) {
-		tst_brkm(TBROK, cleanup, "client/server fork failed: %s",
-			 strerror(errno));
-		return -1;
-	}
-	if (!child_pid) {	/* child */
-#ifdef UCLINUX
-		if (self_exec(argv0, "") < 0) {
-			tst_brkm(TBROK, cleanup, "self_exec failed");
-			return -1;
-
-		}
-#else
-		do_child();
-#endif
-	}
-
-	s = socket(PF_INET, SOCK_DGRAM, 0);
-	inet_aton("127.0.0.1", &sin1.sin_addr);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "call to socket() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
-	SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1, sizeof(sin1));
-	return s;
+	OFF_T offset = -1;
+	in_fd = SAFE_OPEN(IN_FILE, O_RDONLY);
+	struct stat sb;
+	SAFE_STAT(IN_FILE, &sb);

+	TST_EXP_FAIL(sendfile(out_fd, in_fd, &offset, sb.st_size), EINVAL,
+		     "sendfile(out, in, &offset, ..) with offset=%ld", offset);
+	SAFE_CLOSE(in_fd);
 }

-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	argv0 = av[0];
-	maybe_run_child(&do_child, "");
-#endif
-
-	setup();
-
-	/*
-	 * The following loop checks looping state if -c option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		do_sendfile();
-	}
-	cleanup();
-
-	tst_exit();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.cleanup = cleanup,
+	.setup = setup,
+	.test_all = run,
+};
--
2.17.1

