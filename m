Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N7YDw-0005Iv-MX
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:40:16 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7YDp-0004dZ-Do
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:40:16 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA9HX3Mb012685
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 10:33:03 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nA9HdxvP198060
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 10:39:59 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nA9Hdocd020890
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 10:39:50 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40911030915j5848d426j1d9d14cc266457d2@mail.gmail.com>
References: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
	<200911021702.09153.vapier@gentoo.org>
	<200911031130.53505.vapier@gentoo.org>
	<364299f40911030834w463f6aa3ga4a24d273f0142bd@mail.gmail.com>
	<364299f40911030915j5848d426j1d9d14cc266457d2@mail.gmail.com>
Date: Mon, 09 Nov 2009 23:09:19 +0530
Message-Id: <1257788359.7677.69.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Build Fails on some archs
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
To: Garrett Cooper <yanegomi@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Thanks to you both for fixing this.

Regards--
Subrata

On Tue, 2009-11-03 at 09:15 -0800, Garrett Cooper wrote: 
> On Tue, Nov 3, 2009 at 8:34 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> > On Tue, Nov 3, 2009 at 8:30 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> >> On Monday 02 November 2009 17:02:08 Mike Frysinger wrote:
> >>> On Monday 02 November 2009 08:33:55 Subrata Modak wrote:
> >>> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> >>> > -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
> >>> > -I../../../../include -I../../../../include   -L../../../../lib
> >>> > ptrace04.c   -lltp -o ptrace04
> >>> > ptrace03.c: In function 'main':
> >>> > ptrace03.c:182: warning: format '%d' expects type 'int', but argument 3
> >>> > has type 'long int'
> >>> > ptrace04.c: In function 'compare_registers':
> >>> > ptrace04.c:50: error: storage size of 'pt_regs' isn't known
> >>> > ptrace04.c:50: warning: unused variable 'pt_regs'
> >>> > make[4]: *** [ptrace04] Error 1
> >>>
> >>> the ptrace stuff has always been fairly unfriendly to cross-arch work.
> >>>  we'll probably have to add header tests for a bunch of files and unify it
> >>>  in a local ptrace.h header.
> >>>
> >>> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> >>> > -I../../../../include -I../../../../include   -L../../../../lib
> >>> > tomoyo_file_test.c   -o tomoyo_file_test
> >>> > /tmp/ccvzdsNd.o: In function `main':
> >>> > /root/subrata/ltp/ltp-full-20091031/testcases/kernel/security/tomoyo/newn
> >>> >s. c:43: undefined reference to `clone' collect2: ld returned 1 exit
> >>> > status
> >>>
> >>> these test cases need to be changed to the new common ltp clone code.  as
> >>>  part of that, we should probably add a macro that changes clone() to a
> >>>  compile error so that people stop using it by accident
> >>> #define clone(...) DO_NOT_USE_CLONE
> >>
> >> i'll take care of both of these issues if you want to look at the others
> >
> > Sounds good.
> 
>     I've identified the 6 issues with numa, posted a patch for one
> issue, and I'll take care of the rest of them later on tonight after I
> get back from work.
> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
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
