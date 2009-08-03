Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MXvq2-0008PF-NJ
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:36:22 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MXvpw-0004eG-HC
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:36:22 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73BFFoE022109
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 07:15:15 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73BKe3V257906
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 07:20:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73BKeGa012250
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 07:20:40 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40907310148q75cee4f7q1cb8117360459a29@mail.gmail.com>
References: <364299f40907310148q75cee4f7q1cb8117360459a29@mail.gmail.com>
Date: Mon, 03 Aug 2009 16:50:36 +0530
Message-Id: <1249298436.7460.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Remove getgid02 from all runtest files
	(was	"[PATCH] Remove getgid02 from ltplite runtest file")
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Fri, 2009-07-31 at 01:48 -0700, Garrett Cooper wrote: 
> On Fri, Jul 31, 2009 at 1:44 AM, Garrett Cooper<yanegomi@gmail.com> wrote:
> > Looks like someone removed the source file but forgot to remove the
> > reference to it in the ltplite runtest file. This fixes that.

Ok.

Regards--
Subrata

> >
> > Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> >
> > Index: runtest/ltplite
> > ===================================================================
> > RCS file: /cvsroot/ltp/ltp/runtest/ltplite,v
> > retrieving revision 1.20.2.1
> > diff -u -r1.20.2.1 ltplite
> > --- runtest/ltplite     27 Jul 2009 00:21:16 -0000      1.20.2.1
> > +++ runtest/ltplite     31 Jul 2009 08:43:22 -0000
> > @@ -287,7 +287,6 @@
> >  geteuid01 geteuid01
> >
> >  getgid01 getgid01
> > -getgid02 getgid02
> >  getgid03 getgid03
> >
> >  getgroups01 getgroups01
> >
> 
> And it appears that I missed some spots...
> 
> This removes _all_ references to getgid02 from _all_ of the runtest files:
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> 
> Index: runtest/ltplite
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/runtest/ltplite,v
> retrieving revision 1.20.2.1
> diff -u -r1.20.2.1 ltplite
> --- runtest/ltplite     27 Jul 2009 00:21:16 -0000      1.20.2.1
> +++ runtest/ltplite     31 Jul 2009 08:46:55 -0000
> @@ -287,7 +287,6 @@
>  geteuid01 geteuid01
> 
>  getgid01 getgid01
> -getgid02 getgid02
>  getgid03 getgid03
> 
>  getgroups01 getgroups01
> Index: runtest/stress.part3
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/runtest/stress.part3,v
> retrieving revision 1.65
> diff -u -r1.65 stress.part3
> --- runtest/stress.part3        27 May 2009 13:36:35 -0000      1.65
> +++ runtest/stress.part3        31 Jul 2009 08:46:55 -0000
> @@ -226,7 +226,6 @@
>  geteuid01 geteuid01
> 
>  getgid01 getgid01
> -getgid02 getgid02
>  getgid03 getgid03
> 
>  getgroups01 getgroups01
> Index: runtest/syscalls
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/runtest/syscalls,v
> retrieving revision 1.297
> diff -u -r1.297 syscalls
> --- runtest/syscalls    6 Jul 2009 14:42:40 -0000       1.297
> +++ runtest/syscalls    31 Jul 2009 08:46:55 -0000
> @@ -344,8 +344,6 @@
> 
>  getgid01 getgid01
>  getgid01_16 getgid01_16
> -# getgid02 is moved to getegid.
> -# getgid02 getgid02
>  getgid03 getgid03
>  getgid03_16 getgid03_16
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
