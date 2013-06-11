Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UmDSH-0006AD-6i
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 01:33:01 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UmDSG-0004YK-92
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 01:33:01 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 10 Jun 2013 21:32:58 -0400
References: <1370528507-15313-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1370528507-15313-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Message-Id: <201306102132.59648.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============7858286890169465097=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, vasily.isaenko@oracle.com

--===============7858286890169465097==
Content-Type: multipart/signed; boundary="nextPart1498864.ppetHQkQee";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1498864.ppetHQkQee
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 06 June 2013 10:21:47 Alexey Kodanev wrote:
> There're new configure options added to tune modules building process.
> New m4 function tries to determine if kernel-devel package is available
> and sets makefile's variables (WITH_MODULES, ...) accordingly.

also, please version your patches in standard git style.  the first one is:
	[PATCH] configure: ....
then the second one (perhaps with the reply-to set to the fist patch) is:
	[PATCH v2] configure: ...
and so on

having multiple threads starting off with the same subject is really hard t=
o=20
follow
=2Dmike

--nextPart1498864.ppetHQkQee
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRtn5LAAoJEEFjO5/oN/WBN2EP+wQECGnx7v/ljS0UCYScERDB
E3E4F0rMSm0cqTMjYNktyJbE3EewNPqLokLLIXGjg0iRfgAe18Uy+i93izPudqp9
JIK4MZlzf1W/fH0Pm9TGaYrlgsRnC4DmnSCpPBqwQ48ZJv5JcV0ERGy6TT1J+vXT
Cee9sXbg+560CR3Xeqpc8Ux3OWXcvMzCRyyHs199fEbEWFeM9bJ03uDcJHG8EnX/
+JVaLvgAaz9jBUGwKWQKTm5+gaK4PC0he5IMWtW4Pd2oYYSHYXu4ukiWok3N6Zuo
ynSdmoB92AWEAGvQ109VChiPPDzNXHVoH9tVEkFVuE1O8xJ01oQNRQk6lK/R7nLg
VilLzmqpEMFzmQ3MY7e2slvZ1unht6Iqn7uv2uXvcFB4a/TY9fZwYqJDdeTHQ44M
czy4Nv5rjFgGNihPnhucY/Rv6BYG7tvhDTiZ9LZ1AEZiHOHvzYHqEc32qIjE01tS
vATjamsi9mPzQDK/lEeL9etFhnNd8XZwWatxYJMjI9NrX1jhctKhHazwv7/Ro4ju
HklJqNT2TwnEyKuQbMi2oO9ZrtPfp1zCdvfwOT+M/5wfYQt/OuUp4XZRVDY086+k
P+Ot37wtSGb2uYMl52SKMaL8HkHOKrYXFZAQ25e6CKrMCrLg4iSNSkw1juDfPKTd
Cq6R4vrPlkdSfht3Ti8H
=l4/p
-----END PGP SIGNATURE-----

--nextPart1498864.ppetHQkQee--


--===============7858286890169465097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============7858286890169465097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7858286890169465097==--

