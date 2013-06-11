Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UmS0J-0005c7-46
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 17:05:07 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UmS0G-00053u-LR
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 17:05:07 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 11 Jun 2013 13:04:45 -0400
References: <1370528507-15313-1-git-send-email-alexey.kodanev@oracle.com>
	<201306102131.04281.vapier@gentoo.org>
	<51B6EF41.5090702@oracle.com>
In-Reply-To: <51B6EF41.5090702@oracle.com>
MIME-Version: 1.0
Message-Id: <201306111304.47061.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] configure: add configure checks to compile kernel
	modules
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8608039576402335150=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

--===============8608039576402335150==
Content-Type: multipart/signed; boundary="nextPart1392892.3c7AiReMX7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1392892.3c7AiReMX7
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 11 June 2013 05:34:57 alexey.kodanev@oracle.com wrote:
> On 06/11/2013 05:31 AM, Mike Frysinger wrote:
> > defaulting like this won't work.  you need to check $cross_compiling is
> > set to yes in order to default to `uname -r`.
> >=20
> > seems like it'd be simpler to just do:
> > 	AC_ARG_WITH([linux-version], [AC_HELP_STRING(...)],,
> > 		AS_IF([test "$cross_compiling" !=3D no],
> > 			[with_linux_version=3D`uname -r`]))
> > 	LINUX_VERSION=3D$with_linux_version
> > 	AC_SUBST(LINUX_VERSION)
>=20
> May be defaulting it to `uname -r` when $cross_compiling is set to no?

yeah, i inverted the check here (i didn't test any of the code ... just typ=
ed=20
it into the e-mail).  but you get the idea.
=2Dmike

--nextPart1392892.3c7AiReMX7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRt1ivAAoJEEFjO5/oN/WBq5oP/2Mh16fjBZ19+koBPdCrIyfK
UfvA+LzCK3cAxokx4bmGPGNogYIiMS/NS+Jfk35ydt61F5QcNiF3bcXGOwvcsKZv
wgicbx2oSBtmRKwQhxtfhqfCgra6+NA5H9/LFh8FmIeRrJtuI9kfqBbe6XmqCuFn
BDfdpRf2UHneTmRfpsr3zPpnhtNLzogaTsWMLp45hMTBqSdIgm/lDy9UYnvqm/zd
EK6du0a+32BRYz8EhkFvyTTvbTAp2fiYmbPfO6CNMs0x1BtRyWUNvnT0pLO5AIL6
T87ofwdblM0q9vHojmx/BlwTsZoF7b9LAUMUQ32u1kaofgZDWlWKhUYB53LFq3jB
yy3ZEq3iqHCxWSIbXCCRWPkNXfiBoqvTM8ZidN0DoL9eCk0ayFCMXtbELlrRvI1j
SERjEJnzDG7+R5Se3tM31Ja4tzN//KTRq68WloA0BKRYwJHhLglaxbq/GKYURVrv
17hQT/d7NtFhBgRg3mbQ3hPeURsGLLHAFONdl+/Iefbd59Em/rDpMxkApKkyp0sR
koqLkerbKkZY0z3fBCbwg8+RjVdnvxD3D0gzQ5k+rjiFgRsqkcN6/JQdbLONUjUk
5oFFctPfovmqLOrZY2ZNJTYWhSmL1VdsLvc8h7cilBDbzaxZazPYD2Sdy5ElCEHg
ZSi03HHo+hd7xitD8+z+
=FtTm
-----END PGP SIGNATURE-----

--nextPart1392892.3c7AiReMX7--


--===============8608039576402335150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============8608039576402335150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8608039576402335150==--

