Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Yi.Zhao@windriver.com>) id 1Qz0Df-00022g-2g
	for ltp-list@lists.sourceforge.net; Thu, 01 Sep 2011 05:53:43 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qz0Db-0002pL-PM
	for ltp-list@lists.sourceforge.net; Thu, 01 Sep 2011 05:53:42 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p815rV0k021466
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 31 Aug 2011 22:53:31 -0700 (PDT)
From: Yi Zhao <yi.zhao@windriver.com>
Date: Thu, 1 Sep 2011 13:53:27 +0800
Message-ID: <1314856407-9740-1-git-send-email-yi.zhao@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] rt_sigqueueinfo01: Fix test failed on mips.
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

rt_sigqueueinfo01 case test failed on mips arch:
	rt_sigqueueinfo01    1  TFAIL  :  Test Failed
	rt_sigqueueinfo01    2  TFAIL  :  Test Failed

We are sending signal 17 that could be SIGUSR2, SIGCHILD or SIGSTOP and depends on hardware platform.
On x86, arm, and powerpc, this number is defined to SIGCHILD. So in this case I think it should be SIGCHILD.
However, on mips this number is defined to SIGUSR2 and SIGCHILD is defined as 18. 
This made the test case failed. I think that symbolic name rather than number should be used.

And this patch also add a a missing brace.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c   |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
index da3c403..61b1991 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
@@ -85,18 +85,19 @@ int main(int ac, char **av) {
 		else if (TEST_RETURN == 0) {
 			uinfo.si_errno = 0;
 			uinfo.si_code = SI_QUEUE;
-			TEST(syscall(__NR_rt_sigqueueinfo, getpid(), 17,
+			TEST(syscall(__NR_rt_sigqueueinfo, getpid(), SIGCHLD,
 			    &uinfo));
 			if (TEST_RETURN != 0)
 				err(1, "rt_sigqueueinfo");
 			exit(0);
-		} else
+		} else {
 			wait(&status);
 			if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
 				tst_resm(TPASS, "Test Succeeded");
 			else
 				tst_resm(TFAIL, "Test Failed");
+		}
 		cleanup();
 	}
 	tst_exit();
-}
\ No newline at end of file
+}
-- 
1.7.1


------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
