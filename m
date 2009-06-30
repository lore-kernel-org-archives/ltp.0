Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLVWK-0004vP-Sl
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 05:04:40 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLVV0-0002jV-RR
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 05:04:33 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5U4qTt2022173
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 00:52:29 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5U53GDH252414
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:03:16 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5U50pgS007709
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:00:51 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1246330572.12836.40.camel@yhuang-dev.sh.intel.com>
References: <1246330572.12836.40.camel@yhuang-dev.sh.intel.com>
Date: Tue, 30 Jun 2009 10:32:29 +0530
Message-Id: <1246338149.4819.1.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Integration of MCE test suite into LTP
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
Cc: Andi Kleen <andi.kleen@intel.com>, ltp-list@lists.sourceforge.net

On Tue, 2009-06-30 at 10:56 +0800, Huang Ying wrote:
> Hi, All,
> 
> We are working on a test suite to test the Linux kernel MCE handling
> logic named mce-test, which can be find at:
> git://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git. There is a
> HOWTO for it, which is attached with the mail.
> 
> We think the testing target of mce-test is part of that of LTP, so it is
> better to integrate mce-test into LTP. Do you think so?
> 
> As for integration scheme, maybe we can first add mce-test into LTP as a
> separate test case, just as kdump test case. What's your opinions?
> 
> Any comment is welcome!
> 
> Best Regards,
> Huang Ying

Hi Huang,

I will reply to this mail in detail later. Thanks for posting this
information.

Regards--
Subrata

> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
