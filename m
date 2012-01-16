Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RmfT2-00018z-Jw
	for ltp-list@lists.sourceforge.net; Mon, 16 Jan 2012 05:50:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RmfT1-00056r-L9
	for ltp-list@lists.sourceforge.net; Mon, 16 Jan 2012 05:50:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 16 Jan 2012 00:47:32 -0500
References: <4F13940B.8050209@windriver.com>
In-Reply-To: <4F13940B.8050209@windriver.com>
MIME-Version: 1.0
Message-Id: <201201160047.33401.vapier@gentoo.org>
Subject: Re: [LTP] A question about mktemp in script runltp
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3567064591020511390=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3567064591020511390==
Content-Type: multipart/signed; boundary="nextPart2768235.e2EmVRZZs8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2768235.e2EmVRZZs8
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday 15 January 2012 22:05:47 Jin Li wrote:
> In runltp script, mktemp is used to create a temp directory. see below :
>=20
> mnt_pnt=3D`mktemp -d --tmpdir=3D${TMP} mnt_pnt.XXXXXX`
>=20
> But I have a little confused about the argument "--tmpdir"
>=20
> I prefer to use "-p ${TMP}" to replace "--tmpdir=3D${TMP}"

why ?
=2Dmike

--nextPart2768235.e2EmVRZZs8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPE7n1AAoJEEFjO5/oN/WB2rYP/jXrEEqhdjngv+C7cJIuJu2v
yI1YxjWoQtludcVeMdAD5S5kp4DDRPqAOa56drZEYrnbW+3ZYzpmKiv/p0rEfAuB
bwFaeKmqIjkx+EFRbXwHnwhs09nMemhI0vy+NvFPr4cw/hhp3FRBohBTDSaRtXs/
bXmyk16TebzhzA/wf1gM8kyq87bFlJZPMyUfa7/wg/evgV5JPj0YKjII+2a8ko0+
ufT+iRq1cMsAjkeAVVBHwougvBNffWPDSc8Gt4qfoKTjIaXYiy4ZejZQmUcsqijk
s8qusjInqMhHhQLZjSVpW6cNgxO3Q1JBgqaN/NuZFFrrLF54+o7cCQ3goXKubEN/
wQ5ynuen9cK2ntzuUiEWBQdmYDug48zLpVtSqj/ThkPxE3Sh1HIg19r+D8n5xHOF
4NhQwyqqEizlP7OHnmBQw1kFZgXGyIVfeSqe4COV+H/fOP8oLtV0PfF4RGlE4/qs
fR8GvCx/2TG2RIzuxObIdecVG7kNAIzhbocQZAK46vJo5amSj998JBl4x3gdGjcn
m/DRB6n1KqrHZvxAZmw7rYyt2slD4ur0Z0jPX9Y06ld07EuyiLTXXAIazA1/JBTH
3NJ5FOI2NnOM2HJBufrFRozzJH5lYEVrPV/7sasAJBYSDWpxIrBXYOuSgqpUIDfu
9bAMWhZ5RHQRqyUAqWsf
=TEWg
-----END PGP SIGNATURE-----

--nextPart2768235.e2EmVRZZs8--


--===============3567064591020511390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
--===============3567064591020511390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3567064591020511390==--

