Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VsS7Z-0004UK-7R
	for ltp-list@lists.sourceforge.net; Mon, 16 Dec 2013 06:57:41 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VsS7Y-0004Ug-Bg
	for ltp-list@lists.sourceforge.net; Mon, 16 Dec 2013 06:57:41 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 16 Dec 2013 01:58:02 -0500
References: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Message-Id: <201312160158.02840.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] utils: sctp: Fix build for prefixed
	architectures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6142507494234227101=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6142507494234227101==
Content-Type: multipart/signed; boundary="nextPart1774352.VbW7fjQgO6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1774352.VbW7fjQgO6
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 13 December 2013 07:31:02 Markos Chandras wrote:
> Commit 6f22494d19b605ded308dc0fa713e91cb873f44a
> "Move sctp to utils and bump it to 1.0.15"
>=20
> introduced a build failure for the prefixed architectures.
> We need to take into consideration the __USER_LABEL_PREFIX__
> for architectures that define it when creating symbol aliases.
>=20
> The following upstream patch (0600c8968cc2dea04cbf13ec739216e2939d08fe)
> fixes the build for the Meta(metag) architecture
>=20
> [...]
> utils/sctp/func_tests/test_connectx.c:151: undefined reference to
> `_sctp_connectx' utils/sctp/func_tests/test_connectx.c:163: undefined
> reference to `_sctp_connectx' [...]
>=20
> Build tested on x86_64 and metag.

we really should fix this instead by not using any symbol renaming.  symbol=
=20
versions might make sense when dealing with a released project and a stable=
=20
shared library API, but it makes no sense in LTP.

perhaps better to have a compile time knob to disable it all ?
=2Dmike

--nextPart1774352.VbW7fjQgO6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSrqR6AAoJEEFjO5/oN/WBb6IP/3MxfGNcVYSLpcDERRseCHFt
sBAaSmOmcDCVbA6sR6QEKBMB0oiGQ/IZkoeZCASmfcYG+wCJOu1GpxtYkG7XJ7Ys
abgiNWcQqXRM7KT77vUiEIeUNXR1BgLEQbiKd1mq5l8OrrvsNjNaj4ze1NA8wSN3
1kMBOGvWwTOUZqfbdCi4ndcZHZg4TThPXBk1Bu/tj9pyO5WqLhDW+3mma/YeYKDK
Wp9vK9S72DHbM0mxJbqr6PUgkwpjw9V5POQow51XaY2jPfNVbUznSXfkUN56o2kZ
9uGm9OUm8OfxY5+jd/PpxGA9oToXBOYU/jIcSKKt/OU9z+ZxhbqYBA3/PUk3oNwA
kFYrl04VXnAbYYk6J4ZwG51QTSe3ko1nf4IuQumkBCnQqwspJIPx9INtC32THpoV
qhr4Yn29CHOtPkyer6izTvQClvXhhtC7mdZ6T2IFwHAi4qfC4EAj+pHADXwflnRP
cqXCr4MgHWyA1/jHLLeTJeyl7g36JjziAd7yEoWUsYUTTSYfDzrBGhIOQWXNq2wR
raCbMwFFIA+n7D2Gg5fAa9lCvV2bktblvusKCeGyfv8lZoiRDBlhqtoC2aklcB2n
8g9Sb9BFTcMDcr1QtfzR6OyZmHIOgRBxCxOo4B1SfMFeb6Ye09Pea9nYENQ2xldY
411565xprwL+rv/jo/ME
=+Qyn
-----END PGP SIGNATURE-----

--nextPart1774352.VbW7fjQgO6--


--===============6142507494234227101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--===============6142507494234227101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6142507494234227101==--

