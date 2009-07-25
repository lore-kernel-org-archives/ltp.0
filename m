Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MUZoL-0007XB-Rx
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 05:28:45 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MUZoF-0002FX-Pb
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 05:28:45 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 25 Jul 2009 01:28:32 -0400
References: <8368651DACC1964480F951191B94A078E49F0B@svexch01.mvista.com>
In-Reply-To: <8368651DACC1964480F951191B94A078E49F0B@svexch01.mvista.com>
MIME-Version: 1.0
Message-Id: <200907250128.33178.vapier@gentoo.org>
Subject: Re: [LTP] modifying tests to use the configured tmp directory
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2857324397372175242=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2857324397372175242==
Content-Type: multipart/signed; boundary="nextPart27747830.XtiDbb8TXQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart27747830.XtiDbb8TXQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 25 July 2009 00:45:09 Henry Yei wrote:
> Does anyone have a preference on whether the tests should be modified to
> use the tst functions when possible, or use an optional argument?

if a test needs a temp dir, it should always default to the common LTP one.=
 =20
feel free to send patches to do just this.
=2Dmike

--nextPart27747830.XtiDbb8TXQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKapgBAAoJEEFjO5/oN/WBGrkP/1UcyiFNbn0FdYDWlyz+imsK
h+2QYVTFRxOPG2yuvcLUi9OwTbrOOkOGjrHJrj88KQ8+k/wW8SBHEPFByhd4zOx7
AGMBlBizM5C3fdoK8gNWwzRfNt+Y8ik0SYk5oZztckbfu5DDGaRtfrmWJDozRz68
ZDyrJBCQG44VNjww4ndL8xwNuSwetZ3wyTy3V625J7Smvn4tRjHk5McYYAoEOoOf
vSk63ZLSAT1P8wuVY3UmE2KaONOAkNme2Q57ZuUPfDtHPuJPM/yj1MQ2vGdKn5BF
nGrlRWI2+bWeRxVRY72kLcLyoFOEy3R3SeDOrX+mMGOw6ZhZOLGkzZRpMFmszeuN
Fs3YUfnlGHWkK8W+VTCDs6pDNW0ehT3zEFhLDxQMKWKA/obls/Zb2tkBNHB7mbKC
5CzjjPODMo6eDMDOkNrG+QRt8kiJ4x91dGQAtx5QJ72H4REpNe16hvilG43vOJep
ROQ8MxTWI4/dZmiDWOb+CrSxP0JJNTmQ8m2v1aXPqsBuqwBe0Wg/nhSHH9mPNq+i
WXbT1sjXzTX3Gx3/kk/WNnNdZlZfKShOhLzpxEboM/ykdDGgiHKyGmVFQiS2Fhlz
YNXprIZtVLyz1TM9Lve3jphLtYK3IhhZ/xSS0XE59CGM6m1/Mi5yJ1GzgaioNlYj
IO+wx1T0Sue+aAD2fMJE
=WHMo
-----END PGP SIGNATURE-----

--nextPart27747830.XtiDbb8TXQ--


--===============2857324397372175242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============2857324397372175242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2857324397372175242==--

