Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UGBMA-0006r1-Ut
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:50:18 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UGBM9-00033I-As
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:50:18 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 14 Mar 2013 12:52:52 -0400
References: <1363183494-20392-1-git-send-email-markos.chandras@gmail.com>
	<201303131322.49014.vapier@gentoo.org>
	<CAG2jQ8hr0paKFEs31uBrmdUNNCewhpZhk=+o6ocvy5X0eKFVbw@mail.gmail.com>
In-Reply-To: <CAG2jQ8hr0paKFEs31uBrmdUNNCewhpZhk=+o6ocvy5X0eKFVbw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201303141252.53822.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============6657549613584778416=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Markos Chandras <markos.chandras@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============6657549613584778416==
Content-Type: multipart/signed; boundary="nextPart6863618.4MWLzB6NoR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6863618.4MWLzB6NoR
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 13 March 2013 13:28:08 Markos Chandras wrote:
> On 13 March 2013 17:22, Mike Frysinger wrote:
> >> -#if defined(__hppa__)
> >> +#if defined(__hppa__) || (__metag__)
> >=20
> > you're missing "defined"
>=20
> Looking a couple of lines above this I see the following:
>=20
> #if defined (__s390__) || (__s390x__)
>=20
> so I assumed this is the desired style for multiple "#if defined"
> constructs.

nope, that's a bug too

> >>       ret =3D clone(fn, stack, clone_flags, arg);
> >> =20
> >>  #elif defined(__ia64__)
> >> =20
> >>       ret =3D clone2(fn, stack, stack_size, clone_flags, arg, NULL, NU=
LL,
> >>       NULL);
> >=20
> > i wonder if we could make this into a runtime test.  like declare a
> > buffer on the stack, then call alloca(), and compare the resulting
> > pointers.
>=20
> If you ask me, I prefer the way it is now.

the advantage is that the next random person to grow their stock in the=20
opposite direction won't have to update this hard coded list.  and if it wa=
s=20
written this way earlier, you wouldn't be here right now either ;).

not saying you must do this ... fix the defined checks and we can merge that
=2Dmike

--nextPart6863618.4MWLzB6NoR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRQgBlAAoJEEFjO5/oN/WBPbwQAONhXGsakeRnFBzoaJmQwRaF
9/JL6EhfQr5QowxbBL/UQg1g8QFd8/MxMGv9Nn18viVCEcW38mZI3+2SN7Ik+/Rl
mdAZ1FhbH2E67+6xNL2KyqgKNLt6qrE1Dkm6dDBVJhho6S9AvdAI5Sm/7S+NDYFw
OdgllJ8mEmw+awPqg3jAOkH26lfDfDfTKVKRWTMS0c290kKi8quiOJXfQogYq6ZX
kE3i5ut/GW6+HkAxCsRYdXj5u0NgCGNYSvp/75UpIcv+FXx/WkJ41FQqdgB4zOty
UbUwehAS8ts0rpbvKjoLgYQdArKSD/6xJoMLgrmnm0G0l9jY0Xgt+uO2vY8z/yZl
ymRns8IviwjPstz/bD03b6HS94Y+F8oC1yXSGUOki1KcJIlMjwZgnbpelLvDqjKp
17VmJtTtOUkIh0PnDNXv7xv7vcpmujFC78tiy9fqZllTqYOiZbr1BvRuEbwCLM13
v36KXCNcmARogY8wVkeh5VWCfsaNPXeIwVbCGtxbRZJlZZVsfYVdrrDtOP0yAU9C
5crXxsZkXvtN094vV02I9qUjRNw83Y8rQHPDgxCsbUuNAfQ93b4aqOJ6Av3oi4Hc
xaCqyNQWZztf8forBCcrr4VeW1GRrdUd2SbiF8Kf4WSjqv69m98T3Zx4qv9/Z2EC
vq3xffk5zPn9SsigOCKd
=4NpA
-----END PGP SIGNATURE-----

--nextPart6863618.4MWLzB6NoR--


--===============6657549613584778416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
--===============6657549613584778416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6657549613584778416==--

