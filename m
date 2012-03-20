Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <salvatore.cro@st.com>) id 1SA1AP-0004Ks-2K
	for ltp-list@lists.sourceforge.net; Tue, 20 Mar 2012 15:40:09 +0000
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SA1AJ-0008AJ-CP
	for ltp-list@lists.sourceforge.net; Tue, 20 Mar 2012 15:40:09 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82ADE114
	for <ltp-list@lists.sourceforge.net>;
	Tue, 20 Mar 2012 15:39:55 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B764425BD
	for <ltp-list@lists.sourceforge.net>;
	Tue, 20 Mar 2012 15:39:54 +0000 (GMT)
From: "Salvatore CRO'" <salvatore.cro@st.com>
Date: Tue, 20 Mar 2012 16:39:49 +0100
Message-Id: <1332257989-22829-1-git-send-email-salvatore.cro@st.com>
Subject: [LTP] [PATCH] setrlimit01: wait for all children to exit in test3
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

In test3, parent just wait for one child to exit but it
actually has 10.
As it could happen there may be other children around that
didn't get yet the chance to exit, they will get signaled
by ltp-pan (SIGTERM) and pollute the output of subsequent
test (setrlimit02).
Parent definitely needs to wait for all children to exit.

Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index ac32450..430835c 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -267,7 +267,7 @@ void test3()
 			exit(0);
 		}
 	}
-	waitpid(pid, &status, 0);
+	while(wait(&status) > 0) { /* no-op */ ; }
 	if (WEXITSTATUS(status) != 0) {
 		tst_resm(TFAIL, "RLIMIT_NPROC functionality is not correct");
 	} else {
-- 
1.7.4.4


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
