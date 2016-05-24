From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 24 May 2016 10:55:55 +0800
Subject: [LTP] [PATCH 2/3] syscalls/pipe02: Cleanup && convert to new API
In-Reply-To: <1464058556-7675-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1464058556-7675-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1464058556-7675-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/pipe/pipe02.c | 225 +++++++++++---------------------
 1 file changed, 75 insertions(+), 150 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe02.c b/testcases/kernel/syscalls/pipe/pipe02.c
index 7eceacf..119f4fe 100644
--- a/testcases/kernel/syscalls/pipe/pipe02.c
+++ b/testcases/kernel/syscalls/pipe/pipe02.c
@@ -1,20 +1,18 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
  */
 
 /*
@@ -24,173 +22,100 @@
  * DESCRIPTION
  *	Check that if a child has a "broken pipe", this information
  *	is transmitted to the waiting parent.
- *
- * ALGORITHM
- * 	1. Create a pipe, fork child
- * 	2. Child writes to pipe, parent reads to verify the pipe is working
- * 	3. Parent closes the read end of the pipe, child writes to it
- * 	4. Parent checks to see that child was terminated with SIGPIPE
- *
- * USAGE:  <for command-line>
- *  pipe02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	12/2002 Ported by Paul Larson
- *
- * RESTRICTIONS
- *	None
  */
-#include <signal.h>
-#include <fcntl.h>
+
 #include <errno.h>
 #include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
 #include <sys/wait.h>
-#include <sys/types.h>
-#include "test.h"
+#include "tst_test.h"
 
-char *TCID = "pipe02";
-int TST_TOTAL = 1;
+#define SIZE	5
 
-int usrsig;
+static int count;
+static int fd[2];
+static char rdbuf[SIZE];
+static char wrbuf[SIZE];
 
-void do_child(void);
-void setup(void);
-void cleanup(void);
-void catch_usr2(int);
+static void catch_usr2(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	count = 1;
+}
 
-ssize_t do_read(int fd, void *buf, size_t count)
+static void do_child(void)
 {
-	ssize_t n;
+	SAFE_SIGNAL(SIGUSR2, catch_usr2);
+	SAFE_SIGNAL(SIGPIPE, SIG_DFL);
+	SAFE_CLOSE(fd[0]);
+	SAFE_WRITE(1, fd[1], wrbuf, SIZE);
 
-	do {
-		n = read(fd, buf, count);
-	} while (n < 0 && errno == EINTR);
+	while (!count)
+		sleep(1);
 
-	return n;
+	SAFE_WRITE(1, fd[1], wrbuf, SIZE);
 }
 
-int pp[2];			/* pipe descriptor */
-
-int main(int ac, char **av)
+static void verify_pipe(void)
 {
-	int lc;
-	char rbuf[BUFSIZ], wbuf[BUFSIZ];
-	int pid, ret, len, rlen, status;
+	int status;
 	int sig = 0;
+	pid_t pid;
 
-	usrsig = 0;
+	count = 0;
+	memset(wrbuf, 'a', SIZE);
 
-	tst_parse_opts(ac, av, NULL, NULL);
 #ifdef UCLINUX
-	maybe_run_child(&do_child, "dd", &pp[0], &pp[1]);
+	maybe_run_child(&do_child, "dd", &fd[0], &fd[1]);
 #endif
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		ret = pipe(pp);
-		if (ret == -1)
-			tst_brkm(TFAIL, cleanup, "pipe() failed, errno %d",
-				 errno);
+	TEST(pipe(fd));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL|TERRNO, "pipe() failed");
+		return;
+	}
 
-		strcpy(wbuf, "abcd\0");
-		len = strlen(wbuf);
+	pid = SAFE_FORK();
+	if (pid < 0) {
+		tst_brk(TBROK, "fork() failed");
+	} else if (pid == 0) {
 
-		pid = FORK_OR_VFORK();
-		if (pid < 0)
-			tst_brkm(TFAIL, cleanup, "fork() failed, errno %d",
-				 errno);
-		if (pid == 0) {
-			/* CHILD */
 #ifdef UCLINUX
-			if (self_exec(av[0], "dd", pp[0], pp[1]) < 0) {
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-			}
+		if (self_exec(av[0], "dd", fd[0], fd[1]) < 0)
+			tst_brk(TBROK, "self_exec failed");
 #else
-			do_child();
+		do_child();
 #endif
-		} else {
-			/* PARENT */
-			close(pp[1]);	/* close write end of pipe */
-			memset(rbuf, 0, sizeof(rbuf));
-			rlen = do_read(pp[0], rbuf, len);
-			if (memcmp(wbuf, rbuf, len) != 0)
-				tst_resm(TFAIL, "pipe read data and pipe "
-					 "write data didn't match");
-			close(pp[0]);	/* close read end of pipe */
-			kill(pid, SIGUSR2);
-			wait(&status);
-
-			if (WIFSIGNALED(status))
-				sig = WTERMSIG(status);
+
+	} else {
+		memset(rdbuf, 0, SIZE);
+		SAFE_CLOSE(fd[1]);
+		SAFE_READ(1, fd[0], rdbuf, SIZE);
+
+		if (memcmp(wrbuf, rdbuf, SIZE) != 0) {
+			tst_res(TFAIL, "pipe read data and pipe "
+				"write data didn't match");
+			return;
+		}
+
+		SAFE_CLOSE(fd[0]);
+		SAFE_KILL(pid, SIGUSR2);
+		SAFE_WAIT(&status);
+
+		if (WIFSIGNALED(status)) {
+			sig = WTERMSIG(status);
 			if (sig != SIGPIPE)
-				tst_resm(TFAIL, "SIGPIPE not returned by "
+				tst_res(TFAIL, "SIGPIPE not returned by "
 					 "child process");
 			else
-				tst_resm(TPASS, "child process returned "
+				tst_res(TPASS, "child process returned "
 					 "expected SIGPIPE");
 		}
 	}
-	cleanup();
-
-	tst_exit();
-}
-
-void catch_usr2(int sig)
-{
-	usrsig = 1;
 }
 
-/*
- * do_child()
- */
-void do_child(void)
-{
-	char wbuf[BUFSIZ];
-	int len;
-
-	strcpy(wbuf, "abcd\0");
-	len = strlen(wbuf);
-
-	if (signal(SIGUSR2, catch_usr2) == SIG_ERR)
-		tst_resm(TWARN, "signal setup for SIGUSR2 " "failed");
-	if (signal(SIGPIPE, SIG_DFL) == SIG_ERR)
-		tst_resm(TWARN, "signal setup for SIGPIPE " "failed");
-	close(pp[0]);		/* close read end of pipe */
-	write(pp[1], wbuf, len);
-	while (!usrsig)
-		sleep(1);
-	write(pp[1], wbuf, len);
-	exit(1);
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.tid = "pipe02",
+	.forks_child = 1,
+	.test_all = verify_pipe,
+};
-- 
1.8.3.1



