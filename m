Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zohar@us.ibm.com>) id 1MY2Sw-00038E-8z
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 18:40:58 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MY2Sv-0004uF-EL
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 18:40:58 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73IYhS1009122
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 14:34:43 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73IepJ6232508
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 14:40:51 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73Ic6qu023550
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 14:38:07 -0400
In-Reply-To: <1249298430.7460.29.camel@subratamodak.linux.ibm.com>
References: <364299f40907310138v2708c6dfmb378df4004669c4f@mail.gmail.com>
	<1249298430.7460.29.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-ID: <OFF7000B3B.0D392BE9-ON85257607.00640FF0-85257607.00669C2B@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Mon, 3 Aug 2009 14:40:46 -0400
Subject: Re: [LTP] [PATCH] Fix C coding issues and integrate ima into LTP
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
To: subrata@linux.vnet.ibm.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

Subrata Modak <subrata@linux.vnet.ibm.com> wrote on 08/03/2009 07:20:30 
AM:


> This as well for Mimi.
> 
> Regards--
> Subrata

Thanks for copying me.
 
> On Fri, 2009-07-31 at 01:38 -0700, Garrett Cooper wrote: 
> > 1. None of the ima C files which required openssl/sha.h were using the
> > HAVE_OPENSSL_SHA_H macro define.
> > 2. Add tst_resm support.
> > 3. Fix some missing includes in ima_mmap.c.
> > 4. Remove an unused var.
> > 5. Shuffle around some fields in ima_boot_aggregate.c so that it
> > compiles with -Wunused and consumes less memory when 1. applies.
> > 
> > Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

This patch doesn't apply against either the June/July tar. 
Which ltp version was used?

Mimi

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
