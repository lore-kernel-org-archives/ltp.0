Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1Obsc2-00082j-No
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 10:02:46 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Obsby-0005sN-Ow
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 10:02:46 +0000
From: Paul Larson <paul.larson@canonical.com>
In-Reply-To: <AANLkTikq6X_ICkQbfLS9GUSnA3jCUdodxrHkdGYtgZFk@mail.gmail.com>
References: <AANLkTikq6X_ICkQbfLS9GUSnA3jCUdodxrHkdGYtgZFk@mail.gmail.com>
Date: Thu, 22 Jul 2010 12:02:31 +0200
Message-ID: <1279792951.6951.2.camel@plars-t500>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] ARM: Correct stack size & alignment for clone
 tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8428419663154958695=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Peter Pearse <peter.pearse@linaro.org>
Cc: ltp-list@lists.sourceforge.net


--===============8428419663154958695==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-rfZUQ8qijYDaOpLY6EXa"


--=-rfZUQ8qijYDaOpLY6EXa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried this on my arm boxes and it fixes the clone tests, which were
previously broken for arm.  Please apply.

Thanks,
Paul Larson

On Thu, 2010-07-22 at 10:07 +0100, Peter Pearse wrote:
> An ARM stack must be a multiple of 32 bit words in length, and 32 bit
> aligned.
>=20
> Signed-off-by: Peter Pearse <peter.pearse@linaro.org>
>=20
> ---
> diff -purN ltp-full-20100630/lib/cloner.c
> ltp-full-20100630_patched/lib/cloner.c
> --- ltp-full-20100630/lib/cloner.c      2010-07-03 19:29:04.000000000
> +0100
> +++ ltp-full-20100630_patched/lib/cloner.c      2010-07-22
> 11:36:24.830445453 +0100
> @@ -59,6 +59,13 @@ ltp_clone(unsigned long clone_flags, int
>         ret =3D clone(fn, stack, clone_flags, arg);
>  #elif defined(__ia64__)
>         ret =3D clone2(fn, stack, stack_size, clone_flags, arg, NULL,
> NULL, NULL);
> +#elif defined(__arm__)
> +       /*
> +        * Stack size should be a multiple of 32 bit words
> +        * & stack limit must be aligned to a 32 bit boundary
> +        */
> +       ret =3D clone(fn, (stack ? stack + stack_size : NULL),
> +                       clone_flags, arg);
>  #else
>         ret =3D clone(fn, (stack ? stack + stack_size - 1 : NULL),
>                         clone_flags, arg);
> ---
>=20
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by Sprint
> What will you do first with EVO, the first 4G phone?
> Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
> _______________________________________________ Ltp-list mailing list Ltp=
-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/lt=
p-list


--=-rfZUQ8qijYDaOpLY6EXa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxIFzUACgkQ3UR7ubYtCO6yOACgq4FIltatjzUa9KzTHF+Y6Vh2
qI4An0oDZmA6zz0WkwKlH8wzjzD4LNT1
=5EMD
-----END PGP SIGNATURE-----

--=-rfZUQ8qijYDaOpLY6EXa--



--===============8428419663154958695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============8428419663154958695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8428419663154958695==--


