Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MbBtT-0005em-7W
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 11:21:23 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbBtL-0000vL-VR
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 11:21:23 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1249975494.5337.168.camel@yhuang-dev.sh.intel.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
	<1249494939.3623.12.camel@subratamodak.linux.ibm.com>
	<1249521485.24238.308.camel@yhuang-dev.sh.intel.com>
	<1249648896.4851.40.camel@subratamodak.linux.ibm.com>
	<1249888606.5337.158.camel@yhuang-dev.sh.intel.com>
	<2E9E6F5F5978EF44A8590E339E888CF901425402ED@irsmsx503.ger.corp.intel.com>
	<1249975494.5337.168.camel@yhuang-dev.sh.intel.com>
Date: Wed, 12 Aug 2009 16:50:49 +0530
Message-Id: <1250076050.5373.20.camel@subratamodak.linux.ibm.com>
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
To: Huang Ying <ying.huang@intel.com>, "Kleen, Andi" <andi.kleen@intel.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi,

On Tue, 2009-08-11 at 15:24 +0800, Huang Ying wrote: 
> Hi, Subrata,
> 
> What's your opinions about Andi's comments?
> 
> Best Regards,
> Huang Ying
> 
> On Mon, 2009-08-10 at 16:05 +0800, Kleen, Andi wrote:
> > >I will check the coding style with checkpatch.pl. Do you have other
> > >comments about the code?
> > 
> > I would prefer no wide scale reformattings for now, that will
> > impact any out of tree patches other people have and the benefits
> > would seem to be small.
> > 
> > The code is probably not fully compliant, but should be close enough to
> > kernel style (after all it was written by experienced kernel developers)

Lets see, how much your patch will impact. If necessary, i will make
some changes before check-in. But do remember to provide those info i
had asked for in your patch ;-)

Regards--
Subrata

> > 
> > -Andi
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
