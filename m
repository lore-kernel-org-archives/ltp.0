Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <harsh@linux.vnet.ibm.com>) id 1OgE2U-0003E3-1r
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 09:44:02 +0000
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OgE2S-0000vx-Ds
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 09:44:02 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o739hnqL021661
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Aug 2010 19:43:49 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o739hqWK1650804
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Aug 2010 19:43:52 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o739hqB1016114
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Aug 2010 19:43:52 +1000
From: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
Date: Tue,  3 Aug 2010 15:13:46 +0530
Message-Id: <1280828626-9759-1-git-send-email-harsh@linux.vnet.ibm.com>
Subject: [LTP] [PATCH] setrlimit testcase fix Current testcase for setrlimit
	for parameter RLIMIT_FSIZE does not convey the number of
	bytes actually written from child process to parent,
	as the child process writes to its own copy of global variable. This
	patch introduces a pipe to send the information from child to
	the parent process.
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

Signed-off-by: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit01.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index 6952eb3..d8949c6 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -156,7 +156,12 @@ void test2()
 	 * an wired value!  So, it is essential to fflush the parent's
 	 * write buffer HERE
 	 */
+	int pipefd[2];
 	fflush(stdout);
+	if (pipe(pipefd) == -1) {
+		perror("pipe");
+		exit(EXIT_FAILURE);
+	}
 
 	/*
 	 * Spawn a child process, and reduce the filesize to
@@ -170,6 +175,7 @@ void test2()
 	}
 
 	if (pid == 0) {
+		close(pipefd[0]); /* close unused read end */
 		rlim.rlim_cur = 10;
 		rlim.rlim_max = 10;
 		if ((setrlimit(RLIMIT_FSIZE, &rlim)) == -1) {
@@ -181,6 +187,8 @@ void test2()
 		}
 
 		if ((bytes = write(fd, buf, 26)) != 10) {
+			write(pipefd[1], &bytes, sizeof(bytes));
+			close(pipefd[1]); /* EOF */
 			exit(3);
 		}
 		exit(0);	/* success */
@@ -202,6 +210,9 @@ void test2()
 		tst_resm(TFAIL, "creating testfile failed");
 		break;
 	case 3:
+		close(pipefd[1]); /* close unused write end */
+		read(pipefd[0], &bytes, sizeof(bytes));
+		close(pipefd[0]);
 		tst_resm(TFAIL, "setrlimit failed, expected "
 			 "10 got %d", bytes);
 		break;
-- 
1.7.1.1


------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
