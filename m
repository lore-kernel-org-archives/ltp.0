Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MoCBB-0000U4-K8
	for Ltp-list@lists.sourceforge.net; Thu, 17 Sep 2009 08:17:25 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MoCB7-0007M9-1m
	for Ltp-list@lists.sourceforge.net; Thu, 17 Sep 2009 08:17:25 +0000
Date: Thu, 17 Sep 2009 10:17:21 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <20090916170753.GB7549@us.ibm.com>
Message-ID: <alpine.LRH.2.00.0909171014440.13477@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909151730320.29846@vixen.sonytel.be>
	<20090915215307.GD10922@count0.beaverton.ibm.com>
	<1253114232.6343.30.camel@subratamodak.linux.ibm.com>
	<alpine.LRH.2.00.0909161801310.6362@vixen.sonytel.be>
	<20090916170753.GB7549@us.ibm.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>, Serge Hallyn <serue@linux.vnet.ibm.com>

On Wed, 16 Sep 2009, Serge E. Hallyn wrote:
> Quoting Geert Uytterhoeven (Geert.Uytterhoeven@sonycom.com):
> > >From 0e13026c931d26393671884f63446b7389318b27 Mon Sep 17 00:00:00 2001
> > From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > Date: Tue, 15 Sep 2009 17:06:09 +0200
> > Subject: [PATCH 9/9] Filecaps: Update error message for recent kernels
> > =

> >    - As of 2.6.24, `capability' can no longer be a module,
> >    - As of 2.6.27, CONFIG_SECURITY_CAPABILITIES no longer exists.
> > =

> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > --
> > v2: Make the message dependent on the kernel version, as suggested by M=
att
> >     Helsley
> > ---
> >  .../kernel/security/filecaps/checkforfilecaps.sh   |   10 ++++++++--
> >  1 files changed, 8 insertions(+), 2 deletions(-)
> > =

> > diff --git a/testcases/kernel/security/filecaps/checkforfilecaps.sh b/t=
estcases/kernel/security/filecaps/checkforfilecaps.sh
> > index 20f97f5..5ca385e 100755
> > --- a/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > +++ b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > @@ -23,8 +23,14 @@ check_simple_capset
> >  ret=3D$?
> >  if [ $ret -ne 0 ]; then
> >  	echo Posix capabilities not compiled into the kernel.  Please
> > -	echo modprobe capability or recompile your kernel with
> > -	echo CONFIG_SECURITY_CAPABILITIES=3Dy.
> > +	if tst_kvercmp 2 6 24 ; then
> > +		echo modprobe capability or recompile your kernel with
> > +		echo CONFIG_SECURITY_CAPABILITIES=3Dy.
> > +	elif tst_kvercmp 2 6 27 ; then
> > +		echo recompile your kernel with CONFIG_SECURITY_CAPABILITIES=3Dy.
> > +	else
> > +		echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=3D=
y.
> =

> I don't think splitting these last two up is necessary - the
> CONFIG_SECURITY_FILE_CAPABILITIES check is in the next stanza
> in checkforfilecaps.sh.  This check is only for
> CONFIG_SECURITY_CAPABILITIES itself.

However, this (first) check is triggered on my 2.6.31+ kernel with
CONFIG_SECURITY_FILE_CAPABILITIES=3Dn, where the config symbol
CONFIG_SECURITY_CAPABILITIES no longer exists.

Or should it be plain CONFIG_SECURITY?

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
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
