Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbUav-00081P-0p
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:19:29 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbUah-0000m1-M7
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:19:23 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:19:08 -0400
References: <alpine.LRH.2.00.0908071046001.9737@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908071046001.9737@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908130319.09133.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix calculated syscall numbers for hppa/powerpc{,
	64}/s390{, x}/sh/sparc{, 64}
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5484558449294547212=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--===============5484558449294547212==
Content-Type: multipart/signed; boundary="nextPart2493842.FvoRzURG1q";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2493842.FvoRzURG1q
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 07 August 2009 04:49:45 Geert Uytterhoeven wrote:
> Commit "move leading __NR_ to script to make all the .in files simpler"
> accidentally removed all plus signs surrounded by spaces from the syscall
> definition files for hppa/powerpc{,64}/s390{,x}/sh/sparc{,64}, breaking t=
he
> build like:
>
> 	fstatat01.c: In function =A1main=A2:
> 	fstatat01.c:126: error: expected =A1)=A2 before numeric constant
> 	make[4]: *** [fstatat01_64.o] Error 1
>
> Re-add the missing plus signs to fix it.

of course, sorry about that
=2Dmike

--nextPart2493842.FvoRzURG1q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg75tAAoJEEFjO5/oN/WB38gP/2/MJv8Jffqqg6USljSSfl00
t/G17GA2dySopNQuqX1Dbeew+SxrAxzxHz/uOrH6bWexOKlooVycft/GjfxigdNI
w8rTEvrPqqsy/3NLEpmD8F4Fj7m4lu39rvjZgAIcSiL6YUJtDRJdhqeWr1oabEom
0mZ6+Ez5ChkwEb0LS+ONd2zwIRGxeJ08sOq85eUJaPDJusj9OnwwocC3WlnkpzyT
K5J7V0wOE4Nn3mv8EfqdCzVrDJDmX8X/WBErphZ3InnDRIV6cxhZsx2dRYVshcUe
VsmciJx8Ee57Z9fS0B0QJN+dEOkg3Yza0EH7pD4lwBQXduVSsa6mOPkVaqhqvhWm
/tVppqfOSneBqlano3mXyP9VSiY0WHwVVIXGcK8kOmdnuZUBrfBNW7XGfmI93wWd
acmL+Sg3WxWgB7x30rKO8seUwF3Lh5nB5D56evQHp+3iv2RoLpV+ggZupTNm+gm7
AE8pfjOSErZIXlGRhLwgWlP3v7UaOEJbNIZi03uvUosNnTlUtUoNULDqctCx1wuD
Kixz4ovL1VtT91a4FrvBwA1Q33iUmrXBtIULI93FZ32nWXzpDPOnp2bhRjGMGaax
AUEl25/LuPwG5Zy9wXIkUdgi/RH9Wz3sKjsFPHpiiguglhmvVpmyd7XX/uk6ejkJ
kz6DEBbrEkNCS9KmrSrX
=EAML
-----END PGP SIGNATURE-----

--nextPart2493842.FvoRzURG1q--


--===============5484558449294547212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5484558449294547212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5484558449294547212==--

