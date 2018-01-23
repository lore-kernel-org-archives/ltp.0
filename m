From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jan 2018 17:41:16 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/4] syscalls/write: write05 new test
	library refactoring
In-Reply-To: <20180123164117.3052-1-chrubis@suse.cz>
References: <20180123164117.3052-1-chrubis@suse.cz>
Message-ID: <20180123164117.3052-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

From: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/write/write05.c | 235 +++++++++---------------------
 1 file changed, 70 insertions(+), 165 deletions(-)

diff --git a/testcases/kernel/syscalls/write/write05.c b/testcases/kernel/syscalls/write/write05.c
index bcbe85874..ec157ae28 100644
--- a/testcases/kernel/syscalls/write/write05.c
+++ b/testcases/kernel/syscalls/write/write05.c
@@ -1,6 +1,9 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 Ported by John George
+ *      04/2002 wjhuie sigset cleanups
+ *      08/2007 Ricardo Salveti de Araujo <rsalveti@linux.vnet.ibm.com>
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -18,199 +21,101 @@
  */
 
 /*
- * NAME
- *	write05.c
- *
  * DESCRIPTION
  *	Check the return value, and errnos of write(2)
  *	- when the file descriptor is invalid - EBADF
  *	- when the buf parameter is invalid - EFAULT
  *	- on an attempt to write to a pipe that is not open for reading - EPIPE
- *
- * ALGORITHM
- *	Attempt to write on a file with negative file descriptor, check for -1
- *	Attempt to write on a file with invalid buffer, check for -1
- *	Open a pipe and close the read end, attempt to write to the write
- *	end, check for -1.
- *
- * USAGE:  <for command-line>
- *      write05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -e   : Turn on errno logging.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *      04/2002 wjhuie sigset cleanups
- *      08/2007 Ricardo Salveti de Araujo <rsalveti@linux.vnet.ibm.com>
- *		- Closing the fd before removing the file
- *
- * Restrictions
- *	None
  */
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
-#include "test.h"
-
-void setup(void);
-void cleanup(void);
-
-char *TCID = "write05";
-int TST_TOTAL = 1;
-char filename[100];
-int fd;
-
-char *bad_addr = 0;
-
-int main(int argc, char **argv)
+#include "tst_test.h"
+
+static int fd;
+static int inv_fd = -1;
+static char b[32];
+static char *buf = b;
+static char *bad_addr;
+static int pipefd[2];
+
+static struct tcase {
+	int *fd;
+	char **buf;
+	size_t size;
+	int exp_errno;
+} tcases[] = {
+	{&inv_fd, &buf, sizeof(buf), EBADF},
+	{&fd, &bad_addr, sizeof(buf), EFAULT},
+	{&pipefd[1], &buf, sizeof(buf), EPIPE},
+};
+
+static int sigpipe_cnt;
+
+static void sighandler(int sig)
 {
-	int lc;
-
-	char pbuf[BUFSIZ];
-	int pipefildes[2];
-	int status, pid;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	/* global setup */
-	setup();
-
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-//block1:
-		tst_resm(TINFO, "Enter Block 1: test with bad fd");
-		if (write(-1, pbuf, 1) != -1) {
-			tst_resm(TFAIL, "write of invalid fd passed");
-		} else {
-			if (errno != EBADF) {
-				tst_resm(TFAIL, "expected EBADF got %d", errno);
-			}
-			tst_resm(TPASS, "received EBADF as expected.");
-		}
-		tst_resm(TINFO, "Exit Block 1");
-
-//block2:
-		tst_resm(TINFO, "Enter Block 2: test with a bad address");
-		fd = creat(filename, 0644);
-		if (fd < 0) {
-			tst_resm(TFAIL, "creating a new file failed");
-			cleanup();
-		}
-		if (write(fd, bad_addr, 10) != -1) {
-			tst_resm(TFAIL, "write() on an invalid buffer "
-				 "succeeded, but should have failed");
-			cleanup();
-		} else {
-			if (errno != EFAULT) {
-				tst_resm(TFAIL, "write() returned illegal "
-					 "errno: expected EFAULT, got %d",
-					 errno);
-				cleanup();
-			}
-			tst_resm(TPASS, "received EFAULT as expected.");
-		}
-		tst_resm(TINFO, "Exit Block 2");
-
-//block3:
-		tst_resm(TINFO, "Enter Block 3: test with invalid pipe");
-		if ((pid = FORK_OR_VFORK()) == 0) {	/* child */
-			if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) {
-				tst_resm(TINFO, "signal failed");
-			}
-			if (pipe(pipefildes) == -1) {
-				tst_brkm(TBROK, NULL, "can't open pipe");
-				exit(errno);
-			}
-			close(pipefildes[0]);
-			if (write(pipefildes[1], pbuf, 1) != -1) {
-				tst_resm(TFAIL, "write on read-closed"
-					 "pipe succeeded");
-				exit(-1);
-			} else {
-				if (errno != EPIPE) {
-					tst_resm(TFAIL, "write() failed to set"
-						 " errno to EPIPE, got: %d",
-						 errno);
-					exit(errno);
-				}
-				exit(0);
-			}
-		} else {
-			if (pid < 0) {
-				tst_resm(TFAIL, "Fork failed");
-			}
-			wait(&status);
-			if (WIFSIGNALED(status) &&
-				WTERMSIG(status) == SIGPIPE) {
-				tst_resm(TFAIL, "child set SIGPIPE in exit");
-			} else if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "exit status from child "
-					 "expected 0 got %d", status >> 8);
-			} else {
-				tst_resm(TPASS, "received EPIPE as expected.");
-			}
-			tst_resm(TINFO, "Exit Block 3");
-		}
-		close(fd);
-	}
-	cleanup();
-	tst_exit();
+	if (sig == SIGPIPE)
+		sigpipe_cnt++;
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void verify_write(unsigned int i)
 {
+	struct tcase *tc = &tcases[i];
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	sigpipe_cnt = 0;
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
+	TEST(write(*tc->fd, *tc->buf, tc->size));
 
-	/* Create a unique temporary directory and chdir() to it. */
-	tst_tmpdir();
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "write() succeeded unexpectedly");
+		return;
+	}
 
-	sprintf(filename, "write05.%d", getpid());
+	if (TEST_ERRNO != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
+			"write() failed unexpectedly, expected %s",
+			tst_strerrno(tc->exp_errno));
+		return;
+	}
 
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		printf("mmap failed\n");
+	if (tc->exp_errno == EPIPE && sigpipe_cnt != 1) {
+		tst_res(TFAIL, "sigpipe_cnt = %i", sigpipe_cnt);
+		return;
 	}
 
+	tst_res(TPASS | TTERRNO, "write() failed expectedly");
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
+static void setup(void)
 {
+	fd = SAFE_OPEN("write_test", O_RDWR | O_CREAT, 0644);
+
+	bad_addr = SAFE_MMAP(0, 1, PROT_NONE,
+			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+
+	SAFE_PIPE(pipefd);
+	SAFE_CLOSE(pipefd[0]);
 
-	/* Close the file descriptor befor removing the file */
-	close(fd);
+	SAFE_SIGNAL(SIGPIPE, sighandler);
+}
 
-	unlink(filename);
-	tst_rmdir();
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 
+	SAFE_MUNMAP(bad_addr, 1);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_write,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.13.6

