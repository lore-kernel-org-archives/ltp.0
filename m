Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MgueG-0004bn-07
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 06:09:20 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mgue9-0007Vw-Oz
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 06:09:19 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7S65JAm020915
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 00:05:19 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7S693hw259020
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 00:09:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7S693bJ015959
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 00:09:03 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0908271148120.22490@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908261651080.29020@vixen.sonytel.be>
	<200908261548.58741.vapier@gentoo.org>
	<alpine.LRH.2.00.0908271148120.22490@vixen.sonytel.be>
Date: Fri, 28 Aug 2009 11:38:46 +0530
Message-Id: <1251439729.9081.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] LTP must be extracted to an accessible location
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

On Thu, 2009-08-27 at 11:48 +0200, Geert Uytterhoeven wrote: 
> On Wed, 26 Aug 2009, Mike Frysinger wrote:
> > On Wednesday 26 August 2009 10:51:29 Geert Uytterhoeven wrote:
> > > --- a/INSTALL
> > > +++ b/INSTALL
> > > @@ -67,6 +67,9 @@ contributions are welcome.
> > >  2. Untar the ltp tarball into a spare directory.  There is not a
> > >     standard location for it yet.  We put it in our home directory
> > >     while we're working on it.
> > > +   Note that this location must be accessible for unprivileged users, as
> > > +   some tests are run as a different user than root.  Hence /root is not a
> > > +   good choice on several distributions.
> > 
> > i would use the phrase "full path to this location".  non-root could access 
> > ./foo/, but it could not access $PWD/foo/ ...
> > -mike
> 
> Thanks, that's indeed better!
> 
> >From 741d03a6753015ba6373d1f629f4117f978d6129 Mon Sep 17 00:00:00 2001
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Date: Wed, 26 Aug 2009 16:24:59 +0200
> Subject: [PATCH] LTP must be extracted to an accessible location
> 
> If extracted to /root and /root has permissions 750, the following
> tests will fail:
> 
>   - cron02:
> 
>     bash: /root/ltp-cvs/testcases/bin/cron_pos_tests.sh: Permission denied
> 
>   - cron_allow01:
> 
>     bash: /root/ltp-cvs/testcases/bin/cron_allow01: Permission denied
>     bash: /root/ltp-cvs/testcases/bin/cron_allow01: Permission denied
> 
>   - cron_deny01:
> 
>     bash: /root/ltp-cvs/testcases/bin/cron_deny01: Permission denied
>     bash: /root/ltp-cvs/testcases/bin/cron_deny01: Permission denied
> 
>   - su01:
> 
>     bash: /root/ltp-cvs/testcases/bin/su01_s1: Permission denied
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> ---
>  INSTALL |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/INSTALL b/INSTALL
> index 98883fb..73ff29c 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -67,6 +67,9 @@ contributions are welcome.
>  2. Untar the ltp tarball into a spare directory.  There is not a
>     standard location for it yet.  We put it in our home directory
>     while we're working on it.
> +   Note that the full path to this location must be accessible for
> +   unprivileged users, as some tests are run as a different user than root.
> +   Hence /root is not a good choice on several distributions.
>  
>  3. Run "make" to build everything.
>     *NOTE: Some of the Makefiles (example: pan/Makefile) require the lex (or


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
