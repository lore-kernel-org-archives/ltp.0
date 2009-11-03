Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N5Q3o-0004GB-Mo
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 20:33:00 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5Q3g-0003ZX-01
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 20:32:59 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Nov 2009 16:33:53 -0400
References: <b9d696240911031223h6734d911s57830e7d859813f9@mail.gmail.com>
In-Reply-To: <b9d696240911031223h6734d911s57830e7d859813f9@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911031533.53910.vapier@gentoo.org>
Subject: Re: [LTP] 20091031 won't run
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2345786884348632183=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2345786884348632183==
Content-Type: multipart/signed; boundary="nextPart2464640.rCXOz4lvnt";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2464640.rCXOz4lvnt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 November 2009 15:23:47 K.D. Lucas wrote:
> I downloaded the latest LTP, which is version 20091031. I ran ./configure,
> make, and make install. I notice that now make tries to write file to
> /opt/ltp/, so I needed to run make as root.

ltp installs to wherever you configured and installed it to.  the default i=
s=20
merely /opt/ltp/.  so if you didnt change the default, then it's up to you =
to=20
make sure the install location is available.

> When I go to run ltp, I get:
>=20
> FATAL: Test suite not installed correctly
> INFO: as root user type 'make ; make install'

what user did you run `ltp` as ?
=2Dmike

--nextPart2464640.rCXOz4lvnt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK8JOxAAoJEEFjO5/oN/WBZBwP/RuhFnY2/T+B4289oaUbxMji
LsSkNci9mmi5O4UXMYCg2q5uflCCUqcmCIn/uykM8vZ1GXgwaOOfXpN3WzfMQpPm
STLfX8dMknu2GTj3aBkf0BO4oa+Fwg9VqEWPO1QevclBd2K9LvdvZGFGMDLhc6jb
cNqtjBTY+9eem1h9TLIQRqqDIvuH+YZ8puMcGJdimipmscxf2wzCwDk0x+p22wM/
4RyFh/Ft29CmuGCn8u6Afa4J2FO4V/OQruQvaiG8uD06mzya500qcv6LT+51UiUc
To/bFRDugWxRivYhXK8GWynServPuye4vrxC8v3ucn2mlizPNqexSiyoqOPY6XlI
276NBlXLtp9jZ5I8gRmaI/IeNy1Wbcp0va5/Zmj5lDjddVQvQPAhrRYbS+BbEaWs
KP5R61hpUfMlaq7T55+GznUf8AAHc43ogpsH9+GJ5Ab20jlgICJzO2bbW31CiKpx
n+wngGCgMcg9EWE/+CFvqvkCvkTS2AxbYbWLgSezF5xxbtDwHttnSURd9qL2oFER
2YK6HozKgm+nqscrso/2rratqjwu7x2Q/2V6Yv5ZjvppcaGybq6Yh6jSYJ/bfbrD
GBZFZIL+kBWc35ya1yRW6R0Rl/xgVs0uVgASvQzgYaQ6qTJkMQ6ktpgH5cCM5txZ
ubuvMMk8Ekr8j/iWiF3P
=UwEI
-----END PGP SIGNATURE-----

--nextPart2464640.rCXOz4lvnt--


--===============2345786884348632183==
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
--===============2345786884348632183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2345786884348632183==--

