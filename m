Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OIQh1-0002XY-Ro
	for ltp-list@lists.sourceforge.net; Sat, 29 May 2010 18:23:31 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OIQh1-0007P5-0m
	for ltp-list@lists.sourceforge.net; Sat, 29 May 2010 18:23:31 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o4TIAVtJ002127
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 14:10:31 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4TINPDX136710
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 14:23:25 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4TINPMf022360
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 14:23:25 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1274933486-4876-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
	<1274933486-4876-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Date: Fri, 28 May 2010 13:01:42 +0530
Message-Id: <1275031918.5418.22.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 0/5] realtime: functional changes improved in
	pi-tests
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

On Thu, 2010-05-27 at 09:41 +0530, Gowrishankar wrote: 
> Following set of patches applies functional changes in pi-tests
> for better reliability in recent kernels and their order is:
> 
> [PATCH 1/6] realtime: reuse init_pi_mutex from librttest
> [PATCH 2/6] realtime: add test descriptions
> [PATCH 3/6] realtime: threads need not set cpu affinity while main does
> [PATCH 4/6] realtime: use busy_work_ms from librttest to burn cpu cycles
> [PATCH 5/6] realtime: remove thread_stop which is not used anywhere
> [PATCH 6/6] realtime: synchronization fixes for high priority noise thread
> 
> All need to be applied in their order on top or code clean up patch series
> sent previously.

Thanks.

Regards--
Subrata

> 
> Thanks,
> Gowri
> 
> 


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
