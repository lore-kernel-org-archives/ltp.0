Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MZOlr-0000H4-7L
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:07 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZOlk-0006He-Ex
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:07 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n77CX9fU006391
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 06:33:09 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n77Cfok7245354
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 06:41:50 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n77CfjVW027294
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 06:41:49 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1249521485.24238.308.camel@yhuang-dev.sh.intel.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
	<1249494939.3623.12.camel@subratamodak.linux.ibm.com>
	<1249521485.24238.308.camel@yhuang-dev.sh.intel.com>
Date: Fri, 07 Aug 2009 18:11:36 +0530
Message-Id: <1249648896.4851.40.camel@subratamodak.linux.ibm.com>
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

On Thu, 2009-08-06 at 09:18 +0800, Huang Ying wrote: 
> On Thu, 2009-08-06 at 01:55 +0800, Subrata Modak wrote:
> > Hi Huang Ying,
> > 
> > On Wed, 2009-08-05 at 16:25 +0530, Subrata Modak wrote:
> > > Hi Huang Ying,
> > > 
> > > >On Tue, 2009-06-30 at 10:56 +0800, Huang Ying wrote:
> > > >Hi, All,
> > > > 
> > > > We are working on a test suite to test the Linux kernel MCE handling
> > > > logic named mce-test, which can be find at:
> > > > git://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git. There is a
> > > > HOWTO for it, which is attached with the mail.
> > > > 
> > > > We think the testing target of mce-test is part of that of LTP, so it is
> > > > better to integrate mce-test into LTP. Do you think so?
> > > > 
> > > > As for integration scheme, maybe we can first add mce-test into LTP as a
> > > > separate test case, just as kdump test case. What's your opinions?
> > > > 
> > > > Any comment is welcome!
> > > > 
> > > 
> > > Sorry for the very late response to your proposal. Please find below the
> > > first patch which will integrate the existing mce-test to LTP. I had just
> > > done a sanity checking of building it. The following patch will still need:
> > > 
> > > 1) Exclusive testing and sharing those results with the LTP community,
> > 
> > My initial first tests results are:
> > 
> > # uname -a
> > Linux x206f 2.6.29-gcov #1 SMP Fri Jun 19 12:14:27 IST 2009 i686 i686
> > i386 GNU/Linux
> 
> mce-test needs at least Linux kernel 2.6.31-rc? and some additional
> injection related patches from:
> http://ftp.kernel.org/pub/linux/kernel/people/yhuang/mce/. We are
> working on pushing these additional patches into 2.6.32.
> 

Can you please then provide this information inside mce-test/README, so
that users are exactly aware of:

     1. Which kernel to pick up, 
     2. Which additional patches to apply, 
     3. Which config options to set,

before building and running these tests.

Once mainline stable releases are through, you can then again update
mce-test/README with similar information.

I would like people to start doing some testing with your present
mce-test as well. As suggested by Andi, please drop in:

     1. a minimal patch which adds the tests(you want) to LTP, 
     2. update mce-test/README in the same patch with all the above
        info, 
     3. attach test results against the patches you have dropped to ltp,

Regards--
Subrata

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
