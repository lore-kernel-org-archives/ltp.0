Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1SFTsu-0005Ky-K2
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:20:40 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SFTsq-0007so-J7
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:20:40 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 4 Apr 2012 13:20:50 -0400
References: <alpine.BSF.2.00.1204032220270.25027@toaster.local>
In-Reply-To: <alpine.BSF.2.00.1204032220270.25027@toaster.local>
MIME-Version: 1.0
Message-Id: <201204041320.51396.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/4] Install .awk files
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6214195746679222004=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6214195746679222004==
Content-Type: multipart/signed; boundary="nextPart1429566.5KXQf2ukJa";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1429566.5KXQf2ukJa
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 04 April 2012 01:22:25 Garrett Cooper wrote:
> --- a/tools/Makefile
> +++ b/tools/Makefile
>=20
> -INSTALL_TARGETS		:=3D *.pl *.sh html_report_header.txt
> +INSTALL_TARGETS		:=3D *awk *.pl *.sh html_report_header.txt

*.awk ?
=2Dmike

--nextPart1429566.5KXQf2ukJa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPfILzAAoJEEFjO5/oN/WBVYEQAJjHRSP5XOF4diyRrUbrieXe
TO+YQHHxs1mFL8SMvG00QI9pmyoMBK0y8l/j8Ij/wFRzRSZgOs2GZpJnmhojOtMD
UEP3XfaWCYPsswL6n0wWneFHY18u+eYoctxEEs/G0I2QCbr9UpsoPWwVvedvkkCg
X7tNGACfqYziqo66URzyJCTbFvluXcdyXRwF9bPZg5lcMCeKw4vQZbxfhNkFzqqc
yPp5Z0txrqaY8f0KqGscmWe8DbG7BmE+JWS+07cJ6unmNAkcBT/Xv5l/RWBWempu
oUNuYi8vM9EUjnHu3VEb86u/w3vXbutveP2Ia0LfMxRUZDHyzAr5MGFhEQQ9vZZ4
8+rNj3IK/u/BtIVtneiUrX68m7Avzn3RfLWDQw/hupSEzmA+fv4Q7wxb2bLsTyqX
YtwjhW85rDNzRYppwh7tilJkZ00eb8vxJTn5khm7EzQ/hNeoDKKRkLHL/sNlnVM1
ZLgvtvXpJt3a973+98qTW1jT961NEKIo0ls5gGJvAhs9w3o9PGDHSR8wz4wXJtBP
nHP8AoIJbEDkUNlm1YCMFnQLwFFkTmHzKgeDuCbfvqrwwq0BCHt5Vab/xDkJ+egR
BlfiE1+MfX0VhAjM2mLmdTXNSk4tlu2tuGWbpcKmh0F2afRePgnc7wWr3gFIKfTy
XdzS+c3tf2PtKZaiXK9r
=aLS4
-----END PGP SIGNATURE-----

--nextPart1429566.5KXQf2ukJa--


--===============6214195746679222004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--===============6214195746679222004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6214195746679222004==--

