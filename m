Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7Xa-0000B3-GW
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:31:02 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7XV-0002GK-75
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:31:02 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <2E9E6F5F5978EF44A8590E339E888CF90143075853@irsmsx503.ger.corp.intel.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
	<1249494939.3623.12.camel@subratamodak.linux.ibm.com>
	<1249521485.24238.308.camel@yhuang-dev.sh.intel.com>
	<1249648896.4851.40.camel@subratamodak.linux.ibm.com>
	<1249888606.5337.158.camel@yhuang-dev.sh.intel.com>
	<2E9E6F5F5978EF44A8590E339E888CF901425402ED@irsmsx503.ger.corp.intel.com>
	<1249975494.5337.168.camel@yhuang-dev.sh.intel.com>
	<1250076050.5373.20.camel@subratamodak.linux.ibm.com>
	<1250670949.5337.492.camel@yhuang-dev.sh.intel.com>
	<1250963183.10642.31.camel@subratamodak.linux.ibm.com>
	<2E9E6F5F5978EF44A8590E339E888CF90143075853@irsmsx503.ger.corp.intel.com>
Date: Sun, 23 Aug 2009 12:59:49 +0530
Message-Id: <1251012590.16822.45.camel@subratamodak.linux.ibm.com>
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
Cc: ltp-list <ltp-list@lists.sf.net>, "Huang, Ying" <ying.huang@intel.com>

On Sat, 2009-08-22 at 20:05 +0100, Kleen, Andi wrote: 
> >Thanks Huang and Andi. This has now been integrated to LTP. We 
> >will keep
> >testing them as new kernel releases are available. Please keep 
> >this test
> >suite updated as you push respective patches in the kernel.
> 
> Thanks for merging.
> 
> FYI -- there's already one change. The value of the MADV_POISON
> injection interface has changed in linux-next (12->100). That's fixed
> in the git tree now.

Thanks Andi. And i changed them already here:

ltp/testcases/mce-test/tsrc/tinjpage-working.c
ltp/testcases/mce-test/tsrc/tinjpage.c

Regards--
Subrata

> 
> -Andi
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
