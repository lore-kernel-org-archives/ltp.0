Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLehf-0003rB-Ez
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:52:59 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLefu-0001cg-7Y
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:51:14 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UEncgG032752
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:49:38 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEopB3081908
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:50:51 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEoorX027277
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 08:50:51 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.DEB.1.10.0906300738480.3314@makko.or.mcafeemobile.com>
References: <200906232049.n5NKne0h007108@e5.ny.us.ibm.com>
	<1245920973.5542.33.camel@subratamodak.linux.ibm.com>
	<1246347667.4819.27.camel@subratamodak.linux.ibm.com>
	<alpine.DEB.1.10.0906300738480.3314@makko.or.mcafeemobile.com>
Date: Tue, 30 Jun 2009 20:20:45 +0530
Message-Id: <1246373446.6978.2.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Run the eventfd test in a temporary directory,
	because it creates some files
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
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jiri Palecek <jpalecek@web.de>, ltp-list@lists.sourceforge.net

On Tue, 2009-06-30 at 07:41 -0700, Davide Libenzi wrote:
> On Tue, 30 Jun 2009, Subrata Modak wrote:
> 
> > Jiri,
> > 
> > On Thu, 2009-06-25 at 14:39 +0530, Subrata Modak wrote: 
> > > On Mon, 2008-12-29 at 14:48 +0100, Jiri Palecek wrote: 
> > > > Hello,
> > > > 
> > > > the eventfd test creates some files in the current directory. I think it should be creating the files in a temporary directory instead, as is already the standard with other LTP tests, because the current might be nonwriteable and the user might not want the files left there.
> > > > 
> > > > Regards
> > > >     Jiri Palecek
> > > > 
> > > > Signed-off-by: Jiri Palecek <jpalecek@web.de>
> > > 
> > > Thanks. 
> > > 
> > > Recently i have seen some patches on LKML from Davide on the change for
> > > eventfd() interface. Could you please verify how they will affect our
> > > tests, and, make changes if necessary ?
> > > http://lkml.org/lkml/2009/6/24/590,
> > 
> > Any thoughts for this ?
> 
> No worry. It is the internal (kernel) interface that will eventually 
> change. Userspace will not be affected by it.

Thanks Davide for this clarification.

Regards--
Subrata

> 
> 
> - Davide
> 
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
