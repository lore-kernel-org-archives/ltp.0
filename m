Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MxaB5-0002NB-5z
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 05:44:07 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxaB0-0008E1-47
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 05:44:07 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 13 Oct 2009 01:43:52 -0400
References: <364299f40910122222q5117ecf0i854db292154132c7@mail.gmail.com>
	<200910130130.30228.vapier@gentoo.org>
	<364299f40910122240p586a60aarc796112b68c519e2@mail.gmail.com>
In-Reply-To: <364299f40910122240p586a60aarc796112b68c519e2@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200910130143.53176.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] convert linktest.pl to linktest.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4318204949747275610=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============4318204949747275610==
Content-Type: multipart/signed; boundary="nextPart1981332.skL64Spk83";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1981332.skL64Spk83
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 13 October 2009 01:40:44 Garrett Cooper wrote:
> On Mon, Oct 12, 2009 at 10:30 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
> > On Tuesday 13 October 2009 01:22:02 Garrett Cooper wrote:
> >> +                       (( lerrors++ ))
> >> +               (( i++ ))
> >> +       (( TST_COUNT++ ))
> >
> > i think you want:
> >        : $(( TST_COUNT +=3D 1 ))
>=20
> Ok, dumb question again -- $(( TST_COUNT +=3D 1 )) is the POSIX
> compliant method? (( TST_COUNT++ )) works too... (I keep on forgetting
> what's POSIX compliant on this item...).

the form i show is POSIX compliant.  afaik, the variant you're using is not=
 as=20
it lacks a dedicated command and the ++ operator is optional.
=2Dmike

--nextPart1981332.skL64Spk83
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJK1BOZAAoJEEFjO5/oN/WB7nEP/REdZNB8U2YaZtXkT0tDrZkO
XO9Tq4/aAsQrh7voydOcDClJYtgNbmPjDC6josuaYWT/d02eSzNipKo+W39ee+Ap
jPdjWZC+LdpzArft4bPaV+QF/c8iMuRFohiAuJAMyENNhSUsjjTrVq5PULMAP0Vt
uEEq3dM1f5Xv2SqZHrN3WYGzlFUm+OjE4d8IOKGiPo9kx4DBeqC7EUwZQvxs4Ebb
XJqUIqB1ftNMj8+pCbSyhXqLJTuMOHaNEvaF2UUMU5uwDSHCPh/OBCkRLN/Ad1b9
v/Yq08toaBfT7Q/Zh4i43TfuQAuG6mOIfY4YZRmU4AWchonLC4vQkOdnWcrDF3x1
OP+2pVD9nRg9DiyLLH/yxJRVKiKk0lvIcz/QuZwH9TbgGfdcIQYmM0o2FTm8J9hc
oIQWaS1oWpHNntcf1oJuHs6sG4SmmK772s80+FMACTwoiE0lpRL+Hp3jT9277/vB
5Ro0izUP0Fv/oJMXXyaDz/KiALmHdEaHZKGMydSMxoh9zPeDUi744QmPKShD/Axr
oYLS7Yf6fff2nhvztXUaI3hJKpvhPnLkELfoJ4piHwIOXnUjt6/r95sg/YKqqB9a
CNpTaaAA9hxy+405Bef8bMnzUc7vsJ6nhrLgs/gKzUNPwyGzxs+WRxwsqajq/5pA
1LW64qT5XfZvoy4RUlFA
=nmkj
-----END PGP SIGNATURE-----

--nextPart1981332.skL64Spk83--


--===============4318204949747275610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============4318204949747275610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4318204949747275610==--

