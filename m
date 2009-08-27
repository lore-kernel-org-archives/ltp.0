Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1Mgctl-0005At-8b
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 11:12:09 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1Mgcti-0004Nb-UX
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 11:12:09 +0000
Date: Thu, 27 Aug 2009 13:12:01 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <200908270606.16787.vapier@gentoo.org>
Message-ID: <alpine.LRH.2.00.0908271311410.22490@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908261719130.29807@vixen.sonytel.be>
	<200908261550.10710.vapier@gentoo.org>
	<alpine.LRH.2.00.0908271148570.22490@vixen.sonytel.be>
	<200908270606.16787.vapier@gentoo.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] su01: Yellow Dog Linux doesn't support passwd -e
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Thu, 27 Aug 2009, Mike Frysinger wrote:
> On Thursday 27 August 2009 05:49:49 Geert Uytterhoeven wrote:
> > On Wed, 26 Aug 2009, Mike Frysinger wrote:
> > > On Wednesday 26 August 2009 11:20:44 Geert Uytterhoeven wrote:
> > > > Is there any better way to handle this??
> > >
> > > change it to:
> > > if passwd -h | grep -q -e '--expire\>' ; then
> >               ^
> > 	      2>&1
> =

> yeah, some utils are pretty stupid and send help output to stderr.  i'll =
send =

> a patch to the shadow guys.
> =

> > Next question: Does Google Translator do bash =3D> expect? ;-)
> =

> not sure what you mean ... program options are not translated

The script that does the test is written in expect.

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
