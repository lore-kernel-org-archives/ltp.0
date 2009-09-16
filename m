Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MnwxD-0006WZ-Cx
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 16:01:59 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 29vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1Mnwx8-0002Gw-Mb
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 16:01:59 +0000
Date: Wed, 16 Sep 2009 18:01:52 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1253114232.6343.30.camel@subratamodak.linux.ibm.com>
Message-ID: <alpine.LRH.2.00.0909161801310.6362@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909151730320.29846@vixen.sonytel.be>
	<20090915215307.GD10922@count0.beaverton.ibm.com>
	<1253114232.6343.30.camel@subratamodak.linux.ibm.com>
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>, Serge Hallyn <serue@linux.vnet.ibm.com>

On Wed, 16 Sep 2009, Subrata Modak wrote:
> On Tue, 2009-09-15 at 14:53 -0700, Matt Helsley wrote: =

> > On Tue, Sep 15, 2009 at 05:30:55PM +0200, Geert Uytterhoeven wrote:
> > >    - As of 2.6.24, `capability' can no longer be a module,
> > >    - As of 2.6.27, CONFIG_SECURITY_CAPABILITIES no longer exists.
> > > =

> > > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > > ---
> > >  .../kernel/security/filecaps/checkforfilecaps.sh   |    3 +--
> > >  1 files changed, 1 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/testcases/kernel/security/filecaps/checkforfilecaps.sh b=
/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > > index 20f97f5..3f6a4ec 100755
> > > --- a/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > > +++ b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > > @@ -23,8 +23,7 @@ check_simple_capset
> > >  ret=3D$?
> > >  if [ $ret -ne 0 ]; then
> > >  	echo Posix capabilities not compiled into the kernel.  Please
> > > -	echo modprobe capability or recompile your kernel with
> > > -	echo CONFIG_SECURITY_CAPABILITIES=3Dy.
> > > +	echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=
=3Dy.
> > =

> > Then the advice is incorrect for older kernels. If LTP should still run
> > nicely for users of older kernels then perhaps something like this is b=
etter:
> > =

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
> > +	fi
> =

> Yes, this is better. Please shoot off a patch.

At your service!

---
From 0e13026c931d26393671884f63446b7389318b27 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Tue, 15 Sep 2009 17:06:09 +0200
Subject: [PATCH 9/9] Filecaps: Update error message for recent kernels

   - As of 2.6.24, `capability' can no longer be a module,
   - As of 2.6.27, CONFIG_SECURITY_CAPABILITIES no longer exists.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
--
v2: Make the message dependent on the kernel version, as suggested by Matt
    Helsley
---
 .../kernel/security/filecaps/checkforfilecaps.sh   |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/filecaps/checkforfilecaps.sh b/testc=
ases/kernel/security/filecaps/checkforfilecaps.sh
index 20f97f5..5ca385e 100755
--- a/testcases/kernel/security/filecaps/checkforfilecaps.sh
+++ b/testcases/kernel/security/filecaps/checkforfilecaps.sh
@@ -23,8 +23,14 @@ check_simple_capset
 ret=3D$?
 if [ $ret -ne 0 ]; then
 	echo Posix capabilities not compiled into the kernel.  Please
-	echo modprobe capability or recompile your kernel with
-	echo CONFIG_SECURITY_CAPABILITIES=3Dy.
+	if tst_kvercmp 2 6 24 ; then
+		echo modprobe capability or recompile your kernel with
+		echo CONFIG_SECURITY_CAPABILITIES=3Dy.
+	elif tst_kvercmp 2 6 27 ; then
+		echo recompile your kernel with CONFIG_SECURITY_CAPABILITIES=3Dy.
+	else
+		echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=3Dy.
+	fi
 	exit 1
 fi
 =

-- =

1.6.2.4

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
