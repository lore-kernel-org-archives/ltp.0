Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sukadev@linux.vnet.ibm.com>) id 1MH4Zw-0001aP-N9
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 23:30:04 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MH4Yy-00058c-IW
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 23:30:04 +0000
Date: Wed, 17 Jun 2009 16:26:03 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Message-ID: <20090617232603.GA27168@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] pidns17 testcase bugfix/cleanup
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
To: subrata@linux.vnet.ibm.com
Cc: mohankumar@in.ibm.com, ssant@in.ibm.com, sukadev@linux.vnet.ibm.com, ltp-list@lists.sf.net


Fix minor bugs in the test case that cause the test to fail intermittently.
Also, print more debug info when test fails.

This fixes a bug reported by Sachin P. Sant.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 testcases/kernel/containers/pidns/pidns17.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: ltp-full-20090331/testcases/kernel/containers/pidns/pidns17.c
===================================================================
--- ltp-full-20090331.orig/testcases/kernel/containers/pidns/pidns17.c	2009-06-10 23:52:44.022094621 -0700
+++ ltp-full-20090331/testcases/kernel/containers/pidns/pidns17.c	2009-06-11 00:09:37.454753439 -0700
@@ -74,8 +74,10 @@ int child_fn(void *arg)
 
 	/* Spawn many children */
 	for (i = 0; i < 10; i++)
-		if ((children[i] = fork()) == 0)
-			sleep(10);
+		if ((children[i] = fork()) == 0) {
+			pause();
+			exit(2);
+		}
 
 	/* wait for last child to get scheduled */
 	sleep(1);
@@ -86,13 +88,16 @@ int child_fn(void *arg)
 	}
 
 	for (i = 0; i < 10; i++) {
-		if (waitpid(children[i], &status, WNOHANG) == -1) {
+		if (waitpid(children[i], &status, 0) == -1) {
 			tst_resm(TBROK, "cinit: waitpid() failed(%s)",\
 					strerror(errno));
 			cleanup();
 		}
-		if (!(WIFSIGNALED(&status) && WTERMSIG(status) == SIGUSR1)) {
-			tst_resm(TFAIL, "cinit: found a child alive still.");
+		if (!(WIFSIGNALED(status) && WTERMSIG(status) == SIGUSR1)) {
+			tst_resm(TFAIL, "cinit: found a child alive still "
+					"%d exit: %d, %d, signal %d, %d", i,
+					WIFEXITED(status), WEXITSTATUS(status),
+					WIFSIGNALED(status), WTERMSIG(status));
 			cleanup();
 		}
 	}
@@ -125,7 +130,7 @@ int main(int argc, char *argv[])
 	}
 
 	sleep(1);
-	if (wait(&status) < 0)
+	if (waitpid(-1, &status, __WALL) < 0)
 		tst_resm(TWARN, "parent: waitpid() failed.");
 
 	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
