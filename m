Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N7agp-00086k-J2
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 20:18:15 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7agk-0007PK-Jy
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 20:18:15 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 9 Nov 2009 15:19:55 -0500
References: <1257220567.10382.3.camel@munipradeep-laptop>
	<200911091422.07495.vapier@gentoo.org>
	<364299f40911091155t15fbae6am766e5e0b7b53387c@mail.gmail.com>
In-Reply-To: <364299f40911091155t15fbae6am766e5e0b7b53387c@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911091519.56866.vapier@gentoo.org>
Subject: Re: [LTP] Got warning message on ltp-full-20091031 while running
	./configure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1679784962782730542=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

--===============1679784962782730542==
Content-Type: multipart/signed; boundary="nextPart2721227.iTfKIitM5Q";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2721227.iTfKIitM5Q
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 09 November 2009 14:55:54 Garrett Cooper wrote:
> On Mon, Nov 9, 2009 at 11:22 AM, Mike Frysinger wrote:
> > well, the configure script wasnt really broken before.  people just cant
> > handle any sort of warning message and reading the related log files can
> > be too much.
>=20
>     I think we're kind of at fault for not having AC_MSG_INFO instead
> of AC_MSG_WARN, but oh well... AC_MSG_WARN is designed to be terse :].

not sure what you mean.  the warning pointed out originally did not come=20
directly from us, nor do/did we have any way of controlling it other than=20
using a newer version of autoconf ...
=2Dmike

--nextPart2721227.iTfKIitM5Q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK+HlsAAoJEEFjO5/oN/WBBAoP/RIjSSTkMZN7kC2VD7AVCwRS
d/Un+1gn4cVI8W31lIcM32l9zNxvXkApDV1dor2+wV61jbkaXpFFAAm767RhKRcD
HHJyDfBRF/ypDvY9pNeOYk/x/2S5BR2poqVECFu/ntNNEvgp3EHDE/PcLIm/79nJ
BMVqr0jJb542haE4JYX0d8+WeegIWS2wDonygQtwnT6VUvQDFaiJBmSg5IlEedNm
7zw0o9BGrlykTRlI8zuuVcjasVCCv1iFfK1OBjO1atAPoubsIJ3m9BjTZE7uQr/V
jmSvbCh1zP82XjXL4xAIX+x7PBFuXoP0T9TsGe6c/z5hwAMoRx5UqWCd0naKI3OD
LTbxRp1LQCESZu3j6XJGP8nm5S74DYcwyN52/OXupr+dlZUlrU3T1uVsy3YVtx2G
qiQIJwEw8andnCYOaHVPnkTH67yRsfK1FHC2nipq+NxebxoinrTdNgkzbUTAa9L/
IEpHZ+8yDtqh14enuHJcfOTGdSxqY/YWCWSEnfLvYkYzoyGo4E+gdeRihdSXlKfz
s4+G6gwZK8XvOOjegVVT26AWDIwo1zbi8lHkDb3nW6GQm024VvBOmBh02VBVK1GO
gD3CBAYlJ99H4d7NDk4NTLpTcGcSLaEJvrp5Zp85J3e02WlQBgsLxmAuoRIo6SGj
mni71NvdQ5Sx9hkjN9bi
=RSFq
-----END PGP SIGNATURE-----

--nextPart2721227.iTfKIitM5Q--


--===============1679784962782730542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1679784962782730542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1679784962782730542==--

