Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJlhO-0000Cb-Tn
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:56:54 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJlhO-0000s3-2m
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:56:54 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5P9slSl032740
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 03:54:47 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5P9urg2181588
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 03:56:53 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5P9uqw7032563
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 03:56:53 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906231712.08545.vapier@gentoo.org>
References: <4a413aa8.8d13f30a.1754.ffffd0c3SMTPIN_ADDED@mx.google.com>
	<200906231712.08545.vapier@gentoo.org>
Date: Thu, 25 Jun 2009 14:40:03 +0530
Message-Id: <1245921004.5542.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix a surprising error in cacheflush01 test
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Satus-quo unchanged. I think this was meant to be only for mips, so, why
even try to see if it can build on others ?

Regards--
Subrata

On Tue, 2009-06-23 at 17:12 -0400, Mike Frysinger wrote: 
> On Friday 19 June 2009 10:13:25 Jiri Palecek > wrote:
> > this patch fixes a strange build failure in the cacheflush test. Also, it
> > makes the condition where it is build a little broader.
> 
> a little too broad -- you probably broke arm systems with this as they define 
> __NR_cacheflush but not asm/cachectl.h
> 
> > -#if defined __mips__
> > +
> > +#if defined __NR_cacheflush
> >  #include <asm/cachectl.h>
> 
> for using the systemcall you should use __NR_cacheflush.  for the header, you 
> should use autoconf.
> -mike
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
