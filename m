Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MrVPM-0003N2-4s
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 11:25:44 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MrVPH-0003L7-Al
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 11:25:44 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 26 Sep 2009 07:25:28 -0400
References: <200909241229.32866.chandru@in.ibm.com>
In-Reply-To: <200909241229.32866.chandru@in.ibm.com>
MIME-Version: 1.0
Message-Id: <200909260725.29279.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] ppoll01: add signal() syscall to register the
	signal handler
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7651654387098221364=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7651654387098221364==
Content-Type: multipart/signed; boundary="nextPart1338396.znXFOkEcoe";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1338396.znXFOkEcoe
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 24 September 2009 02:59:32 Chandru wrote:
>  3. Takes away
>  printing the type of error ( i.e strerror(errno) ) since it only prints
>  the last error seen and does not report the failures seen in the cases
>  before the last failed one. The reporting of NG or OK shoudl take care of
>  letting the user know the cases that have passed and cases that have
>  failed.
>
> -                 	   	tst_resm(TFAIL, "%s failed - errno =3D %d : %s", T=
CID,
>  TEST_ERRNO, strerror(TEST_ERRNO));
>  +                 	   	tst_resm(TFAIL, "%s failed", TCID);

why dont you *fix* the issues you see with this output instead of making th=
e=20
output even more useless ?  also, this should be converted to TFAIL|TTERRNO.
=2Dmike

--nextPart1338396.znXFOkEcoe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKvfopAAoJEEFjO5/oN/WBS3AP/RoMHWDCuBp3hn84jFFfTOAQ
23/2OXE2m6gJ47YhKPXstR0gVLyw84jF+V/bOg3jaxXmIJh8SYMzy5kvJ9KflkSo
FV5F64VZ4jHHzpCatzz0X8GM9zmr1ESVfOoyTU1e8X0i9ch8+Ja1m4Q8jOK8lwDF
MsoTeXY0PI339pxyFO8ZVgF/FQy+lzcr/lKgAEwLQyYhMbjMP7qDA0AVy63hL6I2
mII8R1dGrk0tPkpGCrB1sa09m7PeGfUnvZ7wISgfu+V13972kKKlg5FqQopptgNC
pZlylga8FCJAD2g3Rx+wtoCPmQEVMMJpRc8YBU32MOXcemDXBAun9dqBE8dWQneZ
ksUYOlF1I2oVMbA02MYZ1MyPdKAtyYbsg/ZxZjQtLT8ahmcBFLxuScuG/SUA1rCh
ngQAih2OGjOm6otHJR+B1sRxuEMeuhg52s9GQ60oJDAVKvvJWBkEouT3DP9/jx47
0yb4zH4KXBjNmEqNhPS0ybKL/KIg3scDTaqDHbmth2PZAFwouJNWDmfM1xG88jUM
zsBXEdFHN2z+hVEQ53EJuE1z6yui35z2jKzpIwpUZq2tTL2o73MX/UAYkGg/aaE/
gfgmAt+6Z3agyloEPpxnsR9gTNNzE/FOFWaLy6/zXiMGbyaP7RQtAccLPktUdcR6
8cHAVlD/sMuqzgBghoWA
=0LI4
-----END PGP SIGNATURE-----

--nextPart1338396.znXFOkEcoe--


--===============7651654387098221364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--===============7651654387098221364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7651654387098221364==--

