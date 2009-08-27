Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgbcC-0007jR-C0
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 09:49:56 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 29vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgbcB-00049T-DQ
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 09:49:56 +0000
Date: Thu, 27 Aug 2009 11:49:49 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <200908261550.10710.vapier@gentoo.org>
Message-ID: <alpine.LRH.2.00.0908271148570.22490@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908261719130.29807@vixen.sonytel.be>
	<200908261550.10710.vapier@gentoo.org>
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

On Wed, 26 Aug 2009, Mike Frysinger wrote:
> On Wednesday 26 August 2009 11:20:44 Geert Uytterhoeven wrote:
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > ---
> > Is there any better way to handle this??
> =

> change it to:
> if passwd -h | grep -q -e '--expire\>' ; then
              ^
	      2>&1

Next question: Does Google Translator do bash =3D> expect? ;-)

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
