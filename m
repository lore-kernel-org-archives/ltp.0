Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VWlOe-0007yz-19
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 11:05:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VWlOd-00010Z-1l
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 11:05:39 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9HB5XBp013486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Oct 2013 07:05:33 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id r9HB5Uj8014903
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Oct 2013 07:05:32 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Oct 2013 13:05:26 +0200
Message-Id: <8b67d5899fcf7196cf6c12ed3a506aac0c33c1ae.1382007845.git.jstancek@redhat.com>
In-Reply-To: <c4b2fd5ad2a7f04ee4979d3a9d6aa967006af688.1382007845.git.jstancek@redhat.com>
References: <c4b2fd5ad2a7f04ee4979d3a9d6aa967006af688.1382007845.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/2] getrusage04: skip it on Xen
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

Skip this test on Xen, as it is known to fail, presumably because
Xen is not able to account virtual CPU time with same accuracy
as on the real CPU.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/getrusage/getrusage04.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index 96e24a4..fa5fe2d 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -205,6 +205,9 @@ static void setup(void)
 {
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
+	if (tst_is_virt(VIRT_XEN))
+		tst_brkm(TCONF, NULL, "This testcase is not supported on Xen.");
+
 	BIAS_MAX = guess_timer_resolution();
 
 	TEST_PAUSE;
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
