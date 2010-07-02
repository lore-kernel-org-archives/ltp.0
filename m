Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OUZh6-0004Yn-Cr
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:48 +0000
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUZh5-0002Qc-0a
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:48 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id o626PcJF004475
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:38 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o626PXk52076810
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o626PXM6004675
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 16:25:33 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Fri,  2 Jul 2010 11:55:23 +0530
Message-Id: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 0/7] realtime/testpi-4: code cleanup and functional
	changes on testpi-4
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

Following set of patches applies code cleanup and functional changes
in LTP realtime pi-test testpi-4. This test was not patched earlier
when other pi-tests were fixed, with the intension of removing it
from the suite due to similarity with testpi-1. But we decided to
keep this test due to dynamically created global mutex lock.

Order of applying patch is:

[PATCH 1/7] realtime/testpi-4: code cleanup on pi-test 4
[PATCH 2/7] realtime/testpi-4: reuse init_pi_mutex from librttest
[PATCH 3/7] realtime/testpi-4: add test description
[PATCH 4/7] realtime/testpi-4: threads need not set cpu affinity while main does
[PATCH 5/7] realtime/testpi-4: use busy_work_ms from librttest to burn cpu cycles
[PATCH 6/7] realtime/testpi-4: remove thread_stop which is not used anywhere
[PATCH 7/7] realtime/testpi-4: synchronization fixes for high priority noise thread

Thanks,
Gowri


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
