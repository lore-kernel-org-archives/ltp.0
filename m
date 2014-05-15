Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Wkt0J-0006qg-NZ
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 10:35:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wkt0H-0001Z1-LU
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 10:35:11 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4FAYZls007630
	for <ltp-list@lists.sourceforge.net>; Thu, 15 May 2014 18:34:36 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 15 May 2014 18:32:18 +0800
Message-ID: <1400149938-12805-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] sendfile/sendfile06.c: cleanup and fix some bugs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

If we run sendfile06 with "-i large number" option, we may get
EMFILE error, this is because we don't close the 'sockfd' and
'out_fd' file descriptor in do_sendfile(), fix this bug.

We also modify the code in do_child(), let child do not loop
'TEST_LOOPING(lc)'times. This makes no sense, and if we run with
"-i large number", this will slow down the program.

Delete some useless comments.
Use SAFE_* macros.
Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/sendfile/sendfile06.c | 182 +++++++++---------------
 1 file changed, 65 insertions(+), 117 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index 8e29f27..738f8e0 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -19,28 +19,14 @@
  */
 
 /*
- * NAME
- *	sendfile06.c
- *
  * DESCRIPTION
  *	Testcase to test that sendfile(2) system call updates file
  *	position of in_fd correctly when passing NULL as offset.
  *
- * USAGE:  <for command-line>
- *  sendfile06 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
  * HISTORY
  *	11/2007 Copyed from sendfile02.c by Masatake YAMATO
- *
- * RESTRICTIONS
- *	NONE
  */
+
 #include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
@@ -53,26 +39,26 @@
 #include <sys/mman.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <string.h>
 #include "usctest.h"
 #include "test.h"
+#include "safe_macros.h"
 
-#ifndef OFF_T
-#define OFF_T off_t
-#endif /* Not def: OFF_T */
 
 TCID_DEFINE(sendfile06);
 
-char in_file[100];
-char out_file[100];
-int out_fd;
-pid_t child_pid;
-static int sockfd, s;
+#define IN_FILE		"infile"
+#define OUT_FILE	"outfile"
+
+static pid_t child_pid;
+static int sockfd;
 static struct sockaddr_in sin1;	/* shared between do_child and create_server */
+static struct stat sb;
 
-void cleanup(void);
-void do_child(void);
-void setup(void);
-int create_server(void);
+static void cleanup(void);
+static void do_child(void);
+static void setup(void);
+static int create_server(void);
 
 int TST_TOTAL = 1;
 
@@ -80,22 +66,15 @@ int TST_TOTAL = 1;
 static char *argv0;
 #endif
 
-void do_sendfile(void)
+static void do_sendfile(void)
 {
-	int in_fd;
-	struct stat sb;
+	int in_fd, out_fd;
 	off_t after_pos;
-	int wait_status;
 	int wait_stat;
 
 	out_fd = create_server();
 
-	if ((in_fd = open(in_file, O_RDONLY)) < 0) {
-		tst_brkm(TBROK, cleanup, "open failed: %d", errno);
-	}
-	if (stat(in_file, &sb) < 0) {
-		tst_brkm(TBROK, cleanup, "stat failed: %d", errno);
-	}
+	in_fd = SAFE_OPEN(cleanup, IN_FILE, O_RDONLY);
 
 	TEST(sendfile(out_fd, in_fd, NULL, sb.st_size));
 	if ((after_pos = lseek(in_fd, 0, SEEK_CUR)) < 0) {
@@ -103,107 +82,79 @@ void do_sendfile(void)
 			 "lseek after invoking sendfile failed: %d", errno);
 	}
 
