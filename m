Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z5EdG-0001zp-V0
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2015 14:48:02 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z5EdF-0005x7-KZ
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2015 14:48:02 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id B97EDB8BBF
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2015 14:47:55 +0000 (UTC)
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t5HElsxP020444
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Jun 2015 10:47:55 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Jun 2015 16:47:49 +0200
Message-Id: <6ad648e0b674845a19073ebd7afcb8ec82f3f891.1434551926.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] kmsg01: avoid infinite run in test_read_block()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

If system continues to produce log entries, test_read_block()
may never end, because it won't reach EOF neither timeout.

This has been observed with x38_edac in debug kernel, where
this module keeps producing periodic log entries.

The test already has a timeout on single read, this patch
adds overall timeout for all reads combined to not cross
over specified value. This should prevent testcase from
running in infinite loop in case log entries are generated
periodically / indefinitely.

It also adds seek to end of kmsg for block/nonblock read tests
as it is not necessary to go through whole content entry by entry.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/logging/kmsg/kmsg01.c | 36 ++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index 4e24298..4307947 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -52,7 +52,8 @@
 #define NUM_READ_MSGS 3
 #define NUM_READ_RETRY 10
 #define NUM_OVERWRITE_MSGS 1024
-#define READ_TIMEOUT 5
+#define SINGLE_READ_TIMEOUT 2
+#define READ_TIMEOUT_MS (30*1000)
 
 char *TCID = "kmsg01";
 static void setup(void);
@@ -196,11 +197,12 @@ static int timed_read(int fd, int timeout_sec)
  *    -1 on read error, errno reflects read() errno
  *    -2 on timeout
  */
-static int timed_read_kmsg(int fd, int timeout_sec)
+static int timed_read_kmsg(int fd, int timeout_ms)
 {
 	int child, status, ret = 0;
 	int pipefd[2];
 	char msg[MAX_MSGSIZE];
+	long long elapsed_ms = 0;
 
 	if (pipe(pipefd) != 0)
 		tst_brkm(TBROK|TERRNO, cleanup, "pipe failed");
@@ -231,11 +233,22 @@ static int timed_read_kmsg(int fd, int timeout_sec)
 	SAFE_CLOSE(cleanup, pipefd[1]);
 
 	/* parent reads pipe until it reaches eof or until read times out */
+	tst_timer_start(CLOCK_MONOTONIC);
 	do {
-		TEST(timed_read(pipefd[0], timeout_sec));
-	} while (TEST_RETURN > 0);
+		TEST(timed_read(pipefd[0], SINGLE_READ_TIMEOUT));
+		tst_timer_stop();
+		elapsed_ms = tst_timer_elapsed_ms();
+	} while (TEST_RETURN > 0 && elapsed_ms < timeout_ms);
 	SAFE_CLOSE(cleanup, pipefd[0]);
 
+	if (elapsed_ms >= timeout_ms) {
+		/* this is not necessarily error, kernel or user-space
+		 * process may generate messages at higher rate than what
+		 * we would consider as 'blocked', see SINGLE_READ_TIMEOUT */
+		tst_resm(TWARN, "reads taking too long, giving up");
+		TEST_RETURN = -2;
+	}
+
 	/* child is blocked, kill it */
 	if (TEST_RETURN == -2)
 		kill(child, SIGTERM);
@@ -261,7 +274,12 @@ static void test_read_nonblock(void)
 	if (fd < 0)
 		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
 
-	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
+	if (lseek(fd, 0, SEEK_END) == -1)
+		tst_resm(TFAIL|TERRNO, "SEEK_END 0 failed");
+
+	/* /dev/kmsg opened with O_NONBLOCK will return EAGAIN when
+	 * no more records are available */
+	TEST(timed_read_kmsg(fd, READ_TIMEOUT_MS));
 	if (TEST_RETURN == -1 && TEST_ERRNO == EAGAIN)
 		tst_resm(TPASS, "non-block read returned EAGAIN");
 	else
@@ -279,7 +297,12 @@ static void test_read_block(void)
 	if (fd < 0)
 		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
 
-	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
+	if (lseek(fd, 0, SEEK_END) == -1)
+		tst_resm(TFAIL|TERRNO, "SEEK_END 0 failed");
+
+	/* /dev/kmsg opened without O_NONBLOCK will block on read when
+	 * no more records are available */
+	TEST(timed_read_kmsg(fd, READ_TIMEOUT_MS));
 	if (TEST_RETURN == -2)
 		tst_resm(TPASS, "read blocked");
 	else
@@ -582,6 +605,7 @@ static void setup(void)
 	if (tst_kvercmp(3, 5, 0) < 0)
 		tst_brkm(TCONF, NULL, "This test requires kernel"
 			" >= 3.5.0");
+	tst_timer_check(CLOCK_MONOTONIC);
 	srand(getpid());
 	TEST_PAUSE;
 }
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
