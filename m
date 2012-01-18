Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RnYet-00073E-A5
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 16:46:47 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnYen-00015z-L3
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 16:46:47 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 18 Jan 2012 11:46:42 -0500
References: <1326897408-26778-1-git-send-email-carmelo.amoroso@st.com>
	<1326901442-23483-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1326901442-23483-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Message-Id: <201201181146.43096.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2 V2] getcontext01: fix build using uClibc C
	runtime
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6905170660135260989=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6905170660135260989==
Content-Type: multipart/signed; boundary="nextPart1617750.HSd3ru2KAe";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1617750.HSd3ru2KAe
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart1617750.HSd3ru2KAe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPFvdzAAoJEEFjO5/oN/WBFEEQAIrz6GAIA67bRQEWR6SqLYPw
Yg60FnLABA88skJrzjFJnHef2/bv0gCPLxmNcbkqvv7Q2LfIrFJwlIZrBu5YSn5+
zBmMWmFepkrzsg3rLH7OMmyY/rp4vk1spUYlJlLwzQHnMq22gcDw2R4pJVJA1t8g
1Vl2B1rUopN7kBtCpCMxzteR/B6UU2rH5ibBXQqPvDR2E0v7VjMTpIysV9YyPbII
WlBZgibBExvNnivX+tjcf77p7Pa3GjkoYUsA0tRvVOA3YG4sKpatAEfCN2fdfFjI
T1Vyo72Df5cV+ZmwO7O8I78N6LdIaE78ZtwvvDigvplYVsh3Kh4PENSjMvjIWwX9
5b25HgL93EMzruc7YqLt85q+Uh/Y1MKlxJhcyBBKq4bsl4hurtJgS9IM5BDUH0/f
DkZerqYtS2BBm8zoqlPOPq23WJe2+hjpU0RpTsBiTNIxiVLe/q8voJPE/5G/NTYY
ZY05x1bX+/Ba0AZYHyOpJU1xItzddf7WrByTbYfDKjhJTsWNmNOjMkhFMbUpxnVO
knCAodNFyRfa+5/tR9vGTJ/C3MyOLSmEFubOAyxtp1Iz51FKWkP7IMkFjnmvaDdF
6CfrJyagQ7DLG841wblBn8F6jMaO1SthlTrD4i84Klrq5SHXRw6sPg8Cpt9c/OmS
0QH83u4mYpjs2ufZ0AQx
=ogW/
-----END PGP SIGNATURE-----

--nextPart1617750.HSd3ru2KAe--


--===============6905170660135260989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--===============6905170660135260989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6905170660135260989==--

