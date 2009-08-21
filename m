Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MeWXc-0003c9-Gw
	for ltp-list@lists.sourceforge.net; Fri, 21 Aug 2009 16:00:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeWXX-0001qT-Pp
	for ltp-list@lists.sourceforge.net; Fri, 21 Aug 2009 16:00:36 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 21 Aug 2009 12:00:32 -0400
References: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
In-Reply-To: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
MIME-Version: 1.0
Message-Id: <200908211200.33401.vapier@gentoo.org>
Subject: Re: [LTP] The Best Practice to Skip Syscall Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2652675519903856444=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: ltp-list@lists.sf.net

--===============2652675519903856444==
Content-Type: multipart/signed; boundary="nextPart9225501.4tzxDqKQj9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart9225501.4tzxDqKQj9
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 21 August 2009 07:57:39 CAI Qian wrote:
> Test cases unshare failed to compile on systems without such a
> syscall. I am unsure what the best way to handle it. The old ways are,
>
> * add a kernel version check in the unshare tests code.
>
> or
>
> * add a m4 rule.
> * modify the unshare tests code to check if the macro, and add stub
>   functions if the macro is false.
>
> The first approach is unable to handle non-vanilla kernels. The second
> approach needs to add stub functions which are unclean. What I would
> like to do is,
>
> * add a m4 rule.
> * modify unshare Makefile like this,
>
>   ifdef HAVE_UNSHARE  <-- if the syscall is present, compile the tests.

the configure test should always be there if the code needs new headers (li=
ke=20
sys/signalfd.h).  if it's only a new syscall, then the configure test shoul=
d=20
only be for the new symbol (assuming one is provided).  in all cases, the=20
tests should be compiled.  your proposal doesnt handle the case where the C=
=20
library is in place, but the kernel is older so returns ENOSYS.
=2Dmike

--nextPart9225501.4tzxDqKQj9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKjsShAAoJEEFjO5/oN/WBY8gQAINCF20W72gJy9jojVoookPt
bPhKWW30qdXl70YtrfjO4bH25bMnZY3jo/rI4kBMKoPwrOOp11Qje3X+yOI08sF7
ec6s0ZbfKDNTde1w2Vq2B++oeLItWVxvi3Kum86NHed9kfrTTA1CogxyEhcWIlJ2
ABxVW9BwvqGFl13v+srchhI2S+RTNXGH1mmIHQ3TM2q/Gpk4t+7n/tzSthzrtJ89
458cuFdXhRt3G+oaUfOz/RhFcQAugjHnZHVitr/KA+R1P26VOzW9zWBsUjM1idMR
qs9WbpcYBXscC+MrzhjxkNX21cjV34GEDE3PeiCwL9dvcFZ4h3wJdrkrhOQclLGr
5vkZaQFFwrB4Coi8j8DI4RYoPfkQPdTn8rmbEVB8gSBk3M7u6dLqd17I2tnMNrUp
Byq4Ejj0nO1LoaVcaw85IBmAGeGm+cFZGdtgM5/obAP/G2S7V4GXlVlqX44HlfI8
k+66aMCAzgD5I85uS7lGjWD+66eTJEvq96y4A3Q9n66B+61UTWkAWrLHC7i04o31
5b43u2ZMzD7H64oYhcoKNcApXsa/Fbgd/dPSBJpv7k6hDSCs4ovnfS8pMcWZlC2r
rMYfeeaeEO+GgL9lXmpxwgjCbu7nccnRSmMEVjT78XGIrVkeYzRxuTgl/xwIxnwb
G2ccasnmdbHNFE++8Rfv
=VsTj
-----END PGP SIGNATURE-----

--nextPart9225501.4tzxDqKQj9--


--===============2652675519903856444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============2652675519903856444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2652675519903856444==--

