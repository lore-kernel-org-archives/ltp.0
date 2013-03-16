Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UGtIL-00055w-5L
	for ltp-list@lists.sourceforge.net; Sat, 16 Mar 2013 15:45:17 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UGtIK-00024Z-B7
	for ltp-list@lists.sourceforge.net; Sat, 16 Mar 2013 15:45:17 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 16 Mar 2013 11:48:24 -0400
References: <1363355370-7738-1-git-send-email-markos.chandras@gmail.com>
In-Reply-To: <1363355370-7738-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Message-Id: <201303161148.25654.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] syscalls/getdents: Add parameter to test
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
Content-Type: multipart/mixed; boundary="===============1835638200471784981=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1835638200471784981==
Content-Type: multipart/signed; boundary="nextPart2964153.RthFKkcXrN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2964153.RthFKkcXrN
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 15 March 2013 09:49:30 Markos Chandras wrote:
> Add new "-l" parameter to test the getdents64 syscall along with
> the getdents one. Use ltp_syscall() to call the system call to get
> proper return values when an architecture does not support any of the
> getdents{,64} syscalls. Modify runtest/syscalls to call getdentsXX tests
> with and without the "-l" parameter

your patch introduces a lot of warnings.  please verify it on a few arches=
=20
first (like x86_64).

> --- a/testcases/kernel/syscalls/getdents/Makefile
> +++ b/testcases/kernel/syscalls/getdents/Makefile
>=20
> +CFLAGS +=3D -D_LARGEFILE64_SOURCE

these are CPPFLAGS, not CFLAGS
=2Dmike

--nextPart2964153.RthFKkcXrN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRRJRJAAoJEEFjO5/oN/WBmnIQAMr2hd3iyiR8F6eFcK2dQD+J
IEyvu9fF577u9I89TzhOyFCSFm0R0+YabW3RRvsE8eIxiGMXC0flMizJKYBGJySO
jhUP0HIeeuDIP+tI6cBYus1lMq089wVws+FHjvndnD3l7r1l9MHKVG0+NR+av6pj
uguS9OfNj3vHGLmq5vtqBiD/Qi6wLmioVg+uoVKhv5LmK/BO9iE74hz9cRjALykD
eKfrkcHrVAvjjGE8zH48EiNW8ILOyN08gj8H4Xo9VeBhO1r7M/XXzTSWORwg2L1M
OpLO55MjhoWKte+AmB2SDKLJrnreGcHu0i8OCB37SIlwfq4e7m0vS5ahOW8sObvJ
pBefyerBtsGlmmsnnf10eqJEgUx5bVi95aTSUn20RF8WjdZVWx2WncnSGFoFp3l+
3Bk+/lvX9kM1U2m+6MJE8GuAGD6WjmHmpa9roW2umaFazjwUq7XrWptwApRgl7A8
jYxP3Azxp9rrvAidCBW9ZmSE+MXTMsdHDwX2VFD7JFmgLTfWBdbgtSAQQ6xy/znw
K8z0FWdcv27TIVOwNnnplV6f4IBp19lYTkiRbhDdrQno14UwV3GYpQqvbsfGpcON
puaXHisL9JWIQa8Wvd0VHue5gxZBZe00VbBKrfvqN8ZB6r9rtNFm51C+7rDMK7g1
KrjMVbvh1U8Uzv+2jcjX
=DmVR
-----END PGP SIGNATURE-----

--nextPart2964153.RthFKkcXrN--


--===============1835638200471784981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
--===============1835638200471784981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1835638200471784981==--

