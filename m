Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgKnr-0008Fl-5Z
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 15:52:51 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgKno-00026n-8o
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 15:52:51 +0000
Date: Wed, 26 Aug 2009 17:52:42 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <4A8C4246.4060607@canonical.com>
Message-ID: <alpine.LRH.2.00.0908261748140.17269@vixen.sonytel.be>
References: <4A8C4246.4060607@canonical.com>
MIME-Version: 1.0
Subject: Re: [LTP] fix for file_test for systems without rpm installed
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
To: Paul Larson <paul.larson@canonical.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Wed, 19 Aug 2009, Paul Larson wrote:
> Here's the fixed version, forgot I needed to redo these...
> =

> If you run file_test.sh on a system without rpm installed, it should
> return tconf instead of tfail.
> =

> Signed-off-by: Paul Larson <paul.larson@canonical.com>
> ---

> index 4fc9dec..4e30d43 100755
> --- a/testcases/commands/ade/file/file_test.sh
> +++ b/testcases/commands/ade/file/file_test.sh
> @@ -582,11 +587,7 @@ fi
>  export TCID=3Dfile10
>  export TST_COUNT=3D10
>  =

> -if [ -f /etc/redhat-release ]; then
> -   KERNEL=3Dvmlinuz
> -else
> -   KERNEL=3Dvmlinux
> -fi
> +KERNEL=3Dvmlinu
>  =

>  $LTPBIN/tst_resm TINFO "TEST #10: file command recognizes $KERNEL file"

I guess this change was not supposed to be part of this patch?

Not that I'm complaining, as it fixes another vmlinuz vs. vmlinux mismatch I
was seeing ;-)

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
