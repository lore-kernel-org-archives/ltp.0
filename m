Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1PXz0Z-0004Nl-Jd
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:36:15 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PXz0Y-0006TF-GU
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:36:15 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 29 Dec 2010 11:35:39 -0500
References: <AANLkTinxp9Aj7MwPqpR13cZRjAYdLVwMkhCteDM-S7Vi@mail.gmail.com>
In-Reply-To: <AANLkTinxp9Aj7MwPqpR13cZRjAYdLVwMkhCteDM-S7Vi@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201012291135.40157.vapier@gentoo.org>
Subject: Re: [LTP] [Bug Fix] Skip first case in adjtimex02 test by a safer
	method
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9163502998394178663=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============9163502998394178663==
Content-Type: multipart/signed; boundary="nextPart8573160.WMHqExoirH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8573160.WMHqExoirH
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 29, 2010 04:35:29 Vivi wrote:
> --- testcases/kernel/syscalls/adjtimex/adjtimex02.c
> +++ testcases/kernel/syscalls/adjtimex/adjtimex02.c
> @@ -122,12 +122,7 @@
>         void (*cleanup) ();
>         int exp_errno;
>  } test_cases[] =3D {
> -#ifndef UCLINUX
> -       /* Skip since uClinux does not implement memory protection */
> -       {
> -       (struct timex *)-1, NULL, NULL, EFAULT},
> -#endif
> -       {
> +       { (struct timex *)-1, NULL, NULL, EFAULT},{
>         &buff, setup2, NULL, EINVAL}, {
>         &buff, setup3, NULL, EINVAL}, {
>         &buff, setup4, NULL, EINVAL}, {
> @@ -159,7 +154,18 @@
>                 Tst_count =3D 0;
>=20
>                 for (i =3D 0; i < TST_TOTAL; ++i) {
> +#ifdef UCLINUX
>                         /*
> +                        * Skip first case since uClinux does not impleme=
nt
> +                        * memory protection.
> +                        */
> +                       if (i =3D=3D 0) {
> +                               tst_resm(TCONF, "uClinux does not
> implement" +                                               " memory
> protection."); +                               continue;
> +                       }
> +#endif

we should be able to handle bad pointers like -1 and NULL.  the kernel's ch=
eck=20
access func should force EFAULT.  so why do we need this new if code ?
=2Dmike

--nextPart8573160.WMHqExoirH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNG2NcAAoJEEFjO5/oN/WBB9EP/jqI4nkvsSJQLa1K2w/t/pKi
/F+HCJqPGVnY2rM/zGLBBKzLYRpl+JmWU+ysJU7TjY9JrtgomFZrp3/Db+qqmotu
BLUH0+qbktY/7mbmRHo4clUsUaP8B1YqGgFoeRiSVEBRKz5UXv1EpRnNe+op3eYA
Irn/GNoOTV7CEYOF683L3nPBBaymxbt/LeonExtlGVQ6/tLijS6sR6Pk0ToAu3Tz
Xc2lL8Nb4UvP9ybZIsWeEqqy6w4S/2kQ8Gm4rkUJT0b+V8UUftfBVOS3tWOTAV9P
JP9x+WPij8vrKxpXepgWMwYu9vu8rZPdT6hvSg9xMAFzysOuaEhf+CJo0RD1Dy7I
PLvpR/BDfaet7bqT2V9k3hb+OpzUeK5Jp7yctQ2wVYHiLMe2xTZDNFnwZ7ZsiFBv
vLAweRMgslKLzk8k/BYk+fdUVvLtwgpXednYTaCPq6Gk068EozV8c19YIr0uR5CF
FG/M1o1w0AJ7EymBYhu9S1Wb+8LagOMsgeFlK0kQjlFpWm9bmGOlPeu3l/JXI3y0
yd5SiS6SLKFcuy7pnr1xdYKZL26IxwGtMBnp/ToKxRw0d/1k2WOX1zmUxtGKGF8r
YF4JmDMWLfY7s93js/PWr53RDODWyxzwLk4MV9kkMvLi1cuWNxXDTCFl2TPlgMgW
LdFDxVD0R6FwzFK37w+7
=/1hy
-----END PGP SIGNATURE-----

--nextPart8573160.WMHqExoirH--


--===============9163502998394178663==
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
--===============9163502998394178663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9163502998394178663==--

