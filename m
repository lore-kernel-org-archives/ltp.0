Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHURY-0004LL-IA
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:40 +0000
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHURX-0006CF-60
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:40 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R4BVhi006800
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:31 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R4BUsL3387484
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:30 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R4BULP021174
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:11:30 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:41:20 +0530
Message-Id: <1274933486-4876-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 0/5] realtime: functional changes improved in pi-tests
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

Following set of patches applies functional changes in pi-tests
for better reliability in recent kernels and their order is:

[PATCH 1/6] realtime: reuse init_pi_mutex from librttest
[PATCH 2/6] realtime: add test descriptions
[PATCH 3/6] realtime: threads need not set cpu affinity while main does
[PATCH 4/6] realtime: use busy_work_ms from librttest to burn cpu cycles
[PATCH 5/6] realtime: remove thread_stop which is not used anywhere
[PATCH 6/6] realtime: synchronization fixes for high priority noise thread

All need to be applied in their order on top or code clean up patch series
sent previously.

Thanks,
Gowri



------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
