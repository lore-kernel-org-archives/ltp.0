Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MZOlk-00048u-F5
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:00 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZOld-0006FZ-6k
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:00 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n77Cdoqd022362
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 06:39:50 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n77Cff2g207372
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 06:41:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n77CffHE032581
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 06:41:41 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <2E9E6F5F5978EF44A8590E339E888CF901424CFEA1@irsmsx503.ger.corp.intel.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
	<1249541331.27116.4.camel@yhuang-dev.sh.intel.com>
	<2E9E6F5F5978EF44A8590E339E888CF901424CFEA1@irsmsx503.ger.corp.intel.com>
Date: Fri, 07 Aug 2009 18:11:32 +0530
Message-Id: <1249648892.4851.39.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Integration of MCE test suite into LTP
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
To: "Kleen, Andi" <andi.kleen@intel.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "Huang,  Ying" <ying.huang@intel.com>

On Thu, 2009-08-06 at 14:29 +0100, Kleen, Andi wrote: 
> >> 3) Sign off from Huang Ying <ying.huang@intel.com>, or, the 
> >concerned Authors,
> >
> >Signed-off-by: Huang Ying <ying.huang@intel.com>
> >You can add that to the patch.
> 
> And Signed-off-by: Andi Kleen <ak@linux.intel.com>

Thank you too.

> (wrote also some early code)
> 
> One thing I should add. There's still development going on for enhancing
> mce-test (e.g. adding stress tests and increasing coverage). Right now
> I would expect the kernel.org git repository to be still the primary
> repository where development is done, with occasional code drops
> into LTP. I hope that's ok for you.

Sure. It should be absolutely fine. Wheneven you want to add/update,
just drop in a patch with the set of new results the patch would have
generated.

> 
> It would be good if you could feed any patches on the LTP side for mce-test
> through Ying also.

As always welcome. Anybody can send patches anytime ;-)

Regards--
Subrata

> 
> Thanks,
> 
> -Andi


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
