Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NnAx5-0000QC-Tw
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 13:18:55 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NnAx3-0003qo-Jc
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 13:18:55 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o24DD8d4013946
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 06:13:08 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o24DIlYv252910
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 06:18:47 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o24DIkwN007411
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 06:18:46 -0700
Date: Thu, 4 Mar 2010 18:48:34 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100304131834.GB21634@linux.vnet.ibm.com>
References: <364299f41002261213q24890454jac60233bd8f92ded@mail.gmail.com>
	<d270b4401002270505n59e448eev69b6f7b263ecd61d@mail.gmail.com>
	<d270b4401002270606y1f695cc8u3afaefb8b722528c@mail.gmail.com>
	<364299f41002271224x2aef49b0i4079babd986403e7@mail.gmail.com>
	<20100228181445.GB4850@linux.vnet.ibm.com>
	<d270b4401002281837x589df62ds4ce246066c3d9442@mail.gmail.com>
	<20100301052100.GA3860@linux.vnet.ibm.com>
	<20100301062821.GC3860@linux.vnet.ibm.com>
	<d270b4401002282340p45597f24tcb61bd3fa9366c31@mail.gmail.com>
	<20100302120239.GA2845@malik-laptop.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100302120239.GA2845@malik-laptop.in.ibm.com>
Subject: Re: [LTP] Testcase to validate the memory usage limit imposed
	by	the topmost memory cgroup
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
To: Sudhir Kumar <skumar@linux.vnet.ibm.com>, Mohamed Naufal <naufal11@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Mar 02, 2010 at 05:32:39PM +0530, Sudhir Kumar wrote:
> On Mon, Mar 01, 2010 at 01:10:31PM +0530, Mohamed Naufal wrote:
> > On 1 March 2010 11:58, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com> wrote:
> 
> The patch looks fair enough.
> Naufel, good job!
> I avoided review and comments as I wanted you to learn the way Linux
> community works, yourself. Now you being well faimiliar, we expect
> future contribution too :)
> 
> Acked-By: Sudhir Kumar <skumar@linux.vnet.ibm.com>
> Thanks Risi, for committing in the next branch.


Tested-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

Merging to maste branch now...

Thanks
Rishi
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
