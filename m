Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N4xRZ-0003BA-10
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 13:59:37 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N4xRS-0005fP-0J
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 13:59:36 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA2Dm2hb016989
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 06:48:02 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA2DxKLK155812
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 06:59:20 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nA2DxKOQ021011
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 06:59:20 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A078016A1648@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078016A156A@svexch01.mvista.com>
	<364299f40910271957g6fc5147bgfbf3fe4c08d73b7@mail.gmail.com>
	<8368651DACC1964480F951191B94A078016A1648@svexch01.mvista.com>
Date: Mon, 02 Nov 2009 19:29:17 +0530
Message-Id: <1257170357.4977.57.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1,
	5: pass correct value	for sigset_t for mips
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

Any further work on this patch ?

Regards--
Subrata

On Wed, 2009-10-28 at 12:08 -0700, Henry Yei wrote: 
> > -----Original Message-----
> > From: Garrett Cooper [mailto:yanegomi@gmail.com]
> > Sent: Tuesday, October 27, 2009 7:57 PM
> > To: Henry Yei
> > Cc: LTP Mailing List
> > Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass correct
> > value for sigset_t for mips
> > 
> > On Tue, Oct 27, 2009 at 6:32 PM, Henry Yei <hyei@mvista.com> wrote:
> > > All,
> > >
> > >
> > >
> > > The patch attached  for ppoll01:
> > >
> > > cleans up spacing and code style
> > >
> > > removes unneeded/broken debug option parsing
> > >
> > > if test fails, it prints out the last failed errno, rather than just
> > the
> > > last errno(which may have been successful)
> > >
> > > passes in correct size of sigset_t for mips
> > >
> > >
> > >
> > > Signed-off by: Henry Yei <hyei@mvista.com>
> > >
> > >
> > >
> > > This patch was tested/passed on x86, mips(little endian), and
> > ppc_82xx .
> > 
> > 1. Please keep tst_exit() at the bottom.
> > 2. Why can't we do sizeof(sigsetmask) ?
> > 
> > Thanks,
> > -Garrett
> 
> Garrett,
> 
> You want me to put tst_exit() at the bottom, even though it is called within cleanup()?
> You mean sizeof(sigmask) ~ sizeof(sigset_t), right? That code was commented out since version 1.1 which I thought was odd too, so I did check sizeof(sigmask).
> However, sizeof(sigmask) on mips returns 128 which does not seem correct. I haven't checked the other architectures, but I suspect some might have a similar mismatch. Apparently sigset_t may have different values when returned from glibc vs kernel space. More information from this post:
> 
> http://lists.uclibc.org/pipermail/uclibc/2009-January/041850.html
> 
> 
> 
> 
> 
> 
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
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
