Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MPncf-00032a-Ex
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 01:12:57 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MPnce-0007mc-Lo
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 01:12:57 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 11 Jul 2009 21:12:53 -0400
References: <364299f40907111758m79a4cb43w9f25dc229ee0842b@mail.gmail.com>
In-Reply-To: <364299f40907111758m79a4cb43w9f25dc229ee0842b@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907112112.54395.vapier@gentoo.org>
Subject: Re: [LTP] Adding hooks for mm.h test in autoconf?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0644814505828641317=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

--===============0644814505828641317==
Content-Type: multipart/signed; boundary="nextPart2463478.jKtiiPQWHs";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2463478.jKtiiPQWHs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 11 July 2009 20:58:30 Garrett Cooper wrote:
>     I realize this isn't an automake / autoconf support list, but I
> ran into a snag when trying to compile libmm in hugetlb, where my
> system doesn't have this header, even after I run configure. I added a
> test for it in configure, but I'm not sure how to interface with
> config.mk. Any hints?

update configure.ac to check for the mm.h header and then have the file in=
=20
question include config.h for the define

we arent using automake in ltp to generate any Makefiles atm on purpose
=2Dmike

--nextPart2463478.jKtiiPQWHs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKWTiWAAoJEEFjO5/oN/WBV0MQAIgdZNVjhv6W+uH7sLtZ+oiS
IOcJbJmzcKtB9PmSxs23RLYTur7rLESZaL0hIbnrZSjW+7D1S0IfGbuJZkjzky8t
ABtXngMX5klDApeFc5K6FCnUlECo7hcumXaKoG7kQFyqyYZtugvsLeBg+TXLRjO+
ZPWUrPLurMiCcAPn9N1d+APkH0IljqQl63TJgEH1mzwLd8qTpx+2bJibMD4guKB4
cvuYvmTQ4ePwo5a0dDOjpX6rejBjRQgGquQiQY0Sy64pnIppk3nnTirlMIckyAja
Sr7Xfid2gGXKGeBCZ+akIdHd+dQXNA8bLAPoLhZMGaK+7Qe2srUk33AbNqDelIPe
/1Bx7jM0hYd8uo5DxkoW5zE55DkcsOAzrTTISTgnv3h0aI1rYUKOZ4MCvHg2oIf9
VGaxUcuiyefll2KMJXUc9XXHvrrsbcmZfGcf2Ae5HEDYhacd0eGqHgp5iHBVg2hH
8flk4/A2ZGqsBK6uDVOoIZ1Fk6eUla27b4OpSSUqbiqkwk+bkgFtKO/SQzOFjcG+
40LYdce3QuWH54oTCN7FxIqy3EOQDMalf6b89zIMbQUjKc/v478PDWrbbA/u1vYR
Q94QAZAqeXtd017c/XYfmMV3HLbS8Bv5n2zSfBh8jnb7qnO0HGgwS9/V5Zs5IQUN
gp0rJceG5eg1+i/8n9yp
=phim
-----END PGP SIGNATURE-----

--nextPart2463478.jKtiiPQWHs--


--===============0644814505828641317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============0644814505828641317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0644814505828641317==--

