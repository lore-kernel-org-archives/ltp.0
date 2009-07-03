Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from [172.29.28.124] (helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MMoyI-000065-6E
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 20:02:58 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMoxG-0005KK-C8
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 20:02:02 +0000
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 70B3E6772A
	for <ltp-list@lists.sourceforge.net>;
	Fri,  3 Jul 2009 20:01:53 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 3 Jul 2009 16:01:52 -0400
MIME-Version: 1.0
Message-Id: <200907031601.52650.vapier@gentoo.org>
Subject: [LTP] futex syscall tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4354051889630418796=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP <ltp-list@lists.sourceforge.net>

--===============4354051889630418796==
Content-Type: multipart/signed; boundary="nextPart1504779.teFW7JnsjM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1504779.teFW7JnsjM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

are there any futex syscall tests already in ltp that i cant seem to locate=
 ? =20
if not, i can adapt the few that already exist in the libfutex code ...
=2Dmike

--nextPart1504779.teFW7JnsjM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKTmOwAAoJEEFjO5/oN/WBKxgP/jvGHfn0nGSnRW7zjFXSSN7f
bvR7F7v+Mm2Q8KcybcUveHi/7taCMl5/806I/owNpmmIY6dOoObkzSJtsVeQpS2X
JGG94evsHkEaSHvaHH62PPxOjt3bThO2NOyEScLhceaFqZhNSo8V48dKxRpXE4+R
79XsmJdFOip2plR+bgHuT6mtFqX/pxWpz0Iy789/V3TTs5wFm+D1LWy7xQ5sItVA
7OuTcWdCGyGiBVcib0DP8PizGqBiDoZiM+kfn2K49Gdu6bP2KZAdJgP0ys7J6TsR
xOx1WPiaL+B1LvDEdWPEXCAAUpJ+La9btuIDBzHrrButk5ziIQy7Mh8FgckgMXFd
Hp1g8SNaWLGG1pKxFNUECU5uJH1oOoF7LG8qXjhEp8mUUniC/geReERMjo9Udz+o
JRin+a4SEvlet9yknG3IJXshbDheMOoS49iMrcrTkB8XKeNQCMpPKGWi9fKb31G1
mWIUE05tZEHqu+SPYoqSNazwD5M+sJyRE8INfKx/t3ZN8s5AxrmwmcbKfe3KlhGV
gNd5c0HyVWRFJyF5qeN8pgAAIzKLTFm/KX4JextenMQTCCPsub81qajnnFX0Ly/S
8qf+aFSbIAdpngCysQbditRX+4aQ10EUmlSKHHEqX76HbOVk78Ula9hCTNNSOcrH
cLEW9eG9z+1LaMITRlhR
=FRp4
-----END PGP SIGNATURE-----

--nextPart1504779.teFW7JnsjM--


--===============4354051889630418796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============4354051889630418796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4354051889630418796==--

