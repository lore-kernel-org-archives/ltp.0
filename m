Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MnaON-0007PZ-Ac
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 15:56:31 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnaOJ-0001ho-5D
	for Ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 15:56:31 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8FFoLq6023600
	for <Ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 09:50:21 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8FFuHNw165728
	for <Ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 09:56:19 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8FFuH83027126
	for <Ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 09:56:17 -0600
Date: Tue, 15 Sep 2009 10:56:11 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090915155611.GA17263@us.ibm.com>
References: <alpine.LRH.2.00.0909151730320.29846@vixen.sonytel.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.0909151730320.29846@vixen.sonytel.be>
Subject: Re: [LTP] [PATCH] Filecaps: Update error message for recent kernels
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

Quoting Geert Uytterhoeven (Geert.Uytterhoeven@sonycom.com):
>    - As of 2.6.24, `capability' can no longer be a module,
>    - As of 2.6.27, CONFIG_SECURITY_CAPABILITIES no longer exists.
> =

> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Yup, thanks.

Acked-by: Serge Hallyn <serue@us.ibm.com>

-serge

> ---
>  .../kernel/security/filecaps/checkforfilecaps.sh   |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> =

> diff --git a/testcases/kernel/security/filecaps/checkforfilecaps.sh b/tes=
tcases/kernel/security/filecaps/checkforfilecaps.sh
> index 20f97f5..3f6a4ec 100755
> --- a/testcases/kernel/security/filecaps/checkforfilecaps.sh
> +++ b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> @@ -23,8 +23,7 @@ check_simple_capset
>  ret=3D$?
>  if [ $ret -ne 0 ]; then
>  	echo Posix capabilities not compiled into the kernel.  Please
> -	echo modprobe capability or recompile your kernel with
> -	echo CONFIG_SECURITY_CAPABILITIES=3Dy.
> +	echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=3Dy.
>  	exit 1
>  fi
>  =

> -- =

> 1.6.2.4
> =

> With kind regards,
> =

> Geert Uytterhoeven
> Software Architect
> Techsoft Centre
> =

> Technology and Software Centre Europe
> The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgi=
um
> =

> Phone:    +32 (0)2 700 8453
> Fax:      +32 (0)2 700 8622
> E-mail:   Geert.Uytterhoeven@sonycom.com
> Internet: http://www.sony-europe.com/
> =

> A division of Sony Europe (Belgium) N.V.
> VAT BE 0413.825.160 =B7 RPR Brussels
> Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
> =

> -------------------------------------------------------------------------=
-----
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay =

> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#3=
3;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
