Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MwhyV-0008H7-0W
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 19:51:31 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MwhyO-0003RQ-GW
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 19:51:30 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 10 Oct 2009 15:51:15 -0400
References: <364299f40910091048w54ece725l2b07a04bb82f6a4f@mail.gmail.com>
In-Reply-To: <364299f40910091048w54ece725l2b07a04bb82f6a4f@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200910101551.16789.vapier@gentoo.org>
Subject: [LTP] mixing of install/build targets
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4557353515075568215=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4557353515075568215==
Content-Type: multipart/signed; boundary="nextPart3470176.SE30j35Ln8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3470176.SE30j35Ln8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 09 October 2009 13:48:42 Garrett Cooper wrote:
>     I'm posting the following diff as reference (it's compressed
> because the entire diff is ~1.8MB) as I'm now going to commit the
> following to CVS after 1.25 years of anticipation waiting for this
> enhancement in the Makefiles to correct issues related to difficulty
> primarily in 1) terms of maintenance, 2) lack of out-of-build-tree
> support, and 3) the fact that we weren't following autoconf-like
> practices for installation [ties into 1) and 2)].
>     If there are any issues in building the sourcebase after this,
> please consult the TODO file in the root directory to determine
> whether or not it's a known issue. If the issue isn't listed there,
> please email the list and CC me. I ran it on Fedora 10, Gentoo Linux,
> and Ubuntu Feisty Fawn, so I tried to get as much coverage as possible
> when making these changes.

seems like the compile step depends on install dirs.  a simple make in a=20
subdir fails with:
$ make
mkdir -p "/opt/ltp/testcases/bin"
mkdir: cannot create directory `/opt/ltp': Permission denied
make: *** [/opt/ltp/testcases/bin] Error 1

or if prefix isnt set:
$ make
mkdir -p "/testcases/bin"
mkdir: cannot create directory `/testcases': Permission denied
make: *** [/testcases/bin] Error 1

these are only needed during the install step
=2Dmike

--nextPart3470176.SE30j35Ln8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJK0OW0AAoJEEFjO5/oN/WBsOkP/jrZb0qHtZ9NHULHf2HSTcag
jXiWEab+DirSZqe1m91j/rGwz3Low//eGYVLlB9WATUTTMXadgoLWtafw85G9cNC
2SsGkxBwnLEEjBM6GPSGbeOX6bUJ1FSHDluBGWrSG+4Rj5cPL0Ri5so1H8EcsH/A
JO//lq9uycu+fGMKo90Uk3NtczV31nUhLlen2sFfxlOPp91KIzNau9hGyA9ugUGq
Xsdl6EloLt5xd1XFiNuXTagnTL6X1cacQXkVxGPbLWeGotQMFyMJ0mTiEs6d+dX3
u85lPkNOnkD7JoCi0jao7bH15qxTn8mrdLWu415zYePUes3Q5jIqxBoZMo9j1ni7
qDawR/QI08Rkrqf+oGE4GvuojZ7/DxuMTgYdKGP1RhvnFYBwPeJ7gKiGx3175D0M
qO0MgH6JRnyKj0721ypct6XOeYkYub6Sb0okKvCtPO1VFpaH2blL3OAG6eoSx+3n
Wy2masGhpJ//fqN7yEaPqKyxiqDF14peo1hjRJmEWnLCaMw/ddHFjoOFB1Tq0A1L
+vYMXtojeU5pdsI9YChWb6/2+XD2ztJ6raPYL/5UsBRnU8QSxNycKfvjnfigDoAV
M/NXF91CAseRK4TOqzasExMhw70aMhNliMu7KiTzuq+GSyK1OEiGcEjP9krk8hD4
Vgi3ogmTtoIsNGslELYr
=+rGv
-----END PGP SIGNATURE-----

--nextPart3470176.SE30j35Ln8--


--===============4557353515075568215==
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
--===============4557353515075568215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4557353515075568215==--

