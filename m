Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ying.huang@intel.com>) id 1MYwmh-0008G6-24
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 06:49:07 +0000
Received: from mga14.intel.com ([143.182.124.37])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYwmZ-0004SV-9Y
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 06:49:07 +0000
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
Date: Thu, 06 Aug 2009 14:48:51 +0800
Message-Id: <1249541331.27116.4.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Integration of MCE test suite into LTP
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: "Kleen, Andi" <andi.kleen@intel.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Wed, 2009-08-05 at 18:55 +0800, Subrata Modak wrote:
> Hi Huang Ying,
> 
> >On Tue, 2009-06-30 at 10:56 +0800, Huang Ying wrote:
> >Hi, All,
> >
> > We are working on a test suite to test the Linux kernel MCE handling
> > logic named mce-test, which can be find at:
> > git://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git. There is a
> > HOWTO for it, which is attached with the mail.
> >
> > We think the testing target of mce-test is part of that of LTP, so it is
> > better to integrate mce-test into LTP. Do you think so?
> >
> > As for integration scheme, maybe we can first add mce-test into LTP as a
> > separate test case, just as kdump test case. What's your opinions?
> >
> > Any comment is welcome!
> >
> 
> Sorry for the very late response to your proposal. Please find below the
> first patch which will integrate the existing mce-test to LTP. I had just
> done a sanity checking of building it. The following patch will still need:
> 
> 1) Exclusive testing and sharing those results with the LTP community,

We do test with mce-test regularly. Do you need our results?

> 2) Comments for and rewriting of this patch for coding styles,

Where can I find the coding style guide for LTP? Are there "indent"
command line for LTP coding style? So we can do some coding style
conversion work automatically.

> 3) Sign off from Huang Ying <ying.huang@intel.com>, or, the concerned Authors,

Signed-off-by: Huang Ying <ying.huang@intel.com>
You can add that to the patch.

Best Regards,
Huang Ying



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
