Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1N3Dro-0007lp-Gi
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2009 19:07:32 +0000
Received: from [206.112.117.47] (helo=gateway-1237.mvista.com)
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N3Dri-0003eC-SH
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2009 19:07:32 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 28 Oct 2009 12:08:20 -0700
Message-ID: <8368651DACC1964480F951191B94A078016A1648@svexch01.mvista.com>
In-Reply-To: <364299f40910271957g6fc5147bgfbf3fe4c08d73b7@mail.gmail.com>
References: <8368651DACC1964480F951191B94A078016A156A@svexch01.mvista.com>
	<364299f40910271957g6fc5147bgfbf3fe4c08d73b7@mail.gmail.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1,
	5: pass correct value for sigset_t for mips
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Tuesday, October 27, 2009 7:57 PM
> To: Henry Yei
> Cc: LTP Mailing List
> Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass correct
> value for sigset_t for mips
> =

> On Tue, Oct 27, 2009 at 6:32 PM, Henry Yei <hyei@mvista.com> wrote:
> > All,
> >
> >
> >
> > The patch attached =A0for ppoll01:
> >
> > cleans up spacing and code style
> >
> > removes unneeded/broken debug option parsing
> >
> > if test fails, it prints out the last failed errno, rather than just
> the
> > last errno(which may have been successful)
> >
> > passes in correct size of sigset_t for mips
> >
> >
> >
> > Signed-off by: Henry Yei <hyei@mvista.com>
> >
> >
> >
> > This patch was tested/passed on x86, mips(little endian), and
> ppc_82xx .
> =

> 1. Please keep tst_exit() at the bottom.
> 2. Why can't we do sizeof(sigsetmask) ?
> =

> Thanks,
> -Garrett

Garrett,

You want me to put tst_exit() at the bottom, even though it is called withi=
n cleanup()?
You mean sizeof(sigmask) ~ sizeof(sigset_t), right? That code was commented=
 out since version 1.1 which I thought was odd too, so I did check sizeof(s=
igmask).
However, sizeof(sigmask) on mips returns 128 which does not seem correct. I=
 haven't checked the other architectures, but I suspect some might have a s=
imilar mismatch. Apparently sigset_t may have different values when returne=
d from glibc vs kernel space. More information from this post:

http://lists.uclibc.org/pipermail/uclibc/2009-January/041850.html







---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
