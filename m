Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OV715-0003dB-OJ
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:00:39 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OV713-0002pX-H6
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:00:39 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o63HxLnD015423
	for <ltp-list@lists.sourceforge.net>; Sat, 3 Jul 2010 13:59:21 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o63I0VBN134516
	for <ltp-list@lists.sourceforge.net>; Sat, 3 Jul 2010 14:00:31 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o63I0VYE027576
	for <ltp-list@lists.sourceforge.net>; Sat, 3 Jul 2010 15:00:31 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Date: Sat, 03 Jul 2010 23:30:21 +0530
Message-Id: <1278180022.7665.18.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 0/7] realtime/testpi-4: code cleanup and
	functional	changes on testpi-4
Reply-To: subrata@linux.vnet.ibm.com
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
To: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Cc: Linux Test Project <ltp-list@lists.sourceforge.net>

On Fri, 2010-07-02 at 11:55 +0530, Gowrishankar wrote: 
> Following set of patches applies code cleanup and functional changes
> in LTP realtime pi-test testpi-4. This test was not patched earlier
> when other pi-tests were fixed, with the intension of removing it
> from the suite due to similarity with testpi-1. But we decided to
> keep this test due to dynamically created global mutex lock.
> 
> Order of applying patch is:
> 
> [PATCH 1/7] realtime/testpi-4: code cleanup on pi-test 4
> [PATCH 2/7] realtime/testpi-4: reuse init_pi_mutex from librttest
> [PATCH 3/7] realtime/testpi-4: add test description
> [PATCH 4/7] realtime/testpi-4: threads need not set cpu affinity while main does
> [PATCH 5/7] realtime/testpi-4: use busy_work_ms from librttest to burn cpu cycles
> [PATCH 6/7] realtime/testpi-4: remove thread_stop which is not used anywhere
> [PATCH 7/7] realtime/testpi-4: synchronization fixes for high priority noise thread

Applied in order. Thanks.

Regards--
Subrata

> 
> Thanks,
> Gowri
> 


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
