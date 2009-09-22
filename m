Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Mq6rM-0005ZX-Sb
	for ltp-list@lists.sourceforge.net; Tue, 22 Sep 2009 15:00:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mq6rM-0007vm-L2
	for ltp-list@lists.sourceforge.net; Tue, 22 Sep 2009 15:00:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 22 Sep 2009 11:00:39 -0400
References: <20090921230644.GA30741@us.ibm.com>
In-Reply-To: <20090921230644.GA30741@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200909221100.42467.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH RFC] ltp: define and use common clone helpers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6954056060465796130=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Nathan T Lynch <natlynch@us.ibm.com>

--===============6954056060465796130==
Content-Type: multipart/signed; boundary="nextPart1502276.73VKkW9IJj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1502276.73VKkW9IJj
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 21 September 2009 19:06:44 Serge E. Hallyn wrote:
> Define ltp_clone() and ltp_clone_malloc() in libltp, and convert existing
> clone usages to them.  (clone04 can't use it bc it wants to pass NULL,
> which ltp_clone() will for many arches convert to NULL+stacksize-1).

so have the code handle NULL specially:
(stack ? stack + stack_size - 1 : NULL)

> +ltp_clone(unsigned long clone_flags, void *stack, int stack_size,
> +		int (*fn)(void *arg), void *arg)
> +{
> +	int ret;
> +
> +#if defined(__hppa__)
> +	ret =3D clone(fn, stack, clone_flags, arg);
> +#elif defined(__ia64__)
> +	ret =3D clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL, NUL=
L);
> +#else
> +	ret =3D clone(fn, stack + stack_size - 1, clone_flags, arg);
> +#endif
> +
> +	if (ret =3D=3D -1)
> +		perror("clone");

we cant be sure why the higher layers are calling clone.  maybe the args gi=
ven=20
expect the clone() call to fail.  so we dont want any perror() invocation=20
here.

> +/***********************************************************************
> + * ltp_clone_malloc: also does the memory allocation for clone.
> + * Experience thus far suggests that one page is often insufficient,
> + * while 4*getpagesize() seems adequate.
> + ***********************************************************************/

a malloc() function implies you should be giving it a size.  i think there=
=20
should be another helper here.
ltp_clone_malloc() - takes a size
ltp_clone_quick() - calls ltp_clone_malloc() with getpagesize() * 4

or a better name than "quick" ...

> +int
> +ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg), void
>  *arg)

i think argument order should be consistent.  i.e. have all ltp_clone_* cal=
ls=20
start with (flags, func, arg) and then the malloc/etc... calls can add on=20
(..., size) and (..., size, buffer).

> +	void *stack =3D malloc (stack_size);

no spacing around function calls

> +	if (!stack) {
> +		perror("malloc");
> +		return -1;
> +	}

since people are linking in -lltp to get these clone helpers, we can assume=
=20
the tst_* funcs exist.  so this should invoke one of them with TBROK|TERRNO.

> +	ret =3D ltp_clone(clone_flags, stack, stack_size, fn, arg);
> +
> +	if (ret =3D=3D -1) {
> +		perror("clone");
> +		free(stack);
> +	}

same issue as the other func -- dont call perror()

i think we should make sure to save/restore errno across the free() invocat=
ion=20
so that the caller gets the result from clone() ...

otherwise this looks great.  thanks for doing the footwork here.
=2Dmike

--nextPart1502276.73VKkW9IJj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKuOaaAAoJEEFjO5/oN/WBxB4QAKsR+wR17JvHAlzpkBepShkp
lxKlle8bGSJ9+p1QbO5legMZQgleyNq9f/6O+yLXuD9FTpGQWS12Tc7RWgCcOqyV
nOOCtDdhjYVkRNk9zZZkown95aO8JGlfKFJuozZFzqLK4i84XM1GGfkX1rP5pnsb
VEav3jZagypn6koVUORil59ZqmfgISTUpov3lMob6UJO/0Jg61G8lzHt1+o4a3mI
3yZMdpfPJ4nxHTdS5q+I8cJwRgIQaDO7T2TMB1Pii32gSFbwML/HGVZ+bcl1EYwH
hKiKhM0bZbwqgH/Eax2bZqUaoebPCIX8u2jOflDbTZjMiQ+mAcu89OuJWB5lNuok
skMj95B3eAv0tUkLiQzaO8mXb3LV41W5AqnazFYgJPUhrgoFzUvPqGleSlhc+wtu
FqE3KFyOV9Q5EgbGSvssnPT0tChd3i/LU+4gUkH6ftckG4F1/ffgAJPBI/uz5qM7
yVDUe2z/ccjUOnuaWq7HC9sVxHtgFBq/9CuZpcbu82zgyK8Y3PY1+jjzys7vxsYL
/pMK6T0gntBLvGr1u6iwU4DjD4yX8uRrQAzcIiEuPn09/v3z3JGGdKq3qkwk4b4x
wo6G1N0mOhuJ+VnR00FO5xkZ5e7Imwuxw9kddT8laWeMvd/cDbECEs1Ln7yScJ+B
77XLewPOU4fRhZl2VSPl
=oqhi
-----END PGP SIGNATURE-----

--nextPart1502276.73VKkW9IJj--


--===============6954056060465796130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--===============6954056060465796130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6954056060465796130==--

