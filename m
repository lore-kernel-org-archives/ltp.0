Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MZOmQ-0002ec-0n
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:42 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZOmK-0008W2-NV
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:41 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n77Caxk2013029
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:36:59 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n77CgSlE249954
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:42:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n77CdfUR010576
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:39:42 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1249494775.13131.18.camel@lucio-laptop>
References: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
	<1249494775.13131.18.camel@lucio-laptop>
Date: Fri, 07 Aug 2009 18:11:52 +0530
Message-Id: <1249648912.4851.44.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] top of tree fails to build on PPC fc11 box
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
To: Lucio Correia <luciojhc@br.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Wed, 2009-08-05 at 14:52 -0300, Lucio Correia wrote: 
> Hi Kumar,
> 
> On Wed, 2009-07-29 at 13:33 -0500, Kumar Gala wrote:
> > I get the following compile error:
> > 
> > make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/fstat'
> > make[4]: Entering directory `/root/ltp/testcases/kernel/syscalls/ 
> > fstatat'
> > cc -Wall  -I../../include -g -Wall -I../../../../include -Wall - 
> > DTST_USE_NEWER64_SYSCALL=1 -D_FILE_OFFSET_BITS=64   -c -o  
> > fstatat01_64.o fstatat01.c
> > fstatat01.c:95:37: error: missing binary operator before token "5"
> > fstatat01.c: In function 'main':
> > fstatat01.c:126: error: expected ')' before numeric constant
> > make[4]: *** [fstatat01_64.o] Error 1
> > make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/fstatat'
> > make[3]: *** [all] Error 2
> > make[3]: Leaving directory `/root/ltp/testcases/kernel/syscalls'
> > make[2]: *** [all] Error 2
> > make[2]: Leaving directory `/root/ltp/testcases/kernel'
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory `/root/ltp/testcases'
> > make: *** [all] Error 2
> 
> This failure is being caused because .in files in kernel/includes are 
> wrong. The prefixes for the names (__NR_) and the plus signs were 
> removed. I've noticed it in .in files for several architectures in the
> latest LTP release (July 2009). 
> 
> 
> 
> This patch fixes bad updates to syscalls declarations for powerpc, that
> are causing build failures. This should be fixed for other archs 
> accordingly.
> 
> Signed-off-by Lucio Correia <luciojhc@br.ibm.com>

Thanks.

Regards--
Subrata

> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
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
