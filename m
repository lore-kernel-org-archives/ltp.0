Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UFpLZ-0007Rk-CH
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 17:20:13 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UFpLX-0004HA-P4
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 17:20:13 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 13 Mar 2013 13:22:48 -0400
References: <1363183494-20392-1-git-send-email-markos.chandras@gmail.com>
In-Reply-To: <1363183494-20392-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Message-Id: <201303131322.49014.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/2] ltp: Add support for Imagination Technologies
	Meta
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0067188642788045527=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0067188642788045527==
Content-Type: multipart/signed; boundary="nextPart1438901.5PqcOpio55";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1438901.5PqcOpio55
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 13 March 2013 10:04:54 Markos Chandras wrote:
> This patch adds support for Imagination's Meta architecture.
> The Meta Linux kernel port will be included in the Linux Kernel
> v3.9. The Meta stack grows upwards so we need to add the appropriate
> __metag__ macro to the ltp_clone function.

i thought only the parisc people were crazy enough to do that ;)

> --- a/lib/cloner.c
> +++ b/lib/cloner.c
> @@ -54,7 +54,7 @@ ltp_clone(unsigned long clone_flags, int (*fn) (void
> *arg), void *arg, {
>  	int ret;
>=20
> -#if defined(__hppa__)
> +#if defined(__hppa__) || (__metag__)

you're missing "defined"

>  	ret =3D clone(fn, stack, clone_flags, arg);
>  #elif defined(__ia64__)
>  	ret =3D clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL, NUL=
L);

i wonder if we could make this into a runtime test.  like declare a buffer =
on=20
the stack, then call alloca(), and compare the resulting pointers.
=2Dmike

--nextPart1438901.5PqcOpio55
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRQLXoAAoJEEFjO5/oN/WB+rYP+wcb/7FHp4aSdMDteQrUI1qr
omQxRLSffDVfh8cr9muLJyl3w0CpoJAQp8DLo9buTowHqaS+KLGEGMyW74WerwZv
z1ec6LlPn0FuDRk4//6Gf6fgL2khLlc3PfGE5NWEWGjuS58MedyNdCBHfHySswTc
iQZ+b6GU/AFcpESUEu19bDO7Ztrkh+F70izYMeNZoJ4aOk3kaxxLkyFPDGJLz22k
oATG+h40IZP6HM6D+lUpcTM1a1N4CIyNpEwnOTA8Tyx1hS3raAcj5kA1Y2wVTBim
bUPSVygJyHzoK0Wtp5PrbNkgf22f5PStiAVRd366NJGMnMHnXmtgxPIhJhm7wYKy
i3e+vvnabQE4TjPQoCHK+cf4ajvjL30FwFooqUJK/gFD9yNe/0c4aiU3bQUqpix5
GhA03WqylvW2Pm4uTFNJpxvh5Xk0JqOZJnWjPK8X+0qlZ3wbPTIc/7j6yC6tIOSe
TpAssdk84+l6lBGKzlfZtvcyom4V13MEb1hS2dWn42pGwE9I58H8b1VghvXpMbxN
zqsa7urPAPQd+vcV4zxBC7OsL1eWps//RUnWs3ZNegPsS6eLzMhyBLtkdi79tejU
00ImgJg5ZeB8F6EU3Q3POo82KG36tUWUtheYw7nfmwzngcwhGlpey1fk22aihd65
uwiNIMWV8PgO2SJVguyE
=ET1t
-----END PGP SIGNATURE-----

--nextPart1438901.5PqcOpio55--


--===============0067188642788045527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
--===============0067188642788045527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0067188642788045527==--

