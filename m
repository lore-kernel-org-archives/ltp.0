Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PhveS-0001D5-Mv
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 03:02:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhveR-0001g8-7A
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 03:02:32 +0000
Message-ID: <4D3F8E97.2030909@cn.fujitsu.com>
Date: Wed, 26 Jan 2011 11:01:43 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH]fix functional/threads/pi_test/pitest-4 test
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

TB1 has a lower priority than TFs, it has not chance to run.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../functional/threads/pi_test/pitest-4.c          |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index ad940dc..93e44b6 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -69,13 +69,13 @@ struct thread_param
 	volatile unsigned progress;
 } tp[] = {
 	{ 0,   0,   0, 1, SCHED_FIFO, "TL",  0, 0, 0, 0 },
-	{ 1,   0, 100, 3, SCHED_FIFO, "TP",  0, 0, 0, 0 },
-	{ 2,   0,   0, 4, SCHED_FIFO, "TF",  1, 0, 0, 0 },
-	{ 3,   0,   0, 4, SCHED_FIFO, "TF",  2, 0, 0, 0 },
-	{ 4,   0,   0, 4, SCHED_FIFO, "TF",  3, 0, 0, 0 },
-	{ 5,   0,   0, 4, SCHED_FIFO, "TF",  4, 0, 0, 0 },
-	{ 6,   0,   0, 4, SCHED_FIFO, "TF",  5, 0, 0, 0 },
-	{ 7,   0,   0, 4, SCHED_FIFO, "TF",  6, 0, 0, 0 }
+	{ 1,   0, 100, 4, SCHED_FIFO, "TP",  0, 0, 0, 0 },
+	{ 2,   0,   0, 2, SCHED_FIFO, "TF",  1, 0, 0, 0 },
+	{ 3,   0,   0, 2, SCHED_FIFO, "TF",  2, 0, 0, 0 },
+	{ 4,   0,   0, 2, SCHED_FIFO, "TF",  3, 0, 0, 0 },
+	{ 5,   0,   0, 2, SCHED_FIFO, "TF",  4, 0, 0, 0 },
+	{ 6,   0,   0, 2, SCHED_FIFO, "TF",  5, 0, 0, 0 },
+	{ 7,   0,   0, 2, SCHED_FIFO, "TF",  6, 0, 0, 0 }
 };
 
 volatile unsigned do_work_dummy;
@@ -180,7 +180,7 @@ void *thread_tb1(void *arg)
 	double t0, t1;
 	int rc;
 
-	test_set_priority(pthread_self(),SCHED_FIFO, 2);
+	test_set_priority(pthread_self(), SCHED_FIFO, 3);
 	DPRINTF(stderr,"Thread TB1: started\n");
 	DPRINTF(stdout, "#EVENT %f Thread TB1 Started\n",
 		seconds_read() - base_time);
@@ -212,7 +212,7 @@ void *thread_tb2(void *arg)
 	double t0, t1;
 	int rc;
 
-	test_set_priority(pthread_self(),SCHED_FIFO, 5);
+	test_set_priority(pthread_self(), SCHED_FIFO, 5);
 	DPRINTF(stderr,"Thread TB2: started\n");
 	DPRINTF(stdout, "#EVENT %f Thread TB2 Started\n",
 		seconds_read() - base_time);
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


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
