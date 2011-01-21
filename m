Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1Pg85p-0000FT-RW
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 03:55:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pg85m-0001KZ-2b
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 03:55:21 +0000
Message-ID: <4D3903AC.2070901@cn.fujitsu.com>
Date: Fri, 21 Jan 2011 11:55:24 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D37EB92.3060901@cn.fujitsu.com>
	<AANLkTin4N+xuTwQP2w7WtGvO20qdsa2mEjeiMi5fFK2d@mail.gmail.com>
In-Reply-To: <AANLkTin4N+xuTwQP2w7WtGvO20qdsa2mEjeiMi5fFK2d@mail.gmail.com>
Subject: Re: [LTP] [PATCH] mprotect02: fix error of the case need
	sighandler()
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

Garrett Cooper said the following on 2011-1-20 17:28:
>> The case expect the signal "SIGSEGV", so should add sighandler().
> 
> For the first portion of the testcase, yes. For the second part of the
> testcase, no.

This is OK, but the default signal handler is invoked when an unexpected signal
is caught. so I think we should add sighandler(). Furthermore, the default
signal handler make the child process exit 2, but the case expect the child
process exit 1, this will cause the case fail.

The following patch will reinitialize signal handler.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 testcases/kernel/syscalls/mprotect/mprotect02.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index ebc4bcc..c0a5d8b 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -129,6 +129,9 @@ int main(int ac, char **av)
 			tst_brkm(TBROK, cleanup, "child failed");
 		 }
 
+		/* Re-Initialization signal handler */
+		tst_sig(FORK, DEF_HANDLER, NULL);
+
 		/*
 		 * Change the protection to WRITE.
 		 */
@@ -198,12 +201,21 @@ int main()
 
 #endif /* UCLINUX */
 
+void sighandler(int sig)
+{
+	tst_resm(TINFO, "received signal: %d", sig);
+	if (sig == SIGSEGV)
+		exit(1);
+	else
+		tst_brkm(TBROK, 0, "Unexpected signal %d received.", sig);
+}
+
 /*
  * setup() - performs all ONE TIME setup for this test
  */
 void setup()
 {
-	tst_sig(FORK, DEF_HANDLER, NULL);
+	tst_sig(FORK, sighandler, NULL);
 
 	TEST_PAUSE;
 
-- 
1.7.3.1


-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
