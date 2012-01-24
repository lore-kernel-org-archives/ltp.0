Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RpUsI-0002Y2-Pw
	for ltp-list@lists.sourceforge.net; Tue, 24 Jan 2012 01:08:38 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RpUsH-0005DN-P4
	for ltp-list@lists.sourceforge.net; Tue, 24 Jan 2012 01:08:38 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 23 Jan 2012 20:09:02 -0500
References: <20120120134016.GG4024@saboteur.suse.cz>
	<1327312869-17016-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1327312869-17016-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Message-Id: <201201232009.03141.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2 V3] getcontext01: fix build using uClibc C
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
Content-Type: multipart/mixed; boundary="===============4987175905941384713=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4987175905941384713==
Content-Type: multipart/signed; boundary="nextPart6768448.4IvIMoaGkQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6768448.4IvIMoaGkQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart6768448.4IvIMoaGkQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPHgSvAAoJEEFjO5/oN/WBzyYP+wSa3SGtA7gcMcbO3cnajMBy
ivwqo5Ml7aLqP35K9Ze9iOnBRL2j03OIWR54iTJax2Lk/gQg6FAf0+CJK/8MlAEx
3G0yPW7vOl6uAkaDG/Mqhd/0ofC44QN3lRi9idGTwtOXuAzEo4qKlrJHoSSwGSlS
7jDqfY36saDsIxzstBmqbEL89ZI7lfjvx2uvwFekw4QK3H70hWKyzKvYuxG+Y6wS
AIFjFCrpGB/AXZrfzvzJFb2zKszFqNrpszi/IXXy6NLTP3Sid+evNHEgjFGM/ey9
zt6i+zK5d5U8l8RnSTYlTboImR0NwDsOhhBjh9jIeUgSvyUK8lw2pRO8RjjXE6e0
/FlAAMG99uDgY4YG2HCB8FaERtUx5ZVDGXsuBvFkK2USKkW0v/aI3QbgdJ70Rn22
KULoyUTwWZRJWZuGqwd7ZlMiZQ+hbgIzqEMIoegqMfJpTPAgn+reU33wTqiQuVzU
xJckROn8fCq8rWmT3oC8Tc8ZPzbrYgT7F1BjhIebX338MrLh8mXpJNcBb8RhoD//
0Opj407KFTJrj4wa9+H/w9EYrCYVy+ulE0VP8FFyKz+Z+YF2fGePHdmS9XD+0qZA
zU1SgFuTquuo7AB0yT+e81FbgoNhpMi0Mt88OiCkrD4zNU6CAf14OxysZqfynSQR
OhQPDe5MQF575Q6I/Jmq
=3l4W
-----END PGP SIGNATURE-----

--nextPart6768448.4IvIMoaGkQ--


--===============4987175905941384713==
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
--===============4987175905941384713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4987175905941384713==--

