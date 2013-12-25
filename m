Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VvkgP-0007fP-Th
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 09:23:17 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VvkgP-000148-1H
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 09:23:17 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 25 Dec 2013 04:23:04 -0500
References: <1387884941.1622.98.camel@G08JYZSD130126>
	<1387885358.1622.104.camel@G08JYZSD130126>
In-Reply-To: <1387885358.1622.104.camel@G08JYZSD130126>
MIME-Version: 1.0
Message-Id: <201312250423.10814.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v3 1/4] fallocate/fallocate.h: move inline function
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6507591583255891098=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

--===============6507591583255891098==
Content-Type: multipart/signed; boundary="nextPart3957052.faqKzgJQke";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3957052.faqKzgJQke
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 24 December 2013 06:42:38 zenglg.jy wrote:
> On Tue, 2013-12-24 at 19:35 +0800, zenglg.jy wrote:
> > >From edb98f0b69c16f612f79fe24d10597af47424f13 Mon Sep 17 00:00:00 2001
> >=20
> > From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> > Date: Tue, 24 Dec 2013 19:21:32 +0800
> > Subject: [PATCH] fallocate/fallocate.h: move inline function
> >=20
> > Moved common inline function to fallocate.h
> >=20
> > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> > ---
> >=20
> >  testcases/kernel/syscalls/fallocate/fallocate.h   | 47
> >  +++++++++++++++++++++++
> >  testcases/kernel/syscalls/fallocate/fallocate01.c | 23 +----------
> >  testcases/kernel/syscalls/fallocate/fallocate02.c | 19 +--------
> >  testcases/kernel/syscalls/fallocate/fallocate03.c | 19 +-------- 4
> >  files changed, 50 insertions(+), 58 deletions(-)
> >  create mode 100644 testcases/kernel/syscalls/fallocate/fallocate.h
> >=20
> > diff --git a/testcases/kernel/syscalls/fallocate/fallocate.h
> > b/testcases/kernel/syscalls/fallocate/fallocate.h new file mode 100644
> > index 0000000..e47338b
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/fallocate/fallocate.h
> > @@ -0,0 +1,47 @@
> > +/*
> > + * Copyright (c) International Business Machines  Corp., 2007
> > + * Copyright (c) 2013 Fujitsu Ltd.
> > + *
> > + * This program is free software;  you can redistribute it and/or modi=
fy
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU Library General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7,
> > USA. + *
> > + */
> > +
> > +#ifndef FALLOCATE_H
> > +#define FALLOCATE_H
> > +
> > +#include <sys/types.h>
> > +#include <endian.h>
> > +#include "linux_syscall_numbers.h"
> > +
> > +static inline long fallocate(int fd, int mode, loff_t offset, loff_t
> > len) +{
> > +/*
> > + * Use __WORDSIZE will fail on ABI's that have 64bit registers but 32b=
it
> > + * longs like MIPS n32 and x86_64 x32
> > + */
>=20
> I do not know about the ABI's problem. Could someone give me a help.

you can check for mips n32 by doing:
	#if defined(__mips__) && _MIPS_SIM =3D=3D _ABIN32

you can check for x86_64 x32 by doing:
	#if defined(__x86_64__) && defined(__ILP32__)

these should use the 64bit code path
=2Dmike

--nextPart3957052.faqKzgJQke
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSuqP+AAoJEEFjO5/oN/WB+s8P/j8fCB8KAKFRU/iEFzdgVXUd
3kwvCX1HBLOVGUCZWKr3A7x2Slvv6PNRwY4py6LgcoUoAGNXeCtHCpWhhtW00UqT
TTgHxurRlZ4P9ggCRQMmgDpSFo5RIFoSXLIBoD+7appKPmNzX+3LU19mbvSOGOTI
MYkGK8SKh+pIm8/vFLCGcBpfTR3EYLoTjs4cOOPcEVmiGAO1oaPNSYYAdWfH4NCT
NtcCj4Ni+c6yYbz7FXAL6FBKeI1cNeyWxwF6afPwSDQL5eicWMf+DtpyiPfJQ+US
F4y6/L+XB/Wfu8TNaIm10Jt8JdE8RIsGyNPOemn7la5ENEiGzpdzmaCgfUW4wuhf
W6eRbWB7jCPa52jTAL/+vRaVnEnZPrSZZ1VghbUdV7ByI3aDcTaD58sbLqh8vEHL
HY6nmppOl32uOZ2JdHchNr9pOt/6ivWJYlSeJ6Boxwi0/xCkv9oMbaT3U7GmT0++
IbrJN/QgYY4OgsAund58R81PMlCZC3qg+U7fJq/e/1Fcsed7wYAPDc+vKRp39pox
q14E08T7f7VzBCDX+Px5T1ojJbShrfLxiJaStkq7SB37wahloMShlsL3Dh7HyC8y
ccLEyf5n8N1xirwBDwIPBWz7fr9Bbdxz+DmQMmvjpQ0eO5Nb0kPjkv31woKUEhSf
SJfVTUjTAul3gymCRVd5
=tQ2E
-----END PGP SIGNATURE-----

--nextPart3957052.faqKzgJQke--


--===============6507591583255891098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--===============6507591583255891098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6507591583255891098==--

