Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7WX-0008MF-FM
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:57 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7WQ-00029d-FM
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:57 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N7SPGc023081
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:28:25 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7TiV3238698
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:29:44 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7TinL007773
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:29:44 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40908200953v3ce12243y6956cbbc679b9edd@mail.gmail.com>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<364299f40908200953v3ce12243y6956cbbc679b9edd@mail.gmail.com>
Date: Sun, 23 Aug 2009 12:59:05 +0530
Message-Id: <1251012545.16822.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch to fix kernbench integration issue
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
To: Garrett Cooper <yanegomi@gmail.com>, Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>, arun@linux.vnet.ibm.com

On Thu, 2009-08-20 at 09:53 -0700, Garrett Cooper wrote: 
> On Thu, Aug 20, 2009 at 9:06 AM, Poornima
> Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> > Kernbench script's mode was not getting modified to executable as 'utils install'
> > was missing in LTP Makefile. Hence this patch fixes this issue.
> >
> > Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
> >
> > diff -uprN ltp-full-20090731_orig/Makefile ltp-full-20090731/Makefile
> > --- ltp-full-20090731_orig/Makefile     2009-08-20 19:59:13.000000000 +0530
> > +++ ltp-full-20090731/Makefile  2009-08-20 20:19:09.000000000 +0530
> > @@ -40,6 +40,7 @@ install: all
> >        @$(MAKE) -C m4 install
> >        @$(MAKE) -C doc/man1 install
> >        @$(MAKE) -C doc/man3 install
> > +       @$(MAKE) -C utils install
> >  ifneq ($(strip $(SKIP_IDCHECK)),1)
> >        @./IDcheck.sh
> >  endif
> 
> No need to worry about this item either. It's already addressed in my
> makefile-infra-rework patch.

Came here. Keeping till the Makefile work gets in.

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
