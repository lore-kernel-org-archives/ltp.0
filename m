Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ying.huang@intel.com>) id 1MVbpd-0007Cm-JH
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 01:50:21 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MVbpV-0006TD-Dy
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 01:50:21 +0000
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <1246338149.4819.1.camel@subratamodak.linux.ibm.com>
References: <1246330572.12836.40.camel@yhuang-dev.sh.intel.com>
	<1246338149.4819.1.camel@subratamodak.linux.ibm.com>
Date: Tue, 28 Jul 2009 09:50:05 +0800
Message-Id: <1248745805.4823.2.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Subject: Re: [LTP] Integration of MCE test suite into LTP
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
To: "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>
Cc: "Kleen, Andi" <andi.kleen@intel.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi, Subrata,

Any update?

Best Regards,
Huang Ying

On Tue, 2009-06-30 at 13:02 +0800, Subrata Modak wrote:
> On Tue, 2009-06-30 at 10:56 +0800, Huang Ying wrote:
> > Hi, All,
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
> > Best Regards,
> > Huang Ying
> 
> Hi Huang,
> 
> I will reply to this mail in detail later. Thanks for posting this
> information.
> 
> Regards--
> Subrata
> 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
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
