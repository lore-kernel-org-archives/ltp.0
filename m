Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OTVI3-0000Mv-75
	for ltp-list@lists.sourceforge.net; Tue, 29 Jun 2010 07:31:31 +0000
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTVI1-0007Dv-SZ
	for ltp-list@lists.sourceforge.net; Tue, 29 Jun 2010 07:31:31 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5T7VHK4019525
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jun 2010 17:31:17 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5T7VIwC1384634
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jun 2010 17:31:18 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5T7VI7a024798
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jun 2010 17:31:18 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Tue, 29 Jun 2010 13:01:16 +0530
Message-Id: <1277796676-6407-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH] realtime: fix min and max calculations in matrix
	multiplication test
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
To: Linux Test Project <ltp-list@lists.sourceforge.net>
Cc: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

In matrix multiplication test, the min and max calculations are done on
stats_container_t data with its index field never set to the last
element position. Due to this min and max are always shown with the
first record value (as index was initiated with -1).

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/matrix_mult/matrix_mult.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/realtime/func/matrix_mult/matrix_mult.c b/testcases/realtime/func/matrix_mult/matrix_mult.c
index 419f697..fa0e352 100644
--- a/testcases/realtime/func/matrix_mult/matrix_mult.c
+++ b/testcases/realtime/func/matrix_mult/matrix_mult.c
@@ -222,6 +222,7 @@ void main_thread(void)
 
 	/* run matrix mult operation sequentially */
 	curdat = &sdat;
+	curdat->index = iterations-1;
 	printf("\nRunning sequential operations\n");
 	start = rt_gettime();
 	for (i = 0; i < iterations; i++)
@@ -252,6 +253,7 @@ void main_thread(void)
 	pthread_barrier_init(&mult_start, NULL, numcpus+1);
 	set_priority(PRIO);
 	curdat = &cdat;
+	curdat->index = iterations-1;
 	online_cpu_id = -1; /* Redispatch cpus */
 	/* Create numcpus-1 concurrent threads */
 	for (j = 0; j < numcpus; j++) {
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