-	if (STD_FUNCTIONAL_TEST) {
-		/* Close the sockets */
-		shutdown(sockfd, SHUT_RDWR);
-		shutdown(s, SHUT_RDWR);
-		if (TEST_RETURN != sb.st_size) {
-			tst_resm(TFAIL, "sendfile(2) failed to return "
-				 "expected value, expected: %" PRId64 ", "
-				 "got: %ld", (int64_t) sb.st_size, TEST_RETURN);
-			kill(child_pid, SIGKILL);
-		} else if (after_pos != sb.st_size) {
-			tst_resm(TFAIL, "sendfile(2) failed to update "
-				 " the file position of in_fd, "
-				 "expected file position: %" PRId64 ", "
-				 "actual file position %" PRId64,
-				 (int64_t) sb.st_size, (int64_t) after_pos);
-			kill(child_pid, SIGKILL);
-		} else {
-			tst_resm(TPASS, "functionality of sendfile() is "
-				 "correct");
-			wait_status = waitpid(-1, &wait_stat, 0);
-		}
+	shutdown(sockfd, SHUT_RDWR);
+	shutdown(out_fd, SHUT_RDWR);
+	if (TEST_RETURN != sb.st_size) {
+		tst_resm(TFAIL, "sendfile(2) failed to return "
+			 "expected value, expected: %" PRId64 ", "
+			 "got: %ld", (int64_t) sb.st_size, TEST_RETURN);
+		SAFE_KILL(cleanup, child_pid, SIGKILL);
+	} else if (after_pos != sb.st_size) {
+		tst_resm(TFAIL, "sendfile(2) failed to update "
+			 " the file position of in_fd, "
+			 "expected file position: %" PRId64 ", "
+			 "actual file position %" PRId64,
+			 (int64_t) sb.st_size, (int64_t) after_pos);
+		SAFE_KILL(cleanup, child_pid, SIGKILL);
 	} else {
-		tst_resm(TPASS, "call succeeded");
-		/* Close the sockets */
-		shutdown(sockfd, SHUT_RDWR);
-		shutdown(s, SHUT_RDWR);
-		if (TEST_RETURN != sb.st_size) {
-			kill(child_pid, SIGKILL);
-		} else {
-			wait_status = waitpid(-1, &wait_stat, 0);
-		}
+		tst_resm(TPASS, "functionality of sendfile() is correct");
+		waitpid(-1, &wait_stat, 0);
 	}
 
-	close(in_fd);
+	SAFE_CLOSE(cleanup, in_fd);
+	SAFE_CLOSE(cleanup, out_fd);
+	SAFE_CLOSE(cleanup, sockfd);
 }
 
-/*
- * do_child
- */
-void do_child(void)
+static void do_child(void)
 {
-	int lc;
-	socklen_t length;
+	socklen_t length = sizeof(sin1);
 	char rbuf[4096];
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		length = sizeof(sin1);
-		recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1,
-			 &length);
+	ssize_t ret, bytes_total_received = 0;
+
+	while (bytes_total_received < sb.st_size) {
+		ret = recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1,
+			       &length);
+		if (ret < 0) {
+			fprintf(stderr, "child process recvfrom failed: %s\n",
+				strerror(errno));
+			exit(1);
+		}
+		bytes_total_received += ret;
 	}
+
 	exit(0);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
 	int fd;
-	char buf[100];
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* make a temporary directory and cd to it */
 	tst_tmpdir();
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
+
+	fd = SAFE_CREAT(cleanup, IN_FILE, 0600);
+
+	SAFE_WRITE(cleanup, 1, fd, "abcdefghijklmnopqrstuvwxyz", 26);
+
+	SAFE_FSTAT(cleanup, fd, &sb);
+
+	SAFE_CLOSE(cleanup, fd);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
-	close(out_fd);
-	/* delete the test directory created in setup() */
 	tst_rmdir();
-
 }
 
-int create_server(void)
+static int create_server(void)
 {
-	static int count = 0;
+	int s;
 	socklen_t slen = sizeof(sin1);
 
 	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
@@ -215,7 +166,7 @@ int create_server(void)
 	sin1.sin_family = AF_INET;
 	sin1.sin_port = 0; /* pick random free port */
 	sin1.sin_addr.s_addr = INADDR_ANY;
-	count++;
+
 	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
 		tst_brkm(TBROK, cleanup, "call to bind() failed: %s",
 			 strerror(errno));
@@ -230,6 +181,7 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
+
 	if (!child_pid) {	/* child */
 #ifdef UCLINUX
 		if (self_exec(argv0, "") < 0) {
@@ -254,13 +206,12 @@ int create_server(void)
 			 strerror(errno));
 	}
 	return s;
-
 }
 
 int main(int ac, char **av)
 {
 	int lc;
-	char *msg;		/* parse_opts() return message */
+	char *msg;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -272,15 +223,12 @@ int main(int ac, char **av)
 
 	setup();
 
-	/*
-	 * The following loop checks looping state if -c option given
-	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
 		do_sendfile();
 	}
-	cleanup();
 
+	cleanup();
 	tst_exit();
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
