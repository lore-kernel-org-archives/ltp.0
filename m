Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NSOOe-0005F9-Pu
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:25:28 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSOOd-0004SH-Uh
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:25:28 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 6 Jan 2010 00:25:44 -0500
References: <4B421480.1040400@petalogix.com>
	<20100104174925.GA1208@us.ibm.com> <4B43E1CD.2050609@web.de>
In-Reply-To: <4B43E1CD.2050609@web.de>
MIME-Version: 1.0
Message-Id: <201001060025.45552.vapier@gentoo.org>
Subject: Re: [LTP] clone tests fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0071938517736633732=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

--===============0071938517736633732==
Content-Type: multipart/signed; boundary="nextPart1327604.PYQBbk5ovC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1327604.PYQBbk5ovC
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 January 2010 20:05:17 Jiri Palecek wrote:
> Michal, I suspect the failures you see are somehow related to alignment
>  (that your architecture doesn't like odd addresses). Is that right? Under
>  x86, the address gets aligned (so some of the space is unused).
>=20
> Perhaps both of these behaviors should be tested by LTP?

i dont think such tests would be reliable or useful ?
=2Dmike

--nextPart1327604.PYQBbk5ovC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLRB7ZAAoJEEFjO5/oN/WBR2kP/R3/PJk3lsPM0XEO3eYNNvP/
R9YizueTa47ahJuU1UVCwIyCnuPdUusaWT/oVEYEXwRA6t8DtmUIXFdXUK85JrpS
70WyQf89L47w/16LZtiYAtERTgGq4Gs/Fv1wdr1PRzUkk1ieJIDZtk7eP0+DkKap
amm/REoPkIIGHV6AUz7/anL/ndMZAjy1H0Rn7CnLvsmhSsLyZ6EX83ipH7ny4TTN
tWBOjgYFxTeGuu1VOG01Gb9OGkw3i6OMHCingOKMaULVe1O9RoxAO3atpXW0AoN5
L8UIbJGCBd7SZfD2R4yJQvVxmr9oHTCTYNhJGTSkDBbkdis+xPiWE8vJwJHjC+9w
S2eOArHRP+80gmSMGvx8i0WA9wpcQq2+yzV3Fu7wCzob9+RHGOxWcUrKXJvIFR3H
RIx2zhUZ6wffSOESdwJtto6kfxXBdHcNp9Ro8BhRYxHb73wnbMlrcnvVxG6dmUT4
mD/9ivVJ00pV9MSdSqZ1vHiYoPXWmLpTo4lVsVaN4F1mgU+292CktnOHZptSWbs3
n3N3MunYK4w8zrT9cQPKJaOpH4yRm74OgrIoyTr2QyhEnKmb2vH0aYGpozZkbVZI
Yy6Mn/BwAP5Kke6Pxv14EalfuzE2v3uv9kvXYf2jtzVtlHPbE9wlFcKDOJPV1Xmh
ieYOmMBUT4XGQqJp7TYr
=4//A
-----END PGP SIGNATURE-----

--nextPart1327604.PYQBbk5ovC--


--===============0071938517736633732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============0071938517736633732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0071938517736633732==--

