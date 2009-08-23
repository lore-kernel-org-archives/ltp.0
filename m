Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7We-0005TY-Hi
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:30:04 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7WW-0002b2-O1
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:30:04 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N7SVxb023121
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:28:31 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7TpjA249718
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:29:51 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7QsHe016618
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:26:55 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40908200952l402269bfy65eb0fc3f50702bc@mail.gmail.com>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160705.30926.960.sendpatchset@localhost.localdomain>
	<364299f40908200952l402269bfy65eb0fc3f50702bc@mail.gmail.com>
Date: Sun, 23 Aug 2009 12:59:10 +0530
Message-Id: <1251012551.16822.39.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch to fix make install issue in ebizzy
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>

On Thu, 2009-08-20 at 09:52 -0700, Garrett Cooper wrote: 
> On Thu, Aug 20, 2009 at 9:07 AM, Poornima
> Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> > install: was missing in Makefile of ebizzy, hence make install was throwing error.
> > This patch will fix make install error.
> >
> > Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
> >
> >
> > diff -uprN ltp-full-20090731_orig/utils/benchmark/ebizzy-0.3/Makefile ltp-full-20090731/utils/benchmark/ebizzy-0.3/Makefile
> > --- ltp-full-20090731_orig/utils/benchmark/ebizzy-0.3/Makefile  2009-08-20 19:59:13.000000000 +0530
> > +++ ltp-full-20090731/utils/benchmark/ebizzy-0.3/Makefile       2009-08-20 20:23:19.000000000 +0530
> > @@ -4,5 +4,7 @@ configure:
> >        ./configure
> >  ebizzy: configure
> >        gcc -Wall -Wshadow -lpthread  -o ebizzy ebizzy.c
> > +install:
> > +
> >  clean:
> >        rm -f ebizzy *~
> 
> No need to address this. It's already been addressed in my
> makefile-infra-rework patch.

Same as well.

Regards--
Subrata

> Thanks,
> -Garrett
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
