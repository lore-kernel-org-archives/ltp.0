Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaOC-0006O6-DF
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:04 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaO6-0001yE-Fi
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:04 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UIOg6Y014748
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:24:42 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UIToGV165596
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:51 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UITnvm006115
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:50 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <OFAF51CC3A.0B2793FB-ON852575FE.00403BE8-862575FE.004135EB@us.ibm.com>
References: <OFAF51CC3A.0B2793FB-ON852575FE.00403BE8-862575FE.004135EB@us.ibm.com>
Date: Thu, 30 Jul 2009 23:59:34 +0530
Message-Id: <1248978575.5788.65.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] sync_file_range01 testcase BUG and PATCH
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
To: Robert Paulsen <rpaulsen@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Sat, 2009-07-25 at 07:50 -0400, Robert Paulsen wrote: 
> The testcase sync_file_range01 uses a file descriptor (variable sfd) in its
> second test, expcting to see an ESPIPE error.
> 
> Unfortunately, the code's open of that file descriptor somehow ended up
> within a set of curly braces encompasing an error path, not the mainline
> code where it should be. Thus, sfd is never set, In practice this leaves
> sfd set to zero. That is actually stdin and stdin can work for the testcase
> but it is not guaranteed. In fact it mostly works, but it hapens to fail
> sometimes. The attached patch causes the open for sfd (to /dev/null) to
> actually get invoked.
> 
> (See attached file: sync_file_range01.diff)
> 
> Robert Paulsen

Thanks for this, although a missing Signed-off-by: is necessary.

Regards--
Subrata

> IBM Linux Technology Center, Austin
> rpaulsen@us.ibm.com
> 512-468-0565
> ------------------------------------------------------------------------------
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
