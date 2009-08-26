Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgIV5-0005bN-RP
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 13:25:19 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 29vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgIV4-0003nx-9u
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 13:25:19 +0000
Date: Wed, 26 Aug 2009 15:25:05 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <20090826130717.GA50086@medusa.sis.pasteur.fr>
Message-ID: <alpine.LRH.2.00.0908261524310.17269@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908261443220.25669@vixen.sonytel.be>
	<20090826130717.GA50086@medusa.sis.pasteur.fr>
MIME-Version: 1.0
Subject: Re: [LTP] undefined macro: _m4_divert_diversion
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
To: Nicolas Joly <njoly@pasteur.fr>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Wed, 26 Aug 2009, Nicolas Joly wrote:
> On Wed, Aug 26, 2009 at 02:57:10PM +0200, Geert Uytterhoeven wrote:
> > When trying to autoconfigure current LTP on YDL, I get:
> > =

> >     # make autotools =

> >     touch config.mk
> >     aclocal -I m4
> >     m4/ltp-unshare.m4:2: error: m4_defn: undefined macro: _m4_divert_di=
version
> >     m4/ltp-unshare.m4:2: the top level
> >     autom4te: /usr/local/bin/m4 failed with exit status: 1
> >     aclocal: autom4te failed with exit status: 1
> >     make: *** [aclocal.m4] Error 1
> >     #
> [...]
> =

> This is a quoting problem ... The following patch should fix it.

Thanks, now it works!

> Index: m4/ltp-unshare.m4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/m4/ltp-unshare.m4,v
> retrieving revision 1.1
> diff -u -p -r1.1 ltp-unshare.m4
> --- m4/ltp-unshare.m4	25 Aug 2009 07:37:46 -0000	1.1
> +++ m4/ltp-unshare.m4	26 Aug 2009 13:04:03 -0000
> @@ -1,2 +1,2 @@
>  AC_DEFUN([LTP_CHECK_SYSCALL_UNSHARE],
> -AC_CHECK_FUNCS_ONCE(unshare))
> +[AC_CHECK_FUNCS_ONCE([unshare])])
> =

> Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

Tested-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

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
