From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 3 Jun 2021 11:36:10 +0800
Subject: [LTP] [PATCH 2/3] syscalls/sendfile: Convert sendfile06 to the new
 API
In-Reply-To: <20210603033611.15619-1-xieziyao@huawei.com>
References: <20210603033611.15619-1-xieziyao@huawei.com>
Message-ID: <20210603033611.15619-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Convert sendfile06 to the new API with file descriptors instead
of socket descriptors.
2. Remove the support for UCLINUX.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/sendfile/sendfile06.c     | 247 ++++--------------
 1 file changed, 45 insertions(+), 202 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index abb67604f..964a71eae 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -1,228 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Copyright (c) Red Hat Inc., 2007
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
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * 11/2007 Copyed from sendfile02.c by Masatake YAMATO
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
  */

-/*
- * DESCRIPTION
- *	Testcase to test that sendfile(2) system call updates file
- *	position of in_fd correctly when passing NULL as offset.
+/*\
+ * [Description]
  *
- * HISTORY
- *	11/2007 Copyed from sendfile02.c by Masatake YAMATO
+ * Test that sendfile() system call updates file position of in_fd correctly
+ * when passing NULL as offset.
  */

-#include <inttypes.h>
 #include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/stat.h>
+#include <inttypes.h>
 #include <sys/sendfile.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/socket.h>
-#include <sys/mman.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"

-TCID_DEFINE(sendfile06);
+#include "tst_test.h"

-#define IN_FILE		"infile"
-#define OUT_FILE	"outfile"
+#define IN_FILE "in_file"
+#define OUT_FILE "out_file"

-static pid_t child_pid;
-static int sockfd;
-static struct sockaddr_in sin1;
 static struct stat sb;

-static void cleanup(void);
-static void do_child(void);
-static void setup(void);
-static int create_server(void);
-
-int TST_TOTAL = 1;
-
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
-static void do_sendfile(void)
-{
-	int in_fd, out_fd;
-	off_t after_pos;
-	int wait_stat;
-
-	out_fd = create_server();
-
-	in_fd = SAFE_OPEN(cleanup, IN_FILE, O_RDONLY);
-
-	TEST(sendfile(out_fd, in_fd, NULL, sb.st_size));
-	if ((after_pos = lseek(in_fd, 0, SEEK_CUR)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "lseek after invoking sendfile failed: %d", errno);
-	}
-
-	/* Close the sockets */
-	shutdown(sockfd, SHUT_RDWR);
-	shutdown(out_fd, SHUT_RDWR);
-	if (TEST_RETURN != sb.st_size) {
-		tst_resm(TFAIL, "sendfile(2) failed to return "
-			 "expected value, expected: %" PRId64 ", "
-			 "got: %ld", (int64_t) sb.st_size, TEST_RETURN);
-		SAFE_KILL(cleanup, child_pid, SIGKILL);
-	} else if (after_pos != sb.st_size) {
-		tst_resm(TFAIL, "sendfile(2) failed to update "
-			 " the file position of in_fd, "
-			 "expected file position: %" PRId64 ", "
-			 "actual file position %" PRId64,
-			 (int64_t) sb.st_size, (int64_t) after_pos);
-		SAFE_KILL(cleanup, child_pid, SIGKILL);
-	} else {
-		tst_resm(TPASS, "functionality of sendfile() is "
-			 "correct");
-		waitpid(-1, &wait_stat, 0);
-	}
-
-	SAFE_CLOSE(cleanup, in_fd);
-	SAFE_CLOSE(cleanup, out_fd);
-	SAFE_CLOSE(cleanup, sockfd);
-}
-
-static void do_child(void)
-{
-	socklen_t length = sizeof(sin1);
-	char rbuf[4096];
-	ssize_t ret, bytes_total_received = 0;
-
-	while (bytes_total_received < sb.st_size) {
-		ret = recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1,
-			       &length);
-		if (ret < 0) {
-			fprintf(stderr, "child process recvfrom failed: %s\n",
-				strerror(errno));
-			exit(1);
-		}
-		bytes_total_received += ret;
-	}
-
-	exit(0);
-}
-
 static void setup(void)
 {
 	int fd;
+	char buf[27];

-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	fd = SAFE_CREAT(IN_FILE, 00700);
+	sprintf(buf, "abcdefghijklmnopqrstuvwxyz");
+	SAFE_WRITE(1, fd, buf, strlen(buf));
+	SAFE_FSTAT(fd, &sb);
+	SAFE_CLOSE(fd);

-	tst_tmpdir();
-
-	fd = SAFE_CREAT(cleanup, IN_FILE, 0600);
-
-	SAFE_WRITE(cleanup, 1, fd, "abcdefghijklmnopqrstuvwxyz", 26);
-
-	SAFE_FSTAT(cleanup, fd, &sb);
-
-	SAFE_CLOSE(cleanup, fd);
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
+	fd = SAFE_CREAT(OUT_FILE, 00700);
+	SAFE_CLOSE(fd);
 }

-static int create_server(void)
+static void run(void)
 {
-	int s;
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
-
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
-
-	if (!child_pid) {
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
-
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "call to socket() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
-
-	SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1, sizeof(sin1));
+	off_t after_pos;
+	int in_fd = SAFE_OPEN(IN_FILE, O_RDONLY);
+	int out_fd = SAFE_OPEN(OUT_FILE, O_WRONLY);

-	return s;
+	TEST(sendfile(out_fd, in_fd, NULL, sb.st_size));
+	after_pos = SAFE_LSEEK(in_fd, 0, SEEK_CUR);
+
+	if (TST_RET != sb.st_size)
+		tst_res(TFAIL, "sendfile() failed to return expected value, "
+			       "expected: %" PRId64 ", got: %ld",
+			sb.st_size, TST_RET);
+	else if (after_pos != sb.st_size)
+		tst_res(TFAIL, "sendfile() updated the file position of in_fd "
+			       "unexpectedly, expected file position: %" PRId64
+			       ", actual file position %" PRId64,
+			(int64_t)(sb.st_size), (int64_t)(after_pos));
+	else
+		tst_res(TPASS, "sendfile() with offset=NULL");
+
+	SAFE_CLOSE(in_fd);
+	SAFE_CLOSE(out_fd);
 }

-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-	argv0 = av[0];
-	maybe_run_child(&do_child, "");
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		do_sendfile();
-	}
-
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = run,
+};
--
2.17.1

