Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1PeHIo-0003vd-HP
	for ltp-list@lists.sourceforge.net; Sun, 16 Jan 2011 01:21:06 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PeHIn-0005kF-ER
	for ltp-list@lists.sourceforge.net; Sun, 16 Jan 2011 01:21:06 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 15 Jan 2011 20:21:28 -0500
References: <AANLkTinxp9Aj7MwPqpR13cZRjAYdLVwMkhCteDM-S7Vi@mail.gmail.com>
	<201012291135.40157.vapier@gentoo.org>
	<AANLkTi=sSsbYn4HKxNLegDqY49POL1Qt287uDK_=MMOT@mail.gmail.com>
In-Reply-To: <AANLkTi=sSsbYn4HKxNLegDqY49POL1Qt287uDK_=MMOT@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201101152021.29499.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============4404333117749940396=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============4404333117749940396==
Content-Type: multipart/signed; boundary="nextPart33213805.8oHTCcSpWY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart33213805.8oHTCcSpWY
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday, January 15, 2011 00:34:23 Garrett Cooper wrote:
> On Wed, Dec 29, 2010 at 8:35 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Wednesday, December 29, 2010 04:35:29 Vivi wrote:
> >> --- testcases/kernel/syscalls/adjtimex/adjtimex02.c
> >> +++ testcases/kernel/syscalls/adjtimex/adjtimex02.c
> >> @@ -122,12 +122,7 @@
> >>         void (*cleanup) ();
> >>         int exp_errno;
> >>  } test_cases[] =3D {
> >> -#ifndef UCLINUX
> >> -       /* Skip since uClinux does not implement memory protection */
> >> -       {
> >> -       (struct timex *)-1, NULL, NULL, EFAULT},
> >> -#endif
> >> -       {
> >> +       { (struct timex *)-1, NULL, NULL, EFAULT},{
> >>         &buff, setup2, NULL, EINVAL}, {
> >>         &buff, setup3, NULL, EINVAL}, {
> >>         &buff, setup4, NULL, EINVAL}, {
> >> @@ -159,7 +154,18 @@
> >>                 Tst_count =3D 0;
> >>=20
> >>                 for (i =3D 0; i < TST_TOTAL; ++i) {
> >> +#ifdef UCLINUX
> >>                         /*
> >> +                        * Skip first case since uClinux does not
> >> implement +                        * memory protection.
> >> +                        */
> >> +                       if (i =3D=3D 0) {
> >> +                               tst_resm(TCONF, "uClinux does not
> >> implement" +                                               " memory
> >> protection."); +                               continue;
> >> +                       }
> >> +#endif
> >=20
> > we should be able to handle bad pointers like -1 and NULL.  the kernel's
> > check access func should force EFAULT.  so why do we need this new if
> > code ?
>=20
>     If so, then there's a lot of code in LTP that needs to be fixed.

NOMMU can handle a few "magic" bad pointers like -1 and NULL, but only in s=
o=20
much where the kernel is given the pointer via a syscall.  in the past, thi=
s=20
wasnt the case, so i imagine a lot of checks have slipped in that can be=20
backed out.
=2Dmike

--nextPart33213805.8oHTCcSpWY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNMkgZAAoJEEFjO5/oN/WBhE4QANpCSJB4YcLZBrcHiBXKfYpZ
OaRKMbzMJTVt9vQL9vWrzjYq72PXI9X1iH/NxXpNIOOhL5S3RMZtEt/apatqe3EE
yW2W+U2QHclh7Fx1qUA4sR59Yd9akm+oHwNxJNTkx7ATy+Zl9ToY5zZTH6Uy6rcM
VaeuoUTGbXWI01u6ZWy8cXTe3kJdzSlbnAgbwLJyk6ZBlt64srcu6+yNkpGQlb0O
eLKEqGkE1TGqaf/4UTJPz5uNdJzJ3a/70IBT9wCCZcZ7MyLlmHX6aKRDxn7y26JW
IqTD8JuCev7PbcZI/43deSXjRXLL/4aRn8xgdAbAllLNWAFr7uUxBxbOidka2E7X
bTUYbHIZ9MnCXK42FqaLaF928VKzrJgTZDni8Or0g4EHfPGn50i7rVzuJeWpHfMy
4BNnHRZDODyGjF+jNOJ8GBL2IwEKIJnEV83jxSJk+RZ9ITuNVFufuQH64/RZfVRH
Yij/kanzKLc10yWkoyFjWjdzte61NHx81UQz2aFUSJ9Y4+JYK24jmAPVK77+c9so
2G+vFM0L0exQQlOsEYQiIXl+4Bc2i6HeDcw22dCvb7UI94NO1zSWU/0QY3Mt/ZZl
FwC0UUl7uc7mm5VtjzuzKUBai1O27x8T3aNNa75Y66r1vYFQQK6Ngb1ERaBBJ66v
NOZ4JnJpyk8sM/fGTZtz
=LaaY
-----END PGP SIGNATURE-----

--nextPart33213805.8oHTCcSpWY--


--===============4404333117749940396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
--===============4404333117749940396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4404333117749940396==--

