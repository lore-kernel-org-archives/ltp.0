Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zohar@us.ibm.com>) id 1MYS7D-0007eF-Sp
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 22:04:15 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYS76-0006I7-KT
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 22:04:15 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74M7f7T009055
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 18:07:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n74M3sng241470
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 18:03:55 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n74M19bR006862
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 18:01:09 -0400
In-Reply-To: <364299f40908031221k4b16e410xf22ea445237579b2@mail.gmail.com>
References: <364299f40907310138v2708c6dfmb378df4004669c4f@mail.gmail.com>	
	<1249298430.7460.29.camel@subratamodak.linux.ibm.com>
	<OFF7000B3B.0D392BE9-ON85257607.00640FF0-85257607.00669C2B@us.ibm.com>
	<364299f40908031221k4b16e410xf22ea445237579b2@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <OF94D45A2D.E3D18B69-ON85257608.0074A393-85257608.00793504@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Tue, 4 Aug 2009 18:03:53 -0400
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Garrett Cooper <yanegomi@gmail.com> wrote on 08/03/2009 03:21:07 PM:

 >> On Fri, 2009-07-31 at 01:38 -0700, Garrett Cooper wrote:
> >> > 1. None of the ima C files which required openssl/sha.h were using 
the
> >> > HAVE_OPENSSL_SHA_H macro define.

I don't have a problem with these changes.  Currently the C files are
only built if openssl/openssl-devel are installed.  You'll need to 
modify testcases/kernel/security/integrity/ima/src/Makefile. 

> >> > 2. Add tst_resm support.

Probably the comment should be "Add additional tst_resm messages".

> >> > 3. Fix some missing includes in ima_mmap.c.

What is "test.h"?

> >> > 4. Remove an unused var.

Thanks.

> >> > 5. Shuffle around some fields in ima_boot_aggregate.c so that it
> >> > compiles with -Wunused and consumes less memory when 1. applies.
> >> >
> >> > Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> >
> > This patch doesn't apply against either the June/July tar.
> > Which ltp version was used?
> 
> It was against a spot off HEAD between June / July, as that's where I
> started the makefile-infra-rework branch.
> 
> If you want another patch directly against HEAD, let me know. Or I'll
> just wait a few days and sync before the first set of reviews before
> the master collapse gets underway.
> 
> Thanks,
> -Garrett

Can't really test without being able to apply the patch. So either I 
need a version against a current ltp tar, or how I can access your
tree.

Thanks!

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
