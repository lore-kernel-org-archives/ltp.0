Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MZOls-0000HJ-Ry
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:08 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZOll-0002Iq-KY
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:08 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n77CbSAR012472
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 06:37:28 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n77Cfo2j235156
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 06:41:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n77Cfo8a027636
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 06:41:50 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1249541331.27116.4.camel@yhuang-dev.sh.intel.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
	<1249541331.27116.4.camel@yhuang-dev.sh.intel.com>
Date: Fri, 07 Aug 2009 18:11:40 +0530
Message-Id: <1249648900.4851.41.camel@subratamodak.linux.ibm.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: "Kleen, Andi" <andi.kleen@intel.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Thu, 2009-08-06 at 14:48 +0800, Huang Ying wrote: 
> On Wed, 2009-08-05 at 18:55 +0800, Subrata Modak wrote:
> > Hi Huang Ying,
> > 
> > >On Tue, 2009-06-30 at 10:56 +0800, Huang Ying wrote:
> > >Hi, All,
> > >
> > > We are working on a test suite to test the Linux kernel MCE handling
> > > logic named mce-test, which can be find at:
> > > git://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git. There is a
> > > HOWTO for it, which is attached with the mail.
> > >
> > > We think the testing target of mce-test is part of that of LTP, so it is
> > > better to integrate mce-test into LTP. Do you think so?
> > >
> > > As for integration scheme, maybe we can first add mce-test into LTP as a
> > > separate test case, just as kdump test case. What's your opinions?
> > >
> > > Any comment is welcome!
> > >
> > 
> > Sorry for the very late response to your proposal. Please find below the
> > first patch which will integrate the existing mce-test to LTP. I had just
> > done a sanity checking of building it. The following patch will still need:
> > 
> > 1) Exclusive testing and sharing those results with the LTP community,
> 
> We do test with mce-test regularly. Do you need our results?

You are correct. Can you also post all exclusive and elaborate results
of the tests ?

> 
> > 2) Comments for and rewriting of this patch for coding styles,
> 
> Where can I find the coding style guide for LTP? Are there "indent"
> command line for LTP coding style? So we can do some coding style
> conversion work automatically.

No. we started to follow the Linux Kernel coding style as rectified
everytime by scripts/checkpatch.pl.

> 
> > 3) Sign off from Huang Ying <ying.huang@intel.com>, or, the concerned Authors,
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>

Thanks. We would need that in future too.

Regards--
Subrata

> You can add that to the patch.
> 
> Best Regards,
> Huang Ying
> 
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
