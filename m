Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O4Bva-0006qz-FH
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 11:47:42 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O4BvV-0002My-6O
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 11:47:39 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3KBd9ZH009070
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Apr 2010 05:39:09 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3KBlH0D111746
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Apr 2010 05:47:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3KBlDFF003914
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Apr 2010 05:47:13 -0600
Date: Tue, 20 Apr 2010 17:17:08 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100420114708.GB4118@linux.vnet.ibm.com>
References: <239293073.562841271760559982.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<2135164550.562871271760576282.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2135164550.562871271760576282.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] Fix MSGCTL10() to avoid un-necessary cluttering
 of whole system with all PIDs
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
To: Caspar ZHANG <czhang@redhat.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Tue, Apr 20, 2010 at 06:49:36AM -0400, Caspar ZHANG wrote:
> 
> ----- "Rishikesh K Rajak" <risrajak@linux.vnet.ibm.com> wrote:
> 
> > After that it will be included in master branch immediately.
> 
> Sure, add Acked-by info in the attached patch.

Committed

Thanks
> 
> Thanks,
> Caspar
> 
-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
