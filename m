Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UHeaL-0001Uv-6N
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 18:15:01 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UHeaK-00046k-Ce
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 18:15:01 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 18 Mar 2013 14:18:24 -0400
References: <1363604093-6960-1-git-send-email-markos.chandras@gmail.com>
In-Reply-To: <1363604093-6960-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Message-Id: <201303181418.25032.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v4] syscalls/getdents: Add parameter to test
	getdents64 syscall
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5635582755688270834=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5635582755688270834==
Content-Type: multipart/signed; boundary="nextPart1626729.Ki49AcNKna";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1626729.Ki49AcNKna
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 18 March 2013 06:54:53 Markos Chandras wrote:
> --- a/testcases/kernel/syscalls/getdents/getdents.h
> +++ b/testcases/kernel/syscalls/getdents/getdents.h
>=20
> +#include <features.h>

this header is not portable.  why do you need to include it explicitly ? =20
glibc will include it automatically as needed.
=2Dmike

--nextPart1626729.Ki49AcNKna
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRR1pwAAoJEEFjO5/oN/WBAY0QANmVhpLEYiRsC1/lsWqFkSCE
YLgJIITZNApqfYGg+uqxXc4TbyJN6HHIsrgOuFkqfROXNBRVKIE4y+QTLYpxTujg
zlEda01L8izUI+oLqwoylJWiGnzOWtbTh6oxJKyG2zKnGHoHO0YsPZL8cPsmuNGv
hOkePVaaj02HkY+o/sKX1BE0A7mV5oWTbiJefBgKeQpiboOj4tj6cRMVxeTA2Wtf
ck5f8neOgvLBmmBU+qM2hzMghPzLsDcjJRHAl98Hsn1WIPg6XTgo8/nRswtOBagH
RhoQM7CpUx+0GFqjTGV4FYN0Y+tXT9pNLcmZ7OoxNkr1GcPskK0EupAtES5gOliI
MekGjHg1/DpVLV1YIFh5GUFor3KivePgjrhIBAytKExtJX4uYszG06yH0y7WUBJ3
aqzB67NclnQ6PlDJISt/0eNpfSeyNv0vNxRoXXSFU2J+hVnurDGvia/ncR7JDCH7
kEvrDt4nYr3ruUw/PcHLiD5eVpzO4X7YrngASa3O97f0dtgQrnjyTDsfl2eEseWR
vj+Lia3dBq7twyBwdzqYJk+/V4QErOibpFQb1NI2MImyC7O1jxLN6k5eRxGnvqER
pCG1hyGB+vYChLyoFpOmY/L0eSaeblFcY/iEn76ABbbU2HtsYzwRGw/Iuj9HSw9u
nRp4LfZlo53KOnzygsgi
=Gh+o
-----END PGP SIGNATURE-----

--nextPart1626729.Ki49AcNKna--


--===============5635582755688270834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
--===============5635582755688270834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5635582755688270834==--

