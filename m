Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1Tnmfr-0001Ji-Q0
	for ltp-list@lists.sourceforge.net; Wed, 26 Dec 2012 08:49:15 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tnmfq-0002cB-Lp
	for ltp-list@lists.sourceforge.net; Wed, 26 Dec 2012 08:49:15 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qBQ8n8Yu001465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Dec 2012 03:49:08 -0500
From: Monson Shao <jshao@redhat.com>
Date: Wed, 26 Dec 2012 16:48:37 +0800
Message-Id: <1356511717-31058-3-git-send-email-jshao@redhat.com>
In-Reply-To: <1356420393-4253-1-git-send-email-jshao@redhat.com>
References: <1356420393-4253-1-git-send-email-jshao@redhat.com>
Subject: [LTP] [PATCHv2 3/3] pidns16: child should not get parent pid in
	parent NS
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

parent pid in parent NS is invisible to child, even when child got signalled
from parent, the signaller process should be fake parent (PID 0).

Signed-off-by: Monson Shao <jshao@redhat.com>
---
 testcases/kernel/containers/pidns/pidns16.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index debc8d2..5b8247b 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -54,7 +54,6 @@
 
 char *TCID = "pidns16";
 int TST_TOTAL = 3;
-pid_t globalpid;
 
 /*
  * cleanup() - performs all ONE TIME cleanup for this test at
@@ -76,7 +75,7 @@ void child_signal_handler(int sig, siginfo_t * si, void *unused)
 
 	switch (c) {
 	case 1:
-		expected_pid = globalpid;
+		expected_pid = PARENT_PID;
 		break;
 	case 2:
 		expected_pid = CHILD_PID;
@@ -138,8 +137,6 @@ int main(int argc, char *argv[])
 	int status;
 	pid_t cpid;
 
-	globalpid = getpid();
-
 	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
 
 	if (cpid < 0) {
-- 
1.7.11.7


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
