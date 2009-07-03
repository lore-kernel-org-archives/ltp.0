Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MMYpc-0002B8-Jm
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 02:48:56 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMYpY-0005ZA-73
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 02:48:56 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 2 Jul 2009 21:57:29 -0400
References: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
	<200907022058.43574.vapier@gentoo.org>
	<4B19CF3F-6820-48B8-BE63-8F9046C559DE@gmail.com>
In-Reply-To: <4B19CF3F-6820-48B8-BE63-8F9046C559DE@gmail.com>
MIME-Version: 1.0
Message-Id: <200907022157.30535.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 8/10] config.mk not required for clean
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0836608555763485168=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============0836608555763485168==
Content-Type: multipart/signed; boundary="nextPart3686406.l7S39c8CnK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3686406.l7S39c8CnK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 02 July 2009 21:21:06 Garrett Cooper wrote:
> Both sinclude and include are possible I suppose, but as far as I
> understand that actually does an fstat, tries to open the file, etc,
> but this completely ignores the include statement and reduces I/O a bit.

yes, it'll remove a syscall or two, but i dont think that is significant in=
=20
the larger scheme of things

the problem is that i dont want these kind of ifdef things propagating as=20
they'll get tweaked and go inconsistent all over the place

how about include a top level .mk file that always exists and in there, you=
=20
have the conditional config.mk include
=2Dmike

--nextPart3686406.l7S39c8CnK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKTWWKAAoJEEFjO5/oN/WBgXkQALr23vCgxiVdqAU+VItJj5Ln
bVJmaG71RZQP83kLR52YZNzTSXEsVzNa1MW0V60zwM/P+WTLoBFpbDg26kVF+O1B
tQKb4NbpUM/+uyA6YZOX0/KFrANYPIIZjbm+E4znQ/yfaqB6iqakfkU7tx4OIlNM
P8yBm1YAqOjR3W/Eha0aP2mvsOQwPFOgaRgdaB6zzwTf8KD9IlAedWDqgayXveit
8yq0tG6rEMx35fHNp8Lj0WMJgg8BN3U9zy2HtifaxsydlmvwfgSjce+6ZQEIEa82
MFcTz6kTYttP2oo/W19mKYDURFZ6UWoOwIwtvFjpZiA8LVlnYh9GP3FM7+jv2L8s
i96NVU/aMPz0HKgnqRpupQRGqvhRuK0YeRc9vKKQv+4ck26hFdv267n/7jKJq5GE
kkaym/bq05197wbGHBb19mmBO44qngcLjz+CseN7TBYdVX1Dc7S+RKBPB4/B4Qh5
kT+GqfyhHLOTo7QnSUQonPw//3EtssbDBHZI7yzm/nltZu9PL32hohDJonLxJdNG
dJi4iw0BqjehyvHLOzaqjLTlIoLFvf+7Zz/f8SWwOGu9Os/htscGLvJz5Kwl/nTj
FP0gCDgxGXcD9LbT5V/1xjUQBbJ4lOKesTdw9H/Q/hXMMs0nsug/UXot+wmiQjGN
4SxWp6MDyINXZuGrLWtF
=iUv+
-----END PGP SIGNATURE-----

--nextPart3686406.l7S39c8CnK--


--===============0836608555763485168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============0836608555763485168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0836608555763485168==--

