Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiB9z-0002VS-TZ
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:40:39 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiB9z-00026b-9S
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:40:39 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:40:46 -0500
References: <4F02E22D.3020802@imgtec.com>
In-Reply-To: <4F02E22D.3020802@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031540.46838.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 10/21] lib/parse_opts: Multiple fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1316671907916965543=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============1316671907916965543==
Content-Type: multipart/signed; boundary="nextPart6195760.ljMzjfhvER";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6195760.ljMzjfhvER
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2012 06:10:37 Markos Chandras wrote:
> Hi, please review the attached patch

looks good, but please write better changelogs

"- Fix TEST_RETURN definition" doesn't really tell much much.  it should sa=
y=20
something like "Fix TEST_RETURN definition to match that of the exported AP=
I in=20
usctest.h".
=2Dmike

--nextPart6195760.ljMzjfhvER
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2fOAAoJEEFjO5/oN/WB1HMP/iEkRjQaBuymAX2yKQW5r3U2
YmigkqfZXa6ua+Zl5CJulw/M+mhIbli2mp4pSqOXTV97D11SAcnFXC0QQuqME1Tm
uPpWWGhwwo2s3mKnCi1NmPBORPEChhY5KxBjnnRwz1gimCWYMTI3ZwrazA5cJkYw
tc9qj5XHzGAj996fdhA4Sl9VVaGlataBYBW/o64ccO8z6a2/kySSM0GkX/gWfyTi
TaJopr9shedtcmhblkk+cNV/jj7N3CSS4jPT+IqOPT+ZAWo1Szr1C0fNKoi+AbTt
uT/yRKYgdS0+RWpmsaUa6ve/B5OmGrv0C+eejcjQrUTnxd52bvnCryAeYfMo98la
Qt9jkTTxo2Yu2nYtPE1kxtcmxOLreaZNLaLW4WcPSdaOdCGGqgBUXB8uFrCaWQ6X
6Jt3BGoEqZrZW7roAEAzoJc5BKO8C6V3jBTIKBEOqhLX4Eu1S4bPSO/POElK32aV
G4LlljXqWz19KEAUNlLKbr6n9Wfz0GnACoxJWREKR5iykcs0KFKm0yrlOdfWIm6Q
37vPAXsMjJ0ITeKCGkoumGyrez2Y/FrJC78W7W4SFVuRlLe/zYcsF9RmFAiIsTlj
fZREhDb6HKHzEqrnpE5X/qfcA5BtX0dS4llHAGgv/nKKC5vFQPgQwqdaf7pnpbW1
yHosWNqV1pkmOM7K6DuM
=m6hQ
-----END PGP SIGNATURE-----

--nextPart6195760.ljMzjfhvER--


--===============1316671907916965543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--===============1316671907916965543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1316671907916965543==--

