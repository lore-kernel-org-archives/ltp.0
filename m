Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIYCA-0004Sn-8t
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:19:38 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIYC9-0007bl-58
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:19:38 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id E40A9100C56E4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 02:20:02 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277) id 1MIXGU-00081i-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:20:02 +0200
Date: Tue, 12 May 2009 19:06:15 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwgn0focfnueu@debian>
Subject: [LTP] [PATCH] Fix cleanup procedure in the setuid04 test
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090512170615.lXAlXfnakcorheEVFXt4uXZiIeFW1tj9M08HFkonwLQ@z>

 Cleanup has to be made only once in the parent process; when the
 child makes the cleanup itself, the parent has nothing to cleanup,
 which makes him sad.

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/setuid/setuid04.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/setuid/setuid04.c b/testcases/kernel/syscalls/setuid/setuid04.c
index 18f1d90..26a3868 100644
--- a/testcases/kernel/syscalls/setuid/setuid04.c
+++ b/testcases/kernel/syscalls/setuid/setuid04.c
@@ -114,7 +114,7 @@ void do_master_child()
 	int status;
 
 	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_brkm(TBROK, cleanup,
+		tst_brkm(TBROK, tst_exit,
 			 "setuid failed to set the effective uid to %d",
 			 ltpuser->pw_uid);
 	}
@@ -143,7 +143,7 @@ void do_master_child()
 
 		pid = FORK_OR_VFORK();
 		if (pid < 0)
-			tst_brkm(TBROK, cleanup, "Fork failed");
+			tst_brkm(TBROK, tst_exit, "Fork failed");
 
 		if (pid == 0) {
 			int tst_fd2;
@@ -160,13 +160,12 @@ void do_master_child()
 
 			if (TEST_ERRNO == EACCES) {
 				tst_resm(TPASS, "open returned errno EACCES");
-				exit(0);
 			} else {
 				tst_resm(TFAIL,
 					 "open returned unexpected errno - %d",
 					 TEST_ERRNO);
-				exit(-1);
 			}
+			tst_exit();
 		} else {
 			/* Wait for son completion */
 			waitpid(pid, &status, 0);
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
