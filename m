Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MbtES-00041k-RW
	for ltp-list@lists.sourceforge.net; Fri, 14 Aug 2009 09:37:56 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MbtEL-0006pb-Un
	for ltp-list@lists.sourceforge.net; Fri, 14 Aug 2009 09:37:56 +0000
Date: Fri, 14 Aug 2009 11:37:41 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <364299f40908082213w425fae44u9b73efe43386353a@mail.gmail.com>
Message-ID: <alpine.LRH.2.00.0908141126130.18586@vixen.sonytel.be>
References: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
	<1249494775.13131.18.camel@lucio-laptop>
	<3E7F2B7B-6BA8-4179-B973-5DA7F4D7618A@kernel.crashing.org>
	<364299f40908061024l42cd1200n99e6e762a77c91d2@mail.gmail.com>
	<D4B24F3A-3BF2-41BA-9626-2D13AC12B515@kernel.crashing.org>
	<2E55F490-102A-4179-B0F2-ED7F5C0D1A12@kernel.crashing.org>
	<364299f40908082026r1fa95822p538298b334eaaefa@mail.gmail.com>
	<364299f40908082213w425fae44u9b73efe43386353a@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] top of tree fails to build on PPC fc11 box
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Sat, 8 Aug 2009, Garrett Cooper wrote:
> On Sat, Aug 8, 2009 at 8:26 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> > On Thu, Aug 6, 2009 at 11:07 AM, Kumar Gala<galak@kernel.crashing.org> =
wrote:
> >> On Aug 6, 2009, at 12:43 PM, Kumar Gala wrote:
> >>>> =A0Ok. I have the time now so I'll install F11 amd64 and see what
> >>>> happens. Something leads me to think that the build toolchain is
> >>>> fubared, but that's just a hunch, as my copy of F10 (the last time I
> >>>> ran the build) worked.
> >>>> Thanks,
> >>>> -Garrett
> >>>
> >>> interesting since I saw the same issues w/F10 amd64.
> >>>
> >>> - k
> >>
> >> I also just tried installing clean versions of automake, autoconf, m4 =
to
> >> match the versions in the INSTALL file and got:
> >>
> >> autoconf-2.61
> >> automake-1.10.2
> >> m4-1.4.12
> >>
> >> and still get the same issue:
> >>
> >> touch config.mk
> >> aclocal -I m4
> >> autoconf
> >> configure.ac:9: error: possibly undefined macro: AC_PROG_AR
> >> =A0 =A0 If this token and others are legitimate, please use m4_pattern=
_allow.
> >> =A0 =A0 See the Autoconf documentation.
> >> make: *** [configure] Error 1
> >
> > Kumar,
> > =A0 =A0I have no idea what's wrong with your install, but it compiles
> > perfectly fine on Fedora 11 / x86. I'll try with Fedora 10 in a few
> > mins...
> =

> And Fedora 10 passed too on x86.
> =

> Try running ac-maintainer-clean first, from the top, then run make
> autotools, then ./configure . Does that work?

I'm having the same issue on debian-powerpc.

During bisection (I'm using Kumar's ltp.git on kernel.org), `make autotools'
started to complain about a missing m4/Makefile.am. After fixing that one,
several other files were found to be missing.

I also tried a fresh checkout from sf.net's CVS, and there it works fine.
So I guess some critical files were not imported in ltp.git?

BTW, how do you run `ac-maintainer-clean'?

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
