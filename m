Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MaQ7N-0000N4-Fk
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:20:33 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MaQ7J-0003n2-Ng
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:20:33 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7A8EZum020203
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Aug 2009 04:14:35 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7A8KMrc237254
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Aug 2009 04:20:22 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7A8KLUX021950
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Aug 2009 04:20:22 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <2A1B6719-9C0B-4271-8A81-1730F79F5E33@kernel.crashing.org>
References: <1842FA33-8C6C-4BE1-8FB4-B8836F1C8F6E@kernel.crashing.org>
	<364299f40908061017g44fd05ecv9c6454ebf04badb4@mail.gmail.com>
	<2A1B6719-9C0B-4271-8A81-1730F79F5E33@kernel.crashing.org>
Date: Mon, 10 Aug 2009 13:50:16 +0530
Message-Id: <1249892416.5187.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] RANLIB not set?
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Fri, 2009-08-07 at 08:14 -0500, Kumar Gala wrote: 
> On Aug 6, 2009, at 12:17 PM, Garrett Cooper wrote:
> 
> > On Thu, Aug 6, 2009 at 9:18 AM, Kumar  
> > Gala<galak@kernel.crashing.org> wrote:
> >> I'm seeing this on fedora 11 on ppc64:
> >>
> >> make[3]: Leaving directory `/root/ltp/testcases/network/ipv6'
> >> make[3]: Entering directory `/root/ltp/testcases/network/lib6'
> >> cc -Wall  -I../../../include -g -D_GNU_SOURCE   -c -o runcc.o runcc.c
> >> ar cr runcc.a runcc.o
> >> runcc.a
> >> make[3]: runcc.a: Command not found
> >> make[3]: *** [runcc.a] Error 127
> >> make[3]: Leaving directory `/root/ltp/testcases/network/lib6'
> >> make[2]: *** [all] Error 2
> >> make[2]: Leaving directory `/root/ltp/testcases/network'
> >> make[1]: *** [all] Error 2
> >> make[1]: Leaving directory `/root/ltp/testcases'
> >> make: *** [all] Error 2
> >>
> >> - k
> >
> >    Make sure to export CROSS_COMPILER=1 at the top-level make, or
> > define RANLIB=$(CROSS_COMPILE)ranlib, where $(CROSS_COMPILE) is the
> > prefix for your compiler set, e.g. $(CROSS_COMPILE)gcc.
> >    One of the many things that will be fixed in a more kosher manner
> > in the next couple months.
> > Thanks,
> > -Garrett
> 
> I see you committed a change to the lib6/Makefile for ranlib.  I  
> believe we need a similar patch to the toplevel Makefile since it  
> exports RANLIB:
> 

True. But, can you create a patch from LTPROOT, as, the below fails to
apply:

patching file Makefile
Hunk #1 FAILED at 9.
1 out of 1 hunk FAILED -- saving rejects to file Makefile.rej

Regards--
Subrata

> diff --git a/Makefile b/Makefile
> index 953eddf..9f8056a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -9,6 +9,8 @@ AR=$(CROSS_COMPILER)ar
>   RANLIB=$(CROSS_COMPILER)ranlib
>   endif
> 
> +RANLIB         ?= ranlib
> +
>   HAS_NUMA=$(shell sh tools/scripts/numa_test.sh)
> 
>   export CFLAGS += -Wall $(CROSS_CFLAGS)
> 
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
