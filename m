Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MDd18-0007S7-LM
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:27:54 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDd0V-0004Qx-BN
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:27:54 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id E2A8210228F96
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Jun 2009 13:26:11 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MDczT-00086J-00
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 13:26:11 +0200
From: Jiri Palecek <jpalecek@web.de>
Date: Mon, 8 Jun 2009 13:29:48 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906081329.48616.jpalecek@web.de>
Subject: [LTP] [PATCH] Remove the signal-waiting logic from create_sig_proc()
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

 In create_sig_proc, the child process waits for the parent to wake it
 with a signal. This doesn't actually solve anything, and the
 implementation with pause() syscall is inherently racy (the race
 results in a deadlock). This patch removes it; it doesn't make the
 function race-free (it's possible the child will send the signal
 before the parent had chance to run), but this is the best you can
 get.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/utils/common_j_h.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
index cda3198..d122ff9 100644
--- a/testcases/kernel/syscalls/utils/common_j_h.c
+++ b/testcases/kernel/syscalls/utils/common_j_h.c
@@ -102,23 +102,14 @@ int cleanup_euid(uid_t old_uid)
 /*
  * Generate a child process which will send a signal
  */
-static void sighandler_for_sig_proc(int sig)
-{
-	if (sig == SIGUSR2)
-		return;
-	return;
-}
-
 pid_t create_sig_proc(unsigned long usec, int sig)
 {
 	pid_t pid, cpid;
 
-	signal(SIGUSR2, sighandler_for_sig_proc);
 	pid = getpid();
 	cpid = fork();
 	switch (cpid) {
 	case 0:
-		pause();
 		usleep(usec);
 		kill(pid, sig);
 		_exit(0);
@@ -127,7 +118,6 @@ pid_t create_sig_proc(unsigned long usec, int sig)
 		EPRINTF("fork failed.\n");
 		return cpid;
 	default:
-		kill(cpid, SIGUSR2);
 		return cpid;
 	}
 }
-- 
1.6.2.4


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
