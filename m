Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYjzU-0001nG-Rr
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 17:09:28 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYjzQ-0005Pr-VP
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 17:09:28 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n75H7S1m031370
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 11:07:28 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75H9FIt190548
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 11:09:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n75H9EtX012144
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 11:09:14 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090805111710.GB7428@linux.vnet.ibm.com>
References: <20090805090005.GA7428@linux.vnet.ibm.com>
	<1249463418.5937.6.camel@subratamodak.linux.ibm.com>
	<20090805111710.GB7428@linux.vnet.ibm.com>
Date: Wed, 05 Aug 2009 22:39:06 +0530
Message-Id: <1249492146.3623.6.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] patch for kernel/fs/fs_di fs_di.patch
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
To: Jyoti <jyotiv@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, ssant@in.ibm.com

On Wed, 2009-08-05 at 16:47 +0530, Jyoti wrote: 
> * Subrata Modak <subrata@linux.vnet.ibm.com> [2009-08-05 14:40:18]:
> 
> > On Wed, 2009-08-05 at 14:30 +0530, Jyoti wrote:
> > > Hello,
> > 
> > Please change the subject line accordingly. It should reflect the patch
> > you are submitting.
> > 
> > Regards--
> > Subrata
> > 
> > > 
> > > The attached patch adds one more way of testing dataitegrity of files.
> > > The data integrity test is performed on fragmented files.
> > > 
> > > Thanks,
> > > Jyoti

And neither is this a good Subject heading. Better could be like:

Subject: [PATCH] Added one more approach for data integrity.

Nevertheless, checked in.

Regards--
Subrata

> > 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
