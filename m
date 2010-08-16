Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <harsh@linux.vnet.ibm.com>) id 1OkxyH-0001Ue-Um
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 11:35:17 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OkxyC-0003Cp-Am
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 11:35:17 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o7GBZ4eK016867
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 21:35:04 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7GBZ4481741002
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 21:35:04 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7GBZ4EG023241
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 21:35:04 +1000
From: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
Date: Mon, 16 Aug 2010 17:05:01 +0530
Message-Id: <1281958501-17087-1-git-send-email-harsh@linux.vnet.ibm.com>
Subject: [LTP] [PATCH] ltp setrlimit testcase patch for RLIMIT_FSIZE resource
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

Current testcase for setrlimit resource RLIMIT_FSIZE
is using a global integer variable to communicate the number of
bytes from child to parent which is incorrect. This
has been corrected by introducing a pipe to transfer
this information from child to parent process.

Signed-off-by: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit01.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index 6952eb3..2bb1e9d 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -156,7 +156,11 @@ void test2()
 	 * an wired value!  So, it is essential to fflush the parent's
 	 * write buffer HERE
 	 */
+	int pipefd[2];
 	fflush(stdout);
+	if (pipe(pipefd) == -1) {
+		tst_brkm(TBROK | TERRNO, NULL, "pipe creation failed");
+	}
 
 	/*
 	 * Spawn a child process, and reduce the filesize to
@@ -170,6 +174,7 @@ void test2()
 	}
 
 	if (pid == 0) {
+		close(pipefd[0]); /* close unused read end */
 		rlim.rlim_cur = 10;
 		rlim.rlim_max = 10;
 		if ((setrlimit(RLIMIT_FSIZE, &rlim)) == -1) {
@@ -181,6 +186,11 @@ void test2()
 		}
 
 		if ((bytes = write(fd, buf, 26)) != 10) {
+			if (write(pipefd[1], &bytes, sizeof(bytes))
+				< sizeof(bytes)) {
+				perror("child: write to pipe failed");
+			}
+			close(pipefd[1]); /* EOF */
 			exit(3);
 		}
 		exit(0);	/* success */
@@ -202,6 +212,11 @@ void test2()
 		tst_resm(TFAIL, "creating testfile failed");
 		break;
 	case 3:
+		close(pipefd[1]); /* close unused write end */
+		if (read(pipefd[0], &bytes, sizeof(bytes)) < sizeof(bytes)) {
+			tst_resm(TFAIL, "parent: reading pipe failed");
+		}
+		close(pipefd[0]);
 		tst_resm(TFAIL, "setrlimit failed, expected "
 			 "10 got %d", bytes);
 		break;
-- 
1.7.1.1


------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
