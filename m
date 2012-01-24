Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RpUsT-00061T-6I
	for ltp-list@lists.sourceforge.net; Tue, 24 Jan 2012 01:08:49 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RpUsS-0002Vi-7W
	for ltp-list@lists.sourceforge.net; Tue, 24 Jan 2012 01:08:49 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 23 Jan 2012 20:09:12 -0500
References: <20120120134016.GG4024@saboteur.suse.cz>
	<1327312869-17016-1-git-send-email-carmelo.amoroso@st.com>
	<1327312869-17016-2-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1327312869-17016-2-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Message-Id: <201201232009.13602.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/2 V3] profile01: fix build using uClibc runtime
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2003501369439480048=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2003501369439480048==
Content-Type: multipart/signed; boundary="nextPart102135724.CtuNoniZyd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart102135724.CtuNoniZyd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart102135724.CtuNoniZyd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPHgS5AAoJEEFjO5/oN/WBKjcP/2oXbCElLhtFY9kFwFYAc+/I
rP5fzD7sEVoXry8I5omFlHMIN600lKnYnbBdz2embcDvVVkQBSdksGCEFScL9beJ
+8hvXowJe0nB2Ql2jzDFrjvtyGePUehkGsIp74PSKCd7bH4VZWSQTWOadMzd+djn
DLQgZbocagSByqFf/XLrND1fPcZ6eR0nULSJkVBE8M+1X6TQftKEGUlFulFcHTQp
51WwFKA8mSugNV9C/G9+qu81/8nb+iwZRyDwDlw2gdwrJ6Hwu90qIQhGPXZBqyMb
ux0CwRKqkLraXa03IydtMa+Hr2D863x+6kKryZCdFuDpVhdGoJxb1zPGSBIQ2ws0
FjSTlxswGUVyA5fkHcyJ8I1lpZPQtDEdGMOc92Ni6AQLPEcLk1hAy9ROC591p7y4
6ncFlKsOd2n1KS3f2BpLUJK7JUPuwTGHTqy30o6hfEqD48/IJJzG6hEHgaPBTS0F
bdexllldFOJwFt0kT1PlUvswZxZRYoA6Gsf0Wp2pCzCTy1WRCrWCsKv0VZFElhey
9ZmKEN81UWYU7N0AwA9CDwAaqv7FJfkAhnSMPLNwvcEBMxBajH9IDAwNPrOOiyvn
KuaqmYDkOm3NEYlXGJMPoEyuopsYvpk+4JTpCqz7T1K9JTYFE5+ZVCFrAVr4+yzf
uDqjcDSbb8b62D/Vn5HU
=kh9Q
-----END PGP SIGNATURE-----

--nextPart102135724.CtuNoniZyd--


--===============2003501369439480048==
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
--===============2003501369439480048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2003501369439480048==--

