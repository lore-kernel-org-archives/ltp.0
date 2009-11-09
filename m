Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N7YD6-0004sO-7f
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:39:24 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7YD1-0005ar-QE
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:39:24 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA9HVQJK016223
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 12:31:26 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA9HdDqK995494
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 12:39:13 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA9HdDA6022517
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 12:39:13 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AF37D4F.1020909@cn.fujitsu.com>
References: <4AF37D4F.1020909@cn.fujitsu.com>
Date: Mon, 09 Nov 2009 23:09:05 +0530
Message-Id: <1257788345.7677.64.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix build failure in cgroup_fj testcase
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Fri, 2009-11-06 at 09:35 +0800, Shi Weihua wrote: 
> The following build failure occured on my x86 box.
> -------------------------------------------------------
> # uname -a
> Linux F8-i386 2.6.32-rc5-tipshiwh+ #3 SMP Wed Oct 21 15:14:54 EDT 2009 i686 i686 i386 GNU/Linux
> # cat /etc/issue
> Fedora release 8 (Werewolf)
> Kernel \r on an \m
> 
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/home/shiwh/ltp-full-20091031/testcases/kernel/include -I/home/shiwh/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj/../libcontrollers -Wall -O2 -Wextra -I../../../../include -I../../../../include   -L/home/shiwh/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj/../libcontrollers -L../../../../lib  cgroup_fj_proc.c   -lltp -lcontrollers -o cgroup_fj_proc
> /usr/bin/ld: cannot find -lcontrollers
> collect2: ld returned 1 exit status
> make[4]: *** [cgroup_fj_proc] Error 1
> make[4]: Leaving directory `/home/shiwh/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/home/shiwh/ltp-full-20091031/testcases/kernel/controllers'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/shiwh/ltp-full-20091031/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/shiwh/ltp-full-20091031/testcases'
> make: *** [testcases-all] Error 2
> -------------------------------------------------------
> 
> But the case "cgroup_fj" does not need "-lcontrollers" when building.
> So in my patch, i deleted "-lcontrollers" in testcases/kernel/controllers/Makefile.inc 
> and added it to testcases/kernel/controllers/memctl/Makefile because the case "memctl" 
> need it. 
> All other cases in testcases/kernel/controllers/ build well too when my patch merged.
> 
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
> diff -urpN ltp-full-20091031.orig/testcases/kernel/controllers/Makefile.inc ltp-full-20091031/testcases/kernel/controllers/Makefile.inc
> --- ltp-full-20091031.orig/testcases/kernel/controllers/Makefile.inc	2009-11-02 04:07:13.000000000 -0500
> +++ ltp-full-20091031/testcases/kernel/controllers/Makefile.inc	2009-11-05 08:54:06.000000000 -0500
> @@ -39,8 +39,6 @@ CPPFLAGS		+= -I$(abs_srcdir)/../$(LIBDIR
> 
>  LDFLAGS			+= -L$(abs_builddir)/../$(LIBDIR)
> 
> -LDLIBS			+= -lcontrollers
> -
>  INSTALL_TARGETS		?= *.sh
> 
>  # vim: syntax=make
> diff -urpN ltp-full-20091031.orig/testcases/kernel/controllers/memctl/Makefile ltp-full-20091031/testcases/kernel/controllers/memctl/Makefile
> --- ltp-full-20091031.orig/testcases/kernel/controllers/memctl/Makefile	2009-11-02 04:07:14.000000000 -0500
> +++ ltp-full-20091031/testcases/kernel/controllers/memctl/Makefile	2009-11-06 04:13:49.000000000 -0500
> @@ -27,4 +27,6 @@ include $(abs_srcdir)/../Makefile.inc
> 
>  INSTALL_TARGETS		:= *.sh
> 
> +LDLIBS			+= -lcontrollers
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
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
