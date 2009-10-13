Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxiba-000700-AK
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:44:02 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxibL-0003ZF-QA
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:43:57 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DEciQp029077
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:38:44 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DEhass159716
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:43:36 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DEhZCE028844
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:43:35 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910042116v40757ceene9d99a9a241b23a7@mail.gmail.com>
References: <364299f40910042116v40757ceene9d99a9a241b23a7@mail.gmail.com>
Date: Tue, 13 Oct 2009 20:13:31 +0530
Message-Id: <1255445011.8438.64.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Remove ballista binary files
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Sun, 2009-10-04 at 21:16 -0700, Garrett Cooper wrote: 
> Just before doing a CVS diff I noticed that these binary files made it
> back into the repository:
> 
> testcases/ballista/ballista/blexer
> testcases/ballista/ballista/bparser
> testcases/ballista/ballista/mut.out
> 
> This change removes them again:
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Thanks for fixing that already.

Regards--
Subrata

> 
> cvs diff: testcases/ballista/ballista/blexer was removed, no
> comparison available
> cvs diff: testcases/ballista/ballista/bparser was removed, no
> comparison available
> cvs diff: testcases/ballista/ballista/mut.out was removed, no
> comparison available
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
