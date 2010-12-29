Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1PXyxE-0001mx-B3
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:32:48 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PXyxD-0006D4-GA
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:32:48 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 29 Dec 2010 11:32:12 -0500
References: <AANLkTi=GnrruHu=2SnXsuc+xHRhLDy1=54YntB9w+325@mail.gmail.com>
In-Reply-To: <AANLkTi=GnrruHu=2SnXsuc+xHRhLDy1=54YntB9w+325@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201012291132.12996.vapier@gentoo.org>
Subject: Re: [LTP] [Bug Fix] write04 will crash on uClinux platform
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5211224071374338066=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5211224071374338066==
Content-Type: multipart/signed; boundary="nextPart7233045.B593ENo19i";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7233045.B593ENo19i
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 29, 2010 04:35:25 Vivi wrote:
> --- testcases/kernel/syscalls/write/write04.c
> +++ testcases/kernel/syscalls/write/write04.c
> @@ -71,6 +71,10 @@
>  static sigjmp_buf jmp;
>  int rfd, wfd;
>=20
> +#ifdef UCLINUX
> +char *wbuf;
> +#endif

should be static

> @@ -79,7 +83,9 @@
>         struct stat buf;
>         int fail;
>         int cnt;
> +#ifndef UCLINUX
>         char wbuf[17 * PIPE_SIZE_TEST];
> +#endif
>         struct sigaction sigptr;        /* set up signal handler */
>=20
>         /* parse standard options */
> @@ -221,6 +227,17 @@
>   */
>  void setup(void)
>  {
> +#ifdef UCLINUX
> +       /* Allocate wbuf in heap not in the local function stack */
> +       int pagesize =3D getpagesize();
> +
> +       wbuf =3D (char *) malloc(17 * pagesize);
> +       if (!wbuf) {
> +               tst_resm(TBROK, "malloc failed");
> +               cleanup();
> +       }
> +#endif

there is no need to make this depend on UCLINUX.  have it execute this code=
=20
for everyone.  also, the original code is 17*PIPE_SIZE_TEST but yours is=20
17*getpagiesize().  please stick to the original define.
=2Dmike

--nextPart7233045.B593ENo19i
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNG2KMAAoJEEFjO5/oN/WB35sP/0ZeNn9uA8Yt33liWqIGjG0M
4CX80SRbUIhp/Jq5pwdJBF7c/laRKvk5dFt59hsiinShUoNu/Xj7T3ztPXNcSzdI
5A/MKE1jwngX/yN03h2IcM8eRRQxKjAcI3UhAbwD49jIaCk7nDxZ+k7iX3sUnNx3
8N0BYCegNwIIiKkVpKUrKYhFhRbwM5hfZnYv5pfyXb57EkK57td3Rh0qxBFm9GXO
CNNNBRNvz1d6huQg3VZnOhWMOyNYggHUhAyZBS81jrHDWNGmdhx91eTHnSj5CcZS
/qhHyZaVZCnDUXxFDpnb2j233z1maw6FgWu2gCXya+4F1VKhiRmuvnIbPawITqnv
od5+lGWHXKz2khWXmoYYC4sr9fxY/3CZ8RpisIBtmCETxc2R/L+jWP5nCpQx+0H6
lW1FBSZPWjW986hfS+fJfxiTRQrfzn4UfnUhrSr/9iHI18ppsC0Ls8oJOyAW6p95
OTbVpa7sZNJ70A6TkDOMMEqESxoCbnxLWIn4OjZE085U6oNe/ek+Cn79FuT/09dI
bubpPYDG3MFXiX87nh4CYmScAXdfFOuy16qfZaaWdzhvATojsZENBtvERmnP1ubC
8Polbewi3xsZ2UJ7eGOZqzohO5onLT0bD6GhSIhnMUMtTY+x+S4xf/7IjopZdQ7U
ZukgKNHgINESs0Tn4XTr
=qNJ/
-----END PGP SIGNATURE-----

--nextPart7233045.B593ENo19i--


--===============5211224071374338066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============5211224071374338066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5211224071374338066==--

