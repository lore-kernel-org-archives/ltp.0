Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MfVD9-00005W-27
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 08:47:31 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MfVD2-0008BS-LN
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 08:47:31 +0000
Date: Mon, 24 Aug 2009 10:47:14 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <200908240003.42716.vapier@gentoo.org>
Message-ID: <alpine.LRH.2.00.0908241046480.31587@vixen.sonytel.be>
References: <20090824.012723.112609532.caiqian@cclom.cn>
	<200908232249.46097.vapier@gentoo.org>
	<20090824.114921.104053885.caiqian@cclom.cn>
	<200908240003.42716.vapier@gentoo.org>
MIME-Version: 1.0
Subject: Re: [LTP] What is the Story of "make autotools"
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
To: Mike Frysinger <vapier@gentoo.org>, Kumar Gala <galak@kernel.crashing.org>
Cc: Linux Test Project <ltp-list@lists.sourceforge.net>

On Mon, 24 Aug 2009, Mike Frysinger wrote:
> On Sunday 23 August 2009 23:49:21 CAI Qian wrote:
> > From: Mike Frysinger <vapier@gentoo.org>
> > > On Sunday 23 August 2009 13:27:23 CAI Qian wrote:
> > >> $ make autotools
> > >> make: *** No rule to make target `m4/Makefile.am', needed by
> > >>       `m4/Makefile.in'.  Stop.
> > >
> > > that file is in cvs.  if you have an incomplete checkout, there's not=
hing
> > > we can do about it.
> >
> > Hmm, looks like the GIT repository has no such file though,
> =

> you'll have to complain to whoever runs the git repo.  it isnt us.
> -mike

I already reported this (also to Kumar) on Fri, 14 Aug...

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
