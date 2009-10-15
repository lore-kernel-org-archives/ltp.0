Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MyTlC-0002Cg-SA
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 17:05:06 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MyTl3-0006s5-QM
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 17:05:06 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 15 Oct 2009 13:04:48 -0400
References: <c651035e0910150449p2792fc3eu653719afe4c354b4@mail.gmail.com>
In-Reply-To: <c651035e0910150449p2792fc3eu653719afe4c354b4@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200910151304.49265.vapier@gentoo.org>
Subject: Re: [LTP] LTP - usage of DESTDIR instead of relative paths
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6028305780578770000=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Martin Persson <martin.r.persson@gmail.com>

--===============6028305780578770000==
Content-Type: multipart/signed; boundary="nextPart2390232.2HOft8DFlf";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2390232.2HOft8DFlf
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 15 October 2009 07:49:19 Martin Persson wrote:
> I wonder if you plan to update the Makefiles in LTP in order to use
> $(DESTDIR) instead of relative "install paths"?
>=20
> I.e. update from:
> install:
>     @set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
>=20
> to:
> install:
>     @set -e; for i in $(TARGETS); do ln -f $$i $(DESTDIR)/$$i ; done

you're using outdated sources.  this should be resolved already in latest c=
vs.

also, your proposed change is incorrect.  DESTDIR is the root path, so=20
installing symlinks into the root path is wrong.  it should have been=20
something like $(DESTDIR)$(bindir)/$$i
=2Dmike

--nextPart2390232.2HOft8DFlf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJK11YxAAoJEEFjO5/oN/WBsloQANerTwmn9h2lGfC4atwDV0f9
bmh0p011kcEF8lkHK1jwDuVATUFpprkOjCCuEPADTlnMVS/Ch6B0tVfEUf1vG6U5
tjYVkZG6FfifQlzONQf5rMNNw0yawhDIF5MI6nt0H/f4vQzighDK2oDcWiryUpj/
QSJ7XecbCfQ32Bc48WAra/bGXDuztRPo/yd7Fb5fsDmwl53MKHni1WOv2ehBHnOu
SS8g4wY+qgKI8jmuni/mECIK/RhuYoutySrJDENKomE52tZQbBbkmqzMb/bcxOWl
DsQC2bulC1a7WzdcUsqehJNrKTxhLdvVAAEGdBnUDfnuPQSMSIopV5/ln5UCuUHl
AyBGkQHkiDx/PvIbFKkYXEgwCisjexTW/40nwlRq3RhryT/WgWKxDS4aISlF/xQc
QAJfq+DqBIvxDLsRmdCad83YwmtLTmak5zsowjxUv+en0Q+kbqpzrUztqsbfu78X
O3aaT0CGjV+oEaXgb2o62l3/4IDAR4hqH1jGcWA5+4pS76I86btc8Ly+eeryCPNX
WuYoGoz/kr96/OKUV4SEw99bLFz79ETsagbzK/Yvmw+cS4eGQa8LyK6AMvZgykcL
ppAdlkNMkHBPrHVVFp6fMP3OQk6WA5Nd110Q3o2bmcKUxUbJBCmdU6++RqwhiSKE
/t6DYobjEoW6ZbqAEgkN
=ph4r
-----END PGP SIGNATURE-----

--nextPart2390232.2HOft8DFlf--


--===============6028305780578770000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============6028305780578770000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6028305780578770000==--

