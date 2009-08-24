Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MfVVW-0006Gy-Su
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:06:30 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MfVVV-0002oj-7l
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:06:30 +0000
Date: Mon, 24 Aug 2009 10:44:05 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <200908222352.42884.vapier@gentoo.org>
Message-ID: <alpine.LRH.2.00.0908241040450.31587@vixen.sonytel.be>
References: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
	<364299f40908211417i21840c17n4e144c85852cb08a@mail.gmail.com>
	<20090823.103728.112603315.caiqian@cclom.cn>
	<200908222352.42884.vapier@gentoo.org>
MIME-Version: 1.0
Subject: Re: [LTP] The Best Practice to Skip Syscall Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sf.net

On Sat, 22 Aug 2009, Mike Frysinger wrote:
> On Saturday 22 August 2009 22:37:28 CAI Qian wrote:
> > From: Garrett Cooper <yanegomi@gmail.com>
> > > On Fri, Aug 21, 2009 at 9:00 AM, Mike Frysinger wrote:
> > >> On Friday 21 August 2009 07:57:39 CAI Qian wrote:
> > >>> Test cases unshare failed to compile on systems without such a
> > >>> syscall. I am unsure what the best way to handle it. The old ways a=
re,
> > >>>
> > >>> * add a kernel version check in the unshare tests code.
> > >>>
> > >>> or
> > >>>
> > >>> * add a m4 rule.
> > >>> * modify the unshare tests code to check if the macro, and add stub
> > >>>   functions if the macro is false.
> > >>>
> > >>> The first approach is unable to handle non-vanilla kernels. The sec=
ond
> > >>> approach needs to add stub functions which are unclean. What I would
> > >>> like to do is,
> > >>>
> > >>> * add a m4 rule.
> > >>> * modify unshare Makefile like this,
> > >>>
> > >>>   ifdef HAVE_UNSHARE  <-- if the syscall is present, compile the te=
sts.
> > >>
> > >> the configure test should always be there if the code needs new head=
ers
> > >> (like sys/signalfd.h).  if it's only a new syscall, then the configu=
re
> > >> test should only be for the new symbol (assuming one is provided).  =
in
> > >> all cases, the tests should be compiled.  your proposal doesnt handle
> > >> the case where the C library is in place, but the kernel is older so
> > >> returns ENOSYS.
> > >
> > >     check_for_unshare was a poorly hacked app, IMO and Mike is
> > > correct. The issue needs to be a combination of buildtime and runtime
> > > tests as it needs to pass through the build and the issue with the
> > > syscall needs to be detected and marked TBROK if the syscall isn't
> > > implemented.
> >
> > ENOSYS is the expected result if the kernel under test has no such
> > implementation, so I would consider TPASS or TCONF.
> =

> TPASS is wrong.  in another thread, people seemed to be OK with TCONF.
> -mike

Still, the summary only shows `FAIL' or `PASS'. What is it supposed to
show for TCONF?

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
