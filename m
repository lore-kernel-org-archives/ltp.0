Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1PXz1t-0004Rf-L7
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:37:37 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PXz1s-0007hg-Td
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:37:37 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 29 Dec 2010 11:37:01 -0500
References: <AANLkTimKGoNfnr0s5PgBxzx+hZOW_8j-k8Dewbw=2e8M@mail.gmail.com>
In-Reply-To: <AANLkTimKGoNfnr0s5PgBxzx+hZOW_8j-k8Dewbw=2e8M@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201012291137.02317.vapier@gentoo.org>
Subject: Re: [LTP] [Bug Fix] fcntl15 is not completely ported to uClinux
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7792154165460645110=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7792154165460645110==
Content-Type: multipart/signed; boundary="nextPart1327394.PnDKjAmbZC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1327394.PnDKjAmbZC
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 29, 2010 04:35:33 Vivi wrote:
> The code of fcntl15 is not completely ported to uClinux.
> So it will fail on uclinux platform.

this looks fine, but again line wrapping has ruined the patch and needs=20
resending
=2Dmike

--nextPart1327394.PnDKjAmbZC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNG2OuAAoJEEFjO5/oN/WBXcAQAKRMZnAO0J9FA2tjIJlGA19Q
QCl83CjmAu52CeXe3XzE9onPVu85Xn+/Bj7neSVjtgXtJumohkKqJcRUEL9eQu4Z
0Eu9uO+FDjxEB9YMYD/LhLkn8uhaj7PNwjqJQPyHSzOAzbJGsqN2TdnQ/0DXo4nG
lS0hmeuJum632CvPfpnu1id40J69sLTCfLbTSvgRqodAliOnQBVirsh8sLtIUSIo
gVDNxEWapVpvRQxgRewalDkM9sx7AC9+dPkAEFHExCS+86fgzJIy6BJl4K+f84Dt
WwUdTeVLb4SYaikX1iUiLu8Kn7ykQnvoN71hTinp4ouLFX6E6/m++/mhC7yUdQGh
FP2c8rFBoNEgQj+epQd3NaD3dVdy/EAgdMX2/yErIE70Bnox4z1i/8XYX3TCk4R1
xRkrt4DHuAjqQM33kGgbI1ScNCSGMaYMjIyDlOIi4mVRRyQLoOBB9QuxJitmQLzN
5ERdO9JwBIdk1oxXaBNutBAvi58KwaLbWSxYvrksGbcaitrfHhlYT/EYOYcA2GSy
3cFk/rrZxznFTPijfzemJO7MNPgqXvNBCnnWM7MO7jKjpwt9OAyVR1BNkApx4tO7
yWwCE8l7BWYh0yAnTBW4v9NkyxAJiKSsYLWJQGn9B2ALFnNk5MjsljkoHNUU5Lj3
VxynoQIp5h7dTxWzYLGd
=Dt9f
-----END PGP SIGNATURE-----

--nextPart1327394.PnDKjAmbZC--


--===============7792154165460645110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============7792154165460645110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7792154165460645110==--

