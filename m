Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWlck-0005s7-CP
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 06:29:50 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWlcc-00024Z-GY
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 06:29:50 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6V6L8cW002904
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2009 00:21:08 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6V6Tas2188818
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2009 00:29:36 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6V6Ta82019604
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2009 00:29:36 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <OF14E618F8.D2F48B92-ON85257604.000CCB2C-86257604.000CE18C@us.ibm.com>
References: <OF14E618F8.D2F48B92-ON85257604.000CCB2C-86257604.000CE18C@us.ibm.com>
Date: Fri, 31 Jul 2009 11:59:33 +0530
Message-Id: <1249021773.5203.0.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Fw: sync_file_range01 testcase BUG and PATCH
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

On Thu, 2009-07-30 at 22:21 -0400, Robert Paulsen wrote:
> 
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
> Signed-off-by: Robert Paulsen <rpaulsen@us.ibm.com>

Thanks for this.

Regards--
Subrata

> 
> Robert Paulsen
> IBM Linux Technology Center, Austin
> rpaulsen@us.ibm.com
> 512-468-0565


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
