Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RnXFj-0002Wf-K4
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:16:43 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnXFe-0005qC-2P
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:16:43 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 18 Jan 2012 10:16:38 -0500
References: <1326897408-26778-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1326897408-26778-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Message-Id: <201201181016.39003.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2] getcontext01: fix build using uClibc C runtime
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6609782250763620073=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6609782250763620073==
Content-Type: multipart/signed; boundary="nextPart1894166.PcpJhphxxH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1894166.PcpJhphxxH
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 January 2012 09:36:47 Carmelo AMOROSO wrote:
> --- a/testcases/kernel/syscalls/getcontext/getcontext01.c
> +++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
>=20
>  #include <features.h>
> +#include <unistd.h>
> +#include "test.h"
> +char *TCID =3D "getcontext01";	/* Test program identifier.    */
> +
>  #if !defined(__UCLIBC__)
>=20
>  #include <stdio.h>
> -#include <unistd.h>
>  #include <errno.h>
>  #include <ucontext.h>
>=20
> -#include "test.h"
>  #include "usctest.h"

all of the system includes should come before LTP includes.  i would just m=
ove=20
the whole block above the #ifdef check.

also, checking __UCLIBC__ is a bit broken now ... we should use configure.a=
c to=20
test for the func and change this test accordingly.
=2Dmike

--nextPart1894166.PcpJhphxxH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPFuJWAAoJEEFjO5/oN/WBqLoQAJcOxuNiz4aur5QOnSrUGlcy
MV+PjLNsW5i8l4CrGEO+Ntyo4zBNWc2PLmgmQmLdXA4cwgtN7h2qYNu/2IUhyRoO
s1Ow3+AIs7m0Rg87QlZJvkbrLfT5S5yA1D+/8hrHr78x7bjuVKWMNNuFDDKWlR7S
wi9XswtcKX6tv8Owwt4BRSQVfdzExK5j2pp+nTVfQ1Qii0FSFrNEdqD0gXRFIDIs
gkGkCvv2RAp8u2p/yhKvwzhdS6uR/XbZnpZwabtomwbLUVR+v0nTuFqISaaVBU97
L0gy3CNiMRL5bHIzu10vSEo8Ov4EFZA3Ln5fKegEk53MRmPvBYzrwzzaXWzBu2AG
biUXdFEHRDNzRrANPdlgCdysbQU4GJABIYlWKTdSyLAqXennFWzll/o6Fpuu5lZ2
kR4zMNSm6ZKlTkXZvwWHdBxb/CSKI8aAGE6lXIljEGO8HTR2CuvfURtEQ55uwFR9
B0bQ2pMO50X+ljN/bvPy5jWZhwOhqq7BfJZ2APOVLDHZbOSUxLAGa/WdQ7gawB8o
8oIFv+8dehRhpaCUA6QZHe6g+6sFOTy8mOgJWtxFmN+itBbuH6tfMdRFOO/a3rEr
VZsx7EtTqp/w4Gc3TeFEfGOSAE5S94ZS7hbN5cmZAjH0pbJff+I7pzznLsdj88n2
E7l9Cr70G2IcLDPh+29O
=Yiir
-----END PGP SIGNATURE-----

--nextPart1894166.PcpJhphxxH--


--===============6609782250763620073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--===============6609782250763620073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6609782250763620073==--

