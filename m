Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MgbsK-00066g-Li
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 10:06:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mgbs7-0006cf-R7
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 10:06:31 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Aug 2009 06:06:15 -0400
References: <alpine.LRH.2.00.0908261719130.29807@vixen.sonytel.be>
	<200908261550.10710.vapier@gentoo.org>
	<alpine.LRH.2.00.0908271148570.22490@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908271148570.22490@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908270606.16787.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============3498681606938521440=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: ltp-list@lists.sourceforge.net

--===============3498681606938521440==
Content-Type: multipart/signed; boundary="nextPart8466582.hbLRo2hxGD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8466582.hbLRo2hxGD
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On Thursday 27 August 2009 05:49:49 Geert Uytterhoeven wrote:
> On Wed, 26 Aug 2009, Mike Frysinger wrote:
> > On Wednesday 26 August 2009 11:20:44 Geert Uytterhoeven wrote:
> > > Is there any better way to handle this??
> >
> > change it to:
> > if passwd -h | grep -q -e '--expire\>' ; then
>               ^
> 	      2>&1

yeah, some utils are pretty stupid and send help output to stderr.  i'll se=
nd=20
a patch to the shadow guys.

> Next question: Does Google Translator do bash =3D> expect? ;-)

not sure what you mean ... program options are not translated
=2Dmike

--nextPart8466582.hbLRo2hxGD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKllqYAAoJEEFjO5/oN/WB06UQALO8dBDzbvv5gfk94CoSrQrb
692lQDFsqEJySoJoeipXB/ShPaux7Ng6Y0+/3F3Q+7WIBctcXC4Ni/1lDdggmYNo
3QSrxiGEDfCXQnYoKxqeLJ4Ia1UlYXbqQBLZQBNF18jBs57U2NLfYMl05ci9LvI2
y4/YqomtAUi7DbVtDRhlZO2lEewDaD13Gd6QXKZFb7IkgKSpafmoiDTvrIrSVXE6
wTpkJFCfGQJfqNPxqfjWoUCTtQmK4sH9ASFijkFppbDVH0sEa0ODAAQej75dvLdy
KbDJnzt9SD4anfrsuixojiKpB16A12wjrr0vLbhE8o/bIkJrABZ9Iulu1fQtj/50
xPxQrGkIOfKmQI/v2DN531DINOp5jUVhH2Abld+ImgX79iZS9bDEvcO9gzjvd+Es
jweZZb8bur8grntuONl9PceRTyEozwSJORzjMy9uTaxQqCD12yOVrrLHNQpOY8Nx
EEayNBHBC/9r9/HmUM6E6Wa0CC0tHG8mB+bdHTj10yWeJN/ITpWLFdxZfJ62gETq
0k/mD4vVZ5NWO0GmysqpJM03O2xtkbQcRNIgEVJoCMu5CVAbFtDaLVy/2mdXCxYc
iVlM2jeEvXisPtOkO0WEMZSSOeTiHkGb4PUmWewzlngNVmEohWeyLBdRcc7vpufN
hYbszCZvzWtUa3p9BSuU
=pHS3
-----END PGP SIGNATURE-----

--nextPart8466582.hbLRo2hxGD--


--===============3498681606938521440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3498681606938521440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3498681606938521440==--

