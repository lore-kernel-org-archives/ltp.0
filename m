Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJlgd-00009L-QK
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:56:07 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJlgc-0000iU-Cs
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:56:07 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5P9qCv3000302
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 03:52:12 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5P9u48r193144
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 03:56:04 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5P9u4Xo009121
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 03:56:04 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906231710.22047.vapier@gentoo.org>
References: <4a413b73.9c13f30a.3059.ffffe109SMTPIN_ADDED@mx.google.com>
	<200906231710.22047.vapier@gentoo.org>
Date: Thu, 25 Jun 2009 14:39:58 +0530
Message-Id: <1245920999.5542.37.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Use present autoconf test for asm/ldt.h
	in	set_thread_area* tests to prevent build failures
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

On Tue, 2009-06-23 at 17:10 -0400, Mike Frysinger wrote: 
> On Friday 19 June 2009 10:12:15 Jiri Palecek > wrote:
> > -#include <stdio.h>
> > -#include <errno.h>
> > -#include <linux/unistd.h>
> > -#include <asm/ldt.h>
> > -
> >  /* Harness Specific Include Files. */
> >  #include "test.h"
> >  #include "usctest.h"
> >  #include "linux_syscall_numbers.h"
> > -
> > -/* Extern Global Variables */
> > -extern int Tst_count;           /* counter for tst_xxx routines.        
> > */ -extern char *TESTDIR;           /* temporary dir created by
> > tst_tmpdir() */ +#include "config.h"
> >
> >  /* Global Variables */
> >  char *TCID = "set_thread_area01";  /* Test program identifier.*/
> >  int  testno;
> >  int  TST_TOTAL = 2;                   /* total number of tests in this
> > file.   */
> >
> > +#if defined HAVE_ASM_LDT_H
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include <linux/unistd.h>
> > +#include <asm/ldt.h>
> 
> moving asm/ldt.h behind the ifdef makes sense, but none of the others do.  
> there is no point in delaying the other includes and in general, all includes 
> should come first ... there shouldnt be definitions before them.  less likely 
> to get bitten in the ass with clashes.

Correct. I did this for Jiri.

Regards--
Subrata

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
