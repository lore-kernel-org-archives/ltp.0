Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NLhXP-0007CW-Pr
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 18:26:51 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NLhXK-0003fG-PQ
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 18:26:51 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 18 Dec 2009 13:27:00 -0500
References: <2039563304.268931260765372686.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2039563304.268931260765372686.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Message-Id: <200912181327.01697.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] fix compiling error on ia64 platform
	(ltp-full-20091130)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5318817379164679248=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

--===============5318817379164679248==
Content-Type: multipart/signed; boundary="nextPart1814685.6nLUR7bBsH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1814685.6nLUR7bBsH
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 13 December 2009 23:36:12 Caspar Zhang wrote:
> ----- "Mike Frysinger" <vapier@gentoo.org> wrote:
> > On Friday 11 December 2009 06:30:01 Caspar Zhang wrote:
> > >   Here are two patches to fix compiling error in ia64,
> > > I tested only in version ltp-full-20091130, please check
> > > your own version. They are for work well on my system.
> > > See the attachment.
> >
> > the ia64 change is incorrect.  there's ia64 ifdef hacks in there
> > already which
> > are to be used.
>=20
> the ia64 ifdef hacks in 20091130 are the following lines(in file
> ptrace.h):
>=20
>     17	/* ia64's a real pain.. */
>     18	#if defined(__ia64__)
>     19	#undef FU_ia64_fpreg
>     20	#undef FU_pt_all_user_regs
>     21	#if ! defined(ia64_fpreg)
>     22	# define ia64_fpreg FU_ia64_fpreg
>     23	#endif
>     24	#if ! defined(pt_all_user_regs)
>     25	# define pt_all_user_regs FU_pt_all_user_regs
>     26	#endif
>     27	#endif
>=20
> I don't think these codes could sovle the compiling problem.

they do if they're used right
=2Dmike

--nextPart1814685.6nLUR7bBsH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLK8l1AAoJEEFjO5/oN/WBbiUP/RoR6nd3N8Wzh/+IKvvW7+Cn
Hg5PefbWf2sB9KgNpjGJSoRmGTTz+IVTHGljg6hXq72Ixo80mySa3wWCb0Q+EKBP
bOCvFEDtai7H2BxsJ9RLYxqdv/dwtOFDqFsxhQ682R5D31m6Ksnb6R3c39Q/50sG
nP5CCVx7lZjGTTRagXnEp5+gvOKl2fy8ufc1wgz/dnWQ483FZrJ6VB8o82K8GLso
ZsRA/3CNp4M/wh4emC20sNe0745rwIdu0GnHhR8NMRXodS/BDm2dRERDKDk8ckOv
gdBLB55pS96M32eqjOe+tlDTL/nXcqYdDy4pLCGK3vg839opp/Hejc39s//riHkQ
0BCBMxuuPH32Up67sQpIj+S2WPoBYVNKnY933etbhua56Et7G6Rq5ouIqO79oswS
HIMfsBT/a4GMxQBpCcbM5ADDHLVIxDB+jo0A6Wk0C/tKEjainuT9YKjdJa3LM48Q
Q8V/DfalKgWoytuUre/qtTzJAs2ogIXsHB7AH5I5Ve42jq9P01hXNOW+hXh3q8vU
VPPmuvuQwoVCabF/Gd1e32zoLeFdUFivQi46Jx62FToEtu+jT2E3+Nyk8x6prd2d
ZR0P5+yvmD1r6mkeXDvXAkvaaUlAXmY/Pj1iqYewuZmHgnwkwp+3hJ4We+97ZBm/
ex2vLBJ09b85RYM6kNJ7
=fRg5
-----END PGP SIGNATURE-----

--nextPart1814685.6nLUR7bBsH--


--===============5318817379164679248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============5318817379164679248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5318817379164679248==--

