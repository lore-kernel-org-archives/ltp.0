Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgxWB-0000te-Tn
	for Ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 09:13:11 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 29vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgxW9-0002ho-55
	for Ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 09:13:11 +0000
Date: Fri, 28 Aug 2009 10:48:08 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1251448700.9081.13.camel@subratamodak.linux.ibm.com>
Message-ID: <alpine.LRH.2.00.0908281044020.29648@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<alpine.LRH.2.00.0908271709060.22490@vixen.sonytel.be>
	<1251439738.9081.9.camel@subratamodak.linux.ibm.com>
	<1251448700.9081.13.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Annotate tst_*() helpers with __attribute__
 ((format (printf, M,
 N))) (was: Re: [PATCH] quotactl01: Fix tst_resm() format causing crash)
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Fri, 28 Aug 2009, Subrata Modak wrote:
> On Fri, 2009-08-28 at 11:38 +0530, Subrata Modak wrote:
> > On Thu, 2009-08-27 at 17:29 +0200, Geert Uytterhoeven wrote: =

> > > On Thu, 27 Aug 2009, Geert Uytterhoeven wrote:
> > > > When the quotactl syscall fails, quotactl01 crashes with a segmenta=
tion fault
> > > > due to an incorrect printf()-style format.
> > > =

> > > This bug encouraged me to add annotations to the test helpers that ta=
ke
> > > printf()-style formats, cfr. the patch below.
> > > =

> > > It causes a massive amount of compiler warnings, most of them caused =
by
> > > TEST_ERRNO being long. According to CVS history, both TEST_RETURN and
> > > TEST_ERRNO have been changed from int to long to accomodate 64-bit pl=
atforms,
> > > but to me the change of TEST_ERRNO looks bogus.
> > > As errno is int according to C99, TEST_ERRNO should actually be int t=
oo, right? =

> > > =

> > > Note that there are also a few other cases where integers are used on=
 pointer
> > > type format specifiers. These will cause crashes when the code path is
> > > executed.
> > > =

> > > >From 601578f79c05779acefe023fd499726d9fe4ce03 Mon Sep 17 00:00:00 20=
01
> > > From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > > Date: Thu, 27 Aug 2009 17:08:18 +0200
> > > Subject: [PATCH] Annotate tst_*() helpers with __attribute__ ((format=
 (printf, M, N)))
> > > =

> > > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > =

> > Ok. Thanks.
> =

> Sorry. I need to revert this as it generates a huge set of warning for
> all the tests compiled. It should not only get fixed at test.h, but also
> in all tests that uses the tst_* family of functions, which obviously is
> too big to fix.

Yes, it should be fixed elsewhere, too. Reverting TEST_ERRNO to int should =
kill
a few thousand of them...

But without enabling the warnings, you don't notice the real bugs, where
integers are passed instead of string pointers.

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
